import { Injectable } from '@angular/core';
import { BackendUrls } from 'blueprints';
import { Observable } from 'rxjs';
import { webSocket, WebSocketSubject } from 'rxjs/webSocket';

@Injectable({
	providedIn: 'root'
})
export class OnlineService {

	private socket: WebSocketSubject<any> | undefined;

	constructor() { }

	public connect(): WebSocketSubject<any> {

		console.log('connecting...');

		if (!this.socket || this.socket.closed) {
			this.socket = webSocket(BackendUrls.AUTH_ONLINE().value);
			console.log('connected', this.socket);
		}

		return this.socket;

	}

	public dataUpdates$(): Observable<any> {

		return this.connect().asObservable();

	}

	disconnect(): void {

		this.connect().complete();
		this.socket = undefined;

	}

	sendMessage(msg: any): void {

		this.socket?.next(msg);

	}

}
