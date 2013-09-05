{if !$loggedin && $currencies}
<div class="pull-right">
	<form method="post" action="cart.php?gid={$smarty.get.gid}" class="form-inline">
		<fieldset class="alert alert-info">
			<label for="choosecurrency">{$LANG.choosecurrency}</label>: 
			<select id="choosecurrency" name="currency" onchange="submit()">
				{foreach from=$currencies item=curr}
				<option value="{$curr.id}"{if $curr.id eq $currency.id} selected{/if}>{$curr.code}</option>
				{/foreach}
			</select>
		</fieldset>
	</form>
</div>
{/if}

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
			{if $gid eq $productgroup.gid}
  	 		<li class="active"><a href="{$smarty.server.PHP_SELF}?gid={$productgroup.gid}" title="{$productgroup.name}">{$productgroup.name}</a></li>
			{else}
				<li><a href="{$smarty.server.PHP_SELF}?gid={$productgroup.gid}" title="{$productgroup.name}">{$productgroup.name}</a></li>
			{/if}
			{/foreach}
			{if $loggedin}
				<li><a href="{$smarty.server.PHP_SELF}?gid=addons" title="{$LANG.cartproductaddons}">{$LANG.cartproductaddons}</a></li>
				{if $renewalsenabled}<li><a href="{$smarty.server.PHP_SELF}?gid=renewals" title="{$LANG.domainrenewals}">{$LANG.domainrenewals}</a></li>{/if}
			{/if}
				{if $registerdomainenabled}<li><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=register" title="{$LANG.registerdomain}">{$LANG.registerdomain}</a></li>{/if}
				{if $transferdomainenabled}<li><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=transfer" title="{$LANG.transferdomain}">{$LANG.transferdomain}</a></li>{/if}
			</ul>
		</div>
	</div>
	<div class="col-md-9">
		<div class="page-header">
			<h3>{$LANG.cartbrowse}</h3>
		</div>
		<div class="list-group">
		{foreach key=num item=product from=$products}
			<div class="list-group-item">
				<h4 class="list-group-item-heading text-info">{$product.name}{if $product.qty!=""} <small>({$product.qty} {$LANG.orderavailable})</small>{/if}</h4>
				<p class="list-group-item-text">{$product.description}</p>
				<div class="span4 text-center">
					<div>
					{if $product.bid}
						<strong>{$LANG.bundledeal}</strong><br>
						{if $product.displayprice}<div class="lead">{$product.displayprice}</div>{/if}
					{elseif $product.paytype eq "free"}
						<div class="lead" style="margin:10px 0px">{$LANG.orderfree|strtolower|ucfirst}</div>
					{else}
						<strong>{$LANG.startingfrom}</strong><br>
						<div class="lead">
							{$product.pricing.minprice.price} 
							{if $product.pricing.minprice.cycle eq "monthly"}{$LANG.orderpaymenttermmonthly}
							{elseif $product.pricing.minprice.cycle eq "quarterly"}{$LANG.orderpaymenttermquarterly}
							{elseif $product.pricing.minprice.cycle eq "semiannually"}{$LANG.orderpaymenttermsemiannually}
							{elseif $product.pricing.minprice.cycle eq "annually"}{$LANG.orderpaymenttermannually}
							{elseif $product.pricing.minprice.cycle eq "biennially"}{$LANG.orderpaymenttermbiennially}
							{elseif $product.pricing.minprice.cycle eq "triennially"}{$LANG.orderpaymenttermtriennially}
							{/if}
						</div>
					{/if}
					</div>
					{if $product.qty eq "0"}
					<a href="javascript:void(0)" class="btn btn-primary btn-lg disabled">{$LANG.ordernowbutton}</a>
					{else}
					<a href="{$smarty.server.PHP_SELF}?a=add&amp;{if $product.bid}bid={$product.bid}{else}pid={$product.pid}{/if}" class="btn btn-primary btn-lg"><i class="icon icon-shopping-cart icon-white"></i> {$LANG.ordernowbutton}</a>
					{/if}
				</div>
			</div>
		{/foreach}
		</div>

		<div class="text-center">
			<a href="cart.php?a=view" title="{$LANG.viewcart}" class="btn btn-default">{$LANG.viewcart}</a>
		</div>

	</div>
</div>
