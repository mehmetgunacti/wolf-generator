import { ChangeDetectionStrategy, Component, Input } from '@angular/core';
import { ${ entity.name.singular.pascal } } from 'blueprints';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-list',
	templateUrl: './${ entity.name.singular.kebab }-list.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }ListComponent {

	@Input() ${ entity.name.plural }: ${ entity.name.singular.pascal }[] | null | undefined = [];

}
