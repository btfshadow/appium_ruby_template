class RecoverBrowser
    def password_text
        $browser.find_element(id: 'pin-new-password')
    end

    def confirm_password_text
       $browser.find_element(id: 'pin-confirm-new-password')
    end

    def send_button_password
        $browser.find_element(:id, 'buttonCreatePass')
    end

    def confirmation_text
        $browser.find_element(:css, 'body')
    end

    def send_button_user
        $browser.find_element(:id, 'buttonCreateUser')
    end

    def user_text
        $browser.find_element(id: 'usercode-new-password')
    end

    def confirm_user_text
        $browser.find_element(id: 'confirm-new-usercode')
    end
end
