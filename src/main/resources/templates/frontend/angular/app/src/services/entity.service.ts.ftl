import { HttpClient } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { BaseDTO, Entity, ID } from 'blueprints';
import { Observable } from 'rxjs';
import { BackendService } from './backend.service';

@Injectable({
	providedIn: 'root'
})
export class EntityService extends BackendService {

	override urlCache = new Set<string>();

	constructor(http: HttpClient) { super(http); }

	create(entity: Entity, params: any): Observable<BaseDTO> {

		return this.POST<BaseDTO>(entity.endpointUrl(), params);

	}

	modify(entity: Entity, id: ID, params: any): Observable<BaseDTO> {

		return this.PATCH<BaseDTO>(entity.endpointUrl(id), params);

	}

	delete(entity: Entity, id: ID): Observable<BaseDTO> {

		return this.DELETE<BaseDTO>(entity.endpointUrl(id));

	}

	loadAll(entity: Entity, skipCache?: boolean): Observable<BaseDTO> {

		return this.GET<BaseDTO>(entity.endpointUrl(), skipCache);

	}

	loadOne(entity: Entity, id: ID, skipCache?: boolean): Observable<BaseDTO> {

		return this.GET<BaseDTO>(entity.endpointUrl(id), skipCache);

	}

}
