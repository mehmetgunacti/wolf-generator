import { ChangeDetectionStrategy, Component, Input } from '@angular/core';
import { User } from 'blueprints';

@Component({
	selector: 'app-auth-user-list',
	templateUrl: './auth-user-list.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class AuthUserListComponent {

	@Input() users: User[] | null | undefined = [];

}
