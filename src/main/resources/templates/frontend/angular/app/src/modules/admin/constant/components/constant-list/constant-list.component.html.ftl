<div class="flex justify-content-between">

	<div>
		<p-dropdown [options]="(categories$ | async) || []"
					[formControl]="control"
					placeholder="Select a category"></p-dropdown>
	</div>
	<div class="p-input-icon-left">
		<i class="fas fa-filter"></i>
		<input pInputText
			   type="text"
			   placeholder="Filter"
			   [formControl]="searchControl">
		<button class="clear-button" (click)="searchControl.setValue('')">
			<i class="fas fa-times"></i>
		</button>
	</div>

</div>
<br>
<p-table [value]="(constants$ | async) || []"
		 styleClass="p-datatable-striped"
		 [responsive]="true"
		 dataKey="code"
		 editMode="row">
	<ng-template pTemplate="header">
		<tr>
			<th>Code</th>
			<th>Name</th>
			<th>Category</th>
			<th style="width:8rem"></th>
		</tr>
	</ng-template>
	<ng-template pTemplate="body"
				 let-constant
				 let-editing="editing"
				 let-ri="rowIndex">
		<tr [pSelectableRow]="constant"
			[pEditableRow]="constant">
			<td><span class="p-column-title">Code</span>{{ constant.code }}</td>
			<td>
				<span class="p-column-title">Name</span>
				<p-cellEditor>
					<ng-template pTemplate="input">
						<input pInputText
							   type="text"
							   [(ngModel)]="edit.name">
					</ng-template>
					<ng-template pTemplate="output">
						{{ constant.name }}
					</ng-template>
				</p-cellEditor>
			</td>
			<td><span class="p-column-title">Category</span>{{ constant.category }}</td>
			<td style="text-align:center">
				<button *ngIf="!editing"
						pButton
						pRipple
						type="button"
						pInitEditableRow
						icon="fas fa-edit"
						title="Edit"
						(click)="onRowEditInit(constant)"
						class="p-button-rounded p-button-text"></button>
				<button *ngIf="editing"
						pButton
						pRipple
						type="button"
						pSaveEditableRow
						icon="fas fa-check"
						title="Save"
						(click)="onRowEditSave(constant)"
						class="p-button-rounded p-button-text p-button-success p-mr-2"></button>
				<button *ngIf="editing"
						pButton
						pRipple
						type="button"
						pCancelEditableRow
						icon="fas fa-times"
						title="Cancel"
						(click)="onRowEditCancel(constant, ri)"
						class="p-button-rounded p-button-text p-button-danger"></button>
				<button *ngIf="!editing"
						#deleteBtn
						pButton
						pRipple
						type="button"
						icon="fas fa-trash"
						title="Delete"
						(click)="onRowDelete(constant, deleteBtn)"
						class="p-button-rounded p-button-text p-button-danger"></button>
			</td>
		</tr>
	</ng-template>
	<ng-template pTemplate="emptymessage"
				 let-columns>
		<tr>
			<td [attr.colspan]="4">
				<div class="flex align-items-center justify-content-center">
					No content to display
				</div>
			</td>
		</tr>
	</ng-template>
</p-table>
