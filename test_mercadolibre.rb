require 'appium_lib'
require 'selenium-webdriver'
require 'erb'

Dir.mkdir("screenshots") unless Dir.exist?("screenshots")

def clear_screenshots_folder
  Dir.glob("screenshots/*.png").each { |file| File.delete(file) }
  puts "Se eliminaron las capturas previas."
end

def take_screenshot(driver, step_name)
  timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
  filename = "screenshots/#{step_name}_#{timestamp}.png"
  driver.screenshot(filename) rescue nil
  puts "Captura guardada: #{filename}"
end

clear_screenshots_folder

def caps
  {
    caps: {
      platformName: "Android",
      deviceName: "odessa",
      appPackage: "com.mercadolibre",
      appActivity: ".splash.SplashActivity",
      automationName: "UiAutomator2",
      autoGrantPermissions: true,
      noReset: false,
      fullReset: false
    }
  }
end

driver = Appium::Driver.new(caps, true)
driver.start_driver
sleep 3

begin
  wait = Selenium::WebDriver::Wait.new(timeout: 15)

  begin
    wait.until { driver.find_element(:id, 'com.mercadolibre:id/andes_button_text') }.click
  rescue Selenium::WebDriver::Error::NoSuchElementError
    puts "✅ No se encontró 'Continuar como Visitante', procediendo..."
  end

  search_box = wait.until { driver.find_element(:id, 'com.mercadolibre:id/ui_components_action_bar_search_field') }
  search_box.click
  take_screenshot(driver, "buscar_ps5")

  escribir = wait.until { driver.find_element(:id, "com.mercadolibre:id/autosuggest_input_search") }
  escribir.send_keys('Playstation 5')
  driver.press_keycode(66)
  take_screenshot(driver, "busqueda_completa")

  sleep 3

  begin
    xpath_filter = '(//android.widget.LinearLayout[@resource-id="com.mercadolibre:id/appbar_content_layout"])[1]/android.widget.LinearLayout'
    wait.until { driver.find_element(:xpath, xpath_filter) }.click
    
    wait.until { driver.find_element(:accessibility_id, "Condición") }.click
    wait.until { driver.find_element(:xpath, "//android.widget.ToggleButton[@text='Nuevo']") }.click
    sleep 1
    wait.until { driver.find_elements(:class, "android.widget.Button")[1] }.click
    take_screenshot(driver, "filtros_aplicados")
  rescue Selenium::WebDriver::Error::NoSuchElementError
    take_screenshot(driver, "error_filtros")
  end


  begin
    wait.until { driver.find_element(:xpath, xpath_filter) }.click 

    8.times do
      driver.execute_script('mobile: scrollGesture', {
        left: 500,    
        top: 1000, 
        width: 500,  
        height: 1000,
        direction: 'down', 
        percent: 1.0  
      })
      sleep 0.3  
    end
    
    wait.until { driver.find_element(:xpath, '//android.widget.ToggleButton[@text="Mayor precio"]') }.click
    sleep 3

    wait.until { driver.find_elements(:class, "android.widget.Button")[1] }.click
    take_screenshot(driver, "ordenar_por_precio")
  rescue Selenium::WebDriver::Error::NoSuchElementError
    puts "No se encontró la opción de ordenamiento."
    take_screenshot(driver, "error_ordenar")
  end

  begin
    wait = Selenium::WebDriver::Wait.new(timeout: 10)
  
    puts "\n**Lista de productos con precios:**"
  
    first_product_xpath = "(//android.widget.RelativeLayout[@resource-id='com.mercadolibre:id/search_cell_core_list'])[1]"
    
    first_title = wait.until { driver.find_element(:xpath, "#{first_product_xpath}//android.widget.TextView[@resource-id='com.mercadolibre:id/search_cell_title_text_view']") }.text
    first_price = wait.until { driver.find_element(:id, "com.mercadolibre:id/search_cell_pds_qty_price_view") }.text
  
    puts "1. #{first_title} - Precio: #{first_price}"
  
    all_prices = wait.until { driver.find_elements(:id, "com.mercadolibre:id/money_amount_text") }
    titles = wait.until { driver.find_elements(:id, "com.mercadolibre:id/search_cell_title_text_view") }
  

    real_prices = all_prices[1..-1]

    (2..3).each do |i|
      product_xpath = "(//android.widget.RelativeLayout[@resource-id='com.mercadolibre:id/search_cell_core_list'])[#{i}]"
  
      title = wait.until { driver.find_element(:xpath, "#{product_xpath}//android.widget.TextView[@resource-id='com.mercadolibre:id/search_cell_title_text_view']") }.text
      price = real_prices[i - 2].text 
  
      puts "#{i}. #{title} - Precio: #{price}"
    end
  
   
    driver.execute_script('mobile: scrollGesture', {
      left: 500,
      top: 1200,
      width: 500,
      height: 500,
      direction: 'down',
      percent: 2.0
    })
    sleep 0.3
  
   
    all_prices = wait.until { driver.find_elements(:id, "com.mercadolibre:id/money_amount_text") }
    real_prices = all_prices[1..-1] 
  
    (4..5).each do |i|
      product_xpath = "(//android.widget.RelativeLayout[@resource-id='com.mercadolibre:id/search_cell_core_list'])[#{i}]"
  
      title = wait.until { driver.find_element(:xpath, "#{product_xpath}//android.widget.TextView[@resource-id='com.mercadolibre:id/search_cell_title_text_view']") }.text
      price = real_prices[i - 2].text 
  
      puts "#{i}. #{title} - Precio: #{price}"
    end
  rescue Selenium::WebDriver::Error::NoSuchElementError
    puts "No se encontraron productos o precios."
  end
  
  
rescue => e
  puts "Error inesperado: #{e.message}"
  take_screenshot(driver, "error_general")
ensure
  driver.quit rescue nil
end

screenshots = Dir.glob("screenshots/*.png").sort

html_template = <<-HTML
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reporte de Pruebas</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; }
        h1 { color: #333; }
        .screenshot { margin-bottom: 20px; }
        img { width: 50%; border: 1px solid #ddd; padding: 5px; border-radius: 5px; }
    </style>
</head>
<body>
    <h1>📊 Reporte de Pruebas de Appium</h1>
    <% screenshots.each do |screenshot| %>
        <div class="screenshot">
            <h3><%= File.basename(screenshot, ".png").gsub("_", " ") %></h3>
            <img src="<%= screenshot %>" alt="<%= screenshot %>">
        </div>
    <% end %>
</body>
</html>
HTML

File.open("reporte_pruebas.html", "w") do |file|
  file.puts ERB.new(html_template).result(binding)
end

puts "Reporte generado: reporte_pruebas.html"
