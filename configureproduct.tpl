<div class="page-header">
	<h1>{$LANG.navservicesorder} <small>{$LANG.cartproductconfig}</small></h1>
</div>

<p>{$LANG.cartproductdesc}</p>

{if $errormessage}
<div class="alert alert-error">
	<ul>{$errormessage}</ul>
</div>
{/if}


<form method="post" action="{$smarty.server.PHP_SELF}?a=confproduct&amp;i={$i}">
	<input type="hidden" name="configure" value="true">

	{if $productinfo}
	<h3>{$LANG.orderproduct}</h3>
	<div class="well well-small">
		<strong>{$productinfo.groupname} - {$productinfo.name}</strong>
		<p>{$productinfo.description}</p>
	</div>

	<h3>{$LANG.orderbillingcycle}</h3>
	<fieldset class="well well-small form-inline">
		<input type="hidden" name="previousbillingcycle" value="{$billingcycle}">
		{if $pricing.type eq "free"}
		<input type="hidden" name="billingcycle" value="free">
		{$LANG.orderfree}
		{elseif $pricing.type eq "onetime"}
		<input type="hidden" name="billingcycle" value="onetime" />
		{$pricing.onetime} {$LANG.orderpaymenttermonetime}
		{else}
		<select name="billingcycle" onchange="submit()">
			{if $pricing.monthly}<option value="monthly"{if $billingcycle eq "monthly"} selected="selected"{/if}>{$pricing.monthly}</option>{/if}
			{if $pricing.quarterly}<option value="quarterly"{if $billingcycle eq "quarterly"} selected="selected"{/if}>{$pricing.quarterly}</option>{/if}
			{if $pricing.semiannually}<option value="semiannually"{if $billingcycle eq "semiannually"} selected="selected"{/if}>{$pricing.semiannually}</option>{/if}
			{if $pricing.annually}<option value="annually"{if $billingcycle eq "annually"} selected="selected"{/if}>{$pricing.annually}</option>{/if}
			{if $pricing.biennially}<option value="biennially"{if $billingcycle eq "biennially"} selected="selected"{/if}>{$pricing.biennially}</option>{/if}
			{if $pricing.triennially}<option value="triennially"{if $billingcycle eq "triennially"} selected="selected"{/if}>{$pricing.triennially}</option>{/if}
		</select>
		{/if}
	</fieldset>
	{/if}

	{if $productinfo.type eq "server"}
	<h3>{$LANG.cartconfigserver}</h3>
	<fieldset class="well well-small form-horizontal">
		<div class="control-group">
			<label class="control-label" for="serverhostname">{$LANG.serverhostname}</label>
			<div class="controls">
				<input type="text" name="hostname" id="serverhostname" size="15" value="{$server.hostname}">
				<span class="help-inline">eg. server1(.yourdomain.com)</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="serverns1prefix">{$LANG.serverns1prefix}</label>
			<div class="controls">
				<input type="text" name="ns1prefix" id="serverns1prefix" size="10" value="{$server.ns1prefix}">
				<span class="help-inline">eg. ns1(.yourdomain.com)</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="serverns2prefix">{$LANG.serverns2prefix}</label>
			<div class="controls">
				<input type="text" name="ns2prefix" id="serverns2prefix" size="10" value="{$server.ns2prefix}">
				<span class="help-inline">eg. ns2(.yourdomain.com)</span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="serverrootpw">{$LANG.serverrootpw}</label>
			<div class="controls">
				<input type="password" name="rootpw" id="serverrootpw" size="20" value="{$server.rootpw}">
			</div>
		</div>
	</fieldset>
	{/if}

	{if $configurableoptions}
	<h3>{$LANG.orderconfigpackage}</h3>
	<p>{$LANG.cartconfigoptionsdesc}</p>
	<fieldset class="well well-small form-horizontal">
		{foreach key=num item=configoption from=$configurableoptions}
		<div class="control-group">
			<label class="control-label" for="{$configoption.optionname}">{$configoption.optionname}</label>
			<div class="controls">
			{if $configoption.optiontype eq 1}
				<select id="{$configoption.optionname}" name="configoption[{$configoption.id}]">
				{foreach key=num2 item=options from=$configoption.options}
					<option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.name}</option>
				{/foreach}
				</select>
			{elseif $configoption.optiontype eq 2}
				{foreach key=num2 item=options from=$configoption.options}
				<label class="radio inline"><input type="radio" name="configoption[{$configoption.id}]" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if}> {$options.name}</label><br>
				{/foreach}
			{elseif $configoption.optiontype eq 3}
				<label class="checkbox inline"><input type="checkbox" id="{$configoption.optionname}" name="configoption[{$configoption.id}]" value="1"{if $configoption.selectedqty} checked{/if}> {$configoption.options.0.name}</label><br>
			{elseif $configoption.optiontype eq 4}
				<input type="text" name="configoption[{$configoption.id}]" id="{$configoption.optionname}" value="{$configoption.selectedqty}" size="5" class="span1"> &times; {$configoption.options.0.name}
			{/if}
			</div>
		</div>
		{/foreach}
	</fieldset>
	{/if}

	{if $addons}
	<h3>{$LANG.cartaddons}</h3>
	<p>{$LANG.orderaddondescription}</p>
	<fieldset class="well well-small form-horizontal">
		{foreach key=num item=addon from=$addons name="addons"}
		<div class="row-fluid">
			<div class="span9">
				<label class="checkbox inline">{$addon.checkbox} <strong>{$addon.name}</strong><br>{if $addon.description}{$addon.description}{/if}</label>
			</div>
			<div class="span3 textright"><strong>{$addon.pricing}</strong></div>
		</div>
		{if !$smarty.foreach.addons.last}<hr>{/if}
<!--
		<div class="control-group">
			<div class="controls">
				<label class="checkbox inline">{$addon.checkbox} {$addon.name}</label><span class="pull-right">{$addon.pricing}</span>
				<span class="help-block">{if $addon.description}{$addon.description}{/if}</span>
			</div>
		</div>
-->
		{/foreach}
	</fieldset>
	{/if}

	{if $customfields}
	<h3>{$LANG.orderadditionalrequiredinfo}</h3>
	<p>{$LANG.cartcustomfieldsdesc}</p>
	<fieldset class="well well-small form-horizontal">
		{foreach key=num item=customfield from=$customfields}
		<div class="control-group">
			<label class="control-label">{$customfield.name}</label>
			<div class="controls">
				{$customfield.input}
				{if $customfield.description}<span class="help-inline">{$customfield.description}</span>{/if}
			</div>
		</div>
		{/foreach}
	</fieldset>
	{/if}

	<div class="form-actions textcenter">
		{if $firstconfig}<input type="submit" class="btn btn-large" value="{$LANG.addtocart}">{else}<input type="submit" clas="btn btn-large" value="{$LANG.updatecart}">{/if}
	</div>

</form>
