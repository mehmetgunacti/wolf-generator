<div class="flex align-items-center justify-content-center">

	<p-fieldset legend="Change Password"
				class="w-full lg:w-10 xl:w-6">

		<app-change-password-form [username]="(loggedInUser$ | async)?.username"
								  (changePassword)="onChangePassword($event)"></app-change-password-form>

	</p-fieldset>

</div>
