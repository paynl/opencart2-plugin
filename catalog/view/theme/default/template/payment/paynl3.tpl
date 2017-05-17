<div id="paynl_payment"></div>
<?php
if(!empty($instructions)){
?>
<div class="well well-sm">
    <p><?php echo nl2br($instructions); ?></p>
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
    function startTransaction() {
        var data = {};
        if (jQuery('#optionsub') != undefined) {
            data.optionSubId = jQuery('#optionsub').val();
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
