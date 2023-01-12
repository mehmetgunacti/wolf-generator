<form [formGroup]="form">

	<div class="p-fluid formgrid">

		<div class="field">

			<label for="username">Username</label>
			<div class="p-inputgroup">

				<span class="p-inputgroup-addon"><i class="fas fa-user"></i></span>
				<input id="username"
					   type="text"
					   pInputText
					   formControlName="username">

			</div>
			<div *ngIf="form.controls['username'].invalid && form.controls['username'].dirty"
				 class="p-error p-1">Username is required.</div>

		</div>
		<div class="field">

			<label for="name">Name</label>
			<div class="p-inputgroup">

				<span class="p-inputgroup-addon"><i class="fas fa-signature"></i></span>
				<input id="name"
					   type="text"
					   pInputText
					   formControlName="name">

			</div>
			<div *ngIf="form.controls['name'].invalid && form.controls['name'].dirty"
				 class="p-error p-1">Name is required.</div>

		</div>
		<div class="field">

			<label for="title">Title</label>
			<div class="p-inputgroup mb-3">

				<span class="p-inputgroup-addon"><i class="fas fa-building"></i></span>
				<input id="title"
					   type="text"
					   pInputText
					   formControlName="title">

			</div>
			<div *ngIf="form.controls['title'].invalid && form.controls['title'].dirty"
				 class="p-error p-1">Title is required.</div>

		</div>
		<div class="field">

			<label for="birthdate">Birthdate</label>
			<div class="p-inputgroup mb-3">

				<span class="p-inputgroup-addon"><i class="fas fa-birthday-cake"></i></span>
				<p-calendar inputId="birthdate"
							formControlName="birthdate"></p-calendar>

			</div>
			<div *ngIf="form.controls['birthdate'].invalid && form.controls['birthdate'].dirty"
				 class="p-error p-1">Birthdate is required.</div>

		</div>
		<div class="field">

			<label for="mobile">Mobile</label>
			<div class="p-inputgroup mb-3">

				<span class="p-inputgroup-addon"><i class="fas fa-mobile"></i></span>
				<input id="mobile"
					   type="text"
					   pInputText
					   formControlName="mobile">

			</div>
			<div *ngIf="form.controls['mobile'].invalid && form.controls['mobile'].dirty"
				 class="p-error p-1">Mobile is required.</div>

		</div>
		<div class="field">

			<label for="phone">Phone</label>
			<div class="p-inputgroup mb-3">

				<span class="p-inputgroup-addon"><i class="fas fa-phone"></i></span>
				<input id="phone"
					   type="text"
					   pInputText
					   formControlName="phone">

			</div>
			<div *ngIf="form.controls['phone'].invalid && form.controls['phone'].dirty"
				 class="p-error p-1">Phone is required.</div>

		</div>

	</div>
	<div class="flex">

		<button pButton
				label="Register"
				[disabled]="form.pristine || form.invalid"
				icon="fas fa-user"
				(click)="onSave()"
				class="p-button-raised ml-auto"></button>

	</div>

</form>
