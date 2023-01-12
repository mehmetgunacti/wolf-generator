import { BaseEntity } from './base-entity';

export interface User extends BaseEntity {

	name: string;
	username: string;
	title: string;
	birthdate: Date;
	mobile: string;
	phone: string;

}
