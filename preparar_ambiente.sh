echo Preparando Ambiente: $(date)

brew install node
brew install npm
bash brew install carthage
brew install cmake
brew tap facebook/fb
brew install fbsimctl
brew install libimobiledevice --HEAD
brew install ideviceinstaller
brew tap wix/brew
brew install wix/brew/applesimutils

npm install -g appium
npm install -g appium-doctor
npm i -g opencv4nodejs
npm install -g ios-deploy

git config core.hooksPath .githooks;

find .git/hooks -type l -exec rm {} \;
find .githooks -type f -exec ln -sf ../../{} .git/hooks/ \;
gem install xcpretty

# brew install imagemagick@6 && brew link imagemagick@6 --force
# brew install tesseract
# brew install tesseract --all-languages

bundle install 

appium-doctor 

echo Fim da execução: $(date)

