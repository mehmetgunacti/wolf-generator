dockerCleanup:
  commands:
    - command: [ "docker-compose", "down", "-v", "--rmi", "local" ]
      run: true
    - command: [ "docker", "image", "prune", "-f" ]
      run: true
dockerStart:
  commands:
    - command: [ "docker-compose", "up", "--build", "-d" ]
      run: true
angular:
  fromCache: true
  commands:
    - command: [ "npx", "--yes", "@angular/cli@${ version.angular }", "new", "${ info.artifactId }", "--directory=.", "--commit=false", "--interactive=false", "--routing=false", "--skip-git=true", "--style=scss" ]
      run: true
    #- command: [ "ng", "new", "${ info.artifactId }", "--directory=frontend", "--commit=false", "--interactive=false", "--routing=false", "--skipGit=true", "--strict=true", "--style=scss" ]
    - command: [ "ng", "add", "@angular-eslint/schematics@${ version.angular }", "--skip-confirmation" ]
      run: true
    - command: [ "ng", "g", "environments"]
      run: false
    #  directory: "${ info.artifactId }-frontend"
    - command: [ "npm", "install", "@angular/cdk@${ version.angular }", "lodash-es", "primeng@${ version.primeNg }", "primeflex@${ version.primeFlex }", "primeicons@${ version.primeIcons }", "@ngrx/effects@${ version.ngrxEffects }", "@ngrx/store@${ version.ngrxStore }", "immer@${ version.immer }", "ngx-progressbar@${ version.ngxProgressbar }", "ngx-toastr@${ version.ngxToastr }", "@stomp/ng2-stompjs@${ version.ng2StompJs }", "@ngx-translate/core@${ version.ngxTranslateCore }", "@ngx-translate/http-loader@${ version.ngxTranslateHttpLoader }" ]
      run: true
      # directory: "${ info.artifactId }-frontend"
    - command: [ "npm", "install", "@types/lodash-es@${ version.lodashEs }", "@ngrx/store-devtools@${ version.ngrxDevtools }", "--save-dev" ]
      run: true
      # directory: "${ info.artifactId }-frontend"
maven:
  commands:
    - command: [ "./mvnw", "package" ]
      run: true
buildAngular:
  commands:
    - command: [ "ng", "build" ]
      run: true
git:
  commands:
    - command: [ "git", "init", "--quiet" ]
      run: true
    - command: [ "git", "add", "-A" ]
      run: true
    - command: [ "git", "commit", "-a", "-m 'initial commit'" ]
      run: true