import { Directive, EmbeddedViewRef, Input, OnDestroy, OnInit, TemplateRef, ViewContainerRef } from '@angular/core';
import { Store } from '@ngrx/store';
import { Subject } from 'rxjs';
import { takeUntil } from 'rxjs/operators';
import * as selectors from 'store';

@Directive({
	selector: '[appHasRole]'
})
export class HasRoleDirective implements OnInit, OnDestroy {

	@Input() appHasRole = '';
	@Input() appHasRoleElse!: TemplateRef<any>;

	stop$ = new Subject();
	isVisible = false;

	/**
	 * @param ViewContainerRef: viewContainerRef
	 * 	-- the location where we need to render the templateRef
	 * @param TemplateRef<any>: templateRef
	 *   -- the templateRef to be potentially rendered
	 * @param RolesService: rolesService
	 *   -- will give us access to the roles a user has
	 */
	constructor(
		private viewContainerRef: ViewContainerRef,
		private templateRef: TemplateRef<any>,
		private store: Store
	) { }

	ngOnInit(): void {

		//  We subscribe to the roles$ to know the roles the user has
		this.store.select(selectors.loggedInUserRoles).pipe(
			takeUntil(this.stop$)
		).subscribe(roles => {

			// If he doesn't have any roles, we clear the viewContainerRef
			if (roles.length === 0)
				this.viewContainerRef.clear();

			// If the user has the role needed to
			// render this component we can add it
			if (roles.includes(this.appHasRole)) {

				// If it is already visible (which can happen if
				// his roles changed) we do not need to add it a second time
				if (!this.isVisible) {

					// in case 'else' block is visible
					if (!!this.appHasRoleElse)
						this.viewContainerRef.clear();

					// We update the `isVisible` property and add the
					// templateRef to the view using the
					// 'createEmbeddedView' method of the viewContainerRef
					this.isVisible = true;
					const el: EmbeddedViewRef<any> = this.viewContainerRef.createEmbeddedView(this.templateRef);
					el.detectChanges();

				}

			} else {

				// If the user does not have the role,
				// we update the `isVisible` property and clear
				// the contents of the viewContainerRef
				this.isVisible = false;
				this.viewContainerRef.clear();

				if (!!this.appHasRoleElse)
					this.viewContainerRef.createEmbeddedView(this.appHasRoleElse);

			}

		});

	}

	ngOnDestroy(): void {

		this.stop$.next(null);

	}

}
