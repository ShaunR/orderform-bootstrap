<div class="page-header">
	<h1>{$LANG.navservicesorder}</h1>
</div>

<p>{$LANG.cartproductdomaindesc}</p>

{if $errormessage}
<div class="alert alert-danger alert-dismissal">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	{$errormessage}
</div>
{/if}

<form method="post" action="{$smarty.server.PHP_SELF}?a=add&pid={$pid}">

	<h2>{$LANG.cartproductconfig}</h2>

	{if $incartdomains}
	<div class="form-group">
		<div class="radio">
			<label>
				<input type="radio" name="domainoption" value="incart" id="selincart" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display=''"> {$LANG.cartproductdomainuseincart}
			</label>
		</div>
	</div>
	{/if}

	{if $registerdomainenabled}
	<div class="forum-group">
		<div class="radio">
			<label>
				<input type="radio" name="domainoption" value="register" id="selregister" onclick="document.getElementById('register').style.display='';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption1part1} {$companyname} {$LANG.orderdomainoption1part2}
			</label>
		</div>
	</div>
	{/if}

	{if $transferdomainenabled}
	<div class="form-group">
		<div class="radio">
			<label>
				<input type="radio" name="domainoption" value="transfer" id="seltransfer" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption3} {$companyname}
			</label>
		</div>
	</div>
	{/if}

	{if $owndomainenabled}
	<div class="form-group">
		<div class="radio">
			<label>
				<input type="radio" name="domainoption" value="owndomain" id="selowndomain" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='';document.getElementById('subdomain').style.display='none';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption2}
			</label>
		</div>
	</div>
	{/if}
	
	{if $subdomains}
	<div class="form-group">
		<div class="radio">
			<label>
				<input type="radio" name="domainoption" value="subdomain" id="selsubdomain" onclick="document.getElementById('register').style.display='none';document.getElementById('transfer').style.display='none';document.getElementById('owndomain').style.display='none';document.getElementById('subdomain').style.display='';document.getElementById('incart').style.display='none'"> {$LANG.orderdomainoption4}
			</label>
		</div>
	</div>
	{/if}


	<div class="well well-sm form-inline">
		<div id="incart" class="text-center">
			<div class="form-group">
				<label>{$LANG.cartproductdomainchoose}</label>	
			</div>
			<div class="form-group">
				<select name="incartdomain" class="form-control">
					{foreach key=num item=incartdomain from=$incartdomains}
					<option value="{$incartdomain}">{$incartdomain}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div id="register" class="text-center">
			<div class="form-group">
				<label>www.</label>
			</div>
			<div class="form-group">
				<input type="text" name="sld[0]" size="40" value="{$sld}" class="form-control">
			</div>
			<div class="form-group">
				<select name="tld[0]" class="form-control">
					{foreach key=num item=listtld from=$registertlds}
					<option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>{$listtld}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div id="transfer" class="text-center">
			<div class="form-group">
				<label>www.</label>
			</div>
			<div class="form-group">
				<input type="text" name="sld[1]" size="40" class="form-control" value="{$sld}">
			</div>
			<div class="form-group">
				<select name="tld[1]" class="form-control">>
					{foreach key=num item=listtld from=$transfertlds}
					<option value="{$listtld}"{if $listtld eq $tld} selected="selected"{/if}>{$listtld}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div id="owndomain" class="text-center">
			<div class="form-group">
				<label>www.</label>
			</div>
			<div class="form-group">
				<input type="text" name="sld[2]" size="40" value="{$sld}" class="form-control">
			</div>
			<div class="form-group">
				<label>.</label>
			</div>
			<div class="form-group">
				<input type="text" name="tld[2]" size="7" value="{$tld}" class="form-control">
			</div>
		</div>
		<div id="subdomain" class="text-center">
			<div class="form-group">
				<label>http://</label>
			</div>
			<div class="form-group">
				<input type="text" name="sld[3]" size="40" value="{$sld}" class="form-control">
			</div>
			<div class="form-group">
				<select name="tld[3]" class="form-control">
					{foreach from=$subdomains key=subid item=subdomain}
					<option value="{$subid}">{$subdomain}</option>
					{/foreach}
				</select>
			</div>
		</div>
	</div>

	{if !$availabilityresults}
	<div class="form-group text-center">
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
							<label>{if $result.status eq $searchvar}<input type="checkbox" name="domains[]" value="{$result.domain}"{if $num eq 0} checked="checked"{/if}> {$LANG.domainavailable}{else} {$LANG.domainunavailable}{/if}</label>
						</div>
					</td>
					<td>
						{if $result.regoptions}
						<select name="domainsregperiod[{$result.domain}]" class="form-control">
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
			</tbody>
		</table>
	</div>

	<div class="form-group text-center">
		<input type="submit" class="btn btn-primary" value="{$LANG.ordercontinuebutton}">
	</div>
	{/if}
	{if $freedomaintlds}* <em>{$LANG.orderfreedomainregistration} {$LANG.orderfreedomainappliesto}: {$freedomaintlds}</em>{/if}
</form>
