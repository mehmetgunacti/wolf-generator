<form [formGroup]="form">

	<div class="p-fluid formgrid">

		<div class="field">

			<label for="code">Code</label>
			<input id="code"
				   type="text"
				   pInputText
				   formControlName="code">
			<small *ngIf="form.controls['code'].invalid && form.controls['code'].dirty"
				   class="p-error">Code is required.</small>

		</div>
		<div class="field">

			<label for="name">Name</label>
			<input id="name"
				   type="text"
				   pInputText
				   formControlName="name">
			<small *ngIf="form.controls['name'].invalid && form.controls['name'].dirty"
				   class="p-error">Name is required.</small>

		</div>
		<div class="field">

			<label for="category">Category</label>
			<p-dropdown [options]="categories || []"
						formControlName="category"
						placeholder="Select a category"></p-dropdown>
			<small *ngIf="form.controls['category'].invalid && form.controls['category'].dirty"
				   class="p-error">Category is required.</small>

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
