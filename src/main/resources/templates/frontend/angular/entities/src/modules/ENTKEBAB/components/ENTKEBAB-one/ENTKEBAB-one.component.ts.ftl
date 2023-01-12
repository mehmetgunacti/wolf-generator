import { ChangeDetectionStrategy, Component, Input } from '@angular/core';
import { ${ entity.name.singular.pascal } } from 'blueprints';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-one',
	templateUrl: './${ entity.name.singular.kebab }-one.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }OneComponent {

	@Input() ${ entity.name.singular }: ${ entity.name.singular.pascal } | undefined | null;

}
