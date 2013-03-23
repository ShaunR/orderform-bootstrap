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
	<h1>{$LANG.navservicesorder} <small>{if $checkout}{$LANG.ordercheckout}{else}{$LANG.ordersummary}{/if}</small></h1>
</div>

{if $errormessage}
<div class="alert alert-error fade in">
	<button class="close" data-dismiss="alert">&times;</button>
	<h4 class="alert-heading">{$LANG.clientareaerrors}</h4>
	<ul>{$errormessage}</ul>
</div>
{elseif $promotioncode && $rawdiscount eq "0.00"}
<div class="alert alert-error fade in">
	<button class="close" data-dismiss="alert">&times;</button>
	{$LANG.promoappliedbutnodiscount}
</div>
{/if}

{if $bundlewarnings}
<div class="alert alerterror">
	<button class="close" data-dismiss="alert">&times;</button>
	<h4 class="alert-heading">{$LANG.bundlereqsnotmet}</h4>
	<ul>
	{foreach from=$bundlewarnings item=warning}
		<li>{$warning}</li>
	{/foreach}
	</ul>
</div>
{/if}

{if !$checkout}
<form method="post" action="{$smarty.server.PHP_SELF}?a=view">

	<table class="table">
		<tr>
			<th class="well well-small textcenter">{$LANG.orderdesc}</th>
			<th class="well well-small textcenter">{$LANG.orderprice}</th>
		</tr>
		{foreach key=num item=product from=$products}
		<tr>
			<td>
				<strong><em>{$product.productinfo.groupname}</em> - {$product.productinfo.name}</strong>{if $product.domain} ({$product.domain}){/if}
				{if $product.configoptions}
				<ul>
				{foreach key=confnum item=configoption from=$product.configoptions}
					<li>{$configoption.name}: {if $configoption.type eq 1 || $configoption.type eq 2}{$configoption.option}{elseif $configoption.type eq 3}{if $configoption.qty}{$LANG.yes}{else}{$LANG.no}{/if}{elseif $configoption.type eq 4}{$configoption.qty} &times; {$configoption.option}{/if}</li>
				{/foreach}
				</ul>
				{/if}
			</td>
			<td class="textcenter">
				<strong>{$product.pricingtext}{if $product.proratadate}<br>({$LANG.orderprorata} {$product.proratadate}){/if}</strong>
			</td>
		</tr>
		{foreach key=addonnum item=addon from=$product.addons}
		<tr>
			<td><strong>{$LANG.orderaddon}</strong> - {$addon.name}</td>
			<td class="textcenter"><strong>{$addon.pricingtext}</strong></td>
		</tr>
		{/foreach}
		<tr>
			<td>
				<a href="{$smarty.server.PHP_SELF}?a=confproduct&i={$num}" class="text-success">{$LANG.carteditproductconfig}</a>
				|
				<a href="cart.php?a=remove&amp;r=p&amp;i={$num}" title="{$LANG.cartremove}" class="text-error" onClick="return confirm('{$LANG.cartremoveitemconfirm}')">{$LANG.cartremove}</a>
				{if $product.allowqty}
				| 
				<fieldset class="form-inline" style="display:inline-block;">
					<label class="muted" for="qty{$num}">{$LANG.cartqtyenterquantity}</label>
					<div class="input-append">
						<input type="text" id="qty{$num}" name="qty[{$num}]" size="3" class="span1" value="{$product.qty}">
						<button class="btn btn-inverse" type="button" onClick="submit()">{$LANG.cartqtyupdate}</button>
					</div>
				</fieldset>
				{/if}
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" class="well well-small">&nbsp;</td>
		</tr>
  {/foreach}

  {foreach key=num item=addon from=$addons}
		<tr>
			<td><strong>{$addon.name}</strong><br>{$addon.productname}{if $addon.domainname} - {$addon.domainname}{/if}</td>
			<td class="textcenter"><strong>{$addon.pricingtext}</strong></td>
		</tr>
		<tr>
			<td>
				<a href="cart.php?a=remove&amp;r=a&amp;i={$num}" class="text-error" title="{$LANG.cartremove}">{$LANG.cartremove}</a>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" class="well well-small">&nbsp;</td>
		</tr>
	{/foreach}

		{foreach key=num item=domain from=$domains}
		<tr>
			<td>
				<strong>{if $domain.type eq "register"}{$LANG.orderdomainregistration}{else}{$LANG.orderdomaintransfer}{/if}</strong> - {$domain.domain} - {$domain.regperiod} {$LANG.orderyears}
				<ul>
					{if $domain.dnsmanagement}<li>{$LANG.domaindnsmanagement}</li>{/if}
					{if $domain.emailforwarding}<li>{$LANG.domainemailforwarding}</li>{/if}
					{if $domain.idprotection}<li>{$LANG.domainidprotection}</li>{/if}
				</ul>
			</td>
			<td class="textcenter"><strong>{$domain.price}</strong></td>
		</tr>
		<tr>
			<td>
				<a href="{$smarty.server.PHP_SELF}?a=confdomains" class="text-success">{$LANG.cartconfigdomainextras}</a>
				|
				<a href="cart.php?a=remove&amp;r=d&amp;i={$num}" class="text-error">{$LANG.cartremove}</a>
			</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" class="well well-small">&nbsp;</td>
		</tr>
		{/foreach}

		{foreach key=num item=domain from=$renewals}
		<tr>
			<td>
				<strong>{$LANG.domainrenewal}</strong> - {$domain.domain} - {$domain.regperiod} {$LANG.orderyears}
				<ul>
					{if $domain.dnsmanagement}<li>{$LANG.domaindnsmanagement}</li>{/if}
					{if $domain.emailforwarding}<li>{$LANG.domainemailforwarding}</li>{/if}
					{if $domain.idprotection}<li>{$LANG.domainidprotection}</li>{/if}
				</ul>
			</td>
			<td class="textcenter"><strong>{$domain.price}</strong></td>
		</tr>
		<tr>
			<td><a href="cart.php?a=remove&amp;r=r&amp;i={$num}" class="text-error">{$LANG.cartremove}</a></td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td colspan="2" class="well well-small">&nbsp;</td>
		</tr>
	  {/foreach}

		{if $cartitems==0}
		<tr>
			<td colspan="2" class="textcenter">{$LANG.cartempty}</td>
		</tr>
		{/if}
		<tr>
			<td class="textright"><strong>{$LANG.ordersubtotal}</strong></td>
			<td><strong>{$subtotal}</strong></td>
		</tr>
		{if $promotioncode}
		<tr>
			<td class="textright"><strong>{$promotiondescription}</strong></td>
			<td><strong>{$discount}</strong></td>
		</tr>
		{/if}
		{if $taxrate}
		<tr>
			<td class="textright"><strong>{$taxname} @ {$taxrate}%</strong></td>
			<td><strong>{$taxtotal}</strong></td>
		</tr>
		{/if}
		{if $taxrate2}
		<tr>
			<td class="textright"><strong>{$taxname2} @ {$taxrate2}%</strong></td>
			<td><strong>{$taxtotal2}</strong></td>
		</tr>
		{/if}
		<tr>
			<td class="textright"><strong>{$LANG.ordertotalduetoday}</strong></td>
			<td><strong>{$total}</strong></td>
		</tr>
		{if $totalrecurringmonthly || $totalrecurringquarterly || $totalrecurringsemiannually || $totalrecurringannually || $totalrecurringbiennially || $totalrecurringtriennially}
		<tr>
			<td class="textright"><strong>{$LANG.ordertotalrecurring}</strong></td>
			<td>
				<strong>
				{if $totalrecurringmonthly}{$totalrecurringmonthly} {$LANG.orderpaymenttermmonthly}<br>{/if}
				{if $totalrecurringquarterly}{$totalrecurringquarterly} {$LANG.orderpaymenttermquarterly}<br>{/if}
				{if $totalrecurringsemiannually}{$totalrecurringsemiannually} {$LANG.orderpaymenttermsemiannually}<br>{/if}
				{if $totalrecurringannually}{$totalrecurringannually} {$LANG.orderpaymenttermannually}<br>{/if}
				{if $totalrecurringbiennially}{$totalrecurringbiennially} {$LANG.orderpaymenttermbiennially}<br>{/if}
				{if $totalrecurringtriennially}{$totalrecurringtriennially} {$LANG.orderpaymenttermtriennially}<br>{/if}
				</strong>
			</td>
		</tr>
		{/if}
	</table>
</form>

<div class="form-actions">
	<div class="row-fluid textcenter">
		<div class="span6">
			<form method="post" action="{$smarty.server.PHP_SELF}?a=view" class="form-inline" style="margin-bottom:0;">
				<input type="hidden" name="validatepromo" value="true">
				<label for="promocode">{$LANG.orderpromotioncode}</label>
				{if $promotioncode}
				{$promotioncode} - {$promotiondescription}<br><a href="{$smarty.server.PHP_SELF}?a=removepromo" class="btn btn-small btn-warning">{$LANG.orderdontusepromo}</a>
				{else}
				<div class="input-append">
					<input type="text" name="promocode" id="promocode">
					<button type="submit" class="btn btn-info">{$LANG.orderpromovalidatebutton}</button>
				</div>
				{/if}
			</form>
		</div>
		<div class="span6">
			<a href="cart.php?a=empty" class="btn btn-danger" title="{$LANG.emptycart}" onClick="return confirm('{$LANG.cartemptyconfirm}')">{$LANG.emptycart}</a>
			<a href="cart.php" class="btn btn-success" title="{$LANG.continueshopping}">{$LANG.continueshopping}</a>
			<a href="cart.php?a=checkout" class="btn btn-primary" title="{$LANG.checkout}"{if $cartitems eq 0} disabled="disabled" onClick="return false"{/if}>{$LANG.checkout}</a>
			{foreach from=$gatewaysoutput item=gatewayoutput}
			<div class="gateway"><strong>- {$LANG.or} -</strong><br><br>{$gatewayoutput}</div>
			{/foreach}
		</div>
	</div>
</div>

{else}

{literal}
<script type="text/javascript">
	function toggleLoginForm() {
		if($('#custtype').val() == 'new') {
			$('#custtype').val('existing');
			$('#signupform').fadeToggle('', function() {
				$('#loginform').fadeToggle('slow');
			});
		} else {
			$('#custtype').val('new');
			$('#loginform').fadeToggle('slow', function() {
				$('#signupform').fadeToggle('slow');
			});
		}
	}
</script>
{/literal}

<h2>{$LANG.yourdetails}</h2>
<form method="post" action="{$smarty.server.PHP_SELF}?a=checkout">
	<input type="hidden" name="submit" value="true">
	<input type="hidden" name="custtype" id="custtype" value="{$custtype}">

	<fieldset id="loginform" class="form-horizontal{if $custtype eq "existing" && !$loggedin}{else} hide{/if}">
		<p>{$LANG.newcustomersignup|sprintf2:'<a href="javascript:void(0)" onclick="toggleLoginForm();return false;">':'</a>'}</a></p>
		<div class="control-group">
			<label class="control-label" for="loginemail">{$LANG.loginemail}</label>
			<div class="controls">
				<input type="text" name="loginemail" id="loginemail" class="span4" value="{$username}">
			</div>
		</div>
		<div class="control-group">
			<label class="control-label" for="loginpw">{$LANG.loginpassword}</label>
			<div class="controls">
				<input type="password" name="loginpw" id="loginpw">
			</div>
		</div>
	</fieldset>

	<fieldset id="signupform" class="form-horizontal{if $custtype eq "existing" && !$loggedin} hide{/if}">
		{if !$loggedin}
		<p>
			<strong>{$LANG.existingcustomer}?</strong> <a href="{$smarty.server.PHP_SELF}?a=login" onclick="toggleLoginForm();return false;">{$LANG.clickheretologin}</a>
		</p>
		{/if}
		<div class="row">
			<div class="span6">
				<div class="control-group">
		 			<label class="control-label" for="firstname">{$LANG.clientareafirstname}</label>
					<div class="controls">
						<input type="text" name="firstname" id="firstname" value="{$clientsdetails.firstname}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
				<div class="control-group">
		 			<label class="control-label" for="lastname">{$LANG.clientarealastname}</label>
					<div class="controls">
						<input type="text" name="lastname" id="lastname" value="{$clientsdetails.lastname}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
			 	<div class="control-group">
					<label class="control-label" for="companyname">{$LANG.clientareacompanyname}</label>
					<div class="controls">
						<input type="text" name="companyname" id="companyname" value="{$clientsdetails.companyname}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="email">{$LANG.clientareaemail}</label>
					<div class="controls">
						<input type="text" name="email" id="email" value="{$clientsdetails.email}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
				{if !$loggedin}
				<div class="control-group">
					<label class="control-label" for="password">{$LANG.clientareapassword}</label>
					<div class="controls">
						<input type="password" name="password" id="password" value="{$password}">
						<span class="help-inline"></span>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="password2">{$LANG.clientareaconfirmpassword}</label>
					<div class="controls">
						<input type="password" name="password2" id="password2" value="{$password2}">
						<span class="help-inline"></span>
					</div>
				</div>
				{literal}
				<script type="text/javascript">
					// Password Strength
					$('#password').keyup(function() {
						$(this).parent().parent().removeClass('warning error success');
						$(this).next().html("");
						if($(this).val().length == 0) return;
						var pwstrength = passwordStrength($(this).val());
						if(pwstrength > 75) {
							$(this).parent().parent().addClass("success");
							$(this).next().html("{/literal}{$LANG.pwstrengthstrong}{literal}");
						} else if (pwstrength > 30) {
							$(this).parent().parent().addClass("warning");
							$(this).next().html("{/literal}{$LANG.pwstrengthmoderate}{literal}");
						} else {
							$(this).parent().parent().addClass("error");
							$(this).next().html("{/literal}{$LANG.pwstrengthweak}{literal}");
						}
						$('#password2').keyup();
					});
					// Compare passwords
					$('#password2').keyup(function() {
						$(this).parent().parent().removeClass('error success');
						$(this).next().html("");
						if($(this).val().length < 1) return;
						if($('#password').val() != $(this).val()) {
							$(this).parent().parent().addClass('error');
						} else {
							$(this).parent().parent().addClass('success');
						}
					});
				</script>
				{/literal}
				{/if}
			</div>
			<div class="span6">
				<div class="control-group">
					<label class="control-label" for="address1">{$LANG.clientareaaddress1}</label>
					<div class="controls">
						<input type="text" name="address1" id="address1" value="{$clientsdetails.address1}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="address2">{$LANG.clientareaaddress2}</label>
					<div class="controls">
						<input type="text" name="address2" id="address2" value="{$clientsdetails.address2}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="city">{$LANG.clientareacity}</label>
					<div class="controls">
						<input type="text" name="city" id="city" value="{$clientsdetails.city}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="state">{$LANG.clientareastate}</label>
					<div class="controls">
						{if $loggedin}
						<input type="text" id="state" value="{$clientsdetails.state}" disabled="disabled" class="disabled">
						{else}
						<input type="text" name="state" id="state" value="{$clientsdetails.state}">
						{/if}
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="postcode">{$LANG.clientareapostcode}</label>
					<div class="controls">
						<input type="text" name="postcode" id="postcode" value="{$clientsdetails.postcode}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="country">{$LANG.clientareacountry}</label>
					<div class="controls">
						{if $loggedin}
						<input type="text" id="country" value="{$clientsdetails.country}" disabled="disabled" class="disabled">
						{else}
						{$clientcountrydropdown}
						{/if}
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="phonenumber">{$LANG.clientareaphonenumber}</label>
					<div class="controls">
						<input type="text" name="phonenumber" id="phonenumber" value="{$clientsdetails.phonenumber}"{if $loggedin} disabled="disabled" class="disabled"{/if}>
					</div>
				</div>
			</div>
		</div>

		{if $customfields}
		<div class="row">
			{foreach key=num item=customfield from=$customfields}
			<div class="span12">
				<div class="control-group">
					<label class="control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
					<div class="controls">
						{$customfield.input} <span class="help-inline">{$customfield.description}</span>
					</div>
				</div>
			</div>
			{/foreach}
		</div>
		{/if}

		{if $securityquestions && !$loggedin}
		<div class="alert alert-info alert-block form-inline textcenter">
			<div class="row-fluid">
				<div class="span6">
					<label for="securityqans">{$LANG.clientareasecurityquestion}</label>
					<select name="securityqid" id="securityqid">
					{foreach key=num item=question from=$securityquestions}
						<option value={$question.id}>{$question.question}</option>
					{/foreach}
					</select>
				</div>
				<div class="span6">
					<label for="securityqans">{$LANG.clientareasecurityanswer}</label>
					<input type="password" name="securityqans" id="securityqans">
				</div>
			</div>
		</div>
		{/if}

	</fieldset>

	{if $taxenabled && !$loggedin}
	<p class="textcenter">{$LANG.carttaxupdateselections} <input type="submit" value="{$LANG.carttaxupdateselectionsupdate}" name="updateonly"></p>
	{/if}

	{if $domainsinorder}
	{literal}
	<script type="text/javascript">
		function domaincontactchange() {
			if ($("#domaincontact").val() == 'addingnew') {
				$('#domaincontactfields').slideDown();
			} else {
				$('#domaincontactfields').slideUp();
			}
		}
	</script>
	{/literal}
	<h2>{$LANG.domainregistrantinfo}</h2>
	<div class="well well-small">
		<fieldset class="textcenter form-inline">
			<label>{$LANG.domainregistrantchoose}</label>
			<select name="contact" id="domaincontact" onchange="domaincontactchange()">
				<option value="">{$LANG.usedefaultcontact}</option>
				{foreach from=$domaincontacts item=domcontact}
				<option value="{$domcontact.id}"{if $contact eq $domcontact.id} selected="selected"{/if}>{$domcontact.name}</option>
				{/foreach}
				<option value="addingnew"{if $contact eq "addingnew"} selected="selected"{/if}>{$LANG.clientareanavaddcontact}</option>
			</select>
		</fieldset>
	</div>
	<fieldset id="domaincontactfields" class="form-horizontal{if $contact neq "addingnew"} hide{/if}">
		<div class="row">
			<div class="span6">
				<div class="control-group">
					<label class="control-label" for="firstname">{$LANG.clientareafirstname}</label>
					<div class="controls">
						<input type="text" name="domaincontactfirstname" id="domaincontactfirstname" value="{$domaincontact.firstname}">
					</div>
				</div>
				<div class="control-group">
			 		<label class="control-label" for="lastname">{$LANG.clientarealastname}</label>
					<div class="controls">
						<input type="text" name="domaincontactlastname" id="domaincontactlastname" value="{$domaincontact.lastname}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="companyname">{$LANG.clientareacompanyname}</label>
					<div class="controls">
						<input type="text" name="domaincontactcompanyname" id="domaincontactcompanyname" value="{$domaincontact.companyname}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="email">{$LANG.clientareaemail}</label>
					<div class="controls">
						<input type="text" name="domaincontactemail" id="domaincontactemail" value="{$domaincontact.email}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="phonenumber">{$LANG.clientareaphonenumber}</label>
					<div class="controls">
						<input type="text" name="domaincontactphonenumber" id="domaincontactphonenumber" value="{$domaincontact.phonenumber}" />
					</div>
				</div>
			</div>
			<div class="span6">
				<div class="control-group">
					<label class="control-label" for="address1">{$LANG.clientareaaddress1}</label>
					<div class="controls">
						<input type="text" name="domaincontactaddress1" id="domaincontactaddress1" value="{$domaincontact.address1}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="address2">{$LANG.clientareaaddress2}</label>
					<div class="controls">
						<input type="text" name="domaincontactaddress2" id="domaincontactaddress2" value="{$domaincontact.address2}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="city">{$LANG.clientareacity}</label>
					<div class="controls">
						<input type="text" name="domaincontactcity" id="domaincontactcity" value="{$domaincontact.city}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="state">{$LANG.clientareastate}</label>
					<div class="controls">
						<input type="text" name="domaincontactstate" id="domaincontactstate" value="{$domaincontact.state}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="postcode">{$LANG.clientareapostcode}</label>
					<div class="controls">
						<input type="text" name="domaincontactpostcode" id="domaincontactpostcode" value="{$domaincontact.postcode}">
					</div>
				</div>
				<div class="control-group">
					<label class="control-label" for="country">{$LANG.clientareacountry}</label>
					<div class="controls">
						{$domaincontactcountrydropdown}
					</div>
				</div>
			</div>
		</div>
	</fieldset>
	{/if}

	{literal}
	<script type="text/javascript">
		function showCCForm() { $("#ccinputform").slideDown(); }
		function hideCCForm() { $("#ccinputform").slideUp(); }
		function useExistingCC() { $(".newccinfo").hide(); }
		function enterNewCC() { $(".newccinfo").show(); }
	</script>
	{/literal}

	<h2>{$LANG.orderpaymentmethod}</h2>
	<fieldset class="well well-small form-inline textcenter">
		{foreach key=num item=gateway from=$gateways}
		<label class="radio inline"><input type="radio" name="paymentmethod" value="{$gateway.sysname}" onclick="{if $gateway.type eq "CC"}showCCForm(){else}hideCCForm(){/if}"{if $selectedgateway eq $gateway.sysname} checked="checked"{/if}> {$gateway.name}</label>
		{/foreach}
	</fieldset>

	<fieldset id="ccinputform" class="form-horizontal{if $selectedgatewaytype neq "CC"} hide{/if}">
		{if $clientsdetails.cclastfour}
		<div class="control-group">
			<div class="controls">
				<label class="radio"><input type="radio" name="ccinfo" value="useexisting" id="useexisting" onclick="useExistingCC()"{if $clientsdetails.cclastfour} checked="checked"{else} disabled="disabled"{/if}> {$LANG.creditcarduseexisting}{if $clientsdetails.cclastfour} ({$clientsdetails.cclastfour}){/if}</label>
			</div>
		</div>
		<div class="control-group">
			<div class="controls">
				<label class="radio"><input type="radio" name="ccinfo" value="new" id="new" onclick="enterNewCC()"{if !$clientsdetails.cclastfour || $ccinfo eq "new"} checked="checked"{/if}> {$LANG.creditcardenternewcard}</label>
			</div>
		</div>
		{else}
		<div class="control-group">
			<div class="controls">
				<input type="hidden" name="ccinfo" value="new">
			</div>
		</div>
		{/if}
		<div class="control-group newccinfo{if $clientsdetails.cclastfour && $ccinfo neq "new"} hide{/if}">
			<label class="control-label">{$LANG.creditcardcardtype}</label>
			<div class="controls">
				<select name="cctype">
					{foreach key=num item=cardtype from=$acceptedcctypes}
					<option{if $cctype eq $cardtype} selected="selected"{/if}>{$cardtype}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div class="control-group newccinfo{if $clientsdetails.cclastfour && $ccinfo neq "new"} hide{/if}">
			<label class="control-label">{$LANG.creditcardcardnumber}</label>
			<div class="controls">
				<input type="text" name="ccnumber" size="30" value="{$ccnumber}" autocomplete="off">
			</div>
		</div>
		<div class="control-group newccinfo{if $clientsdetails.cclastfour && $ccinfo neq "new"} hide{/if}">
			<label class="control-label">{$LANG.creditcardcardexpires}</label>
			<div class="controls">
				<select name="ccexpirymonth" id="ccexpirymonth" class="span1">
					{foreach from=$months item=month}
					<option{if $ccexpirymonth eq $month} selected="selected"{/if}>{$month}</option>
					{/foreach}
				</select>
				 / 
				<select name="ccexpiryyear" class="span1">
					{foreach from=$expiryyears item=year}
					<option{if $ccexpiryyear eq $year} selected="selected"{/if}>{$year}</option>
					{/foreach}
				</select>
			</div>
		</div>
		{if $showccissuestart}
		<div class="control-group newccinfo{if $clientsdetails.cclastfour && $ccinfo neq "new"} hide{/if}">
			<label class="control-label">{$LANG.creditcardcardstart}</label>
			<div class="controls">
				<select name="ccstartmonth" id="ccstartmonth">
					{foreach from=$months item=month}
					<option{if $ccstartmonth eq $month} selected="selected"{/if}>{$month}</option>
					{/foreach}
				</select>
				/ 
				<select name="ccstartyear">
					{foreach from=$startyears item=year}
					<option{if $ccstartyear eq $year} selected="selected"{/if}>{$year}</option>
					{/foreach}
				</select>
			</div>
		</div>
		<div class="control-group newccinfo{if $clientsdetails.cclastfour && $ccinfo neq "new"} hide{/if}">
			<label class="control-label">{$LANG.creditcardcardissuenum}</label>
			<div class="controls">
				<input type="text" name="ccissuenum" value="{$ccissuenum}" class="span1" size="5" maxlength="3">
			</div>
		</div>
		{/if}
		<div class="control-group">
			<label class="control-label">{$LANG.creditcardcvvnumber}</label>
			<div class="controls">
				<input type="text" name="cccvv" value="{$cccvv}" class="span1" size="5" autocomplete="off">
				<span class="help-inline"><a href="#" onclick="window.open('images/ccv.gif','','width=280,height=200,scrollbars=no,top=100,left=100');return false">{$LANG.creditcardcvvwhere}</a></span>
			</div>
		</div>
		{if $shownostore}
		<div class="control-group">
			<div class="controls">
				<label class="checkbox"><input type="checkbox" name="nostore"> {$LANG.creditcardnostore}</label>
			</div>
		</div>
		{/if}
	</fieldset>

	{if $shownotesfield}
	<h2>{$LANG.ordernotes}</h2>
	<div class="textcenter">
		<p>{$LANG.ordernotesdescription}</p>
		<textarea name="notes" rows="4" class="span9"></textarea>
	</div>
	{/if}


	<div class="form-actions textcenter">

	{if $accepttos}
		<p>
			<label class="checkbox inline"><input type="checkbox" name="accepttos" id="accepttos"> {$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a></label>
		</p>
	{/if}

		<input type="submit" class="btn btn-primary" value="{$LANG.completeorder}"{if $cartitems eq 0} disabled="disabled"{/if} onclick="this.value='{$LANG.pleasewait}'">
	</div>

	<p class="textcenter">
		<img src="images/padlock.gif" border="0" class="imgfloat" alt="Secure Transaction" /> {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
	</p>


</form>

{/if}
