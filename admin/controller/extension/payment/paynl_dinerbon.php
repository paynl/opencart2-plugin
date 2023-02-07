<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ControllerExtensionPaymentPaynlDinerbon extends Pay_Controller_Admin {
    protected $_paymentOptionId = 2670;
    protected $_paymentMethodName = 'paynl_dinerbon';

    protected $_defaultLabel = 'Dinerbon';


}
