<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <div class="pull-right">
                <button type="submit" form="form-pay" data-toggle="tooltip" title="<?php echo $button_save; ?>"
                        class="btn btn-primary"><i class="fa fa-save"></i></button>
                <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>"
                   class="btn btn-default"><i class="fa fa-reply"></i></a></div>
            <h1><?php echo $heading_title; ?></h1>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($error_warning) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
            </div>
            <div class="panel-body">
                <form action="<?php echo $action; ?>" method="post" class="form-horizontal"
                      enctype="multipart/form-data" id="form-pay">
                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="<?php echo $payment_method_name; ?>_status">Actief</label>
                        <div class="col-sm-10">
                            <select name="<?php echo $payment_method_name; ?>_status"
                                    id="<?php echo $payment_method_name; ?>_status" class="form-control">
                                <?php if ($status) { ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for="<?php echo $payment_method_name; ?>_apitoken">Apitoken</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="<?php echo $payment_method_name; ?>_apitoken"
                                   value="<?php echo $apitoken; ?>"/>
                            <?php if($error_apitoken){ ?>
                            <div class="text-danger"><?php echo $error_apitoken; ?></div>
                            <?php } ?>
                        </div>
                    </div>
                    <div class="form-group required">
                        <label class="col-sm-2 control-label" for="<?php echo $payment_method_name; ?>_serviceid">ServiceId</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="<?php echo $payment_method_name; ?>_serviceid"
                                   value="<?php echo $serviceid; ?>"/>
                            <?php if($error_apitoken){ ?>
                            <div class="text-danger"><?php echo $error_apitoken; ?></div>
                            <?php } ?>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="<?php echo $payment_method_name; ?>_label">Label</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="<?php echo $payment_method_name; ?>_label"
                                   value="<?php echo $label; ?>"/>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="input-geo-zone">Geo zone</label>
                        <div class="col-sm-10">
                            <select name="<?php echo $payment_method_name; ?>_geo_zone_id" id="input-geo-zone"
                                    class="form-control">
                                <option value="0">All Zones</option>
                                <?php foreach ($geo_zones as $geo_zone) { ?>
                                <?php if ($geo_zone['geo_zone_id'] == $geo_zone_id) { ?>
                                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"
                                        selected="selected"><?php echo $geo_zone['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="<?php echo $payment_method_name; ?>_confirm_on_start"><span data-toggle="tooltip"
                                                                                                title="De order bevestigen bij het starten van de transactie, dus voordat er betaald is. De bevestigingsmail wordt dan ook meteen verstuurd">Order bevestigen bij starten transactie</span></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="<?php echo $payment_method_name; ?>_confirm_on_start">
                                <?php if ($confirm_on_start == 1) { ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="<?php echo $payment_method_name; ?>_send_status_updates"><span data-toggle="tooltip"
                                                                                                   title="De gebruiker een email sturen als de status van de bestelling veranderd">Statusupdates versturen</span></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="<?php echo $payment_method_name; ?>_send_status_updates">
                                <?php if ($send_status_updates == 1) { ?>
                                <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                                <option value="0"><?php echo $text_disabled; ?></option>
                                <?php } else { ?>
                                <option value="1"><?php echo $text_enabled; ?></option>
                                <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="<?php echo $payment_method_name; ?>_pending_status"><span data-toggle="tooltip"
                                                                                              title="De status van de transactie wanneer de betaling is gestart, maar nog niet afgerond">Order status pending</span></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="<?php echo $payment_method_name; ?>_pending_status">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                <?php if ($order_status['order_status_id'] == $pending_status) { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>"
                                        selected="selected"><?php echo $order_status['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label"
                               for="<?php echo $payment_method_name; ?>_completed_status"><span data-toggle="tooltip"
                                                                                                title="De status die het order moet krijgen nadat de betaling succesvol is ontvangen">Order status complete</span></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="<?php echo $payment_method_name; ?>_completed_status">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                <?php if ($order_status['order_status_id'] == $completed_status) { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>"
                                        selected="selected"><?php echo $order_status['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="<?php echo $payment_method_name; ?>_canceled_status"><span
                                    data-toggle="tooltip"
                                    title="De status die het order moet krijgen nadat de betaling is geannuleerd">Order status canceled</span></label>
                        <div class="col-sm-10">
                            <select class="form-control" name="<?php echo $payment_method_name; ?>_canceled_status">
                                <?php foreach ($order_statuses as $order_status) { ?>
                                <?php if ($order_status['order_status_id'] == $canceled_status) { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>"
                                        selected="selected"><?php echo $order_status['name']; ?></option>
                                <?php } else { ?>
                                <option value="<?php echo $order_status['order_status_id']; ?>"><?php echo $order_status['name']; ?></option>
                                <?php } ?>
                                <?php } ?>
                            </select>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="<?php echo $payment_method_name; ?>_total">Minimum
                            bedrag</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="<?php echo $payment_method_name; ?>_total"
                                   value="<?php echo $total; ?>"/>

                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="<?php echo $payment_method_name; ?>_totalmax">Maximum
                            bedrag</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control" name="<?php echo $payment_method_name; ?>_totalmax"
                                   value="<?php echo $totalmax; ?>"/>

                        </div>
                    </div>

                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="<?php echo $payment_method_name; ?>_sort_order">Sortering</label>
                        <div class="col-sm-10">
                            <input type="text" class="form-control"
                                   name="<?php echo $payment_method_name; ?>_sort_order"
                                   value="<?php echo $sort_order; ?>"/>

                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label" for="<?php echo $payment_method_name; ?>_instructions">Instructies</label>
                        <div class="col-sm-10">
                            <textarea class="form-control" name="<?php echo $payment_method_name; ?>_instructions" value="<?php echo $instructions; ?>" placeholder="Als u instructies wilt tonen aan de klant, kunt u die hier hier aangeven"  cols="80" rows="10"><?php echo $instructions;?></textarea>
                        </div>
                    </div>

                </form>
            </div>
        </div>
    </div>
</div>
<?php echo $footer; ?>