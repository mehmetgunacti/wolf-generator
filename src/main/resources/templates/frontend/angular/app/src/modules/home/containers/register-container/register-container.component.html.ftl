<div class="flex align-items-center justify-content-center">

	<p-fieldset class="hide-legend w-full lg:w-10 xl:w-6">

		<div class="text-center mb-5">

			<img src="/assets/logo.svg"
				 class="logo mb-3"
				 style="width: 19rem; height: 4rem;">
			<div class="text-900 text-3xl font-medium mb-3">Register</div>
			<span class="text-600 font-medium line-height-3">Already have an account?</span>
			<a class="font-medium no-underline ml-2 text-blue-500 cursor-pointer" routerLink="/login">Sign In!</a>

		</div>
		<div>

			<app-register-form (register)="onRegister($event)"></app-register-form>

		</div>

	</p-fieldset>

</div>
