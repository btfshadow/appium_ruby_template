class Commnons < Utilites
    def cancel_button
        object = {
            android: ['', ''],
            ios: ['name', 'Cancel'],
            name: 'cancel_button'
        }
        find_element_screen(object, 10)
    rescue
        object = {
            android: ['', ''],
            ios: ['name', 'Cancelation'],
            name: 'cancel_button'
        }
        find_element_screen(object, 10)
    end

    def continue_button
        object = {
            android: ['', ''],
            ios: ['name', 'Continue'],
            name: 'continue_button'
        }
        find_element_screen(object, 10)
    rescue
        object = {
            android: ['', ''],
            ios: ['name', 'Continuar'],
            name: 'continue_button'
        }
        find_element_screen(object, 10)
    end

    def allow_button
        object = {
            android: ['', ''],
            ios: ['name', 'Allow'],
            name: 'continue_button'
        }
        find_element_screen(object, 10)
    rescue
        object = {
            android: ['', ''],
            ios: ['name', 'Aceitar'],
            name: 'continue_button'
        }
        find_element_screen(object, 10)
    end
end
