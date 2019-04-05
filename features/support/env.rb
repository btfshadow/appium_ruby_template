require 'pry'
require 'appium_lib'
require 'rspec/expectations'
require 'rubygems'
require 'rtesseract'
require 'rest-client'

# ENV
paralelo = ENV['PARALELO']
test_batch_id = ENV['TEST_ENV_NUMBER']
plataforma = ENV['PLATAFORMAAPI']
$appiumtxt = ENV['PLATFORM']
jenkins = ENV['JENKINS']
$branch = ENV['BRANCH']
$bandeira = ENV['BANDEIRA']
zeroandroid = nil
$branch = 'homolog' if $branch.nil? || $branch.empty?
$bandeira = 'bandeira1' if $bandeira.nil? || $bandeira.empty?
zeroandroid = 0 if test_batch_id.nil?
test_batch_id = 0 if test_batch_id.nil? || test_batch_id.empty?
paralelo = false if paralelo.nil? || $branch.empty?
$visual_regression = false
$visual_regression = true if ENV['VISUAL']

port={ 0=>0, 2=>2, 3=>4, 4=>6, 5=>8, 6=>10 }

$imgreport = nil

platformversion = case
                  when $appiumtxt.include?('android')
                  if $appiumtxt.include? '26'
                    6.0
                  elsif $appiumtxt.include? '19'
                    4.4
                  else
                    6.0
                  end
                  when $appiumtxt.include?('ios') || $appiumtxt.include?('iPhone')
                  if $appiumtxt.include? '12'
                    12.1
                  elsif $appiumtxt.include? '10'
                    10.0
                  else
                    12.1
                  end
                  end

androidport = 6 if $appiumtxt.include? '26'
androidport = 7 if $appiumtxt.include? '19'
iosport = 9 if $appiumtxt.include? '10'
iosport = 8 if $appiumtxt.include? '12'
androidport_3 = "85#{androidport}#{port[test_batch_id.to_i]}#{zeroandroid}"
appios = 'Casasbandeira1'
appios = 'bandeira2' if $bandeira.include? 'bandeira2'
zero = 0 if ($appiumtxt.eql? 'ios12') || ($appiumtxt.eql? 'ios10')
plataforma = 'ios' if plataforma.nil?
$appiumtxt = "#{$appiumtxt}122" if $appiumtxt.eql? 'ios'
# Class to not pollute 'Object' class with appium methods
class AppiumWorld
end

opts = if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
          {
            caps: {
              'platformName' => plataforma.to_s.tr('0-9', ''),
              'platformVersion' => platformversion.to_s,
              'deviceName' => "#{$appiumtxt}#{zero}",
              'app' => "#{$bandeira}/#{appios}.app",
              'automationName' => 'XCUITest',
              'noReset' => 'true',
              'fullReset' => 'false',
              'keepKeychains' => 'false',
              'connectHardwareKeyboard' => 'false',
              'autoAcceptAlerts' => 'true',
              'clearSystemFiles' => 'true'
            }
          }
       else
          {
            caps: {
              'platformName' => $appiumtxt.to_s.tr('0-9', ''),
              'deviceName' => $appiumtxt.to_s,
              'app' => "../apk/#{$bandeira}/#{$branch}/app-#{$bandeira}-#{$branch}.apk",
              'noReset' => 'true',
              'fullReset' => 'false',
              'autoGrantPermissions' => 'true',
              'appActivity' => 'home.HomeActivity'
            }
          }
       end

opts[:caps]['udid'] = "emulator-55#{androidport}#{port[test_batch_id.to_i]}" if paralelo == 'true' && $appiumtxt.include?('android')
opts[:caps]['systemPort'] = androidport_3.to_i if paralelo == 'true' && $appiumtxt.include?('android')
opts[:caps]['automationName'] = 'UiAutomator2' if $appiumtxt.include?('26')
opts[:caps]['wdaLocalPort'] = "#{iosport}#{test_batch_id}00".to_i if paralelo == 'true' && $appiumtxt.include?('ios')

puts opts

Appium::Driver.new(opts, true)
Appium.promote_appium_methods Object

World do
  AppiumWorld.new
end
