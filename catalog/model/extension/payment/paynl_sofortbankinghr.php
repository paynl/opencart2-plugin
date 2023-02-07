<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir . '/Pay/Autoload.php';

require_once $autoload;

class ModelExtensionPaymentPaynlSofortbankinghr extends Pay_Model
{
    protected $_paymentOptionId = 595;
    protected $_paymentMethodName = 'paynl_sofortbankinghr';

    public function getLabel()
    {
        return parent::getLabel();
    }
}