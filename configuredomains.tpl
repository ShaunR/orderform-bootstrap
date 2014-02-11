<div class="page-header">
	<h1>{$LANG.navservicesorder} <small>{$LANG.cartdomainsconfig}</small></h1>
</div>

<p>{$LANG.cartdomainsconfigdesc}</p>

{if $errormessage}
<div class="alert alert-danger alert-dismisible">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<ul>{$errormessage}</ul>
</div>
{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?a=confdomains">
	<input type="hidden" name="update" value="true">

{foreach key=num item=domain from=$domains}
	<h4>{$domain.domain} - {$domain.regperiod} {$LANG.orderyears}</h4>
	{if $domain.configtoshow}
	<fieldset class="well well-sm form-horizontal">
		<div class="pull-right">{if $domain.hosting}<span class="text-success">[{$LANG.cartdomainshashosting}]</span>{else}<a href="cart.php" class="btn btn-small btn-warning">{$LANG.cartdomainsnohosting}</a>{/if}</div>
		{if $domain.eppenabled}
		<div class="form-group">
			<label class="col-md-2 control-label">{$LANG.domaineppcode}</label>
			<div class="col-md-3">
				<input type="text" name="epp[{$num}]" class="form-control" value="{$domain.eppvalue}">
			</div>
			<div class="col-md-7">
				<div class="help-block">{$LANG.domaineppcodedesc}</div>
			</div>
		</div>
		{/if}
		<div class="form-group">
			<label class="col-md-2 control-label">{$LANG.cartaddons}</label>
			<div class="col-md-6">
			{if $domain.dnsmanagement}
				<div class="checkbox">
					<label><input type="checkbox" name="dnsmanagement[{$num}]"{if $domain.dnsmanagementselected} checked="checked"{/if}> {$LANG.domaindnsmanagement} ({$domain.dnsmanagementprice})</label>
				</div>
			{/if}
			{if $domain.emailforwarding}
				<div class="checkbox">
					<label><input type="checkbox" name="emailforwarding[{$num}]"{if $domain.emailforwardingselected} checked="checked"{/if}> {$LANG.domainemailforwarding} ({$domain.emailforwardingprice})</label>
				</div>
			{/if}
			{if $domain.idprotection}
				<div class="checkbox">
					<label><input type="checkbox" name="idprotection[{$num}]"{if $domain.idprotectionselected} checked="checked"{/if}>{$LANG.domainidprotection} ({$domain.idprotectionprice})</label>
				</div>
			{/if}
		</div>
		{foreach from=$domain.fields key=domainfieldname item=domainfield}
		<div class="form-group">
			<label class="col-md-2 control-label">{$domainfieldname}</label>
			<div class="col-md-6">
				{$domainfield}
			</div>
		</div>
		{/foreach}
	</fieldset>
	{/if}
{/foreach}

{if $atleastonenohosting}
	<h2>{$LANG.domainnameservers}</h2>
	<p>{$LANG.cartnameserversdesc}</p>

	<fieldset class="well well-sm form-horizontal">
		<div class="form-group">
			<label class="col-md-2 control-label">{$LANG.domainnameserver1}</label>
			<div class="col-md-5">
				<input type="text" name="domainns1" class="form-control" value="{$domainns1}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-2 control-label">{$LANG.domainnameserver2}</label>
			<div class="col-md-5">
				<input type="text" name="domainns2" class="form-control" value="{$domainns2}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-2 control-label">{$LANG.domainnameserver3}</label>
			<div class="col-md-5">
				<input type="text" name="domainns3" class="form-control" value="{$domainns3}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-2 control-label">{$LANG.domainnameserver4}</label>
			<div class="col-md-5">
				<input type="text" name="domainns4" class="form-control" value="{$domainns4}">
			</div>
		</div>
		<div class="form-group">
			<label class="col-md-2 control-label">{$LANG.domainnameserver5}</label>
			<div class="col-md-5">
				<input type="text" name="domainns5" class="form-control" value="{$domainns5}">
			</div>
		</div>
	</fieldset>
{/if}

	<div class="form-group text-center">
		<input type="submit" class="btn btn-primary" value="{$LANG.updatecart}">
	</div>

</form>


