import { HttpClient } from '@angular/common/http';
import { BackendUrl } from 'blueprints';
import { EMPTY, Observable } from 'rxjs';
import { tap } from 'rxjs/operators';

export class BackendService {

	urlCache = new Set<string>();

	constructor(
		protected http: HttpClient
	) { }

	protected GET<T>(url: BackendUrl, skipCache = false): Observable<T> {

		const loadFromCache = !skipCache;
		if (loadFromCache && this.urlCache.has(url.value))
			return EMPTY;

		return this.http.get<T>(url.value).pipe(

			tap(() => this.urlCache.add(url.value))

		);

	}

	protected POST<T>(url: BackendUrl, params: any): Observable<T> {

		return this.http.post<T>(url.value, params);

	}

	protected PUT<T>(url: BackendUrl, params: any): Observable<T> {

		return this.http.put<T>(url.value, params);

	}

	protected PATCH<T>(url: BackendUrl, params?: any): Observable<T> {

		return this.http.patch<T>(url.value, params);

	}

	protected DELETE<T>(url: BackendUrl): Observable<T> {

		return this.http.delete<T>(url.value);

	}

}
