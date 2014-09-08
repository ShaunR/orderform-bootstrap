<section>
	<div class="container">
		<h1>{$LANG.navservicesorder} <small>{$LANG.cartproductconfig}</small></h1>
		
		<p>{$LANG.cartproductdesc}</p>
		
		{if $errormessage}
		<div class="alert alert-danger">
			<ul>{$errormessage}</ul>
		</div>
		{/if}
		
		
		<form method="post" action="{$smarty.server.PHP_SELF}?a=confproduct&amp;i={$i}">
			<input type="hidden" name="configure" value="true">
		
			{if $productinfo}
			<h3>{$LANG.orderproduct}</h3>
			<div class="well well-sm">
				<strong>{$productinfo.groupname} - {$productinfo.name}</strong>
				<p>{$productinfo.description}</p>
			</div>
		
			<h3>{$LANG.orderbillingcycle}</h3>
			<fieldset class="well well-sm form-inline">
				<input type="hidden" name="previousbillingcycle" value="{$billingcycle}">
				{if $pricing.type eq "free"}
				<input type="hidden" name="billingcycle" value="free">
				{$LANG.orderfree}
				{elseif $pricing.type eq "onetime"}
				<input type="hidden" name="billingcycle" value="onetime">
				{$pricing.onetime} {$LANG.orderpaymenttermonetime}
				{else}
				<div class="form-group">
					<select name="billingcycle" onchange="submit()" class="form-control">
						{if $pricing.monthly}<option value="monthly"{if $billingcycle eq "monthly"} selected="selected"{/if}>{$pricing.monthly}</option>{/if}
						{if $pricing.quarterly}<option value="quarterly"{if $billingcycle eq "quarterly"} selected="selected"{/if}>{$pricing.quarterly}</option>{/if}
						{if $pricing.semiannually}<option value="semiannually"{if $billingcycle eq "semiannually"} selected="selected"{/if}>{$pricing.semiannually}</option>{/if}
						{if $pricing.annually}<option value="annually"{if $billingcycle eq "annually"} selected="selected"{/if}>{$pricing.annually}</option>{/if}
						{if $pricing.biennially}<option value="biennially"{if $billingcycle eq "biennially"} selected="selected"{/if}>{$pricing.biennially}</option>{/if}
						{if $pricing.triennially}<option value="triennially"{if $billingcycle eq "triennially"} selected="selected"{/if}>{$pricing.triennially}</option>{/if}
					</select>
				</div>
				{/if}
			</fieldset>
			{/if}
		
			{if $productinfo.type eq "server"}
			<h3>{$LANG.cartconfigserver}</h3>
			<fieldset class="well well-sm form-horizontal">
				<div class="form-group">
					<label class="col-md-2 control-label" for="serverhostname">{$LANG.serverhostname}</label>
					<div class="col-md-4">
						<input type="text" name="hostname" id="serverhostname" size="15" value="{$server.hostname}" class="form-control">
					</div>
					<div class="col-md-6">
						<div class="help-block">eg. server1(.yourdomain.com)</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label" for="serverns1prefix">{$LANG.serverns1prefix}</label>
					<div class="col-md-2">
						<input type="text" name="ns1prefix" id="serverns1prefix" size="10" value="{$server.ns1prefix}" class="form-control">
					</div>
					<div class="col-md-8">
						<div class="help-block">eg. ns1(.yourdomain.com)</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label" for="serverns2prefix">{$LANG.serverns2prefix}</label>
					<div class="col-md-2">
						<input type="text" name="ns2prefix" id="serverns2prefix" size="10" value="{$server.ns2prefix}" class="form-control">
					</div>
					<div class="col-md-8">
						<div class="help-block">eg. ns2(.yourdomain.com)</div>
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-2 control-label" for="serverrootpw">{$LANG.serverrootpw}</label>
					<div class="col-md-4">
						<input type="password" name="rootpw" id="serverrootpw" size="20" value="{$server.rootpw}" class="form-control">
					</div>
				</div>
			</fieldset>
			{/if}
		
			{if $configurableoptions}
			<h3>{$LANG.orderconfigpackage}</h3>
			<p>{$LANG.cartconfigoptionsdesc}</p>
			<fieldset class="well well-sm form-horizontal">
				{foreach key=num item=configoption from=$configurableoptions}
				<div class="form-group">
					<label class="col-md-2 control-label" for="{$configoption.optionname}">{$configoption.optionname}</label>
					{if $configoption.optiontype eq 1}
					<div class="col-md-4">
						<select id="{$configoption.optionname}" name="configoption[{$configoption.id}]" class="form-control">
						{foreach key=num2 item=options from=$configoption.options}
							<option value="{$options.id}"{if $configoption.selectedvalue eq $options.id} selected="selected"{/if}>{$options.name}</option>
						{/foreach}
						</select>
					</div>
					{elseif $configoption.optiontype eq 2}
					<div class="col-md-10">
						{foreach key=num2 item=options from=$configoption.options}
						<label class="radio-inline">
							<input type="radio" name="configoption[{$configoption.id}]" value="{$options.id}"{if $configoption.selectedvalue eq $options.id} checked="checked"{/if}> 
							{$options.name}
						</label>
						<br>
						{/foreach}
					</div>
					{elseif $configoption.optiontype eq 3}
					<div class="col-md-10">
						<label class="checkbox-inline">
							<input type="checkbox" id="{$configoption.optionname}" name="configoption[{$configoption.id}]" value="1"{if $configoption.selectedqty} checked{/if}> 
							{$configoption.options.0.name}
						</label>
						<br>
					</div>
					{elseif $configoption.optiontype eq 4}
					<div class="col-md-3">
						<div class="input-group">
							<input type="text" name="configoption[{$configoption.id}]" id="{$configoption.optionname}" value="{$configoption.selectedqty}" size="5" class="form-control">
							<span class="input-group-addon">&times; {$configoption.options.0.name}</span>
						</div>
					</div>
					{/if}
				</div>
				{/foreach}
			</fieldset>
			{/if}
		
			{if $addons}
			<h3>{$LANG.cartaddons}</h3>
			<p>{$LANG.orderaddondescription}</p>
			<fieldset class="well well-sm">
				{foreach key=num item=addon from=$addons name="addons"}
				<div class="row">
					<div class="col-md-9">
						<div class="checkbox">
							<label>{$addon.checkbox} <strong>{$addon.name}</strong>{if $addon.description}<br>{$addon.description}{/if}</label>
						</div>
					</div>
					<div class="col-md-3 text-right">
						<strong>{$addon.pricing}</strong>
					</div>
				</div>
				{/foreach}
			</fieldset>
			{/if}
		
			{if $customfields}
			<h3>{$LANG.orderadditionalrequiredinfo}</h3>
			<p>{$LANG.cartcustomfieldsdesc}</p>
			<fieldset class="well well-sm form-horizontal">
				{foreach key=num item=customfield from=$customfields}
				<div class="form-group">
					<label class="col-md-2 control-label">{$customfield.name}</label>
					<div class="col-md-10">
						{$customfield.input}
						{if $customfield.description}<span class="help-inline">{$customfield.description}</span>{/if}
					</div>
				</div>
				{/foreach}
			</fieldset>
			{/if}
		
			<div class="text-center form-group">
				<a href="cart.php?a=view" title="{$LANG.viewcart}" class="btn btn-info">{$LANG.viewcart}</a>
				<button type="submit" class="btn btn-primary">{if $firstconfig}{$LANG.addtocart}{else}{$LANG.updatecart}{/if}</button>
			</div>
		
		</form>
	</div>
</section>
