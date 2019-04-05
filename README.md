O produto consiste em uma transcrição do APP atual em webview para um app nativo, e ao longo da jornada ir adicionando novas funcionalidades que fizerem sentido. Além de um desenvolvimento de API responsável por reduzir o número de chamadas que o APP faz, além de ter um serviço específico para o mobile.

> Pasta do projeto 
    Todos os projetos ficam dentro de uma pasta chamada workspace
    #EX:
        workspace
            vv-viaunica-qa
            vv-viaunica-qa-contrato
            vv-viaunica-ios
            vv-viaunica-android

Ferramentas:

> Android studio
É a IDE oficial para criação de aplicativos em todos os tipos de dispositivos android Para baixar o android segue o link: 
    https://developer.android.com/studio/index.html?hl=pt-br

> Java
Para baixar segue o link: http://www.oracle.com/technetwork/pt/java/javase/downloads/jdk8-downloads-2133151.html
Após ter instalado é necessário setar as variáveis de ambiente JAVA_HOME e ANDROID_HOME no seu arquivo bash_profile.

> Homebrew
O Homebrew instala os pacotes que não vem por padrão no sistema da Apple. Para instalar o homebrew cole no seu terminal:
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

> XCode
A principal ferramenta para desenvolvimento na plataforma IOS
Instalação só ir na loja da apple e baixar depois executar o comando:
    xcode-select --install    # instala Xcode Command Line Tools

##A partir deste ponto é possivel rodar o "preparar_ambiente.sh" que ele já instala e verifica as dependências do projeto. E também infoma caso algo esteja faltando e ele não consegue instalar neste momento.

> Node JS
O Appium é um servidor HTTP escrito em node.js que cria e manipula várias sessões do Drivers para diferentes plataformas. Para instalar basta colar no terminal:
    brew install npm    #instalar o appium via(source) npn(Node JS Package Manager)


> Appium-doctor
Verificar se todas as dependências do Appium são atendidas e se todas as dependências estão configuradas corretamente. Para instalar o appium-doctor basta colar no seu terminal:
    npm install -g appium-doctor  # instalar o appium-doctor


>> Configurando os Emuladores
Para facilitar a vida confira se estas pastas estão em seu bash profile

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="$ANDROID_HOME/emulator:$PATH"

Após vamos configurar o emuladores 
|Emulador   |   Configuração                            | Porta Appium  | Profile Cucumber  |
|NexuAPI26  | Hardware Nexus 5 api 26 com google apps   |   4726        |   NexusAPI26      |
|Nexu4API23 | Hardware Nexus 4 api 23 com google apps   |   4723        |   NexusAPI23      |
|J5API19    | Hardware j5 api 19 com google apps        |   4719        |   J5API19         |

Exemplo de comandos
> Compilar 
    cd ../vv-viaunica-android/ && ./gradlew assemblebandeira1Homolog

>Abrir Emulador
    emulator @NexusAPI26

> Abrir Appium server
    appium -p 4726

> Executar os testes
    cucumber -p NexusAPI26

# iOS

Somente é nescessário baixar o simulador do iphone 5s, SE, e IPhone 8, e as versões de sistema operacional 10.0.0 e a mais atual.

No momento os comandos são os seguintes

> Compilar 
    ruby config/scripts/ios/build_app.rb "nome do perfil"

> Abrir Appium server
    appium

> Executar os testes
    cucumber -p ios 

    Em implantação 
    cucumber -p ios10
    
# personalizado Thiago
export PATH="/usr/local/bin:$PATH"

# this is the root folder where all globally installed node packages will  go
export NPM_PACKAGES="/usr/local/npm_packages"
export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
# add to PATH
export PATH="$NPM_PACKAGES/bin:$PATH"

eval "$(rbenv init -)"
# NPM
export PATH="$HOME/.npm-packages/bin:$PATH"
# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
export PATH="$ANDROID_HOME/emulator:$PATH"
# Java
export JAVA_HOME=$(/usr/libexec/java_home)
export PATH=${PATH}:$JAVA_HOME/bin


