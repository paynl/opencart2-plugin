<?php
$dir = dirname(dirname(dirname(dirname(__FILE__))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ControllerPaymentPaynlGivacard extends Pay_Controller_Admin {
    protected $_paymentOptionId = 1657;
    protected $_paymentMethodName = 'paynl_givacard';
    
    protected $_defaultLabel = 'Givacard';
    
    
}
