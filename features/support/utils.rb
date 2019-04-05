class Utilites
  def tocar_contem_texto(texto)
    if ($appiumtxt.include? 'android') || ($appiumtxt.include? 'android')
      esperar_por(5) { find_element(:xpath, "//*[contains(@text,'#{texto}')]").click }
    else
      esperar_por(5) { find_element(:name, texto).click }
    end
  end

  def verify_product_list?
    wait { find_element(:id, name).displayed? }
  end

  def compararitens(elemento_1, elemento_2)
    raise "Os Elementos o elemento: #{elemento_1} não é igual ao elemento #{elemento_2}" unless elemento_1.include? elemento_2
  end

  def verificar_desigualdade(elemento_1, elemento_2)
    raise "O elemento: #{elemento_1} é igual ao elemento #{elemento_2}" unless elemento_1 != elemento_2
  end

  def proximo_campo
    if ($appiumtxt.include? 'android') || ($appiumtxt.include? 'android')
      press_keycode(66)
    else
      find_element(:name, 'Toolbar Done Button').click
    end
  end

  def tocar_sim
    if ($appiumtxt.include? 'android') || ($appiumtxt.include? 'android')
     esperar_por(8) { find_element(:xpath, "//*[@text='SIM']").click }
    else
     esperar_por(8) { find_element(:xpath, "//*[@label='Sim']").click }
    end
  end

  def esperar_por(time = 1, tentar: true, loading: true)
    tentar_novamente if tentar
    esperar_barra_sumir if loading
    tentar_novamente if tentar
    Selenium::WebDriver::Wait.new(timeout: time).until { yield }
  end

  def deslizar_sobre_tela(inicio_x: window_size[:width] - 3, inicio_y: window_size[:height] * 0.5, moveate_x: window_size[:width] - 3, moveate_y: window_size[:height] * 0.5, elemento: nil)
    unless elemento.nil?
      location = elemento.location
      inicio_x = elemento.x + (elemento.width/2)
      inicio_y = elemento.y + (elemento.height/2)
    end
    if ($appiumtxt.include? 'android')
      swipe(start_x: inicio_x, start_y: inicio_y, end_x: moveate_x, end_y: moveate_y)
    else
      drag_from_to_for_duration(from_x: inicio_x, from_y: inicio_y, to_x: moveate_x, to_y: moveate_y, duration: 0)
    end
  end
  # Optical Character Recognition

  def touch_ocr_screen(palavra)
    screenshot 'teste.png'
    words = RTesseract::Box.new('teste.png').words
    words.each do |x|
      puts x
      next unless x[:word].include? palavra

      x_1 = x[:x_start]
      y_1 = x[:y_start]
      Appium::TouchAction.new.tap(options ={ x: x_1, y: y_1 })
      break
    end
  end

  def valida_ocr_screen(palavra)
    screenshot 'teste.png'
    words = RTesseract::Box.new('teste.png').words
    words.each do |x|
      puts x
      next unless x[:word].include? palavra

      return true
    end
    false
  end

  def rolar_ate_texto(texto, direction: 'down')
    if $appiumtxt.include? 'android'
      count = 0
      direcao = 0.33
      direcao = 0.7 if direction.eql? 'up'
      sleep 2
      while count <=30
        begin
          break if esperar_por(0.3, tentar: false, loading: false) { find_exact(texto).displayed? }

          deslizar_sobre_tela(moveate_y: window_size[:height] * direcao)
        rescue
          deslizar_sobre_tela(moveate_y: window_size[:height] * direcao)
        end
        count +=1
      end
    elsif ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
      count = 0
      direcao = 0.125
      direcao = 0.6 if direction.eql? 'up'
      while count <=10
        begin
          break if esperar_por(0.3, tentar: false, loading: false) { find_element(:name, texto).displayed? }

          deslizar_sobre_tela(moveate_y: window_size[:height] * direcao)
        rescue
          deslizar_sobre_tela(moveate_y: window_size[:height] * direcao)
        end
        count +=1
      end
    end
  end

  def rolar_ate(elemento)
    if ($appiumtxt.include? 'android') || ($appiumtxt.include? 'android')
      count = 0
      while count <=5
        begin
          esperar_por { text(texto).displayed? }
        rescue
          deslizar_sobre_tela
        end
        count +=1
      end
    elsif ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
      count = 0
      while count <=5
        break if elemento.displayed?

        deslizar_sobre_tela(moveate_y: window_size[:height] * 0.10)
        count +=1
      end
    else
      raise 'Qual plataforma é isso ?'
    end
  end

  def atualizar_pagina(elemento)
    if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
    else
      elemento.click
      elemento.press_keycode(66)
    end
  end

  def tocar_ok_teclado
    find_element(:accessibility_id, 'Toolbar Done Button').click if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
    hide_keyboard if ($appiumtxt.include? 'android') && is_keyboard_shown
  end

  def esperar_barra_sumir
    count = 0
    until barra_de_progresso.nil?
      sleep 1
      count +=1
      break if count >= 10 && barra_ignore
    end
  rescue
    nil
  end

  def barra_de_progresso
    if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
      Selenium::WebDriver::Wait.new(timeout: 0.1).until { find_element(:accessibility_id, 'SVProgressHUD') }
    else
      Selenium::WebDriver::Wait.new(timeout: 0.1).until { find_element(:class, 'android.widget.ProgressBar').displayed? }
    end
  rescue
    nil
  end

  def barra_ignore
    Selenium::WebDriver::Wait.new(timeout: 0.3).until { find_element(:id, 'contractServiceLoaderFloatingHire').displayed? }
  rescue
    nil
  end

  def tentar_novamente
    get_tentar_novamente.click
  rescue
    nil
  end

  def get_tentar_novamente
    if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
      Selenium::WebDriver::Wait.new(timeout: 1).until {  find_element(:name, 'Tentar novamente') }
    else
      Selenium::WebDriver::Wait.new(timeout: 1).until {  find_element(:id, 'buttonTryAgain') }
    end
  rescue
    nil
  end

  def primeira_vez_ios
    primeiroAviso
    segundoAviso
    terceiroAviso
  end

  def primeiroAviso
    Selenium::WebDriver::Wait.new(timeout: 5).until { find_element(:accessibility_id, 'Allow').click }  if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
  rescue
    nil
  end

  def segundoAviso
    Selenium::WebDriver::Wait.new(timeout: 10).until { find_element(:accessibility_id, 'Always Allow').click }  if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
  rescue
    nil
  end

  def terceiroAviso
    Selenium::WebDriver::Wait.new(timeout: 10).until { find_element(:accessibility_id, 'Allow').click }  if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
  rescue
    nil
  end

  def procurar_elemento_por_imagem(img)
    imagem = Base64.encode64(img)
    esperar_por(30) { find_element(:image, imagem) }
  end

  def comparar_imagens(img_1, img_2)
    get_images_result_visual = @driver.get_images_similarity first_image: img_1, second_image: img_2, visualize: true
    if get_images_result_visual['score'] < 0.9
      $imgreport =get_images_result_visual['visualization']
      raise 'A tela atual não é compativel em 90% da tela enviada'
    else
      true
    end
  end

  def validar_tela(img_2)
    element_screenshot(id('android:id/content'), 'validar_tela.png') if $appiumtxt.include? 'android'
    element_screenshot(find_element(:class_name, 'XCUIElementTypeApplication')) if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
    image_1 = File.read 'validar_tela.png'
    get_images_result_visual = @driver.get_images_similarity first_image: image_1, second_image: img_2, visualize: true
    if get_images_result_visual['score'] < 0.9
      $imgreport =get_images_result_visual['visualization']
      raise 'A tela atual não é compativel em 90% da tela enviada'
    else
      true
    end
  end

  def ocorrencia_imagens_tela(img)
    element_screenshot(id('android:id/content'), 'ocorrencia_imagem.png') if $appiumtxt.include? 'android'
    element_screenshot(find_element(:class_name, 'XCUIElementTypeApplication'), 'ocorrencia_imagem.png') if ($appiumtxt.include? 'ios') || ($appiumtxt.include? 'iPhone')
    image_1 = File.read 'ocorrencia_imagem.png'
    find_result_visual = match_images_features first_image: image_1, second_image: img, visualize: true
    # File.binwrite 'find_result_visual.png', Base64.decode64(find_result_visual['visualization'])
    if find_result_visual['totalCount'] <= 1
      $imgreport =get_images_result_visual['visualization']
      raise 'Não existe nenhuma ocorrencia na tela'
    else
      true
    end
  end

  def screenshot_elemento(elemento)
    element_screenshot elemento, :base64
  end
end
