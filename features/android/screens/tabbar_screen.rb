require_relative '../../modules/utils'
class NavegacaoTabbar < Utilites
    def tocar_tabbar(tabbar)
        esperar_por(30) { find_element(:id, 'tabBar').find_element(:xpath, "//*[@text='#{tabbar}']").click }
    end

    def validar_tabbar(tabbar)
        esperar_por(30) { find_element(:id, 'toolbar').find_element(:xpath, "//*[@text='#{tabbar}']").displayed? }
    end
end
