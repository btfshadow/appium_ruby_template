# Até o momento ele só completla se o carrinho houver itens
def preparar_50_mil(conta)
    carrinho = consultar_item_carrinho(conta)
    count = 0
    while carrinho[:valor_total] + carrinho[:produtos].first[:preco] > 50_000.0
        quantidade = (50_000.0 - carrinho[:valor_total]) / carrinho[:produtos][count][:preco]
        quantidade += carrinho[:produtos][count][:quantidade] if quantidade + carrinho[:produtos][count][:quantidade] < 5
        alterar_quantidade_item_carrinho(conta, quantidade.to_i, carrinho[:produtos][count][:idCarrinhoSku])
        count += 1
        return if count == 10
    end
end

def preparar_6_itens(conta)
    carrinho = consultar_item_carrinho(conta)
    colocar_item_carrinho(conta, M6ITENS[$bandeira.to_sym].sample) unless carrinho[:produtos].any?
    alterar_quantidade_item_carrinho(conta, 6, carrinho[:produtos].first[:idCarrinhoSku])
end

def preparar_30_itens(conta)
    raise 'Massa não possui 6 itens' if M30ITENS[$bandeira.to_sym].count < 6

    preparar_limpar_carrinho(conta)
    M30ITENS[$bandeira.to_sym].each { |x| colocar_item_carrinho(conta, x) }
    carrinho = consultar_item_carrinho(conta)
    carrinho[:produtos].each { |x| alterar_quantidade_item_carrinho(conta, 5, x[:idCarrinhoSku]) }
end

def preparar_limpar_carrinho(conta)
    carrinho = consultar_item_carrinho(conta)
    carrinho[:produtos].each { |x| remover_item_carrinho(x[:idCarrinhoSku], x[:sku], x[:lojista][:id], conta) }
end
