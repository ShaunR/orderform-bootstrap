<div class="page-header">
   <h1>{$LANG.navservicesorder}</h1>
</div>

<p>{$LANG.cartproductdomaindesc}</p>

{if $errormessage}
<div class="alert alert-error fade in">
	<button class="close" data-dismiss="alert">&times;</button>
	{$errormessage}
</div>
{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?a=add&pid={$pid}" class="form-inline">

	<h2>{$LANG.cartproductconfig}</h2>
	<hr>

	{if $incartdomains}
	<div class="control-group">
		<div class="controls">
			<label class="radio"><input type="radio" name="domainoption" value="incart" id="selincart" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display=''"> {$LANG.cartproductdomainuseincart}</label>
		</div>
	</div>
	{/if}

	{if $registerdomainenabled}
	<div class="control-group">
		<div class="controls">
			<label class="radio"><input type="radio" name="domainoption" value="register" id="selregister" onclick="document.getElementById('register').style.display='';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption1part1} {$companyname} {$LANG.orderdomainoption1part2}</label>
		</div>
	</div>
	{/if}

	{if $transferdomainenabled}
	<div class="control-group">
		<div class="controls">
			<label class="radio"><input type="radio" name="domainoption" value="transfer" id="seltransfer" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption3} {$companyname}</label>
		</div>
	</div>
	{/if}

	{if $owndomainenabled}
	<div class="control-group">
		<div class="controls">
			<label class="radio"><input type="radio" name="domainoption" value="owndomain" id="selowndomain" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption2}</label>
		</div>
	</div>
	{/if}
	
	{if $subdomains}
	<div class="control-group">
		<div class="controls">
			<label class="radio"><input type="radio" name="domainoption" value="subdomain" id="selsubdomain" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption4}</label>
		</div>
	</div>
	{/if}


	<div class="well well-small">
		<div id="incart" class="textcenter">
			<label>{$LANG.cartproductdomainchoose}</label>
			<select name="incartdomain">
				{foreach key=num item=incartdomain from=$incartdomains}
				<option value="{$incartdomain}">{$incartdomain}</option>
				{/foreach}
			</select>
		</div>
		<div id="register" class="textcenter">
			<label>www.</label>
			<input type="text" name="sld[0]" size="40" value="{$sld}">
			<select name="tld[0]">
				{foreach key=num item=listtld from=$registertlds}
				<option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>{$listtld}</option>
				{/foreach}
			</select>
		</div>
		<div id="transfer" class="textcenter">
			<label>www.</label>
			<input type="text" name="sld[1]" size="40" class="span4" value="{$sld}">
			<select name="tld[1]">
				{foreach key=num item=listtld from=$transfertlds}
				<option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>{$listtld}</option>
				{/foreach}
			</select>
		</div>
		<div id="owndomain" class="textcenter">
			<label>www.</label>
			<input type="text" name="sld[2]" class="span4" size="40" value="{$sld}">
			.
			<input type="text" name="tld[2]" class="span1" size="7" value="{$tld}" />
		</div>
		<div id="subdomain" class="textcenter">
			<label>http://</label>
			<input type="text" name="sld[3]" class="span4" size="40" value="{$sld}">
			<select name="tld[3]">
				{foreach from=$subdomains key=subid item=subdomain}
				<option value="{$subid}">{$subdomain}</option>
				{/foreach}
			</select>
		</div>
	</div>

	{if !$availabilityresults}
	<div class="form-actions textcenter">
		<input type="submit" value="{$LANG.ordercontinuebutton}" class="btn btn-primary">
	</div>
	{/if}
	
	<script language="javascript" type="text/javascript">
		document.getElementById('incart').style.display='none';
		document.getElementById('register').style.display='none';
		document.getElementById('transfer').style.display='none';
		document.getElementById('owndomain').style.display='none';
		document.getElementById('subdomain').style.display='none';
		document.getElementById('sel{$domainoption}').checked='true';
		document.getElementById('{$domainoption}').style.display='';
	</script>

	{if $availabilityresults}
	<h2>{$LANG.choosedomains}</h2>
	<table class="table textcenter">
		<tr>
			<th>{$LANG.domainname}</th>
			<th>{$LANG.domainstatus}</th>
			<th>{$LANG.domainmoreinfo}</th>
		</tr>
		{foreach key=num item=result from=$availabilityresults}
		<tr>
			<td>{$result.domain}</td>
			<td class="{if $result.status eq $searchvar}text-success{else}text-error{/if}">
				<label class="checkbox inline">{if $result.status eq $searchvar}<input type="checkbox" name="domains[]" value="{$result.domain}"{if $num eq 0} checked="checked"{/if}> {$LANG.domainavailable}{else} {$LANG.domainunavailable}{/if}</label>
			</td>
			<td>
				{if $result.regoptions}
				<select name="domainsregperiod[{$result.domain}]">
					{foreach key=period item=regoption from=$result.regoptions}
					{if $regoption.$domainoption}
					<option value="{$period}">{$period} {$LANG.orderyears} @ {$regoption.$domainoption}</option>
					{/if}
					{/foreach}
				</select>
				{/if}
			</td>
		</tr>
		{/foreach}
	</table>

	<div class="form-actions textcenter">
		<input type="submit" class="btn btn-primary" value="{$LANG.ordercontinuebutton}">
	</div>
	{/if}
	{if $freedomaintlds}* <em>{$LANG.orderfreedomainregistration} {$LANG.orderfreedomainappliesto}: {$freedomaintlds}</em>{/if}
</form>
