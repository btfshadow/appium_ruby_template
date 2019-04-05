def validar_toggle(chave_toggle)
        servico = TOGGLE[chave_toggle.to_sym].to_s
        entity = toggle[servico].get
        objeto = parse(entity)
        resultado = objeto['valor']
        return false if resultado.eql? 'false'

        return true if resultado.eql? 'true'

        raise 'Algo Deu Errado no toggle'
end
