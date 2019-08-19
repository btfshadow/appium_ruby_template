Given('que tentaste accender la cuenta diez veces consecutivas de forma equivocada') do
    main = MainActivity.new
    main.authentication_button_login.click
    main.continue_button.click if $platform.include? 'ios'
    @login = LoginModule.new
    @login.login('credencial_semi_valida')
    for a in 1..11
        sleep 1
        @login.touch_wrong_login
        sleep 1
        @login.login_button_touch
    end 
end

Given('tiene la cuenta bloqueada') do
    @login.login_block_account_message
end

When('voy a desbloquear la cuenta') do
    link = recevie_email('recuperar_cuenta','link_email_desblock')
    @recover = RecoverModule.new
    @recover.start_and_open_link(link)
end

Then('desbloeo la cuenta con éxito') do
    $driver_appium.start_driver
    steps 'Given que yo estoy en la pantalla de inicio de sesión de la aplicación
            When iniciar sesión con las credenciales validas
            Then así que estoy logueando con éxito'
end
