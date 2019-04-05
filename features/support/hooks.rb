Before do
  $driver.start_driver
  set_wait(0)
end

After do |scenario|
  if scenario.failed?
    encoded_img = $imgreport
    encoded_img = driver.screenshot_as(:base64) if $imgreport.nil?
    embed("data:image/png;base64,#{encoded_img}", 'image/png')
  end
  $driver.driver_quit
end

After('@Reinstall') do |scenario|
  if scenario.failed?
    encoded_img = $imgreport
    encoded_img = driver.screenshot_as(:base64) if $imgreport.nil?
    embed("data:image/png;base64,#{encoded_img}", 'image/png')
  end
  $driver.reset
end
