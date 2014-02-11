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
			{if $registerdomainenabled}<li{if $domain eq "register"} class="active"{/if}><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=register" title="{$LANG.registerdomain}">{$LANG.registerdomain}</a></li>{/if}
			{if $transferdomainenabled}<li{if $domain eq "transfer"} class="active"{/if}><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=transfer" title="{$LANG.transferdomain}">{$LANG.transferdomain}</a></li>{/if}
		</ul>
	</div>
	<div class="col-md-9">
		<div class="page-header">
			<h3>{if $domain eq "register"}{$LANG.registerdomainname}{else}{$LANG.transferdomainname}{/if}</h3>
		</div>
		<p>{if $domain eq "register"}{$LANG.registerdomaindesc}{else}{$LANG.transferdomaindesc}{/if}</p>
		<form method="post" action="{$smarty.server.PHP_SELF}?a=add&domain={$domain}" class="form-inline">
			<fieldset class="well text-center">
				<div class="form-group">
					<input type="text" id="sld" name="sld" size="40" value="{$sld}" class="form-control">
				</div>
				<div class="form-group">
					<select name="tld" class="form-control">
					{foreach key=num item=listtld from=$tlds}
						<option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>{$listtld}</option>
					{/foreach}
					</select>
				</div>
				<div class="form-group">
					<input type="submit" class="btn btn-primary" value="{$LANG.checkavailability}">
				</div>
			</fieldset>
		</form>
		{if $availabilityresults}
		<h3>{$LANG.choosedomains}</h3>
		<form method="post" action="{$smarty.server.PHP_SELF}?a=add&domain={$domain}">
			<div class="panel panel-default">
				<table class="table">
					<thead>
						<tr>
							<th>{$LANG.domainname}</th>
							<th>{$LANG.domainstatus}</th>
							<th>{$LANG.domainmoreinfo}</th>
						</tr>
					</thead>
					<tbody>
						{foreach key=num item=result from=$availabilityresults}
						<tr>
							<td><p class="form-control-static">{$result.domain}</p></td>
							<td class="{if $result.status eq $searchvar}text-success{else}text-danger{/if}">
								<div class="checkbox">
									<label>{if $result.status eq $searchvar} <input type="checkbox" name="domains[]" value="{$result.domain}"{if $result.domain|in_array:$domains} checked="checked"{/if}> {$LANG.domainavailable}{else} {$LANG.domainunavailable}{/if}</label>
								</div>
							</td>
							<td>
								{if $result.regoptions}
								<select name="domainsregperiod[{$result.domain}]" class="form-control">
									{foreach key=period item=regoption from=$result.regoptions}
									{if $regoption.$domain}<option value="{$period}">{$period} {$LANG.orderyears} @ {$regoption.$domain}</option>{/if}
									{/foreach}
								</select>
								{/if}
							</td>
						</tr>
						{/foreach}
					</tbody>
				</table>
			</div>
			<div class="form-group text-center">
				<a href="cart.php?a=view" class="btn" title="{$LANG.viewcart}">{$LANG.viewcart}</a>
				<input type="submit" class="btn btn-primary" value="{$LANG.addtocart}">
			</div>
		</form>
		{else}
		<div class="form-group text-center">
			<a href="cart.php?a=view" class="btn" title="{$LANG.viewcart}">{$LANG.viewcart}</a>
		</div>
		{/if}
	</div>
</div>
