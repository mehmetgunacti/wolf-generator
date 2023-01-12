import { User } from './user.entity';

export interface AuthUser extends User {

	roles: string[];
	password: string;
	passwordExpiration: Date;
	passwordLocked: boolean;
	passwordAttempts: 0;
	passwordFailed: boolean;
	accountEnabled: boolean;
	accountExpiration: Date;
	lastLogin: Date;

}
