<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ModelExtensionPaymentPaynlAmazonpay extends Pay_Model {
	protected $_paymentMethodName = 'paynl_amazonpay';

	public function getLabel(){
		return parent::getLabel();
	}
}
?>