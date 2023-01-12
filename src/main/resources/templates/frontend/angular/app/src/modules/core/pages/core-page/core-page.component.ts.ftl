import { BreakpointObserver } from '@angular/cdk/layout';
import { Component, HostBinding, OnDestroy } from '@angular/core';
import { Store } from '@ngrx/store';
import { LangChangeEvent, TranslateService } from '@ngx-translate/core';
import { LANG, ThemeInfo } from 'blueprints';
import { MenuItem } from 'primeng/api';
import { Observable, Subscription } from 'rxjs';
import * as actions from 'store/actions';
import * as selectors from 'store/selectors';

@Component({
	selector: 'app-core-page',
	templateUrl: './core-page.component.html',
	styleUrls: ['./core-page.component.scss']
})
export class CorePageComponent implements OnDestroy {

	isLoggedIn$: Observable<boolean>;
	navMenuItems$: Observable<MenuItem[]>;
	navAdminItems$: Observable<MenuItem[]>;
	navSessionItems$: Observable<MenuItem[]>;
	theme$: Observable<ThemeInfo>;
	lang$: Observable<LANG>

	subscriptions = new Subscription();

	@HostBinding('class.smallScreen')
	smallScreen = false;

	@HostBinding('class.navCollapsed')
	navCollapsed = false;

	constructor(
		breakpointObserver: BreakpointObserver,
		translate: TranslateService,
		private store: Store
	) {

		translate.addLangs(['en', 'tr']);
		this.isLoggedIn$ = store.select(selectors.isLoggedIn);
		this.subscriptions.add(

			breakpointObserver
				.observe('(max-width: 767px)')
				.subscribe(result => this.smallScreen = result.matches)

		);
		this.subscriptions.add(

			translate.onLangChange.subscribe(
				(event: LangChangeEvent) => store.dispatch(
					actions.i18nSaveTranslations({ translations: event.translations })
				)
			)

		);

		this.navMenuItems$ = store.select(selectors.navMenuItems);
		this.navAdminItems$ = store.select(selectors.navAdminMenuItems);
		this.navSessionItems$ = store.select(selectors.navSessionMenuItems);

		this.theme$ = store.select(selectors.themeInfo);
		this.lang$ = store.select(selectors.lang);

	}

	ngOnDestroy(): void {

		this.subscriptions.unsubscribe();

	}

	toggleNav(): void {

		this.navCollapsed = !this.navCollapsed;

	}

	onThemeChange(newTheme: ThemeInfo): void {

		this.store.dispatch(actions.themeSet({ newTheme }));

	}

	onLangChange(newLang: LANG): void {

		this.store.dispatch(actions.i18nSetLanguage({ newLang }));

	}

}
