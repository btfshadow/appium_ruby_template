Given('estoy no fluxo de onboard') do
    @main_activity = MainActivity.new
    @main_activity.authentication_text_create_account.click
end

When('voy a través de todo el flujo') do
    @onboarding = Onboarding.new
    raise 'Pantalla de el onboarding no estás visible' until @onboarding.onboarding_title_screen.displayed?
    @onboarding.touch_until(@onboarding.onboarding_button_next_id[$platform.to_sym][1], 'Comenzar ahora')
    find_element(id: @onboarding.onboarding_button_next_id[$platform.to_sym][1]).click
end

Then('Puedo iniciar el registro') do
    create_account = CreateAccount.new
    raise 'screen create account' unless create_account.email_textbox.displayed?
end

When('saltar toda la informacion') do
    pending # Write code here that turns the phrase above into concrete actions
end

Given('que he enviado los datos para crear cuenta') do
    pending # Write code here that turns the phrase above into concrete actions
end

When('accede al vínculo enviado al correo electrónico') do
    pending # Write code here that turns the phrase above into concrete actions
end

Then('abro la aplicación para continuar con el proceso de registro') do
    pending # Write code here that turns the phrase above into concrete actions
end
