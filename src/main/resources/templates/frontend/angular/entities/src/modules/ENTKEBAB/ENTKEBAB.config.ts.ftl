import { ${ entity.name.singular.pascal }FormComponent } from './components/${ entity.name.singular.kebab }-form/${ entity.name.singular.kebab }-form.component';
import { ${ entity.name.singular.pascal }ListComponent } from './components/${ entity.name.singular.kebab }-list/${ entity.name.singular.kebab }-list.component';
import { ${ entity.name.singular.pascal }OneComponent } from './components/${ entity.name.singular.kebab }-one/${ entity.name.singular.kebab }-one.component';
import { ${ entity.name.singular.pascal }EditContainerComponent } from './containers/${ entity.name.singular.kebab }-edit-container/${ entity.name.singular.kebab }-edit-container.component';
import { ${ entity.name.singular.pascal }ListContainerComponent } from './containers/${ entity.name.singular.kebab }-list-container/${ entity.name.singular.kebab }-list-container.component';
import { ${ entity.name.singular.pascal }NewContainerComponent } from './containers/${ entity.name.singular.kebab }-new-container/${ entity.name.singular.kebab }-new-container.component';
import { ${ entity.name.singular.pascal }OneContainerComponent } from './containers/${ entity.name.singular.kebab }-one-container/${ entity.name.singular.kebab }-one-container.component';
import { ${ entity.name.singular.pascal }EditPageComponent } from './pages/${ entity.name.singular.kebab }-edit-page/${ entity.name.singular.kebab }-edit-page.component';
import { ${ entity.name.singular.pascal }ListPageComponent } from './pages/${ entity.name.singular.kebab }-list-page/${ entity.name.singular.kebab }-list-page.component';
import { ${ entity.name.singular.pascal }NewPageComponent } from './pages/${ entity.name.singular.kebab }-new-page/${ entity.name.singular.kebab }-new-page.component';
import { ${ entity.name.singular.pascal }OnePageComponent } from './pages/${ entity.name.singular.kebab }-one-page/${ entity.name.singular.kebab }-one-page.component';

export const components = [
	${ entity.name.singular.pascal }FormComponent,
	${ entity.name.singular.pascal }ListComponent,
	${ entity.name.singular.pascal }OneContainerComponent,
	${ entity.name.singular.pascal }EditContainerComponent,
	${ entity.name.singular.pascal }NewContainerComponent,
	${ entity.name.singular.pascal }OneComponent,
	${ entity.name.singular.pascal }OnePageComponent,
	${ entity.name.singular.pascal }EditPageComponent,
	${ entity.name.singular.pascal }NewPageComponent,
	${ entity.name.singular.pascal }ListPageComponent,
	${ entity.name.singular.pascal }ListContainerComponent
];
