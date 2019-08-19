Given('que yo estoy en la pantalla de inicio de sesión de la aplicación') do
    @main_activity = MainActivity.new
end

When('iniciar sesión con las credenciales validas') do
  @main_activity.authentication_button_login.click
  @common = Commnons.new
  sleep 1
  @common.continue_button.click if $platform.include? 'ios'
  login = LoginModule.new
  login.login('credencial_valida')
end

When('iniciar sesión con las credenciales no válidas') do
  @main_activity.authentication_button_login.click
  @common = Commnons.new
  @common.continue_button.click if $platform.include? 'ios'
  @login = LoginModule.new
  @login.login('credencial_invalida')
end

Then('así que estoy logueando con éxito') do
  home = Home.new
  begin
    status = home.modal_title.nil?
  rescue
    status = home.view_home.nil?
  end
  raise 'Home not found' if status
end

Then('continuación veo la pantalla de error en el inicio de sesión') do
  @login.invalid_login_message
end
