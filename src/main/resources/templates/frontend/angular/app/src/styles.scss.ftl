@import url('https://use.fontawesome.com/releases/v5.15.2/css/all.css');

// Prime Icons
@import '../node_modules/primeicons/primeicons.css';

// PrimeNG Theme
// Note: 'arya-blue' should be the same as in app.config.ts > DEFAULT_THEME
// IMPORTANT: if you comment this line, themeing will still work but flickering will occur during transitions
@import '../node_modules/primeng/resources/themes/arya-blue/theme.css';

// PrimeNG
@import '../node_modules/primeng/resources/primeng.min.css';

// Prime Flex
@import '../node_modules/primeflex/primeflex.scss';

// Toastr
@import '../node_modules/ngx-toastr/toastr.css';

// Custom
@import './scss/overrides';
@import './scss/responsive';
@import './scss/index';
@import './scss/extensions';
@import './modules/core/core.style.scss';

// Entities

// home
@import './modules/home/home.style.scss';

// shared
@import './modules/shared/shared.style.scss';

// session
//change-password
@import './modules/session/change-password/change-password.style.scss';

// profile
@import './modules/session/profile/profile.style.scss';

// admin/user
@import './modules/admin/auth-user/auth-user.style.scss';

// constant
@import './modules/admin/constant/constant.style.scss';

<#list entities as entity>

// ${ entity.name.singular }
@import './modules/${ entity.name.singular.kebab }/${ entity.name.singular.kebab }.style.scss';
</#list>
