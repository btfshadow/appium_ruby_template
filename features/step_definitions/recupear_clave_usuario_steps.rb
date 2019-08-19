Given('que está en la pantalla de inicio de sesión') do
    @main_activity = MainActivity.new
    @main_activity.authentication_button_login.click
    @common = Commnons.new
    @common.continue_button.click if $platform.include? 'ios'
end

When('realizar el proceso de recuperación de contraseñas') do
    login = Login.new
    login.login_password_recovery.click
    login.forgot_email_recovery_password.send_keys(LOGIN[:credencial_user_code][:email])
    login.send_button.click
    link = recevie_email('recuperar_cuenta', 'link_email_recovery')
    @recover = RecoverModule.new
    @recover.start_and_open_link(link)
    @recover.fill_password
end

Then('realizo la recuperación de contraseña con éxito') do
    sleep 10
    @recover.confirm_operation('Creaste tu nueva clave!')
end

When('realizar el proceso de recuperación de usuario') do
    login = Login.new
    login.login_usercode_recovery.click
    login.forgot_email_recovery_usercode.send_keys(LOGIN[:credencial_user_code][:email])
    login.recover_usercode_button_send.click
    link = recevie_email('recuperar_cuenta','link_email_recovery')
    @recover = RecoverModule.new
    @recover.start_and_open_link(link)
    @recover.fill_usercode
end

Then('realizo la recuperación de usuario con éxito') do
    @recover.confirm_operation('Creaste tu nuevo usuario!')
end
