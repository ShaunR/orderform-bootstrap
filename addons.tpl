<div class="page-header">
	<h1>{$LANG.navservicesorder}</h1>
</div>

<div class="row">
	<div class="col-md-3">
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
	<div class="col-md-9">
		<div class="page-header">
			<h3>{$LANG.cartproductaddons}</h3>
		</div>
		{foreach from=$addons item=addon}
		<form method="post" action="{$smarty.server.PHP_SELF}?a=add">
			<input type="hidden" name="aid" value="{$addon.id}">
			<div class="panel panel-default">
				<div class="panel-body">
					<div class="row">
						<div class="col-md-8">
							<h3 class="text-info" style="margin-top:0px">{$addon.name}</h3>
							<p>{$addon.description}</p>
							<hr>
							<fieldset class="form-inline">
								<div class="form-group">
									<label>{$LANG.cartchooseproduct}:</label>
								</div>
								<div class="form-group">
									<select name="productid" class="form-control">
										{foreach from=$addon.productids item=product}
										<option value="{$product.id}">{$product.product}{if $product.domain} - {$product.domain}{/if}</option>
										{/foreach}
									</select>
								</div>
							</fieldset>
						</div>
						<div class="col-md-4 text-center">
							<div class="lead" style="margin-top: 20px;">
								{if $addon.free}
								{$LANG.orderfree}
								{else}
								{$addon.recurringamount} {$addon.billingcycle}
								{if $addon.setupfee}<br />+ {$addon.setupfee} {$LANG.ordersetupfee}{/if}
								{/if}
							</div>
							<button type="submit" class="btn btn-primary btn-large"><span class="glyphicon glyphicon-shopping-cart"></span> {$LANG.ordernowbutton}</button>
						</div>
					</div>
				</div>
			</div>
		</form>
		{/foreach}

		<div class="text-center" style="margin-bottom:30px;">
			<a href="cart.php?a=view" title="{$LANG.viewcart}" class="btn btn-default">{$LANG.viewcart}</a>
		</div>

	</div>
</div>
