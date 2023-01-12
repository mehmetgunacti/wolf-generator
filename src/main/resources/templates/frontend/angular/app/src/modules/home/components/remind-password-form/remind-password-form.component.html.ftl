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

		<div class="flex">

			<button pButton
					label="Send"
					[disabled]="form.pristine || form.invalid"
					icon="fas fa-check"
					(click)="onRemindPassword()"
					class="p-button-raised ml-auto"></button>

		</div>

	</div>

</form>
