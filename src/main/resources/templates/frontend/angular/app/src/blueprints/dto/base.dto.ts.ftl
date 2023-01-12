import { EntityState } from 'store';

export interface BaseDTO {

	data: Record<string, EntityState<any>>;

}
