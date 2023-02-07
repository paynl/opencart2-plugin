<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir . '/Pay/Autoload.php';

require_once $autoload;

class ModelExtensionPaymentPaynlBiller extends Pay_Model
{
    protected $_paymentOptionId = 2931;
    protected $_paymentMethodName = 'paynl_biller';

    public function getLabel()
    {
        return parent::getLabel();
    }
}