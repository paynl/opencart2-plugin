<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ControllerExtensionPaymentPaynlCartasi extends Pay_Controller_Payment {
    protected $_paymentOptionId = 1945;
    protected $_paymentMethodName = 'paynl_cartasi';
    
    
}
