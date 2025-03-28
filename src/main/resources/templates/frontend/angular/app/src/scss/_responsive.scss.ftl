@mixin sm() {
	@media screen and (min-width: $sm) {
		@content;
	}
}

@mixin md() {
	@media screen and (min-width: $md) {
		@content;
	}
}

@mixin lg() {
	@media screen and (min-width: $lg) {
		@content;
	}
}

@mixin xl() {
	@media screen and (min-width: $xl) {
		@content;
	}
}
