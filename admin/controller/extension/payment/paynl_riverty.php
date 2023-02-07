<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ControllerExtensionPaymentPaynlRiverty extends Pay_Controller_Admin {
    protected $_paymentOptionId = 2561;
    protected $_paymentMethodName = 'paynl_riverty';

    protected $_defaultLabel = 'Riverty';


}
