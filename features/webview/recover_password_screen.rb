class RecoverPassword < Utilites
    def recover_password_text_email
        find_element(:id, 'pin-forgot-password-email')
    end

    def recover_password_button_send
        find_element(:id, 'buttonSend')
    end

    def recover_password_button_back
        find_element(:id, 'pin-back-to-login')
    end
end
