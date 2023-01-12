import { HttpEvent, HttpHandler, HttpInterceptor, HttpRequest } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { Store } from '@ngrx/store';
import { Observable } from 'rxjs';
import { first, mergeMap } from 'rxjs/operators';
import * as selectors from 'store/selectors';

@Injectable()
export class JwtInterceptor implements HttpInterceptor {

	constructor(private store: Store) { }

	intercept(request: HttpRequest<any>, next: HttpHandler): Observable<HttpEvent<any>> {

		// add auth header with jwt if user is logged in and request is to api url
		// const isApiUrl = request.url.startsWith(environment.apiUrl);
		return this.store.select(selectors.loggedInUserToken).pipe(

			first(),
			mergeMap(token => {

				if (!!token) {

					request = request.clone({
						setHeaders: {
							Authorization: `Bearer ${r"${token}"}`
						}
					});
					// console.log('added token', request);

				} // else console.log('NOT added token', request);
				return next.handle(request);

			}),

		);

	}

}
