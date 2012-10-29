<div class="page-header">
	<h1>{$LANG.navservicesorder} <small>{$LANG.cartdomainsconfig}</small></h1>
</div>

<p>{$LANG.cartdomainsconfigdesc}</p>

{if $errormessage}
<div class="alert alert-error fade in">
	<button class="close" data-dismiss="alert">&times;</button>
	<ul>{$errormessage}</ul>
</div>
{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?a=confdomains">
	<input type="hidden" name="update" value="true">

{foreach key=num item=domain from=$domains}
	<span class="pull-right">{if $domain.hosting}<span class="text-success">[{$LANG.cartdomainshashosting}]</span>{else}<a href="cart.php" class="btn btn-small btn-warning">{$LANG.cartdomainsnohosting}</a>{/if}</span>
	<h4>{$domain.domain} - {$domain.regperiod} {$LANG.orderyears}</h4>
	{if $domain.configtoshow}
	<fieldset class="well well-small form-horizontal">
		{if $domain.eppenabled}
		<div class="control-group">
			<label class="control-label">{$LANG.domaineppcode}</label>
			<div class="controls">
				<input type="text" name="epp[{$num}]" class="span3" value="{$domain.eppvalue}">
				<span class="help-inline">{$LANG.domaineppcodedesc}</span>
			</div>
		</div>
		{/if}
		<div class="control-group">
			<label class="control-label">{$LANG.cartaddons}</label>
			{if $domain.dnsmanagement}
			<div class="controls">
				<label class="checkbox inline"><input type="checkbox" name="dnsmanagement[{$num}]"{if $domain.dnsmanagementselected} checked="checked"{/if}> {$LANG.domaindnsmanagement} ({$domain.dnsmanagementprice})</label>
			</div>
			{/if}
			{if $domain.emailforwarding}
			<div class="controls">
				<label class="checkbox inline"><input type="checkbox" name="emailforwarding[{$num}]"{if $domain.emailforwardingselected} checked="checked"{/if}> {$LANG.domainemailforwarding} ({$domain.emailforwardingprice})</label>
			</div>
			{/if}
			{if $domain.idprotection}
			<div class="controls">
				<label class="checkbox inline"><input type="checkbox" name="idprotection[{$num}]"{if $domain.idprotectionselected} checked="checked"{/if}>{$LANG.domainidprotection} ({$domain.idprotectionprice})</label>
			</div>
			{/if}
		</div>
		{foreach from=$domain.fields key=domainfieldname item=domainfield}
		<div class="control-group">
			<label class="control-label">{$domainfieldname}</label>
			<div class="controls">
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

	<fieldset class="well well-small form-horizontal">
		<div class="control-group">
			<label class="control-label">{$LANG.domainnameserver1}</label>
			<div class="controls">
				<input type="text" name="domainns1" class="span3" value="{$domainns1}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">{$LANG.domainnameserver2}</label>
			<div class="controls">
				<input type="text" name="domainns2" class="span3" value="{$domainns2}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">{$LANG.domainnameserver3}</label>
			<div class="controls">
				<input type="text" name="domainns3" class="span3" value="{$domainns3}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">{$LANG.domainnameserver4}</label>
			<div class="controls">
				<input type="text" name="domainns4" class="span3" value="{$domainns4}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">{$LANG.domainnameserver5}</label>
			<div class="controls">
				<input type="text" name="domainns5" class="span3" value="{$domainns5}">
			</div>
		</div>
	</fieldset>
{/if}

	<div class="form-actions textcenter">
		<input type="submit" class="btn btn-primary" value="{$LANG.updatecart}">
	</div>

</form>


