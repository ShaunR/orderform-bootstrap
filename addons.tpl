<div class="page-header">
	<h1>{$LANG.navservicesorder}</h1>
</div>

<div class="row">
	<div class="span3">
		<div class="page-header">
			<h3>{$LANG.ordertitle} {$LANG.ordercategories}</h3>
		</div>
		<div>
			<ul class="nav nav-pills nav-stacked">
				{foreach key=num item=productgroup from=$productgroups}
				<li><a href="{$smarty.server.PHP_SELF}?gid={$productgroup.gid}" title="{$productgroup.name}">{$productgroup.name}</a></li>
				{/foreach}
				{if $loggedin}
				<li class="active"><a href="{$smarty.server.PHP_SELF}?gid=addons" title="{$LANG.cartproductaddons}">{$LANG.cartproductaddons}</a></li>
				{if $renewalsenabled}<li><a href="{$smarty.server.PHP_SELF}?gid=renewals" title="{$LANG.domainrenewals}">{$LANG.domainrenewals}</a></li>{/if}
				{/if}
				{if $registerdomainenabled}<li><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=register" title="{$LANG.registerdomain}">{$LANG.registerdomain}</a></li>{/if}
				{if $transferdomainenabled}<li><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=transfer" title="{$LANG.transferdomain}">{$LANG.transferdomain}</a></li>{/if}
			</ul>
		</div>
	</div>
	<div class="span9">
		<div class="page-header">
			<h3>{$LANG.cartproductaddons}</h3>
		</div>
		<ul class="thumbnails">
			{foreach from=$addons item=addon}
			<li class="thumbnail span9">
				<form method="post" action="{$smarty.server.PHP_SELF}?a=add">
					<input type="hidden" name="aid" value="{$addon.id}">
					<div class="row-fluid" style="padding: 0px 10px 10px 10px;">
						<div class="span8">
							<h3 class="text-info">{$addon.name}</h3>
							<p>{$addon.description}</p>
							<fieldset class="form-inline">
								<label><strong>{$LANG.cartchooseproduct}</strong></label>
								<select name="productid">
									{foreach from=$addon.productids item=product}
									<option value="{$product.id}">{$product.product}{if $product.domain} - {$product.domain}{/if}</option>
									{/foreach}
								</select>
							</fieldset>
						</div>
						<div class="span4 textcenter">
							<div class="lead" style="margin-top: 20px;">
								{if $addon.free}
								{$LANG.orderfree}
								{else}
								{$addon.recurringamount} {$addon.billingcycle}
								{if $addon.setupfee}<br />+ {$addon.setupfee} {$LANG.ordersetupfee}{/if}
								{/if}
							</div>
							<button type="submit" class="btn btn-primary btn-large"><i class="icon icon-shopping-cart icon-white"></i> {$LANG.ordernowbutton}</button>
						</div>
					</div>
				</form>
			</li>
		{/foreach}

		<div class="textcenter" style="margin-bottom:30px;">
			<a href="cart.php?a=view" title="{$LANG.viewcart}" class="btn">{$LANG.viewcart}</a>
		</div>

	</div>
</div>
