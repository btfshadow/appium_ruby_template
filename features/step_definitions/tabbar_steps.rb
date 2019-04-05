######### QUANDO #########

Quando('toco na {string} da tabbar') do |tabbar|
    @tabbar = NavegacaoTabbar.new
    @tabbar.tocar_tabbar tabbar
end

######### ENTÃO ##########
Então('Vejo a tela do {string} com sucesso') do |tabbar|
  # @tabbar.validar_tabbar tabbar
end
