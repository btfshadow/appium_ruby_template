Given('que tengo la {string} para comparar') do |imagem|
  @main_activity = MainActivity.new
  @main_activity.authentication_button_login.displayed?
  @compare = File.read("#{PATHS[:img_compare]}/#{imagem}.png")
  @matriz = File.read("#{PATHS[:img_matriz]}/#{imagem}.png")
end

When('comparo con la matriz {string}') do |imagem|
  util = Utilites.new
  @main_activity.authentication_button_login.displayed?
  @status = util.compare_img(@compare, @matriz)
end

Then('valido que todo esta bien') do
    raise 'Não funcionou' unless @status

    $driver_appium = nil
end
