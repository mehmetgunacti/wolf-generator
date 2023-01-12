<p-breadcrumb [model]="[
	{ label: 'Home', routerLink: '/' },
	{ label: 'Admin' },
	{ label: 'Users', routerLink: '/admin/users' },
	{ label: 'User', routerLink: ['/admin/users', (id$ | async)] }
]"></p-breadcrumb>
<app-auth-user-edit-container></app-auth-user-edit-container>
