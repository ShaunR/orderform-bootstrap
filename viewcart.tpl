{if !$loggedin && $currencies}
<div class="pull-right">
	<form method="post" action="cart.php?a=view" class="form-inline">
		<fieldset class="well well-sm">
			<div class="form-group">
				<label for="choosecurrency">{$LANG.choosecurrency}</label>:
			</div>
			<div class="form-group">
				<select id="choosecurrency" name="currency" onchange="submit()" class="form-control">
					{foreach from=$currencies item=curr}
					<option value="{$curr.id}"{if $curr.id eq $currency.id} selected{/if}>{$curr.code}</option>
					{/foreach}
				</select>
			</div>
		</fieldset>
	</form>
</div>
{/if}

<div class="page-header">
	<h1>{$LANG.navservicesorder} <small>{if $checkout}{$LANG.ordercheckout}{else}{$LANG.ordersummary}{/if}</small></h1>
</div>

{if $errormessage}
<div class="alert alert-danger">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<h4>{$LANG.clientareaerrors}</h4>
	<ul>{$errormessage}</ul>
</div>
{elseif $promotioncode && $rawdiscount eq "0.00"}
<div class="alert alert-danger">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	{$LANG.promoappliedbutnodiscount}
</div>
{/if}

{if $bundlewarnings}
<div class="alert alert-danger">
	<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
	<h4>{$LANG.bundlereqsnotmet}</h4>
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
		<thead>
			<tr>
				<th class="active">{$LANG.orderdesc}</th>
				<th class="active">{$LANG.orderprice}</th>
			</tr>
		</thead>
		<tbody>
			{foreach key=num item=product from=$products}
			<tr>
				<td>
					<em>{$product.productinfo.groupname}</em> - {$product.productinfo.name}{if $product.domain} ({$product.domain}){/if}
					{if $product.configoptions}
					<ul>
						{foreach key=confnum item=configoption from=$product.configoptions}
						<li>{$configoption.name}: {if $configoption.type eq 1 || $configoption.type eq 2}{$configoption.option}{elseif $configoption.type eq 3}{if $configoption.qty}{$LANG.yes}{else}{$LANG.no}{/if}{elseif $configoption.type eq 4}{$configoption.qty} &times; {$configoption.option}{/if}</li>
						{/foreach}
					</ul>
					{/if}
				</td>
				<td>
					{$product.pricingtext}{if $product.proratadate}<br>({$LANG.orderprorata} {$product.proratadate}){/if}
				</td>
			</tr>
			{foreach key=addonnum item=addon from=$product.addons}
			<tr>
				<td>{$LANG.orderaddon} - {$addon.name}</td>
				<td>{$addon.pricingtext}</td>
			</tr>
			{/foreach}
			<tr>
				<td colspan="2">
					<fieldset class="form-inline">
						<a href="{$smarty.server.PHP_SELF}?a=confproduct&i={$num}" class="text-success">{$LANG.carteditproductconfig}</a>
						<span class="text-muted">|</span>
						<a href="cart.php?a=remove&amp;r=p&amp;i={$num}" title="{$LANG.cartremove}" class="text-danger" onClick="return confirm('{$LANG.cartremoveitemconfirm}')">{$LANG.cartremove}</a>
						{if $product.allowqty}
						<span class="text-muted">|</span>
						<span> {$LANG.cartqtyenterquantity}</span>
						<div class="form-group">
							<div class="input-group">
								<input type="text" id="qty{$num}" name="qty[{$num}]" size="3" class="form-control input-sm" value="{$product.qty}">
								<span class="input-group-btn">
									<button class="btn btn-primary btn-sm" type="button" onClick="submit()">{$LANG.cartqtyupdate}</button>
								</span>
							</div>
						</div>
						{/if}
					</fieldset>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="active">&nbsp;</td>
			</tr>
			{/foreach}

			{foreach key=num item=addon from=$addons}
			<tr>
				<td>{$addon.name}<br>{$addon.productname}{if $addon.domainname} - {$addon.domainname}{/if}</td>
				<td><strong>{$addon.pricingtext}</strong></td>
			</tr>
			<tr>
				<td>
					<a href="cart.php?a=remove&amp;r=a&amp;i={$num}" class="text-danger" title="{$LANG.cartremove}">{$LANG.cartremove}</a>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" class="active">&nbsp;</td>
			</tr>
			{/foreach}

			{foreach key=num item=domain from=$domains}
			<tr>
				<td>
				{if $domain.type eq "register"}{$LANG.orderdomainregistration}{else}{$LANG.orderdomaintransfer}{/if} - {$domain.domain} - {$domain.regperiod} {$LANG.orderyears}
					<ul>
						{if $domain.dnsmanagement}<li>{$LANG.domaindnsmanagement}</li>{/if}
						{if $domain.emailforwarding}<li>{$LANG.domainemailforwarding}</li>{/if}
						{if $domain.idprotection}<li>{$LANG.domainidprotection}</li>{/if}
					</ul>
				</td>
				<td>{$domain.price}</td>
			</tr>
			<tr>
				<td>
					<a href="{$smarty.server.PHP_SELF}?a=confdomains" class="text-success">{$LANG.cartconfigdomainextras}</a>
					<span class="text-muted">|</span>
					<a href="cart.php?a=remove&amp;r=d&amp;i={$num}" class="text-danger">{$LANG.cartremove}</a>
				</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" class="active">&nbsp;</td>
			</tr>
			{/foreach}

			{foreach key=num item=domain from=$renewals}
			<tr>
				<td>
					{$LANG.domainrenewal} - {$domain.domain} - {$domain.regperiod} {$LANG.orderyears}
					<ul>
						{if $domain.dnsmanagement}<li>{$LANG.domaindnsmanagement}</li>{/if}
						{if $domain.emailforwarding}<li>{$LANG.domainemailforwarding}</li>{/if}
						{if $domain.idprotection}<li>{$LANG.domainidprotection}</li>{/if}
					</ul>
				</td>
				<td>{$domain.price}</td>
			</tr>
			<tr>
				<td><a href="cart.php?a=remove&amp;r=r&amp;i={$num}" class="text-danger">{$LANG.cartremove}</a></td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td colspan="2" class="active">&nbsp;</td>
			</tr>
			{/foreach}

			{if $cartitems==0}
			<tr>
				<td colspan="2" class="text-center">{$LANG.cartempty}</td>
			</tr>
			{/if}
			<tr>
				<td class="text-right">{$LANG.ordersubtotal}</td>
				<td>{$subtotal}</td>
			</tr>
			{if $promotioncode}
			<tr>
				<td class="text-right">{$promotiondescription}</td>
				<td>{$discount}</td>
			</tr>
			{/if}
			{if $taxrate}
			<tr>
				<td class="text-right">{$taxname} @ {$taxrate}%</td>
				<td>{$taxtotal}</td>
			</tr>
			{/if}
			{if $taxrate2}
			<tr>
				<td class="text-right">{$taxname2} @ {$taxrate2}%</td>
				<td>{$taxtotal2}</td>
			</tr>
			{/if}
			<tr>
				<td class="text-right">{$LANG.ordertotalduetoday}</td>
				<td>{$total}</td>
			</tr>
			{if $totalrecurringmonthly || $totalrecurringquarterly || $totalrecurringsemiannually || $totalrecurringannually || $totalrecurringbiennially || $totalrecurringtriennially}
			<tr>
				<td class="text-right">{$LANG.ordertotalrecurring}</td>
				<td>
					{if $totalrecurringmonthly}{$totalrecurringmonthly} {$LANG.orderpaymenttermmonthly}<br>{/if}
					{if $totalrecurringquarterly}{$totalrecurringquarterly} {$LANG.orderpaymenttermquarterly}<br>{/if}
					{if $totalrecurringsemiannually}{$totalrecurringsemiannually} {$LANG.orderpaymenttermsemiannually}<br>{/if}
					{if $totalrecurringannually}{$totalrecurringannually} {$LANG.orderpaymenttermannually}<br>{/if}
					{if $totalrecurringbiennially}{$totalrecurringbiennially} {$LANG.orderpaymenttermbiennially}<br>{/if}
					{if $totalrecurringtriennially}{$totalrecurringtriennially} {$LANG.orderpaymenttermtriennially}<br>{/if}
				</td>
			</tr>
			{/if}	
		</tbody>
	</table>
</form>

<div class="row text-center">
	<div class="col-md-6">
		<form method="post" action="{$smarty.server.PHP_SELF}?a=view" class="form-horizontal well well-sm">
			<input type="hidden" name="validatepromo" value="true">
			<div class="row">
				<label class="control-label col-md-4" for="promocode">{$LANG.orderpromotioncode}</label>
				{if $promotioncode}
				<div class="col-md-8 text-center">
					<p>{$promotioncode} - {$promotiondescription}</p>
					<a href="{$smarty.server.PHP_SELF}?a=removepromo" class="btn btn-sm btn-warning">{$LANG.orderdontusepromo}</a>
				</div>
				{else}
				<div class="col-md-8">
					<div class="input-group">
						<input type="text" name="promocode" id="promocode" class="form-control">
						<span class="input-group-btn">
							<button type="submit" class="btn btn-info">{$LANG.orderpromovalidatebutton}</button>
						</span>
					</div>
				</div>
				{/if}
			</div>
		</form>
	</div>
	<div class="col-md-6">
		<div class="well well-sm" style="border:none;background:none;box-shadow:none">
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

<form method="post" action="{$smarty.server.PHP_SELF}?a=checkout">
	<input type="hidden" name="submit" value="true">
	<input type="hidden" name="custtype" id="custtype" value="{$custtype}">
	<div class="panel panel-default">
		<div class="panel-heading">{$LANG.yourdetails}</div>
		<div class="panel-body">
			<fieldset id="loginform" class="form-horizontal"{if $custtype eq "existing" && !$loggedin}{else} style="display:none"{/if}>
				<p>{$LANG.newcustomersignup|sprintf2:'<a href="javascript:void(0)" onclick="toggleLoginForm();return false;">':'</a>'}</p>
				<div class="form-group">
					<label class="col-md-4 control-label" for="loginemail">{$LANG.loginemail}</label>
					<div class="col-md-4">
						<input type="text" name="loginemail" id="loginemail" class="form-control" value="{$username}">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="loginpw">{$LANG.loginpassword}</label>
					<div class="col-md-4">
						<input type="password" name="loginpw" id="loginpw" class="form-control">
					</div>
				</div>
			</fieldset>

			<fieldset id="signupform" class="form-horizontal"{if $custtype eq "existing" && !$loggedin} style="display:none"{/if}>
				{if !$loggedin}
				<p>
					<strong>{$LANG.existingcustomer}?</strong> <a href="{$smarty.server.PHP_SELF}?a=login" onclick="toggleLoginForm();return false;">{$LANG.clickheretologin}</a>
				</p>
				{/if}
				<div class="row">
					<div class="col-md-6">
						<div class="form-group">
				 			<label class="col-md-4 control-label" for="firstname">{$LANG.clientareafirstname}</label>
							<div class="col-md-8">
								<input type="text" name="firstname" id="firstname" value="{$clientsdetails.firstname}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
						<div class="form-group">
				 			<label class="col-md-4 control-label" for="lastname">{$LANG.clientarealastname}</label>
							<div class="col-md-8">
								<input type="text" name="lastname" id="lastname" value="{$clientsdetails.lastname}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
					 	<div class="form-group">
							<label class="col-md-4 control-label" for="companyname">{$LANG.clientareacompanyname}</label>
							<div class="col-md-8">
								<input type="text" name="companyname" id="companyname" value="{$clientsdetails.companyname}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="email">{$LANG.clientareaemail}</label>
							<div class="col-md-8">
								<input type="text" name="email" id="email" value="{$clientsdetails.email}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
						{if !$loggedin}
						<div class="form-group">
							<label class="col-md-4 control-label" for="password">{$LANG.clientareapassword}</label>
							<div class="col-md-8">
								<input type="password" name="password" id="password" value="{$password}" class="form-control">
								<span class="help-inline"></span>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="password2">{$LANG.clientareaconfirmpassword}</label>
							<div class="col-md-8">
								<input type="password" name="password2" id="password2" value="{$password2}" class="form-control">
								<span class="help-inline"></span>
							</div>
						</div>
						{literal}
						<script type="text/javascript">
							// Password Strength
							$('#password').keyup(function() {
								$(this).parent().parent().removeClass('has-warning has-error has-success');
								$(this).next().html("");
								if($(this).val().length == 0) return;
								var pwstrength = passwordStrength($(this).val());
								if(pwstrength > 75) {
									$(this).parent().parent().addClass("has-success");
									$(this).next().html("{/literal}{$LANG.pwstrengthstrong}{literal}");
								} else if (pwstrength > 30) {
									$(this).parent().parent().addClass("has-warning");
									$(this).next().html("{/literal}{$LANG.pwstrengthmoderate}{literal}");
								} else {
									$(this).parent().parent().addClass("has-error");
									$(this).next().html("{/literal}{$LANG.pwstrengthweak}{literal}");
								}
								$('#password2').keyup();
							});
							// Compare passwords
							$('#password2').keyup(function() {
								$(this).parent().parent().removeClass('has-error has-success');
								$(this).next().html("");
								if($(this).val().length < 1) return;
								if($('#password').val() != $(this).val()) {
									$(this).parent().parent().addClass('has-error');
								} else {
									$(this).parent().parent().addClass('has-success');
								}
							});
						</script>
						{/literal}
						{/if}
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label class="col-md-4 control-label" for="address1">{$LANG.clientareaaddress1}</label>
							<div class="col-md-8">
								<input type="text" name="address1" id="address1" value="{$clientsdetails.address1}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="address2">{$LANG.clientareaaddress2}</label>
							<div class="col-md-8">
								<input type="text" name="address2" id="address2" value="{$clientsdetails.address2}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="city">{$LANG.clientareacity}</label>
							<div class="col-md-8">
								<input type="text" name="city" id="city" value="{$clientsdetails.city}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="state">{$LANG.clientareastate}</label>
							<div class="col-md-8">
								{if $loggedin}
								<input type="text" id="state" value="{$clientsdetails.state}" disabled="disabled" class="disabled form-control">
								{else}
								<input type="text" name="state" id="state" value="{$clientsdetails.state}" class="form-control">
								{/if}
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="postcode">{$LANG.clientareapostcode}</label>
							<div class="col-md-8">
								<input type="text" name="postcode" id="postcode" value="{$clientsdetails.postcode}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="country">{$LANG.clientareacountry}</label>
							<div class="col-md-8">
								{if $loggedin}
								<input type="text" id="country" value="{$clientsdetails.country}" disabled="disabled" class="disabled form-control">
								{else}
								{$clientcountrydropdown}
								<script type="text/javascript">$('#country').addClass('form-control');</script>
								{/if}
							</div>
						</div>
						<div class="form-group">
							<label class="col-md-4 control-label" for="phonenumber">{$LANG.clientareaphonenumber}</label>
							<div class="col-md-8">
								<input type="text" name="phonenumber" id="phonenumber" value="{$clientsdetails.phonenumber}" {if $loggedin}disabled="disabled" class="form-control disabled"{else}class="form-control"{/if}>
							</div>
						</div>
					</div>
				</div>

				{if $customfields}
				{foreach key=num item=customfield from=$customfields}
				<div class="form-group customfields">
					<label class="col-md-2 control-label" for="customfield{$customfield.id}">{$customfield.name}</label>
					{if $customfield.type eq "tickbox"}
					<div class="col-md-10">
						<div class="checkbox">
							<label>{$customfield.input} {$customfield.description}</label>
						</div>
					</div>
					{else}
					<div class="col-md-4">
						{$customfield.input}
					</div>
					<div class="col-md-6">
						<div class="help-block">{$customfield.description}</div>
					</div>
					{/if}
				</div>
				{/foreach}
				<script type="text/javascript">
					$(".customfields input[type=text]").addClass("form-control");
					$(".customfields select").addClass("form-control");
				</script>
				{/if}

				{if $securityquestions && !$loggedin}
				<div class="alert alert-info">
					<div class="form-group">
						<label class="col-md-4 control-label" for="securityqans">{$LANG.clientareasecurityquestion}</label>
						<div class="col-md-6">
							<select name="securityqid" id="securityqid" class="form-control">
								{foreach key=num item=question from=$securityquestions}
								<option value={$question.id}>{$question.question}</option>
								{/foreach}
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-md-4 control-label" for="securityqans">{$LANG.clientareasecurityanswer}</label>
						<div class="col-md-6">
							<input type="password" name="securityqans" id="securityqans" class="form-control">
						</div>
					</div>
				</div>
				{/if}
		
			</fieldset>
		</div>
	</div>

	{if $taxenabled && !$loggedin}
	<p class="text-center">{$LANG.carttaxupdateselections} <input type="submit" value="{$LANG.carttaxupdateselectionsupdate}" name="updateonly"></p>
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
	<div class="well well-sm">
		<fieldset class="text-center form-inline">
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
	<fieldset id="domaincontactfields" class="form-horizontal"{if $contact neq "addingnew"} style="display:none"{/if}>
		<div class="row">
			<div class="col-md-6">
				<div class="form-group">
					<label class="col-md-4 control-label" for="firstname">{$LANG.clientareafirstname}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactfirstname" id="domaincontactfirstname" value="{$domaincontact.firstname}" class="form-control">
					</div>
				</div>
				<div class="form-group">
			 		<label class="col-md-4 control-label" for="lastname">{$LANG.clientarealastname}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactlastname" id="domaincontactlastname" value="{$domaincontact.lastname}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="companyname">{$LANG.clientareacompanyname}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactcompanyname" id="domaincontactcompanyname" value="{$domaincontact.companyname}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="email">{$LANG.clientareaemail}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactemail" id="domaincontactemail" value="{$domaincontact.email}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="phonenumber">{$LANG.clientareaphonenumber}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactphonenumber" id="domaincontactphonenumber" value="{$domaincontact.phonenumber}" class="form-control">
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<div class="form-group">
					<label class="col-md-4 control-label" for="address1">{$LANG.clientareaaddress1}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactaddress1" id="domaincontactaddress1" value="{$domaincontact.address1}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="address2">{$LANG.clientareaaddress2}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactaddress2" id="domaincontactaddress2" value="{$domaincontact.address2}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="city">{$LANG.clientareacity}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactcity" id="domaincontactcity" value="{$domaincontact.city}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="state">{$LANG.clientareastate}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactstate" id="domaincontactstate" value="{$domaincontact.state}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="postcode">{$LANG.clientareapostcode}</label>
					<div class="col-md-8">
						<input type="text" name="domaincontactpostcode" id="domaincontactpostcode" value="{$domaincontact.postcode}" class="form-control">
					</div>
				</div>
				<div class="form-group">
					<label class="col-md-4 control-label" for="country">{$LANG.clientareacountry}</label>
					<div class="col-md-8">
						{$domaincontactcountrydropdown}
					</div>
				</div>
			</div>
		</div>
	</fieldset>
	{/if}
	
	<div class="panel panel-default">
		<div class="panel-heading">{$LANG.orderpaymentmethod}</div>
		<div class="panel-body">
			<fieldset id="fieldset-payment-method">
			{foreach key=num item=gateway from=$gateways}
				<label class="radio-inline">
					<input type="radio" name="paymentmethod" value="{$gateway.sysname}" onclick="{if $gateway.type eq 'CC'}showCCFields();{else}hideCCFields();{/if}"{if $selectedgateway eq $gateway.sysname} checked="checked"{/if}> {$gateway.name}
				</label>
			{/foreach}
			</fieldset>
			<script>
			{literal}
				function showCCFields() {
					$('#fieldset-payment-method-creditcard').show();
				}
				function hideCCFields() {
					$('#fieldset-payment-method-creditcard').hide();
				}

				$(function() {
					$('input[name=ccinfo]').change(function() {
						if($(this).val() == 'useexisting') {
							$('#cctype').hide();
							$('#ccnumber').hide();
							$('#ccexpiry').hide();
							$('#ccstart').hide();
							$('#ccissue').hide();
							$('#ccstore').hide();
						} else {
							$('#cctype').show();
							$('#ccnumber').show();
							$('#ccexpiry').show();
							$('#ccstart').show();
							$('#ccissue').show();
							$('#ccstore').show();
						}
					});
					$('input[name=ccinfo]:checked').change();
				});
			{/literal}
			</script>
			<fieldset id="fieldset-payment-method-creditcard" style="overflow:none">
				<hr>
				{if $clientsdetails.cclastfour}
				<div class="form-group">
					<label class="radio-inline">
						<input type="radio" name="ccinfo" value="useexisting"{if $clientsdetails.cclastfour} checked="checked"{/if}> {$LANG.creditcarduseexisting} ({$clientsdetails.cclastfour})
					</label>
					<label class="radio-inline">
						<input type="radio" name="ccinfo" value="new" id="new"{if !$clientsdetails.cclastfour || $ccinfo eq "new"} checked="checked"{/if}> {$LANG.creditcardenternewcard}
					</label>
				</div>
				{else}
				<input type="hidden" name="ccinfo" value="new">
				{/if}
				<div class="well well-sm">
					<div class="row">
						<div class="col-md-6" id="cctype">
							<div class="form-group">
								<label>{$LANG.creditcardcardtype}</label>
								<select name="cctype" class="form-control">
									{foreach key=num item=cardtype from=$acceptedcctypes}
									<option{if $cctype eq $cardtype} selected="selected"{/if}>{$cardtype}</option>
									{/foreach}
								</select>
							</div>
						</div>
						<div class="col-md-6" id="ccnumber">
							<div class="form-group">
								<label>{$LANG.creditcardcardnumber}</label>
								<input type="text" name="ccnumber" value="{$ccnumber}" autocomplete="off" class="form-control">
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6" id="ccexpiry">
							<div class="form-group">
								<label>{$LANG.creditcardcardexpires}</label>
								<div class="row">
									<div class="col-md-5">
										<select name="ccexpirymonth" id="ccexpirymonth" class="form-control">
											{foreach from=$months item=month}
											<option{if $ccexpirymonth eq $month} selected="selected"{/if}>{$month}</option>
											{/foreach}
										</select>
									</div>
									<div class="col-md-2 text-center">
										<p class="help-block">/</p>
									</div>
									<div class="col-md-5">
										<select name="ccexpiryyear" class="form-control">
											{foreach from=$expiryyears item=year}
											<option{if $ccexpiryyear eq $year} selected="selected"{/if}>{$year}</option>
											{/foreach}
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6" id="cccvv">
							<div class="form-group">
								<label>{$LANG.creditcardcvvnumber}</label>
								<div class="row">
									<div class="col-md-4">
										<input type="text" name="cccvv" value="{$cccvv}" class="form-control" size="5" autocomplete="off">
									</div>
									<div class="col-md-8">
										<span class="help-block"><a href="#" onclick="window.open('images/ccv.gif','','width=280,height=200,scrollbars=no,top=100,left=100');return false">{$LANG.creditcardcvvwhere}</a></span>
									</div>
								</div>
							</div>
						</div>
					</div>
					{if $showccissuestart}
					<div class="row">
						<div class="col-md-6" id="ccstart">
							<div class="form-group">
								<label>{$LANG.creditcardcardstart}</label>
								<div class="row">
									<div class="col-md-5">
										<select name="ccstartmonth" id="ccstartmonth" class="form-control">
											{foreach from=$months item=month}
											<option{if $ccstartmonth eq $month} selected="selected"{/if}>{$month}</option>
											{/foreach}
										</select>
									</div>
									<div class="col-md-2 text-center">
										<span class="help-block">/</span>
									</div>
									<div class="col-md-5">
										<select name="ccexpiryyear" class="form-control">
											{foreach from=$expiryyears item=year}
											<option{if $ccexpiryyear eq $year} selected="selected"{/if}>{$year}</option>
											{/foreach}
										</select>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6" id="ccissue">
							<div class="form-group">
								<label>{$LANG.creditcardcardissuenum}</label>
								<input type="text" name="ccissuenum" value="{$ccissuenum}" class="form-control" size="5" maxlength="3">
							</div>
						</div>
					</div>
					{/if}
					<div class="form-group" id="ccstore">
						<div class="checkbox">
							<label>
								<input type="checkbox" name="nostore"> {$LANG.creditcardnostore}
							</label>
						</div>
					</div>
				</div>
			</fieldset>
		</div>
	</div>

	{if $shownotesfield}
	<div class="panel panel-default">
		<div class="panel-heading">{$LANG.ordernotes}</div>
		<div class="panel-body">
			<div class="text-center form-group">
				<p>{$LANG.ordernotesdescription}</p>
				<textarea name="notes" rows="4" class="form-control"></textarea>
			</div>
		</div>
	</div>
	{/if}


	<div class="well well-sm text-center">
		{if $accepttos}
		<div class="form-group">
			<label class="checkbox-inline"><input type="checkbox" name="accepttos" id="accepttos"> {$LANG.ordertosagreement} <a href="{$tosurl}" target="_blank">{$LANG.ordertos}</a></label>
		</div>
		{/if}
		<div class="form-group">
			<input type="submit" class="btn btn-primary" value="{$LANG.completeorder}"{if $cartitems eq 0} disabled="disabled"{/if} onclick="this.value='{$LANG.pleasewait}'">
		</div>
		<p class="text-center">
			<img src="images/padlock.gif" class="imgfloat" alt="Secure Transaction"> {$LANG.ordersecure} (<strong>{$ipaddress}</strong>) {$LANG.ordersecure2}
		</p>
	</div>


</form>
{/if}
