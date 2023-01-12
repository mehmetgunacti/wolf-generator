<form [formGroup]="form">

	<div class="p-fluid formgrid">

		<div class="field">

			<label for="username">Username</label>
			<div class="p-inputgroup">

				<span class="p-inputgroup-addon"><i class="fas fa-user"></i></span>
				<input type="text"
					   autocomplete="username"
					   pInputText
					   placeholder="Username"
					   formControlName="username">

			</div>
			<div *ngIf="form.controls['username'].invalid && form.controls['username'].dirty"
				 class="p-error p-1">Username is required.</div>

		</div>
		<div class="field">

			<label for="currentPassword">Current Password</label>
			<div class="p-inputgroup">

				<span class="p-inputgroup-addon"><i class="fas fa-lock"></i></span>
				<input type="password"
					   autocomplete="current-password"
					   pInputText
					   placeholder="Current Password"
					   formControlName="currentPassword">

			</div>
			<div *ngIf="form.controls['currentPassword'].invalid && form.controls['currentPassword'].dirty"
				 class="p-error p-1">Current password is required.</div>

		</div>
		<div class="field">

			<label for="newPassword">New Password</label>
			<div class="p-inputgroup">

				<span class="p-inputgroup-addon"><i class="fas fa-lock"></i></span>
				<input type="password"
					   autocomplete="new-password"
					   pInputText
					   placeholder="New Password"
					   formControlName="newPassword">

			</div>
			<div *ngIf="form.controls['newPassword'].invalid && form.controls['newPassword'].dirty"
				 class="p-error p-1">New password is required.</div>

		</div>
		<div class="field">

			<label for="retypePassword">Retype New Password</label>
			<div class="p-inputgroup">

				<span class="p-inputgroup-addon"><i class="fas fa-lock"></i></span>
				<input type="password"
					   autocomplete="retype-password"
					   pInputText
					   placeholder="Retype New Password"
					   formControlName="retypePassword">

			</div>
			<div *ngIf="form.controls['retypePassword'].invalid && form.controls['retypePassword'].dirty"
				 class="p-error p-1">Retype new password is required.</div>
			<div 
				class="p-error p-1">Passwords don't match
				ngIf="form.errors['mismatch']? && form.controls['retypePassword'].dirty && form.controls['currentPassword'].dirty"</div>

		</div>
		<div class="flex">
[disabled]="form['pristine'] || form['invalid']"
			<button pButton
					label="Send"
					
					icon="fas fa-check"
					(click)="onChangePassword($event)"
					class="p-button-raised ml-auto"></button>

		</div>

	</div>

</form>
