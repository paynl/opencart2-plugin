<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ControllerExtensionPaymentPaynlBoekenbon extends Pay_Controller_Admin {
    protected $_paymentOptionId = 2838;
    protected $_paymentMethodName = 'paynl_boekenbon';

    protected $_defaultLabel = 'Boekenbon';


}
