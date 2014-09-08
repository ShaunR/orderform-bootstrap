<section>
	<div class="container">
		<div class="panel panel-default" style="margin-top:20px;">
			<div class="panel-body text-center">
				<h1>{$LANG.orderconfirmation}</h1>
				<hr>
				<p><strong>Your order number is #{$ordernumber}</strong></p>
				<p>{$LANG.orderreceived}</p>
				<p>{$LANG.orderfinalinstructions}</p>
				{if $invoiceid && !$ispaid}
				<br>
				<p class="text-danger">{$LANG.ordercompletebutnotpaid}<br><br><a href="viewinvoice.php?id={$invoiceid}" class="btn btn-danger" target="_blank">{$LANG.invoicenumber}{$invoiceid}</a></p>
				{/if}
			</div>
		</div>
		
		{foreach from=$addons_html item=addon_html}
		<div style="margin: 15px 0;">{$addon_html}</div>
		{/foreach}
		
		<p class="text-center" style="margin-bottom: 15px;">
			<a href="clientarea.php">{$LANG.ordergotoclientarea}</a>
		</p>
	</div>
</section>
