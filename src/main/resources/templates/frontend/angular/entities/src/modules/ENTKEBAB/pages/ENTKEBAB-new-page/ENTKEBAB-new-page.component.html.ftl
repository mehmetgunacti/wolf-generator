<p-breadcrumb [model]="[
	{ label: 'Home', routerLink: '/' },
	{ label: '${ entity.name.plural.pascal }', routerLink: '/${ entity.name.plural.kebab }' }
]"></p-breadcrumb>
<app-${ entity.name.singular.kebab }-new-container></app-${ entity.name.singular.kebab }-new-container>
