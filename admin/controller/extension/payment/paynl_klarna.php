<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ControllerExtensionPaymentPaynlKlarna extends Pay_Controller_Admin {
	protected $_paymentOptionId = 1717;
	protected $_paymentMethodName = 'paynl_klarna';

	protected $_defaultLabel = 'Klarna';

}
