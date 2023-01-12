export * from './admin';
export * from './core';
export * from './home';
export * from './session';
export * from './shared';
<#list entities as entity>
export * from './${ entity.name.singular.kebab }';
</#list>
export * from './primeng.module';
