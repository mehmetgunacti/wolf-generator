<p-breadcrumb [model]="[
	{ label: 'Home', routerLink: '/' },
	{ label: '${ entity.name.plural.pascal }', routerLink: '/${ entity.name.plural.kebab }' },
	{ label: '${ entity.name.singular.pascal }', routerLink: ['/${ entity.name.plural.kebab }', (id$ | async)] }
]"></p-breadcrumb>
<app-${ entity.name.singular.kebab }-edit-container></app-${ entity.name.singular.kebab }-edit-container>
