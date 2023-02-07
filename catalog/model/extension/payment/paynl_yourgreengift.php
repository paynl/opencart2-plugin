<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir . '/Pay/Autoload.php';

require_once $autoload;

class ModelExtensionPaymentPaynlYourgreengift extends Pay_Model
{
    protected $_paymentOptionId = 2925;
    protected $_paymentMethodName = 'paynl_yourgreengift';

    public function getLabel()
    {
        return parent::getLabel();
    }
}