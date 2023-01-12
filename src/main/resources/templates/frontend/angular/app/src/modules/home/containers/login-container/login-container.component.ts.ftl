import { ChangeDetectionStrategy, Component } from '@angular/core';
import { Store } from '@ngrx/store';
import { LoginDTO } from 'blueprints/dto/login.dto';
import * as fromStore from 'store';

@Component({
	selector: 'app-login-container',
	templateUrl: './login-container.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class LoginContainerComponent {

	constructor(private store: Store) { }

	onLogin(dto: LoginDTO): void {

		this.store.dispatch(fromStore.login({ dto }));

	}

	onSaveToken(rememberMe: boolean): void {

		this.store.dispatch(fromStore.toggleToken({ rememberMe }));

	}

}
