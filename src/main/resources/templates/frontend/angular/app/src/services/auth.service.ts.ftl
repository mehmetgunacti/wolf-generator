import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import {
	AuthRole,
	AuthUserDTO,
	BackendUrls,
	BaseDTO,
	ChangePasswordDTO,
	ID,
	LoginDTO,
	RegisterDTO,
	RemindPasswordDTO
} from 'blueprints';
import { Observable } from 'rxjs';
import { BackendService } from './backend.service';

@Injectable({
	providedIn: 'root'
})
export class AuthService extends BackendService {

	constructor(
		http: HttpClient
	) {

		super(http);

	}

	login(dto: LoginDTO): Observable<AuthUserDTO> {

		return this.POST<AuthUserDTO>(
			BackendUrls.AUTH_LOGIN(),
			dto
		);

	}

	autoLogin(token: string): Observable<AuthUserDTO> {

		return this.PUT<AuthUserDTO>(
			BackendUrls.AUTH_LOGIN(),
			token
		);

	}

	register(dto: RegisterDTO): Observable<void> {

		return this.POST<void>(
			BackendUrls.AUTH_REGISTER(),
			dto
		);

	}

	remindPassword(dto: RemindPasswordDTO): Observable<BaseDTO> {

		return this.PUT<BaseDTO>(
			BackendUrls.AUTH_REMIND_PASSWORD(),
			dto
		);

	}

	changePassword(dto: ChangePasswordDTO): Observable<BaseDTO> {

		return this.PUT<BaseDTO>(
			BackendUrls.AUTH_CHANGE_PASSWORD(),
			dto
		);

	}

	toggleRole(id: ID, role: AuthRole): Observable<BaseDTO> {

		return this.PATCH<BaseDTO>(
			BackendUrls.AUTH_USERS_ID_ROLES_NAME(id, role)
		);

	}

	enableAccount(id: ID): Observable<BaseDTO> {

		return this.PATCH<BaseDTO>(
			BackendUrls.AUTH_USERS_ID_ENABLE(id)
		);

	}

	disableAccount(id: ID): Observable<BaseDTO> {

		return this.PATCH<BaseDTO>(
			BackendUrls.AUTH_USERS_ID_DISABLE(id)
		);

	}

}
