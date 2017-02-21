
{capture name=path}{l s='Your addresses'}{/capture}

<div class="my-account-selfcare">
<div class="box">
	<h3 class="page-subheading">{l s='Ajouter une adresse'}</h3>
	<div class="text-center">
	<p class="info-title">
	<!--
		{if isset($id_address) && (isset($smarty.post.alias) || isset($address->alias))}
			{l s='Modify address'}
			{if isset($smarty.post.alias)}
				"{$smarty.post.alias}"
			{else}
				{if isset($address->alias)}"{$address->alias|escape:'html':'UTF-8'}"{/if}
			{/if}
		{else}
			{l s='To add a new address, please fill out the form below.'}
		{/if}
	</p>
	-->
	{include file="$tpl_dir./errors.tpl"}
	<!--<p class="required"><sup>*</sup>{l s='Required field'}</p>-->
	</div>

	<div class="text-center">
	<form action="{$link->getPageLink('address', true)|escape:'html':'UTF-8'}" method="post" class="form-horizontal std" id="add_address">
		<!--h3 class="page-subheading">{if isset($id_address)}{l s='Your address'}{else}{l s='New address'}{/if}</h3-->
		{assign var="stateExist" value=false}
		{assign var="postCodeExist" value=false}
		{assign var="dniExist" value=false}
		{assign var="homePhoneExist" value=false}
		{assign var="mobilePhoneExist" value=false}
		{assign var="atLeastOneExists" value=false}
		{foreach from=$ordered_adr_fields item=field_name}
			<!-- {if $field_name eq 'company'}
				<div class="form-group">
					<label for="company">{l s='Company'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
					<input class="form-control validate" data-validate="{$address_validation.$field_name.validate}" type="text" id="company" name="company" value="{if isset($smarty.post.company)}{$smarty.post.company}{else}{if isset($address->company)}{$address->company|escape:'html':'UTF-8'}{/if}{/if}" />
				</div>
			{/if} -->
			<!--
			{if $field_name eq 'vat_number'}
				<div id="vat_area">
					<div id="vat_number">
						<div class="form-group">
							<label for="vat-number">{l s='VAT number'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
							<input type="text" class="form-control validate" data-validate="{$address_validation.$field_name.validate}" id="vat-number" name="vat_number" value="{if isset($smarty.post.vat_number)}{$smarty.post.vat_number}{else}{if isset($address->vat_number)}{$address->vat_number|escape:'html':'UTF-8'}{/if}{/if}" />
						</div>
					</div>
				</div>
			{/if}

			{if $field_name eq 'dni'}
			{assign var="dniExist" value=true}
			<div class="row required form-group dni">
				<label for="dni" class="col-md-4">{l s='Identification number'} <sup>*</sup></label>
				<div class="col-md-8">
				<input class="form-control" data-validate="{$address_validation.$field_name.validate}" type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{else}{if isset($address->dni)}{$address->dni|escape:'html':'UTF-8'}{/if}{/if}" />
				<span class="form_info">{l s='DNI / NIF / NIE'}</span>
				</div>
			</div>
			{/if}
			-->
			{if $field_name eq 'firstname'}
				<div class="row required form-group">
					<label for="firstname" class="col-md-4 text-right">{l s='First name'} <sup>*</sup></label>
					<div class="col-md-8">
					<input class="is_required validate form-control" data-validation="check_name" data-validation-error-msg="{l s='Merci de saisir un prénom valide.'}" type="text" name="firstname" id="firstname" value="{if isset($smarty.post.firstname)}{$smarty.post.firstname}{else}{if isset($address->firstname)}{$address->firstname|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'lastname'}
				<div class="row required form-group">
					<label for="lastname" class="col-md-4 text-right">{l s='Last name'} <sup>*</sup></label>
					<div class="col-md-8">
					<input class="is_required validate form-control" data-validation="check_name" data-validation-error-msg="{l s='Merci de saisir un nom valide.'}" type="text" id="lastname" name="lastname" value="{if isset($smarty.post.lastname)}{$smarty.post.lastname}{else}{if isset($address->lastname)}{$address->lastname|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}

			{if $field_name eq 'address1'}
				<div class="row required form-group">
					<label for="address1" class="col-md-4 text-right">{l s='Numéro voie'} <sup>*</sup></label>
					<div class="col-md-8">
					<input class="is_required validate form-control" data-validation="check_num_voie" data-validation-error-msg="{l s='Merci de saisir une adresse valide.'}" type="text" id="address1" name="address1" value="{if isset($smarty.post.address1)}{$smarty.post.address1}{else}{if isset($address->address1)}{$address->address1|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'address2'}
				<div class="row required form-group">
					<label for="address2" class="col-md-4 text-right">{l s='Nom voie'}{if isset($required_fields) && in_array($field_name, $required_fields)} <sup>*</sup>{/if}</label>
					<div class="col-md-8">
					<input class="validate form-control" data-validation="check_alpha_num" data-validation-error-msg="{l s='Merci de saisir une adresse valide.'}" type="text" id="address2" name="address2" value="{if isset($smarty.post.address2)}{$smarty.post.address2}{else}{if isset($address->address2)}{$address->address2|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'postcode'}
				{assign var="postCodeExist" value=true}
				<div class="row required postcode form-group unvisible">
					<label for="postcode" class="col-md-4 text-right">{l s='Zip/Postal Code'} <sup>*</sup></label>
					<div class="col-md-8">
					<input class="is_required validate form-control" data-validation="check_cp" data-validation-error-msg="{l s='Merci de saisir un code postal valide.'}" type="text" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{else}{if isset($address->postcode)}{$address->postcode|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if $field_name eq 'city'}
				<div class="row required form-group">
					<label for="city" class="col-md-4 text-right">{l s='City'} <sup>*</sup></label>
					<div class="col-md-8">
					<input class="is_required validate form-control" data-validation="check_alpha_num" data-validation-error-msg="{l s='Merci de saisir une ville valide.'}" type="text" name="city" id="city" value="{if isset($smarty.post.city)}{$smarty.post.city}{else}{if isset($address->city)}{$address->city|escape:'html':'UTF-8'}{/if}{/if}"  />
					</div>
				</div>
				{* if customer hasn't update his layout address, country has to be verified but it's deprecated *}
			{/if}
			{if $field_name eq 'Country:name' || $field_name eq 'country' || $field_name eq 'Country:iso_code'}
				<div class="row required form-group">
					<label for="id_country" class="col-md-4 text-right">{l s='Country'} <sup>*</sup></label>
					<div class="col-md-8">
						<select id="id_country" class="select_title" data-validation="required" data-validation-error-msg="{l s='Merci de sélectionner votre civilité.'}" name="id_country">
						
						{$countries_list}
						</select>
					</div>
				</div>
			{/if}
			<!--
			{if $field_name eq 'State:name'}
				{assign var="stateExist" value=true}
				<div class="row required id_state form-group">
					<label for="id_state" class="col-md-4 text-right">{l s='State'} <sup>*</sup></label>
					<div class="col-md-8">
					<select name="id_state" id="id_state" class="form-control">
						<option value="">-</option>
					</select>
					</div>
				</div>
			{/if}
			-->
			
			<!-- {if $field_name eq 'phone'}
				{assign var="homePhoneExist" value=true}
				<div class="row form-group phone-number">
					<label for="phone" class="col-md-4 text-right">{l s='Home phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
					<div class="col-md-8">
					<input class="{if isset($one_phone_at_least) && $one_phone_at_least}is_required{/if} validate form-control" data-validate="{$address_validation.phone.validate}" type="tel" id="phone" name="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{else}{if isset($address->phone)}{$address->phone|escape:'html':'UTF-8'}{/if}{/if}"  />
					</div>
				</div>
			{/if} -->

			{if $field_name eq 'phone_mobile'}
				{assign var="mobilePhoneExist" value=true}
				<div class="row form-group {if isset($one_phone_at_least) && $one_phone_at_least}required {/if}">
					<label for="phone_mobile" class="col-md-4 text-right">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
					<div class="col-md-8">
					<input class="validate form-control" data-validation="check_phone" data-validation-error-msg="{l s='Merci de saisir un numéro de téléphone valide. '}" data-validation-optional="true" type="tel" id="phone_mobile" name="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{else}{if isset($address->phone_mobile)}{$address->phone_mobile|escape:'html':'UTF-8'}{/if}{/if}" />
					</div>
				</div>
			{/if}
			{if ($field_name eq 'phone_mobile') || ($field_name eq 'phone_mobile') && !isset($atLeastOneExists) && isset($one_phone_at_least) && $one_phone_at_least}
				{assign var="atLeastOneExists" value=true}
				
			{/if}
		{/foreach}

		<!-- ERROR -->

		{if !$postCodeExist}
			<div class="required postcode form-group unvisible">
				<label for="postcode">{l s='Zip/Postal Code'} <sup>*</sup></label>
				<input class="is_required validate form-control" data-validate="{$address_validation.postcode.validate}" type="text" id="postcode" name="postcode" value="{if isset($smarty.post.postcode)}{$smarty.post.postcode}{else}{if isset($address->postcode)}{$address->postcode|escape:'html':'UTF-8'}{/if}{/if}" />
			</div>
		{/if}
		<!--
		{if !$stateExist}
			<div class="required id_state form-group unvisible">
				<label for="id_state">{l s='State'} <sup>*</sup></label>
				<select name="id_state" id="id_state" class="form-control">
					<option value="">-</option>
				</select>
			</div>
		{/if}
		-->
		{if !$dniExist}
			<div class="required dni form-group unvisible">
				<label for="dni">{l s='Identification number'} <sup>*</sup></label>
				<input class="is_required form-control" data-validate="{$address_validation.dni.validate}" type="text" name="dni" id="dni" value="{if isset($smarty.post.dni)}{$smarty.post.dni}{else}{if isset($address->dni)}{$address->dni|escape:'html':'UTF-8'}{/if}{/if}" />
				<span class="form_info">{l s='DNI / NIF / NIE'}</span>
			</div>
		{/if}
		<!-- end ERROR -->


		<div class="row form-group">
			<label for="other" class="col-md-4 text-right">{l s='Complément adresse'}</label>
			<div class="col-md-8">
			<textarea class="validate form-control" data-validation="length" data-validation-length="2-38" data-validation-error-msg="{l s='Merci de saisir une adresse valide. '}" data-validation-optional="true" id="other" name="other" cols="26" rows="3" >{if isset($smarty.post.other)}{$smarty.post.other}{else}{if isset($address->other)}{$address->other|escape:'html':'UTF-8'}{/if}{/if}</textarea>
			</div>
		</div>

		<!-- ERROR -->
		{if !$homePhoneExist}
			<div class="form-group phone-number">
				<label for="phone">{l s='Home phone'}</label>
				<input class="{if isset($one_phone_at_least) && $one_phone_at_least}is_required{/if} validate form-control" data-validate="{$address_validation.phone.validate}" type="tel" id="phone" name="phone" value="{if isset($smarty.post.phone)}{$smarty.post.phone}{else}{if isset($address->phone)}{$address->phone|escape:'html':'UTF-8'}{/if}{/if}"  />
			</div>
		{/if}
		<div class="clearfix"></div>
		{if !$mobilePhoneExist}
			<div class="{if isset($one_phone_at_least) && $one_phone_at_least}required {/if}form-group">
				<label for="phone_mobile">{l s='Mobile phone'}{if isset($one_phone_at_least) && $one_phone_at_least} <sup>**</sup>{/if}</label>
				<input class="validate form-control" data-validate="{$address_validation.phone_mobile.validate}" type="tel" id="phone_mobile" name="phone_mobile" value="{if isset($smarty.post.phone_mobile)}{$smarty.post.phone_mobile}{else}{if isset($address->phone_mobile)}{$address->phone_mobile|escape:'html':'UTF-8'}{/if}{/if}" />
			</div>
		{/if}
		{if isset($one_phone_at_least) && $one_phone_at_least && !$atLeastOneExists}
			<p class="inline-infos required">{l s='You must register at least one phone number.'}</p>
		{/if}
		<!-- End Error -->


		<div class="row required form-group" id="adress_alias">
			<label for="alias" class="col-md-4 text-right">{l s='Please assign an address title for future reference.'} <sup>*</sup></label>
			<div class="col-md-8">
			<input type="text" id="alias" class="is_required validate form-control" data-validate="{$address_validation.alias.validate}" name="alias" value="{if isset($smarty.post.alias)}{$smarty.post.alias}{elseif isset($address->alias)}{$address->alias|escape:'html':'UTF-8'}{elseif !$select_address}{l s='My address'}{/if}" />
			</div>
		</div>

		<div class="row">
			<p class="submit2">
				{if isset($id_address)}<input type="hidden" name="id_address" value="{$id_address|intval}" />{/if}
				{if isset($back)}<input type="hidden" name="back" value="{$back}" />{/if}
				{if isset($mod)}<input type="hidden" name="mod" value="{$mod}" />{/if}
				{if isset($select_address)}<input type="hidden" name="select_address" value="{$select_address|intval}" />{/if}
				<input type="hidden" name="token" value="{$token}" />
				<button type="submit" name="submitAddress" id="submitAddress" class="btn btn-default button button-medium">
					<span>
						{l s='Save'}
						<i class="icon-chevron-right right"></i>
					</span>
				</button>
			</p>
		</div>

	</form>
</div>		
</div>
</div> <!-- end my-account-selfcare -->

<ul class="footer_links clearfix">
	<li>
		<a class="btn btn-defaul button button-small" href="{$link->getPageLink('addresses', true)|escape:'html':'UTF-8'}">
			<span><i class="icon-chevron-left"></i> {l s='Back to your addresses'}</span>
		</a>
	</li>
</ul>
{strip}
{if isset($smarty.post.id_state) && $smarty.post.id_state}
	{addJsDef idSelectedState=$smarty.post.id_state|intval}
{elseif isset($address->id_state) && $address->id_state}
	{addJsDef idSelectedState=$address->id_state|intval}
{else}
	{addJsDef idSelectedState=false}
{/if}
{if isset($smarty.post.id_country) && $smarty.post.id_country}
	{addJsDef idSelectedCountry=$smarty.post.id_country|intval}
{elseif isset($address->id_country) && $address->id_country}
	{addJsDef idSelectedCountry=$address->id_country|intval}
{else}
	{addJsDef idSelectedCountry=false}
{/if}
{if isset($countries)}
	{addJsDef countries=$countries}
{/if}
{if isset($vatnumber_ajax_call) && $vatnumber_ajax_call}
	{addJsDef vatnumber_ajax_call=$vatnumber_ajax_call}
{/if}
{/strip}
<script>
	$.formUtils.addValidator({
      name : 'check_name',
      validatorFunction : function(value) {
        var regex = /^[a-zA-Zéèïçà^îù¨ê-]+[ \-']?[[a-zA-Zéèïçà^îù¨ê-]+$/;
        return ( (value.length >= 2 && value.length <= 28) && (regex.test(value))) 
      }
    });
    $.formUtils.addValidator({
      name : 'check_num_voie',
      validatorFunction : function(value) {
        return ( (value.length >= 1 && value.length <= 5) && (parseFloat(value) == parseInt(value)) && !isNaN(value)) 
      }
    });
    $.formUtils.addValidator({
      name : 'check_alpha_num',
      validatorFunction : function(value) {
        return ( (value.length >= 2 && value.length <= 38) && (value.toString().match(/^[A-Za-z0-9éèïçà^îù¨-ê-]+$/)))  
      }
    });
    $.formUtils.addValidator({
      name : 'check_phone',
      validatorFunction : function(value) {
        start = value.substr(0, 2);
		var array = ["01", "02", "03", "04", "05", "06", "07", "09"];
		return ( value.length == 10  && (parseFloat(value) == parseInt(value)) && !isNaN(value) && array.indexOf(start) >= 0) 
      }
    });
    $.formUtils.addValidator({
      name : 'check_cp',
      validatorFunction : function(value) {
        return ( value.length == 5  && (parseFloat(value) == parseInt(value)) && !isNaN(value)) 
      }
    });
    $.validate({
            lang : 'fr',
            modules : 'file,html5,sanitize,toggleDisabled,security',
            form : '#add_address'
    });
    $("#firstname").focus();
</script>