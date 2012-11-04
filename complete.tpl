<div class="textcenter hero-unit" style="background-color:#fff; border: 1px solid #ddd;margin-top:30px;">
	<h1 style="margin-bottom:10px">{$LANG.orderconfirmation}</h1>
	<p><strong>Your order number is #{$ordernumber}</strong></p>
	<p>{$LANG.orderreceived}</p>
	<p>{$LANG.orderfinalinstructions}</p>
	{if $invoiceid && !$ispaid}
	<hr>
	<p class="text-error">{$LANG.ordercompletebutnotpaid}<br><br><a href="viewinvoice.php?id={$invoiceid}" class="btn btn-danger" target="_blank">{$LANG.invoicenumber}{$invoiceid}</a></p>
	{/if}
</div>

{foreach from=$addons_html item=addon_html}
<div style="margin: 15px 0;">{$addon_html}</div>
{/foreach}

<p class="textcenter" style="margin-bottom: 15px;">
	<a href="clientarea.php">{$LANG.ordergotoclientarea}</a>
</p>
