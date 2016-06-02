<?php

class Pay_Controller_Payment extends Controller
{
  protected $_paymentOptionId;
  protected $_paymentMethodName;
  protected $data = array();

  public function index()
  {
    $this->data['button_confirm'] = $this->language->get('button_confirm');
    $this->data['button_loading'] = $this->language->get('text_loading');

    $this->data['paymentMethodName'] = $this->_paymentMethodName;

    $this->load->model('setting/setting');
    $settings = $this->model_setting_setting->getSetting('paynl');


    $serviceId = $settings[$this->_paymentMethodName . '_serviceid'];

    // paymentoption ophalen
    $this->load->model('payment/' . $this->_paymentMethodName);
    $modelName = 'model_payment_' . $this->_paymentMethodName;
    $paymentOption = $this->$modelName->getPaymentOption($serviceId,
      $this->_paymentOptionId);

    if (!$paymentOption)
    {
      die('Payment method not available');
    }

    $this->data['instructions'] = $settings[$this->_paymentMethodName . '_instructions'];

    $this->data['optionSubList'] = array();

    if ($this->_paymentOptionId == 10 && !empty($paymentOption['optionSubs']))
    {
      $this->data['optionSubList'] = $paymentOption['optionSubs'];
    }

    $this->data['terms'] = '';
    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/payment/paynl3.tpl'))
    {
      return $this->load->view($this->config->get('config_template') . '/template/payment/paynl3.tpl',
        $this->data);
    } else
    {
      return $this->load->view('payment/paynl3.tpl', $this->data);
    }
  }

  public function startTransaction()
  {
    $this->load->model('payment/' . $this->_paymentMethodName);

    $this->load->model('checkout/order');
    $this->load->model('setting/setting');
    $settings = $this->model_setting_setting->getSetting('paynl');

    $statusPending = $settings[$this->_paymentMethodName . '_pending_status'];

    $order_info = $this->model_checkout_order->getOrder($this->session->data['order_id']);


    $response = array();
    try
    {
      $apiStart = new Pay_Api_Start();
      $apiStart->setApiToken($settings[$this->_paymentMethodName . '_apitoken']);
      $apiStart->setServiceId($settings[$this->_paymentMethodName . '_serviceid']);

      $returnUrl = $this->url->link('payment/' . $this->_paymentMethodName . '/finish');
      $exchangeUrl = $this->url->link('payment/' . $this->_paymentMethodName . '/exchange');

      $apiStart->setFinishUrl($returnUrl);
      $apiStart->setExchangeUrl($exchangeUrl);


      $apiStart->setPaymentOptionId($this->_paymentOptionId);
      $amount = round($order_info['total'] * 100);
      $apiStart->setAmount($amount);

      $apiStart->setCurrency($order_info['currency_code']);

      $optionSub = null;
      if (!empty($_POST['optionSubId']))
      {
        $optionSub = $_POST['optionSubId'];
        $apiStart->setPaymentOptionSubId($optionSub);
      }
      $apiStart->setDescription($order_info['order_id']);
      $apiStart->setExtra1($order_info['order_id']);


      // Klantdata verzamelen en meesturen
      $strAddress = $order_info['shipping_address_1'] . ' ' . $order_info['shipping_address_2'];
      list($street, $housenumber) = Pay_Helper::splitAddress($strAddress);
      $arrShippingAddress = array(
        'streetName' => $street,
        'streetNumber' => $housenumber,
        'zipCode' => $order_info['shipping_postcode'],
        'city' => $order_info['shipping_city'],
        'countryCode' => $order_info['shipping_iso_code_2'],
      );

      $initialsPayment = substr($order_info['payment_firstname'], 0, 1);
      $initialsShipping = substr($order_info['shipping_firstname'], 0, 1);

      $strAddress = $order_info['payment_address_1'] . ' ' . $order_info['payment_address_2'];
      list($street, $housenumber) = Pay_Helper::splitAddress($strAddress);
      $arrPaymentAddress = array(
        'initials' => $initialsPayment,
        'lastName' => $order_info['payment_lastname'],
        'streetName' => $street,
        'streetNumber' => $housenumber,
        'zipCode' => $order_info['payment_postcode'],
        'city' => $order_info['payment_city'],
        'countryCode' => $order_info['payment_iso_code_2'],
      );


      $arrEnduser = array(
        'initials' => $initialsShipping,
        'lastName' => $order_info['shipping_lastname'],
        'language' => substr($order_info['language_code'], 0, 2),
        'emailAddress' => $order_info['email'],
        'address' => $arrShippingAddress,
        'invoiceAddress' => $arrPaymentAddress,
      );

      $apiStart->setEnduser($arrEnduser);

      $totalAmount = 0;

      //Producten toevoegen

      foreach ($this->cart->getProducts() as $product)
      {
        $priceWithTax = $this->tax->calculate($product['price'],
          $product['tax_class_id'], $this->config->get('config_tax'));
        $price = round($priceWithTax * 100);
        $totalAmount += $price * $product['quantity'];
        $apiStart->addProduct($product['product_id'], $product['name'],
          $price, $product['quantity'], 'H');
      }


      $taxes = $this->cart->getTaxes();

      $this->load->model('extension/extension');
      $results = $this->model_extension_extension->getExtensions('total');

      $totals= array();
      $total = 0;
      $arrTotals = array(
        'totals' => &$totals,
        'taxes'  => &$taxes,
        'total'  => &$total
      );

      $taxesForTotals = array();


      foreach ($results as $result)
      {
        $taxesBefore = array_sum($arrTotals['taxes']);

        if ($this->config->get($result['code'] . '_status'))
        {
          $this->load->model('total/' . $result['code']);
          $this->{'model_total_' . $result['code']}->getTotal($arrTotals);
          $taxAfter = array_sum($arrTotals['taxes']);
          $taxesForTotals[$result['code']] = $taxAfter - $taxesBefore;
        }
      }

      foreach ($arrTotals['totals'] as $total_row)
      {
        if (!in_array($total_row['code'], array('sub_total', 'tax', 'total')))
        {
          $totalIncl = $total_row['value'] + $taxesForTotals[$total_row['code']];
          $apiStart->addProduct($total_row['code'], $total_row['title'], round($totalIncl * 100), 1, Pay_Helper::calculateTaxClass($totalIncl, $taxesForTotals[$total_row['code']]));
        }
      }

      $amount = round($order_info['total'] * 100);

      $postData = $apiStart->getPostData();

      $result = $apiStart->doRequest();

      //transactie is aangemaakt, nu loggen
      $modelName = 'model_payment_' . $this->_paymentMethodName;
      $this->$modelName->addTransaction($result['transaction']['transactionId'],
        $order_info['order_id'], $this->_paymentOptionId, $amount,
        $postData, $optionSub);

      $message = 'Pay.nl Transactie aangemaakt. TransactieId: ' . $result['transaction']['transactionId'] . ' .<br />';

      $confirm_on_start = $settings[$this->_paymentMethodName . '_confirm_on_start'];
      if ($confirm_on_start == 1)
      {
        $this->model_checkout_order->addOrderHistory($order_info['order_id'], $statusPending, $message, false);
      }

      $response['success'] = $result['transaction']['paymentURL'];
    } catch (Pay_Api_Exception $e)
    {
      $response['error'] = "De pay.nl api gaf de volgende fout: " . $e->getMessage();
    } catch (Pay_Exception $e)
    {
      $response['error'] = "Er is een fout opgetreden: " . $e->getMessage();
    } catch (Exception $e)
    {
      $response['error'] = "Onbekende fout: " . $e->getMessage();
    }

    die(json_encode($response));
  }

  public function finish()
  {
    $this->load->model('payment/' . $this->_paymentMethodName);

    $transactionId = $_GET['orderId'];

    $modelName = 'model_payment_' . $this->_paymentMethodName;
    try
    {
      $status = $this->$modelName->processTransaction($transactionId);
    } catch (Exception $e)
    {
      // we doen er niks mee, want redirecten moeten we sowieso.
    }

    if (isset($status) && ($status == Pay_Model::STATUS_COMPLETE || $status == Pay_Model::STATUS_PENDING))
    {
      header("Location: " . $this->url->link('checkout/success'));
      die();
    } else
    {
      header("Location: " . $this->url->link('checkout/checkout'));
      die();
    }
  }

  public function exchange()
  {
    $this->load->model('payment/' . $this->_paymentMethodName);


    $transactionId = $_GET['order_id'];
    $modelName = 'model_payment_' . $this->_paymentMethodName;
    if ($_GET['action'] == 'pending')
    {
      $message = 'ignoring PENDING';
    } else
    {
      try
      {
        $status = $this->$modelName->processTransaction($transactionId);
        $message = "Status updated to $status";
      } catch (Pay_Api_Exception $e)
      {
        $message = "Api Error: " . $e->getMessage();
      } catch (Pay_Exception $e)
      {
        $message = "Plugin error: " . $e->getMessage();
      } catch (Exception $e)
      {
        $message = "Unknown error: " . $e->getMessage();
      }
    }
    echo "TRUE|" . $message;
    die();
  }
}
