import { ChangeDetectionStrategy, Component, OnDestroy, OnInit } from '@angular/core';
import { FormControl } from '@angular/forms';
import { Store } from '@ngrx/store';
import { Constant, Entities } from 'blueprints';
import { ConfirmationService } from 'primeng/api';
import { combineLatest, Observable, Subscription } from 'rxjs';
import { debounceTime, distinctUntilChanged, map, startWith, take, tap } from 'rxjs/operators';
import * as actions from 'store/actions';
import * as selectors from 'store/selectors';

@Component({
	selector: 'app-constant-list',
	templateUrl: './constant-list.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ConstantListComponent implements OnInit, OnDestroy {

	control: FormControl;
	subscription = new Subscription();

	constants$: Observable<Constant[]>;
	categories$: Observable<string[]>;

	edit: { code?: string, name?: string } = {}
	searchControl = new FormControl();

	constructor(
		private store: Store,
		private confirmationService: ConfirmationService
	) {

		this.control = new FormControl();
		this.constants$ =
			combineLatest([
				store.select(selectors.constantFilteredBySelectedCategory),
				this.searchControl.valueChanges.pipe(startWith(''), debounceTime(200), distinctUntilChanged())
			]).pipe(
				map(([constants, search]: [Constant[], string]) => {

					if (!!search)
						return constants.filter(constant => constant.name.toLocaleLowerCase().indexOf(search.toLocaleLowerCase()) > -1);

					return constants;

				})
			);
		this.categories$ = store.select(selectors.constantCategoriesAll);

		store.select(selectors.constantSelectedCategory).pipe(take(1)).subscribe(
			category => this.control.setValue(category)
		);

	}

	ngOnInit(): void {

		this.subscription.add(

			this.control.valueChanges.subscribe(

				(category: string) => {
					this.store.dispatch(actions.constantChangeCategory({ category }));
				}

			)

		);

	}

	ngOnDestroy(): void {

		this.subscription.unsubscribe();

	}

	onRowEditInit(constant: Constant): void {

		this.edit.code = constant.code;
		this.edit.name = constant.name;

	}

	onRowEditSave(constant: Constant): void {

		this.store.dispatch(
			actions.modifyEntity({
				entity: Entities.constants,
				id: constant.code,
				body: this.edit,
				after: { redirect: false, showSuccess: true }
			})
		);
		this.edit = {};

	}

	onRowEditCancel(constant: Constant, index: number): void {

		this.edit = {};

	}

	onRowDelete(constant: Constant, btn: HTMLButtonElement): void {

		this.confirmationService.confirm({
			target: btn,
			message: 'Are you sure that you want to proceed?',
			icon: 'fas fa-exclamation-triangle',
			acceptButtonStyleClass: 'p-button-danger',
			acceptLabel: 'Delete',
			accept: () => this.store.dispatch(actions.deleteEntity({ entity: Entities.constants, id: constant.code }))
		});
		this.edit = {};

	}

}
