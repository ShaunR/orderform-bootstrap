<section>
	<div class="container">
		<div class="row">
			<div class="col-md-6 col-md-offset-3">
				<div class="page-header">
					<h1>{$LANG.cartexistingclientlogin}</h1>
				</div>
		{if $incorrect}
				<div class="alert alert-danger alert-dismissable">
					<button type="button" class="close" data-dismiss="alert" aria-hidden="true">&times;</button>
					{$LANG.loginincorrect}
				</div>
		{/if}
				<form method="post" action="{$systemsslurl}dologin.php" class="form-horizontal">
					<fieldset>
						<div class="form-group">
							<label class="control-label col-md-4" for="username">{$LANG.loginemail}:</label>
							<div class="col-md-8">
								<input class="form-control" name="username" id="username" type="text">
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-4" for="password">{$LANG.loginpassword}:</label>
							<div class="col-md-8">
								<input class="form-control" name="password" id="password" type="password">
							</div>
						</div>
						<div class="form-group">
							<div class="col-md-8 col-md-offset-4">
								<button type="submit" class="btn btn-primary">{$LANG.loginbutton}</button>
								<a href="pwreset.php" style="margin-left:10px;">{$LANG.loginforgotteninstructions}</a>
							</div>
						</div>
					</fieldset>
				</form>
			</div>
		</div>
	</div>
</section>
