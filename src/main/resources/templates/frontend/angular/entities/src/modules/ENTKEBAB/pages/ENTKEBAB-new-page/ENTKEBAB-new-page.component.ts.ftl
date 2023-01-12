import { ChangeDetectionStrategy, Component } from '@angular/core';

@Component({
	selector: 'app-${ entity.name.singular.kebab }-new-page',
	templateUrl: './${ entity.name.singular.kebab }-new-page.component.html',
	changeDetection: ChangeDetectionStrategy.OnPush
})
export class ${ entity.name.singular.pascal }NewPageComponent { }
