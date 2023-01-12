app-auth-user-auth-form {

	& .button-grid {

		display					: grid;
		grid-template-columns	: repeat(auto-fill, minmax(20rem, 1fr));
		grid-gap				: 1rem;

		& button {

			@include styleclass('p-button-outlined p-button-secondary');

		}

	}

}
