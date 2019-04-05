require_relative '../../modules/utils'
class NavegacaoTabbar < Utilites
    def tocar_tabbar(tabbar)
        esperar_por(8) { find_element(:name, tabbar).click }
    end

    def validar_tabbar(tabbar)
        elementos = esperar_por(8) { find_elements(:name, tabbar) }
        elementos.each(&:displayed?)
    end
end
