import { AuthUserAccountInfoComponent } from './components/auth-user-account-info/auth-user-account-info.component';
import { AuthUserAuthFormComponent } from './components/auth-user-auth-form/auth-user-auth-form.component';
import { AuthUserFormComponent } from './components/auth-user-form/auth-user-form.component';
import { AuthUserListComponent } from './components/auth-user-list/auth-user-list.component';
import { AuthUserPasswordComponent } from './components/auth-user-password/auth-user-password.component';
import { AuthUserEditContainerComponent } from './containers/auth-user-edit-container/auth-user-edit-container.component';
import { AuthUserListContainerComponent } from './containers/auth-user-list-container/auth-user-list-container.component';
import { AuthUserNewContainerComponent } from './containers/auth-user-new-container/auth-user-new-container.component';
import { AuthUserOneContainerComponent } from './containers/auth-user-one-container/auth-user-one-container.component';
import { AuthUserEditPageComponent } from './pages/auth-user-edit-page/auth-user-edit-page.component';
import { AuthUserListPageComponent } from './pages/auth-user-list-page/auth-user-list-page.component';
import { AuthUserNewPageComponent } from './pages/auth-user-new-page/auth-user-new-page.component';
import { AuthUserOnePageComponent } from './pages/auth-user-one-page/auth-user-one-page.component';

export const components = [

	AuthUserFormComponent,
	AuthUserListComponent,
	AuthUserAccountInfoComponent,
	AuthUserAuthFormComponent,
	AuthUserPasswordComponent,

	AuthUserOneContainerComponent,
	AuthUserEditContainerComponent,
	AuthUserNewContainerComponent,
	AuthUserListContainerComponent,

	AuthUserOnePageComponent,
	AuthUserEditPageComponent,
	AuthUserNewPageComponent,
	AuthUserListPageComponent

];
