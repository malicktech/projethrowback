<!-- Block user information module NAV  -->

<div class="header_user_info col-sm-4 clearfix">
   <div class="dropdown">
	{if $is_logged}
		<button class="dropbtn"> 
			<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow">
		      			 <span>{l s='Salutation' mod='blockuserinfo'} {$cookie->customer_firstname}
		      				<img src="{$base_dir}/img/icones/icone-mon-compte-on.png"/>
		      			</span>
		      </a>
	    </button>
	    <div class="dropdown-content">
	      		<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow">
	      			<span>{l s='View my customer account' mod='blockuserinfo'}</span>
	      		</a>
	      	
	      		<a class="logout" href="{$link->getPageLink('index', true, NULL, "mylogout")|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Log me out' mod='blockuserinfo'}">
				{l s='Sign out' mod='blockuserinfo'}
				</a>
	    </div>
	{else}
		<button class="dropbtn"> 
			<a href="javascript:void(0)">
				<span>
					{l s='My espace' mod='blockuserinfo'} <img src="{$base_dir}/img/icones/icone-mon-compte-off.png"/>
				</span>
			</a>
    	</button>
    	<div class="dropdown-content">
			<a class="login" href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" rel="nofollow" title="{l s='Log in to your customer account' mod='blockuserinfo'}">
				{l s='Sign in' mod='blockuserinfo'}
			</a>

			<a href="{$link->getPageLink('my-account', true)|escape:'html':'UTF-8'}" title="{l s='View my customer account' mod='blockuserinfo'}" class="account" rel="nofollow">
	      			<span>{l s='Sign up' mod='blockuserinfo'}</span>
	      		</a>
		</div>
	{/if}
	</div>
</div>
<!-- /Block usmodule NAV -->