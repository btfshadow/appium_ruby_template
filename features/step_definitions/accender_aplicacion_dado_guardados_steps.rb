When('iniciar sesión con las credenciales validas guardando los dados') do
    @main_activity.authentication_button_login.click
    @main_activity.continue_button.click if $platform.include? 'ios'
    @login = LoginModule.new
    @login.login('credencial_valida', true)
end

Then('la próxima vez que abra la aplicación veo sólo el campo de contraseña') do
    step 'así que estoy logueando con éxito'
    $driver_appium.reset
    @main_activity.authentication_button_login.click
    begin
        @main_activity.continue_button.click if $platform.include? 'ios'
    rescue
        nil
    end
    raise 'no estoy en la pantalla de contraseña' unless @login.only_password_screen?
end

Given('que estoy en la pantalla de contraseña') do
    steps '
    Given que yo estoy en la pantalla de inicio de sesión de la aplicación
    When iniciar sesión con las credenciales validas guardando los dados
    Then la próxima vez que abra la aplicación veo sólo el campo de contraseña
    '
    raise 'no estoy en la pantalla de contraseña' unless @login.only_password_screen?
end

When('iniciar sesión con la clave') do
   @login.login('credencial_valida', only_password: false)
end

When('tocar cambiar cuenta') do
    @login = LoginModule.new
    @login.swap_account_touch
end

Then('veo la pantalla de inicio de sesión de nuevo') do
    @login = LoginModule.new
    raise 'no estoy en la pantalla de login' unless @login.login_screen?
end
