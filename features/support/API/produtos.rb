def busca_produto(sku)
    servico = "?termo=#{sku}&Ordenacao=4&PaginaAtual=1&QuantidadePorPagina=20"
    gerar_token(conta)
    entity = produtos[servico].get
    valor = parse(entity)
    hash = {
        id: valor['produtos'][0]['id'],
        sku: valor['produtos'][0]['sku'],
        preco: valor['produtos'][0]['preco']['precoAtual']
    }
end

def colocar_item_carrinho(conta, sku)
    gerar_token(conta)
    produto_lojista = lista_lojistas(sku)
    servico = '/produto'
    payload = { 'idLojista': produto_lojista[0][:id], 'price': produto_lojista[0][:preco], 'sku': sku }
    entity = carrinho[servico].post payload.to_json
    parse(entity)
end

# def pagina_produto(id_produto)
#     servico = "/#{id_produto}?OfertarServicos=true"
#     entity = produtos[servico].get
#     objeto = parse(entity)
#     retorno = objeto.map do |x| {
#             categorias:
#             {
#                 id: x['categorias']['id'],
#                 descricao: x['categorias']['descricao'],
#               }
#             }
#         end
# end

def lista_lojistas(sku)
    servico = "/skus/#{sku}/lojistas"
    entity = produtos[servico].get
    objeto = parse(entity)
    retorno = objeto.map { |x| { id: x['id'], nome: x['nome'], preco: x['preco'], retiraRapido: x['retiraRapido'] } }
end

def alterar_quantidade_item_carrinho(conta, quantidade, id_carrinho_sku)
    gerar_token(conta)
    servico = '/produto'
    payload = { 'quantidade': quantidade, 'idCarrinhoSku': id_carrinho_sku }
    entity = carrinho[servico].patch payload.to_json
    parse(entity)
end

def remover_item_carrinho(id_carrinho_sku, sku, id_lojista, conta)
    gerar_token(conta)
    servico = "/produto?IdCarrinhoSku=#{id_carrinho_sku}&Sku=#{sku}&IdLojista=#{id_lojista}"
    entity = carrinho[servico].delete
    entity.code
end

def consultar_item_carrinho(conta)
    gerar_token(conta)
    servico = '?OfertarServicos=true&OfertarGarantia=false&PontosFidelidade=false'
    entity = carrinho[servico].get
    objeto = parse(entity)
    retorno = {
        itens_diferentes: objeto['skus'].count,
        valor_total: objeto['valorTotal'],
        produtos: objeto['skus'].map do |x| {
                                              id: x['id'],
                                              sku: x['sku'],
                                              idCarrinhoSku: x['idCarrinhoSku'],
                                              nome: x['nome'],
                                              quantidade: x['quantidade'],
                                              preco: x['preco'],
                                              lojista:
                                              {
                                                id: x['lojista']['id'],
                                                nome: x['lojista']['nome'],
                                                marketplace: x['lojista']['marketplace']
                                              },
                                              indisponivel: x['indisponivel'],
                                              produtoIndisponivelParaEntregaNaRegiao: x['produtoIndisponivelParaEntregaNaRegiao']
                                            }
                  end
            }
end
