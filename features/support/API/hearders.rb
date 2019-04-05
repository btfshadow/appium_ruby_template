def headers
    header =    {
        'Accept': 'application/json',
        'Content-type': 'application/json',
        'X-AppName': 'ViaVarejo',
        'X-BuildCode': '250000018',
        'X-AppVersion': '4.5.2',
        'X-DeviceBrand': 'Motorola',
        'X-DeviceModel': 'Moto G (5S) Plus',
        'X-Platform': 'android',
        'X-PlatformVersion': '7.1.1'
                }
    header['Authorization'.to_sym] = 'Bearer ' + @token unless @token.nil?
    header
end
