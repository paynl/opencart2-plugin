<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir . '/Pay/Autoload.php';

require_once $autoload;

class ModelExtensionPaymentPaynlDinerbon extends Pay_Model
{
    protected $_paymentOptionId = 2670;
    protected $_paymentMethodName = 'paynl_dinerbon';

    public function getLabel()
    {
        return parent::getLabel();
    }
}