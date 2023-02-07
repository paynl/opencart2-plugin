<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir.'/Pay/Autoload.php';

require_once $autoload;
class ControllerExtensionPaymentPaynlWinkelcheque extends Pay_Controller_Admin {
    protected $_paymentOptionId = 2616;
    protected $_paymentMethodName = 'paynl_winkelcheque';

    protected $_defaultLabel = 'Winkelcheque';


}
