import { ChangeDetectionStrategy, Component, Input } from '@angular/core';
import { AuthUser } from 'blueprints';

@Component({
	selector: 'app-user-info',
	templateUrl: './user-info.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class UserInfoComponent {

	@Input() user: AuthUser | undefined | null;

}
