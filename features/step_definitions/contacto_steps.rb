When('acceso a la pantalla de contacto') do
    @main_activity = MainActivity.new
    @main_activity.authentication_text_contacto.click
end

Then('veo la pantalla de contacto') do
    contacto = Contato.new
    raise 'no estoy en la pantalla de contacto' unless contacto.contact_text_mail_account.displayed?
    raise 'no estoy en la pantalla de contacto' unless contacto.contact_text_telephone_number.displayed?
end

Given('que yo estoy en la pantalla de contacto') do
    steps '
        Given que yo estoy en la pantalla de inicio de sesión de la aplicación
        When acceso a la pantalla de contacto
        Then veo la pantalla de contacto
    '
end

When('toco el numero de telefono') do
    contacto = Contato.new
    contacto.contact_text_telephone_number.click
end

Then('veo la pantalla de Dialer') do
    contacto = Contato.new
    raise 'no estoy en la pantalla de dialer' unless contacto.dialer_screen.displayed?

    contacto.dialer_screen.click if $platform.include? 'ios'
end

When('toco el mail') do
    contacto = Contato.new
    contacto.contact_text_mail_account.click
end

Then('veo la pantalla de mail') do
    contacto = Contato.new
    raise 'no estoy en la pantalla de mail' unless contacto.mail_screen.displayed?
end

Given('que yo estoy navegando fuera de la aplicación') do
end

When('toco en Deeplink') do
    $driver_appium.reset.get(DEEPLINK[:contacto_screen])
end
