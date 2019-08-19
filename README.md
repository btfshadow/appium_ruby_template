Herramientas

Estudio de android
Es el IDE oficial para crear aplicaciones en todos los tipos de dispositivos Android Para descargar Android, siga el enlace:
    https://developer.android.com/studio/index.html?hl=es

Java
Para descargar, siga el enlace: http://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html
Después de la instalación, es necesario establecer las variables de entorno JAVA_HOME y ANDROID_HOME en su archivo bash_profile.

> Homebrew
Homebrew instala paquetes que no vienen por defecto en el sistema Apple. Para instalar la pasta homebrew en tu terminal:
    / usr / bin / ruby ​​-e "$ (curl -sSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

> XCode
La principal herramienta de desarrollo en la plataforma IOS.
La instalación simplemente vaya a la tienda de Apple y descargue, luego ejecute el comando:
    xcode-select --install # install Xcode Command Line Tools

## Desde aquí es posible ejecutar el "prepare_environment.sh" que ya instala y verifica las dependencias del proyecto. Y también infoma si falta algo y no se puede instalar en este momento.

> Nodo JS
Appium es un servidor HTTP escrito en node.js que crea y manipula varias sesiones de los controladores para diferentes plataformas. Para instalar solo pegar en el terminal:
    brew install npm # install appium a través de (source) npn (Node JS Package Manager)


> Appium-doctor
Verifique que todas las dependencias de Appium se cumplan y que todas las dependencias estén configuradas correctamente. Para instalar el appium-doctor solo pégalo en tu terminal:
    npm install -g appium-doctor # install -g appium-doctor


>> Configuración de emuladores
Para hacer la vida más fácil, compruebe si estas carpetas están en su perfil de bash.

Android
export ANDROID_HOME = $ HOME / Library / Android / sdk
export PATH = $ {PATH}: $ ANDROID_HOME / tools: $ ANDROID_HOME / platform-tools
export PATH = "$ ANDROID_HOME / emulator: $ PATH"

Ejemplos de comandos
> Compilar
    rake 'app:compile [android, assembleDevDebug]'
    rake 'app:compile [ios, DevDebug]'

> Open Emulator
    emulador @NexusAPI26

> Abrir servidor de Appium
    appium

> Ejecutar las pruebas
    cucumber -p android

# iOS

Solo es necesario descargar el simulador para iPhone 5s, SE e iPhone 8, y las versiones del sistema operativo 10.0.0 y las más actuales.

Por el momento los comandos son los siguientes.

> Compilar
    ruby config / scripts / ios / build_app.rb "nombre de perfil"

> Abrir servidor de Appium
    appium

> Ejecutar las pruebas
    cucumber-p ios

    En despliegue
    cucumber -p ios10
    
# PATHS MAC #
export PATH = "/usr/local/bin:$PATH"

# esta es la carpeta raíz donde irán todos los paquetes de nodos instalados globalmente
exportar NPM_PACKAGES = "/ usr / local / npm_packages"
export NODE_PATH = "$ NPM_PACKAGES / lib / node_modules: $ NODE_PATH"

# añadir a PATH
export PATH = "$ NPM_PACKAGES / bin: $ PATH"

eval "$ (rbenv init -)"
# NPM
export PATH = "$ HOME / .npm-packages / bin: $ PATH"
Android
export ANDROID_HOME = $ HOME / Library / Android / sdk
export PATH = $ {PATH}: $ ANDROID_HOME / tools: $ ANDROID_HOME / platform-tools
export PATH = "$ ANDROID_HOME / emulator: $ PATH"
Java
export JAVA_HOME = $ (/ usr / libexec / java_home)
export PATH = $ {PATH}: $ JAVA_HOME / bin