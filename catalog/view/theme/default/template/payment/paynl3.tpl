<?php define('ACHTERAF_BETAALMETHODEN', json_encode(array(739,1924,740,1672,1675,1673,1744,1813,1702,1703,1717))); ?>

<div id="paynl_payment"></div>
<?php
if(!empty($instructions)){
?>
<div class="well well-sm">
    <p><?php echo nl2br($instructions); ?></p>
</div>
<?php } ?>

<?php if(in_array($paymentOptionId,json_decode(ACHTERAF_BETAALMETHODEN))) { ?>

    <div class="row">
        <div class="alert alert-danger" id="dobEmpty">Geboorte datum is verplicht</div>
        <div class="alert alert-danger" id="dobInvalid">Geboorte datum is onjuist</div>
        <div class="form-group">
            <label>Geboortedatum</label>
            <input type="text" placeholder="dd-mm-yyyy" class="form-control" id="dob"/>
        </div>
    </div>


<?php } ?>
<?php
if(!empty($optionSubList)){
?>
<div class="buttons">
    <div class="pull-right">

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
<?php } ?>
<div class="buttons">
    <div class="pull-right">
        <input onclick="startTransaction();"  value="<?php echo $button_confirm; ?>" type="button" data-loading-text="<?php echo $button_loading; ?>"  id="button-confirm" class="btn btn-primary" />
    </div>
</div>

<script type="text/javascript">
    jQuery('.alert').hide();
    function startTransaction() {
        var data = {};
        if (jQuery('#optionsub') != undefined) {
            data.optionSubId = jQuery('#optionsub').val();
        }

        if (jQuery('#dob') != undefined) {
            if(jQuery('#dob').val() == "")
            {
                jQuery('#dobEmpty').show();
                return;
            }
            else {
                jQuery('#dobEmpty').hide();
            }


            var dob = jQuery('#dob').val().match(/^(\d{1,2})-(\d{1,2})-(\d{4})$/);

            if(!dob
            || !new Date(dob[3], dob[2], dob[1]))
            {
                jQuery('#dobInvalid').show();
                return;
            }else{
                jQuery('#dobInvalid').hide();
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
