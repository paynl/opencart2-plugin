<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir . '/Pay/Autoload.php';

require_once $autoload;

class ModelExtensionPaymentPaynlMinitixsms extends Pay_Model
{
    protected $_paymentOptionId = 808;
    protected $_paymentMethodName = 'paynl_minitixsms';

    public function getLabel()
    {
        return parent::getLabel();
    }
}