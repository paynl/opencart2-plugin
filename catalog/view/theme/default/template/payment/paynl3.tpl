<?php
$arrPaylater = array(739,1924,740,1672,1675,1673,1744,1813,1702,1703,1717);
?>
<div id="paynl_payment"></div>
<?php
if(!empty($instructions)){
?>
<div class="well well-sm">
    <p><?php echo nl2br($instructions); ?></p>
</div>
<?php } ?>

<?php if(in_array($paymentOptionId,$arrPaylater)) { ?>
<form class="form-horizontal">
    <div class="form-group required">
        <label class="control-label col-sm-2" for="dob">Geboortedatum</label>
        <div class="col-sm-10">
            <input type="text" name="dob" placeholder="dd-mm-yyyy" class="form-control" id="dob"/>
        </div>
    </div>
</form>
<?php } ?>
<?php
if(!empty($optionSubList)){
?>
<form class="form-horizontal">
    <div class="form-group ">
        <label class="control-label col-sm-2" for="optionsub">Bank</label>
        <div class="col-sm-10">
            <select class="form-control" id="optionsub">
                <option value=''>Kies uw bank</option>
                <?php
        foreach($optionSubList as $optionSub){
        echo "<option value='".$optionSub['id']."'>".$optionSub['name']."</option>";
                }
                ?>
            </select>
        </div>
    </div>
</form>
<?php } ?>
<div class="buttons">
    <div class="pull-right">
        <input onclick="startTransaction();" value="<?php echo $button_confirm; ?>" type="button"
               data-loading-text="<?php echo $button_loading; ?>" id="button-confirm" class="btn btn-primary"/>
    </div>
</div>

<script type="text/javascript">

    function startTransaction() {
        var data = {};
        if (jQuery('#optionsub') != undefined && jQuery('#optionsub').val() != undefined) {
            data.optionSubId = jQuery('#optionsub').val();
        }

        if (jQuery('#dob') != undefined && jQuery('#dob').val() != undefined) {
            if (jQuery('#dob').val() == "") {
                if (typeof triggerLoadingOff === 'function') {
                    // journal checkout cancel loading
                    triggerLoadingOff();
                }

                jQuery('#dob').parent().parent().addClass('has-error')
                jQuery('#dob').before('<div class="text-danger">Geboorte datum is verplicht</div>');
                return;
            }
            else {
                jQuery('#dob').parent().parent().removeClass('has-error');
                jQuery('#dob').siblings('.text-danger').remove();
            }

            var dob = jQuery('#dob').val().match(/^(\d{1,2})-(\d{1,2})-(\d{4})$/);

            if (!dob
                || !new Date(dob[3], dob[2], dob[1])) {
                if (typeof triggerLoadingOff === 'function') {
                    // journal checkout cancel loading
                    triggerLoadingOff();
                }
                jQuery('#dob').before('<div class="text-danger">Geboortedatum is ongeldig</div>');
                jQuery('#dob').parent().parent().addClass('has-error');
                return;
            } else {
                jQuery('#dob').parent().parent().removeClass('has-error');
                jQuery('#dob').siblings('.text-danger').remove();
            }
            data.dob = jQuery('#dob').val();
        }

        jQuery.ajax({
            url: 'index.php?route=extension/payment/<?php echo $paymentMethodName;?>/startTransaction',
            dataType: 'json',
            data: data,
            type: 'POST',
            beforeSend: function () {
                $('#button-confirm').button('loading');
            },
            complete: function () {
            },
            success: function (json) {
                $('.alert').remove();

                if (json['error']) {
                    $('#paynl_payment').before('<div class="alert alert-danger">' + json['error'] + '</div>');
                }

                if (json['success']) {
                    location = json['success']
                }
            }
        });
    }
</script>