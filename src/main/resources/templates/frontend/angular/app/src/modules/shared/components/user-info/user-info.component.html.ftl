<div *ngIf="user">

	<div class="font-medium text-3xl text-900">{{ user.name }}

		<small>({{ user.username }})
			<br><i>{{ user.title }}</i>
		</small>

	</div>
	<div class="flex align-items-center text-700 flex-wrap mb-3">
		
		<div class="mr-5 flex align-items-center mt-3">
			<i class="fas fa-birthday-cake mr-2"></i>
			<span>{{ user.birthdate | date }}</span>
		</div>
		<div class="mr-5 flex align-items-center mt-3">
			<i class="fas fa-phone-alt mr-2"></i>
			<span>{{ user.mobile }}</span>
		</div>
		<div class="flex align-items-center mt-3">
			<i class="fas fa-mobile-alt mr-2"></i>
			<span>{{ user.phone }}</span>
		</div>

	</div>

</div>
