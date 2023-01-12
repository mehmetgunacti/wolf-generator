<form [formGroup]="form">

	<div class="p-fluid formgrid">

		<div class="field">

			<label for="name">NAME</label>
			<input id="name"
				   type="text"
				   pInputText
				   formControlName="name">
			<small *ngIf="form.controls['name'].invalid && form.controls['name'].dirty"
				   class="p-error">Name is not available.</small>

		</div>
		<div class="field">

			<label for="title">TITLE</label>
			<input id="title"
				   type="text"
				   pInputText
				   formControlName="title">
			<small *ngIf="form.controls['title'].invalid && form.controls['title'].dirty"
				   class="p-error">Title is not available.</small>

		</div>
		<div class="field">

			<label for="birthdate">BIRTHDATE</label>
			<p-calendar inputId="birthdate"
						formControlName="birthdate"></p-calendar>
			<small *ngIf="form.controls['birthdate'].invalid && form.controls['birthdate'].dirty"
				   class="p-error">Birthdate is not available.</small>

		</div>
		<div class="field">

			<label for="mobile">MOBILE</label>
			<input id="mobile"
				   type="text"
				   pInputText
				   formControlName="mobile">
			<small *ngIf="form.controls['mobile'].invalid && form.controls['mobile'].dirty"
				   class="p-error">Mobile is not available.</small>

		</div>
		<div class="field">

			<label for="phone">PHONE</label>
			<input id="phone"
				   type="text"
				   pInputText
				   formControlName="phone">
			<small *ngIf="form.controls['phone'].invalid && form.controls['phone'].dirty"
				   class="p-error">Phone is not available.</small>

		</div>
		<div class="field">

			<label for="username">USERNAME</label>
			<input id="username"
				   type="text"
				   pInputText
				   formControlName="username">
			<small *ngIf="form.controls['username'].invalid && form.controls['username'].dirty"
				   class="p-error">Username is not available.</small>

		</div>

	</div>
	<div class="flex">
		<button pButton
				label="Save"
				[disabled]="form.pristine || form.invalid"
				icon="fas fa-save"
				(click)="onSave()"
				class="p-button-raised ml-auto"></button>
	</div>

</form>