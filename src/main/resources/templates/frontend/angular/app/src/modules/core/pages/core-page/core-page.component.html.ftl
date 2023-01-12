<p-confirmPopup></p-confirmPopup>
<header>

	<button pButton
			type="button"
			icon="fas fa-bars"
			class="p-button-text"
			(click)="toggleNav()"></button>
	<img src="/assets/logo.svg"
		 class="logo mr-auto ml-2"
		 style="width: 10rem; height: 2rem;">
	<section id="portal-outlet">
		<!-- content will be placed dynamically via Cdk Portal -->
	</section>

</header>
<section>

	<div id="main-overlay"
		 (click)="toggleNav()"></div>
	<aside>

		<ng-container *ngIf="isLoggedIn$ | async">
			<p-panelMenu [model]="(navSessionItems$ | async) || []"
						 class="mb-2"></p-panelMenu>
		</ng-container>

		<ng-container *ngIf="(navAdminItems$ | async) || [] as navAdminItems">
			<p-panelMenu *ngIf="navAdminItems.length > 0"
						 [model]="navAdminItems"
						 class="mb-2"></p-panelMenu>
		</ng-container>

		<p-panelMenu [model]="(navMenuItems$ | async) || []"></p-panelMenu>

		<div bottom-buttons>
			<app-theme-switcher [theme]="theme$ | async"
								(newTheme)="onThemeChange($event)"></app-theme-switcher>

			<app-lang-switcher [lang]="lang$ | async"
							   (newLang)="onLangChange($event)"></app-lang-switcher>
		</div>

	</aside>
	<main>

		<router-outlet></router-outlet>

	</main>

</section>
