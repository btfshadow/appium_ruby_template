def login
    url     = URL[$bandeira.to_sym][$branch.to_sym] + '/token'
    RestClient::Resource.new(url, headers: headers)
end

def carrinho
    url     = URL[$bandeira.to_sym][$branch.to_sym] + '/carrinho'
    RestClient::Resource.new(url, headers: headers)
end

def enderecos
    url     = URL[$bandeira.to_sym][$branch.to_sym] + '/enderecos'
    RestClient::Resource.new(url, headers: headers)
end

def favoritos
    url     = URL[$bandeira.to_sym][$branch.to_sym] + '/favoritos'
    RestClient::Resource.new(url, headers: headers)
end

def produtos
    url     = URL[$bandeira.to_sym][$branch.to_sym] + '/produtos'
    RestClient::Resource.new(url, headers: headers)
end

def toggle
    url     = URL[$bandeira.to_sym][:toggle]
    RestClient::Resource.new(url, headers: headers)
end

def parse(request)
    JSON.parse(request.body)
end
