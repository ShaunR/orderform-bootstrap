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
			<li><a href="{$smarty.server.PHP_SELF}?gid={$productgroup.gid}" title="{$productgroup.name}">{$productgroup.name}</a></li>
			{/foreach}
			{if $loggedin}
			<li><a href="{$smarty.server.PHP_SELF}?gid=addons" title="{$LANG.cartproductaddons}">{$LANG.cartproductaddons}</a></li>
			{if $renewalsenabled}<li class="active"><a href="{$smarty.server.PHP_SELF}?gid=renewals" title="{$LANG.domainrenewals}">{$LANG.domainrenewals}</a></li>{/if}
			{/if}
			{if $registerdomainenabled}<li><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=register" title="{$LANG.registerdomain}">{$LANG.registerdomain}</a></li>{/if}
			{if $transferdomainenabled}<li><a href="{$smarty.server.PHP_SELF}?a=add&amp;domain=transfer" title="{$LANG.transferdomain}">{$LANG.transferdomain}</a></li>{/if}
		</ul>
	</div>
	<div class="col-md-9">
		<div class="page-header">
			<h3>{$LANG.domainrenewals}</h3>
		</div>
		<p>{$LANG.domainrenewdesc}</p>
		<form method="post" action="cart.php?a=add&renewals=true">
			<table class="table">
				<thead>
					<tr>
						<th style="width: 20px;">&nbsp;</th>
						<th>{$LANG.orderdomain}</th>
						<th>{$LANG.domainstatus}</th>
						<th>{$LANG.domaindaysuntilexpiry}</th>
						<th></th>
					</tr>
				</thead>
				<tbody>
					{foreach from=$renewals item=renewal name="renewals"}
					<tr>
						<td>{if !$renewal.pastgraceperiod}<input type="checkbox" id="domain-{$smarty.foreach.renewals.index}" name="renewalids[]" value="{$renewal.id}">{/if}</td>
						<td><label for="domain-{$smarty.foreach.renewals.index}">{$renewal.domain}</label></td>
						<td><span class="label label-{$renewal.status|strtolower}">{$renewal.status}</span></td>
						<td>
							{if $renewal.daysuntilexpiry > 30}
							<span class="text-success">{$renewal.daysuntilexpiry} {$LANG.domainrenewalsdays}</span>
							{elseif $renewal.daysuntilexpiry > 0}
							<span class="text-danger">{$renewal.daysuntilexpiry} {$LANG.domainrenewalsdays}</span>
							{else}
							{$renewal.daysuntilexpiry*-1} {$LANG.domainrenewalsdaysago}
							{/if}
							{if $renewal.ingraceperiod}
							<br>
							<span class="text-danger">{$LANG.domainrenewalsingraceperiod}</span>
							{/if}
						</td>
						<td>
							{if $renewal.beforerenewlimit}
							<span class="text-danger">{$LANG.domainrenewalsbeforerenewlimit|sprintf2:$renewal.beforerenewlimitdays}</span>
							{elseif $renewal.pastgraceperiod}
							<span class="text-danger">{$LANG.domainrenewalspastgraceperiod}</span>
							{else}
							<select name="renewalperiod[{$renewal.id}]">
								{foreach from=$renewal.renewaloptions item=renewaloption}
								<option value="{$renewaloption.period}">{$renewaloption.period} {$LANG.orderyears} @ {$renewaloption.price}</option>
								{/foreach}
							</select>
							{/if}
						</td>
					</tr>
					{foreachelse}
					<tr>
						<td colspan="5">{$LANG.domainrenewalsnoneavailable}</td>
					</tr>
					{/foreach}
				</tbody>
			</table>

			<div class="form-group text-center">
				<a href="cart.php?a=view" class="btn" title="{$LANG.viewcart}">{$LANG.viewcart}</a>
				<input type="submit" class="btn btn-primary" value="{$LANG.ordernowbutton}">
			</div>
		</form>
	</div>
</div>
