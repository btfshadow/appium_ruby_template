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
brew install make
brew install allure
brew install ios-deploy
brew install ios-webkit-debug-proxy

npm install -g appium
npm install -g appium-doctor
npm i -g opencv4nodejs
npm install -g ios-deploy
npm install -g mjpeg-consumer
npm install appium-chromedriver

git config core.hooksPath .githooks;

find .git/hooks -type l -exec rm {} \;
find .githooks -type f -exec ln -sf ../../{} .git/hooks/ \;
gem install xcpretty

bundle install 

appium-doctor 