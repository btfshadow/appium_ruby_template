def gerar_token(conta)
    payload = {
                'textoCaptcha': '',
                'email': LOGIN[conta.to_sym][:email].to_s,
                'grantType': 'Password',
                'senha': LOGIN[conta.to_sym][:senha].to_s
              }
    entity = login.post payload.to_json
    @token = parse(entity)['accessToken']
end
