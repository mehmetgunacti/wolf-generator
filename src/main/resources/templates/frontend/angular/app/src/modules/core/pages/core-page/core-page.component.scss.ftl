$animation-duration				: 0.6s;
$animation-ease					: cubic-bezier(0.25, 1, 0.25, 1);
$nav-width						: 18rem;
$default-padding				: 0.5rem;
$header-height					: 4rem;

@keyframes fadeIn {
	from {
		opacity:0;
	}
	to {
		opacity:1;
	}
}

app-core-page {

	display						: flex;
	flex-direction				: column;
	height						: 100vh;

	& > header {

		display					: flex;
		justify-content			: space-between;
		align-items				: center;
		min-height				: ${r"#{$header-height}"};
		padding					: 0 0.5rem;
		background-color		: var(--surface-c);

	}

	& > section {

		flex					: 1;
		position				: relative;
		display					: flex;
		height					: calc(100vh - ${r"#{$header-height})"};

		& > #main-overlay {

			display				: none;

		}

		& > aside {

			display				: flex;
			flex-direction		: column;
			width				: $nav-width;
			background-color	: var(--surface-b);
			transition			: margin-left $animation-duration $animation-ease;
			padding				: $default-padding;

			& > div[bottom-buttons] {

				display			: flex;
				justify-content	: space-evenly;
				margin-top		: auto;
				align-self		: center;
				width			: 100%;
				padding-top		: 0.5rem;
				padding-bottom	: 0.5rem;

			}

		}

		& > main {

			flex				: 1;
			padding				: $default-padding;
			overflow-y			: auto;

		}

	}

	&.smallScreen {

		& > section {

			& > #main-overlay {

				display				: block;
				position			: absolute;
				z-index				: 5;
				left				: 0;
				top					: 0;
				right				: 0;
				bottom				: 0;
				animation			: fadeIn $animation-duration $animation-ease;
				background-color	: #0000005b;

			}

			& > aside {

				position		: absolute;
				z-index			: 10;
				height			: 100%;

			}

		}

	}

	&.navCollapsed {

		& > section {

			& > aside {

				margin-left		: -$nav-width;

			}

		}

	}

	&.smallScreen.navCollapsed {

		& > section > #main-overlay {

			display				: none;

		}

	}

}
