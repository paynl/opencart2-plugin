<?php
$dir = dirname(dirname(dirname(dirname(dirname(__FILE__)))));
$autoload = $dir . '/Pay/Autoload.php';

require_once $autoload;

class ModelExtensionPaymentPaynlCreditclick extends Pay_Model
{
    protected $_paymentOptionId = 2107;
    protected $_paymentMethodName = 'paynl_creditclick';

    public function getLabel()
    {
        return parent::getLabel();
    }
}
