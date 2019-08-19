class RecoverUsercode < Utilites
    def recover_usercode_text_email
        find_element(:id, 'usercode-forgot-password-email')
    end

    def recover_usercode_button_send
        find_element(:id, 'buttonSendUser')
    end

    def recover_usercode_button_back
        find_element(:id, 'usercode-back-to-login')
    end
end
