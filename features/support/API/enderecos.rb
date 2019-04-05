def cadastrar_endereco(conta, endereco)
    gerar_token(conta)
    servico = ''
    payload = ENDERECOS[endereco.to_sym]
    entity = enderecos[servico].post payload.to_json
    parse(entity)
rescue RestClient::ExceptionWithResponse => e
    nil
end

def consultar_enderecos(conta)
    gerar_token(conta)
    servico = '?formasEntrega=false'
    entity = enderecos[servico].get
    valor = parse(entity)
    retorno = {
        quantidade: valor.count,
        enderecos: valor.map { |x| { nome: x['nome'], idClienteEndereco: x['idClienteEndereco'] } }
    }
rescue RestClient::ExceptionWithResponse => e
    nil
end

def deletar_enderecos(nome_endereco, conta)
    objeto = consultar_enderecos(conta)
    filtro = objeto[:enderecos].select { |x| x[:nome].include? nome_endereco }
    servico = filtro[0][:idClienteEndereco].to_s
    entity = enderecos[servico].delete
    entity.code
rescue RestClient::ExceptionWithResponse => e
    nil
end
