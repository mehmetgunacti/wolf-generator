<form [formGroup]="form">

	<div class="p-fluid formgrid">

		<div class="field">

			<label class="block text-900 font-medium mb-2">Username</label>
			<div class="p-inputgroup mb-3">
				<span class="p-inputgroup-addon"><i class="fas fa-user"></i></span>
				<input type="text"
					   pInputText
					   autocomplete="username"
					   placeholder="Username"
					   formControlName="username">
			</div>

		</div>

		<div class="field">

			<label class="block text-900 font-medium mb-2">Password</label>
			<div class="p-inputgroup mb-3">

				<span class="p-inputgroup-addon"><i class="fas fa-lock"></i></span>
				<input type="password"
					   autocomplete="current-password"
					   pInputText
					   placeholder="Password"
					   formControlName="password">

			</div>

		</div>

		<div class="field">

			<div class="flex align-items-center justify-content-between mb-6 mt-3">

				<div class="flex align-items-center">
					<p-checkbox label="Remember Me"
								[binary]="true"
								(onChange)="onSaveToken($event.checked)"></p-checkbox>
				</div>
				<a routerLink="/remind-password"
						class="font-medium no-underline ml-2 text-blue-500 text-right cursor-pointer">Forgot your password?</a>

			</div>

		</div>

		<div class="field">

			<button pButton
					pRipple
					label="Sign In"
					icon="pi pi-user"
					(click)="onLogin()"
					class="w-full"></button>
		</div>

	</div>

</form>
