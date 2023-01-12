import { LANG, ThemeInfo, THEME_DARK, THEME_LIGHT } from 'blueprints';

interface ConstantUI {

	selectedCategory: string

}

interface ThemeUI {

	info: ThemeInfo;
	scriptElement?: any

}

export interface UIState {

	constant: ConstantUI,
	theme: ThemeUI,
	lang: LANG,
	translations: any

}

export const initialUIState: UIState = {

	constant: { selectedCategory: '' },
	theme: {
		info: localStorage.getItem('theme') === THEME_LIGHT.name ? THEME_LIGHT : THEME_DARK
	},
	lang: 'en',
	translations: {}

};
