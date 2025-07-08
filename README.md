# Automatización de Pruebas con Appium en Mercado Libre

Este repositorio contiene un script en Ruby para automatizar pruebas en la aplicación móvil de Mercado Libre utilizando Appium y Selenium WebDriver. El objetivo es realizar una búsqueda de "Playstation 5", aplicar filtros, ordenar por precio y extraer los nombres y precios de los primeros productos listados.

## Contenido del Repositorio

- **screenshots/**: Carpeta donde se guardan las capturas de pantalla tomadas durante la ejecución de la prueba.
- **Gemfile**: Lista de dependencias necesarias para el proyecto.
- **Gemfile.lock**: Archivo generado automáticamente con las versiones exactas de las dependencias.
- **reporte_pruebas.html**: Reporte en formato HTML con capturas de pantalla de cada paso.
- **test_mercadolibre.rb**: Script de prueba principal en Ruby con Appium.

## Configuración e Instalación

### Requisitos Previos

1. **Instalar Appium**
   ```bash
   npm install -g appium
   
2. **Instalar Appium Doctor (para verificar dependencias)**
    ```bash
    npm install -g appium-doctor
    appium-doctor

3. **Instalar Ruby**
   - Descarga e instala desde [https://rubyinstaller.org](https://rubyinstaller.org/)
   - Durante la instalación, asegúrate de seleccionar la opción **“Add Ruby executables to your PATH”**

4. **Verificar instalación**
   - Abre una terminal y ejecuta:
     ```bash
     ruby -v
     gem -v
     ```

   - Si ves las versiones, Ruby está correctamente instalado.
    
5. **Instalar dependencias Ruby (Desde laa ruta donde tienes clonado el proyecto)**
    ```bash
    gem install bundler
    bundle install

## Configurar Appium Server
Ejecutar el siguiente comando para iniciar el servidor de Appium:

     appium

**Ejecución de la Prueba**

Para ejecutar el script, simplemente corre el siguiente comando en la terminal dentro del repositorio:

    ruby test_mercadolibre.rb

Este comando iniciará la aplicación de Mercado Libre en un dispositivo Android, ejecutará la prueba automatizada y generará un reporte con capturas de pantalla.

## Flujo de la Prueba
1. **Abrir la app de Mercado Libre.**
2. **Omitir la pantalla de bienvenida si aparece.**
3. **Buscar "Playstation 5".**
4. **Aplicar filtros.**
5. **Ordenar por "Mayor precio".**
6. **Extraer los nombres y precios de los primeros productos listados.**
7. **Tomar capturas de pantalla en cada paso.**
8. **Generar un reporte en HTML con las capturas y resultados**

## Reporte de Pruebas
Al finalizar la prueba, se generará un archivo **reporte_pruebas.html**, donde podrás visualizar todas las capturas de pantalla tomadas durante la ejecución. Para abrirlo, solo basta con hacer doble clic sobre el archivo en tu explorador de archivos o abrirlo en un navegador web.

## Posibles Errores y Soluciones

1. **Error: NoSuchElementError:**
        Puede ocurrir si la interfaz de la app ha cambiado. Verifica los identificadores de elementos (ID o XPath) en UI Automator Viewer.

2. **Error: Appium Server no se ejecuta:**
    Asegúrate de que el servidor de Appium está corriendo con:

        appium

3. **Error: Dispositivo no detectado:**
    Verifica que el dispositivo está conectado y el modo Depuración USB está habilitado.
    Usa el comando:

       adb devices
4. **Error: Nombre del dispositivo incorrecto:**
    Verifica que el nombre del dispositivo que está conectado sea el correcto.
    Usa el comando para visualizar el name del dispositivo, despues de verificar que si esta conectado y en modo Depuración USB:

       adb shell
