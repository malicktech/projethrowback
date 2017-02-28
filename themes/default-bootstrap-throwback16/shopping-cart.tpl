{*
* 2007-2016 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2016 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

{capture name=path}{l s='Your shopping cart'}{/capture}
<!--
<h1 id="cart_title" class="page-heading">{l s='Shopping-cart summary'}
	{if !isset($empty) && !$PS_CATALOG_MODE}
		<span class="heading-counter">{l s='Your shopping cart contains:'}
			<span id="summary_products_quantity">{$productNumber} {if $productNumber == 1}{l s='product'}{else}{l s='products'}{/if}</span>
		</span>
	{/if}
</h1>
-->
{if isset($account_created)}
	<p class="alert alert-success">
		{l s='Your account has been created.'}
	</p>
{/if}
{*
{assign var='current_step' value='summary'}
{include file="$tpl_dir./order-steps.tpl"}
*}
{include file="$tpl_dir./errors.tpl"}

{if isset($empty)}
	<p class="alert alert-warning">{l s='Your shopping cart is empty.'}</p>
{elseif $PS_CATALOG_MODE}
	<p class="alert alert-warning">{l s='This store has not accepted your new order.'}</p>
{else}
	<p id="emptyCartWarning" class="alert alert-warning unvisible">{l s='Your shopping cart is empty.'}</p>
	{if isset($lastProductAdded) AND $lastProductAdded}
		<div class="cart_last_product">
			<div class="cart_last_product_header">
				<div class="left">{l s='Last product added'}</div>
			</div>
			<a class="cart_last_product_img" href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, $lastProductAdded.id_shop)|escape:'html':'UTF-8'}">
				<img src="{$link->getImageLink($lastProductAdded.link_rewrite, $lastProductAdded.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$lastProductAdded.name|escape:'html':'UTF-8'}"/>
			</a>
			<div class="cart_last_product_content">
				<p class="product-name">
					<a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
						{$lastProductAdded.name|escape:'html':'UTF-8'}
					</a>
				</p>
				{if isset($lastProductAdded.attributes) && $lastProductAdded.attributes}
					<small>
						<a href="{$link->getProductLink($lastProductAdded.id_product, $lastProductAdded.link_rewrite, $lastProductAdded.category, null, null, null, $lastProductAdded.id_product_attribute)|escape:'html':'UTF-8'}">
							{$lastProductAdded.attributes|escape:'html':'UTF-8'}
						</a>
					</small>
				{/if}
			</div>
		</div>
	{/if}
	{assign var='total_discounts_num' value="{if $total_discounts != 0}1{else}0{/if}"}
	{assign var='use_show_taxes' value="{if $use_taxes && $show_taxes}2{else}0{/if}"}
	{assign var='total_wrapping_taxes_num' value="{if $total_wrapping != 0}1{else}0{/if}"}
	{* eu-legal *}
	{hook h="displayBeforeShoppingCartBlock"}
	<div id="order-detail-content" class="table_block table-responsive">
		<div class="row">
				<div class="col-md-9">
					{assign var='odd' value=0}
					{assign var='have_non_virtual_products' value=false}
					{foreach $products as $product}
						{* {$product|var_dump} *}
						{assign var="productId" value=$product.id_product}
						{assign var="attributes" value=$product.attributes}
						{assign var="split_size" value=","|explode:$attributes}
						{assign var="result_size" value=":"|explode:$split_size[0]}
						{assign var="sizing" value=$result_size[1]|trim}

				<form id="buy_block"{if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
						<div id="product_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product line_product_{$product.id_product}">
							<div class="col-md-2 img-line">
								<a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}"><img src="{$link->getImageLink($product.link_rewrite, $product.id_image, 'small_default')|escape:'html':'UTF-8'}" alt="{$product.name|escape:'html':'UTF-8'}" {if isset($smallSize)}width="{$smallSize.width}" height="{$smallSize.height}" {/if} /></a>
							</div>

							<div class="col-md-9">
								<p class="product-name"><a href="{$link->getProductLink($product.id_product, $product.link_rewrite, $product.category, null, null, $product.id_shop, $product.id_product_attribute, false, false, true)|escape:'html':'UTF-8'}">{$product.name|escape:'html':'UTF-8'}</a></p>
								<br><br>

								<div class="row">

									<div class="col-md-3">
									{addJsDef quantityAvailable=$product.quantity_available}
										<p id="quantity_wanted_p" class="quantity_{$product.id_product}_{$product.id_product_attribute}" style="display: none">
											<label>{l s='Quantity'}</label>
											<input type="number" min="1" name="qty" id="quantity_wanted" class="text" value="{$product.cart_quantity}" />
											<a href="#" data-field-qty="qty" class="btn btn-default button-minus product_quantity_down">
												<img src="{$base_dir}/img/icones/size_down.png"/>
											</a>
											<a href="#" data-field-qty="qty" class="btn btn-default button-plus product_quantity_up">
												<img src="{$base_dir}/img/icones/size_up.png"/>
											</a>
										</p>
										<p class="attributes_line_{$product.id_product}_{$product.id_product_attribute}">
											<label>{l s='Quantity'}</label>
											<span class="size_line">{$product.cart_quantity}</span>
										</p>
									</div>

									<div class="col-md-5">
											<div class="attributes_to_modify_{$product.id_product}_{$product.id_product_attribute}" style="display: none">
												<div class="row">
													{if isset($groups)}
														<div id="attributes">
															<div class="attribute_list">
																<label class="attribute_label" >{l s='Taille'}</label>
																{foreach from=$groups[$product.id_product] key=id_attribute_group item=group}
																	{if $group.attributes|@count}
																	<fieldset class="attribute_fieldset">
																		
																		{assign var="groupName" value="group_"|cat:$productId|cat:"_"|cat:$product.id_product_attribute}
																		 
																		<div class="attribute_list">
																			
																			{if ($group.group_type == 'radio')}
																				<ul>
																					{foreach from=$group.attributes key=id_attribute item=group_attribute}
																					
																						<li>
																							<input type="radio" class="attribute_radio" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}" 
																							{if ($group_attribute == $sizing)} checked="checked"{/if} />
																							<span>{$group_attribute|escape:'html':'UTF-8'}</span>
																						</li>
																					{/foreach}
																				</ul>
																			{/if}
																		</div> <!-- end attribute_list -->
																	</fieldset>
																	{/if}
																{/foreach}
															</div>
														</div>
													{/if}
												</div>
											</div>

											<p class="attributes_line_{$product.id_product}_{$product.id_product_attribute}">
												<label>{l s='Taille'}</label>
												<span class="size_line">
													{$sizing}
												</span>
											</p>
									</div>

									<div class="col-md-4">
										{if !$priceDisplay}
											<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.price_wt}</span>
										{else}
						               	 	<span class="price{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies} {/if}">{convertPrice price=$product.price}</span>
										{/if}
										{if isset($product.is_discounted) && $product.is_discounted && isset($product.reduction_applies) && $product.reduction_applies}
										<span class="reduction-text">
											{if !$priceDisplay}
					            				{if isset($product.reduction_type) && $product.reduction_type == 'amount'}
					                    			{assign var='priceReduction' value=($product.price_wt - $product.price_without_specific_price)}
					                    			{assign var='symbol' value=$currency->sign}
					                    		{else}
					                    			{assign var='priceReduction' value=(($product.price_without_specific_price - $product.price_wt)/$product.price_without_specific_price) * 100 * -1}
					                    			{assign var='symbol' value='%'}
					                    		{/if}
											{else}
												{if isset($product.reduction_type) && $product.reduction_type == 'amount'}
													{assign var='priceReduction' value=($product.price - $product.price_without_specific_price)}
													{assign var='symbol' value=$currency->sign}
												{else}
													{assign var='priceReduction' value=(($product.price_without_specific_price - $product.price)/$product.price_without_specific_price) * -100}
													{assign var='symbol' value='%'}
												{/if}
											{/if}
											{if $symbol == '%'}
												&nbsp;{$priceReduction|string_format:"%.2f"|regex_replace:"/[^\d]0+$/":""}{$symbol}&nbsp;
											{else}
												&nbsp;{convertPrice price=$priceReduction}&nbsp;
											{/if}
										</span>
										<span class="old-price">{convertPrice price=$product.price_without_specific_price}</span>
										
										{/if}
									</div>

								</div>
								<div class="row">
									<div class="col-md-12 margin-top-10">
										<span class="dispo-text">{if $product.quantity_available <= 0}{if isset($product.allow_oosp) && $product.allow_oosp}{if isset($product.available_later) && $product.available_later}{$product.available_later}{else}{l s='In Stock'}{/if}{else}{l s='Out of stock'}{/if}{else}{if isset($product.available_now) && $product.available_now}{l s='Disponible'}{else}{l s='In Stock'}{/if}{/if}
										</span>
									</div>
								</div>
								<div class="row buttons_line_{$product.id_product}_{$product.id_product_attribute}" style="display: none">
										<div class="col-md-6 text-right">
											<button class="buttons_modify buttons_modify_line_{$product.id_product}_{$product.id_product_attribute}" type="submit">
											<span>{l s='VALIDER'}</span>
											</button>
										</div>
										<div class="col-md-6">
											<button class="buttons_modify buttons_cancel_line_{$product.id_product}_{$product.id_product_attribute}" type="submit">
											<span>{l s='ANNULER'}</span>
											</button>
										</div>
								</div>
							</div>

							<div class="col-md-1">
								<div class="row">
									
									<div class="col-md-6 edit">
										<a href="{$product.id_product}_{$product.id_product_attribute}" title="Modifier l'article" href="javascript:void(0)"><i class="fa fa-pencil-square-o fa-2x icone-active" aria-hidden="true"></i></a>
									</div>
									
									<div class="col-md-6">
										<a
											id="{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}"
											class="cart_quantity_delete"
											href="{$link->getPageLink('cart', true, NULL, "delete=1&amp;id_product={$product.id_product|intval}&amp;ipa={$product.id_product_attribute|intval}&amp;id_customization=0&amp;id_address_delivery={$product.id_address_delivery}&amp;token={$token_cart}")|escape:'html':'UTF-8'}"
											rel="nofollow"
											title="{l s='Delete'}">
											X
										</a>
									</div>
								</div>
							</div>
						</div>
						
					</form>		
					{/foreach}
				</div>

				

				<div class="col-md-3">
					<div class="row commande_title text-center">
						<div class="col-md-12">
							{l s='VOTRE COMMANDE'}
						</div>
					</div>
					<div class="row commande_body">
						{foreach $products as $product}
						<div id="facturette_{$product.id_product}_{$product.id_product_attribute}_0_{$product.id_address_delivery|intval}{if !empty($product.gift)}_gift{/if}" class="row row_line_product_commande">
								<div class="col-md-8">
									<p class="command-product-name">{$product.name|escape:'html':'UTF-8'}</p>
								</div>

								<div class="col-md-4 text-right">
										{if !$priceDisplay}{displayPrice price=$product.total_wt}{else}{displayPrice price=$product.total}{/if}
								</div>
						</div>
						{/foreach}

						<div class="row line_product">
								<div class="col-md-8">
									<p class="command-product-name total"><span>{l s='Total'|upper}</span></p>
								</div>

								<div class="col-md-4 text-right total">
										{if $use_taxes}
										<span id="total_price">{displayPrice price=$total_price}</span>
										{else}
										<span id="total_price">{displayPrice price=$total_price_without_tax}</span>
										{/if}
								</div>
						</div>
					</div>
					<div class="row commande_button text-center">
						<div class="col-md-12">	
							{if !$opc}
								<a  href="{if $back}{$link->getPageLink('order', true, NULL, 'step=1&amp;back={$back}')|escape:'html':'UTF-8'}{else}{$link->getPageLink('order', true, NULL, 'step=1')|escape:'html':'UTF-8'}{/if}"  title="{l s='Proceed to checkout'}">
									<span class="text_valid_commande">{l s='Valider mon panier'} <i class="icon-chevron-right right"></i></span>
								</a>
							{/if}
						</div>
					</div>

					<div class="row text-center">
						<div class="col-md-12">	
						<p class="cart_navigation clearfix">
							<a href="{$base_dir}" class="button-exclusive btn btn-default continue_shoping" title="{l s='Continue shopping'}">
							<i class="icon-chevron-left"></i>{l s='Continuer mon shopping'}
						</a>
						</p>
						</div>
					</div>
				</div>

		</div>
	</div> <!-- end order-detail-content -->

	{if $show_option_allow_separate_package}
	<p>
		<label for="allow_seperated_package" class="checkbox inline">
			<input type="checkbox" name="allow_seperated_package" id="allow_seperated_package" {if $cart->allow_seperated_package}checked="checked"{/if} autocomplete="off"/>
			{l s='Send available products first'}
		</label>
	</p>
	{/if}

	{* Define the style if it doesn't exist in the PrestaShop version*}
	{* Will be deleted for 1.5 version and more *}


	<div id="HOOK_SHOPPING_CART">{$HOOK_SHOPPING_CART}</div>
	
{strip}
{addJsDef deliveryAddress=$cart->id_address_delivery|intval}
{addJsDefL name=txtProduct}{l s='product' js=1}{/addJsDefL}
{addJsDefL name=txtProducts}{l s='products' js=1}{/addJsDefL}

{addJsDef quantityLimitedAvailable=10}
{addJsDef allowBuyWhenOutOfStock=false}
<!-- assign quantity variable to product.js   -->
{foreach $products as $product}			
	{addJsDef quantityAvailable=$product.quantity_available}
{/foreach}

{addJsDef attributesCombinations="test"}


{/strip}
{/if}

<link href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" rel="stylesheet" data-semver="3.1.1" data-require="bootstrap-css" />
<script>
		    $( document ).ready(function() {
			   $( ".edit a" ).on( "click", function(e) {
			   		e.preventDefault();
			   		var line = $(this).attr('href');
			   		var radio_choice = $( ".attributes_to_modify_"+line+ " input[type='radio']:checked").val();
			   		$( ".attributes_line_"+line ).hide();
			   		$( ".quantity_"+line ).show();
			   		$( ".attributes_to_modify_"+line ).show();
			   		$( ".buttons_line_"+line ).show();

			   		//console.log($( ".attributes_to_modify_"+line+ " input[type='radio']:checked").val());



			   			$( ".buttons_cancel_line_"+line ).on( "click", function(e) {
					   		e.preventDefault();
					   		$( ".attributes_line_"+line ).show();
					   		$( ".quantity_"+line ).hide();
					   		$( ".attributes_to_modify_"+line ).hide();
					   		$( ".buttons_line_"+line ).hide();

					   		//$("input[name=group_"+line+"][value=" + radio_choice + "]").attr('checked', 'checked');
					   		//console.log($("input[name=group_"+line+"][value=" + radio_choice + "]").attr('checked', 'checked'));
					   		//$(".attributes_to_modify_"+line+ "[value=" + radio_choice + "]").attr('checked', 'checked');
			   			});
			   });

			   
		    });
		
    </script>

