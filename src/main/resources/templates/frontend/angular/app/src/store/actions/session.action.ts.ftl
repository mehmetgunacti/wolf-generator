import { createAction, props } from '@ngrx/store';
import { AuthUserDTO, ID } from 'blueprints';
import { RemindPasswordDTO } from 'blueprints/dto';
import { AuthRole } from 'blueprints';
import { RegisterDTO } from 'blueprints/dto/register.dto';
import { LoginDTO } from 'blueprints/dto/login.dto';
import { ChangePasswordDTO } from 'blueprints/dto/change-password.dto';

export const login = createAction('[Session] Login', props<{ dto: LoginDTO }>());
export const loginSuccess = createAction('[Session] Login Success', props<{ dto: AuthUserDTO }>());
export const updateLoggedInUser = createAction('[Session] Update LoggedInUser', props<{ dto: AuthUserDTO }>());
export const logout = createAction('[Session] Logout');
export const remindPassword = createAction('[Session] Remind Password', props<{ dto: RemindPasswordDTO }>());
export const toggleRole = createAction('[Session] Toggle Role', props<{ id: ID, role: AuthRole }>());
export const enableAccount = createAction('[Session] Enable User Account', props<{ id: ID }>());
export const disableAccount = createAction('[Session] Disable User Account', props<{ id: ID }>());

export const register = createAction('[Session] Register', props<{ dto: RegisterDTO }>());
export const changePassword = createAction('[Session] Change Password', props<{ dto: ChangePasswordDTO }>());
export const autoLogin = createAction('[Session] Auto Login', props<{ token: string }>());
export const toggleToken = createAction('[Session] Toggle Token', props<{ rememberMe: boolean }>());

export const activateOnline = createAction('[Session] Activate Online');
export const deactivateOnline = createAction('[Session] Deactivate Online');
export const pingOnline = createAction('[Session] Ping Online');
export const subscribeOnlineList = createAction(`[Session] Subscribe to Who's Online Topic`);
export const unsubscribeOnlineList = createAction(`[Session] Unsubscribe from Who's Online Topic`);
export const subscribeLoggedInUserChanges = createAction(`[Session] Subscribe to LoggedInUser Changes`);
