<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir . '/Pay/Autoload.php';

require_once $autoload;

class ModelExtensionPaymentPaynlBlik extends Pay_Model
{
    protected $_paymentOptionId = 2856;
    protected $_paymentMethodName = 'paynl_blik';

    public function getLabel()
    {
        return parent::getLabel();
    }
}