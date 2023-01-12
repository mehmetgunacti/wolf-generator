import { LoginFormComponent } from "./components/login-form/login-form.component";
import { RegisterFormComponent } from "./components/register-form/register-form.component";
import { RemindPasswordFormComponent } from "./components/remind-password-form/remind-password-form.component";
import { LoginContainerComponent } from "./containers/login-container/login-container.component";
import { RegisterContainerComponent } from "./containers/register-container/register-container.component";
import { RemindPasswordContainerComponent } from "./containers/remind-password-container/remind-password-container.component";
import { HomePageComponent } from "./pages/home-page/home-page.component";
import { LoginPageComponent } from "./pages/login-page/login-page.component";
import { RegisterPageComponent } from "./pages/register-page/register-page.component";
import { RemindPasswordPageComponent } from "./pages/remind-password-page/remind-password-page.component";
import { OnlinePageComponent } from "./pages/online-page/online-page.component";

export const components = [

	LoginFormComponent,
	LoginContainerComponent,
	LoginPageComponent,

	RemindPasswordFormComponent,
	RemindPasswordContainerComponent,
	RemindPasswordPageComponent,

	RegisterFormComponent,
	RegisterContainerComponent,
	RegisterPageComponent,

	HomePageComponent,
    OnlinePageComponent

];
