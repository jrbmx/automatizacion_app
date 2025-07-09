
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
   ```

2. **Instalar Appium Doctor (para verificar dependencias)**
   ```bash
   npm install -g appium-doctor
   appium-doctor
   ```

3. **Instalar Ruby**
   - Descarga e instala desde [https://rubyinstaller.org](https://rubyinstaller.org/)
   - Durante la instalación, asegúrate de seleccionar la opción **“Add Ruby executables to your PATH”**

4. **Verificar instalación**
   - Abre una terminal y ejecuta:
     ```bash
     ruby -v
     gem -v
     ```

5. **Instalar dependencias Ruby (desde la carpeta del proyecto)**
   ```bash
   gem install bundler
   bundle install
   ```

6. **Instalar ADB (Android Debug Bridge)**

   Para que Appium pueda comunicarse con el dispositivo Android:

   - Descargar desde: [https://developer.android.com/studio/releases/platform-tools](https://developer.android.com/studio/releases/platform-tools)
   - Extraer y mover la carpeta a una ubicación como: `C:\Android\platform-tools`
   - Agregar esa carpeta al PATH del sistema:
     - Ir a `Panel de Control > Sistema > Configuración avanzada del sistema > Variables de entorno`
     - Editar la variable `Path` y agregar: `C:\Android\platform-tools`
   - Verificar ejecución:
     ```bash
     adb devices
     ```

### Configuración del dispositivo Android

1. **Activar Opciones de Desarrollador**
   - Ajustes > Acerca del teléfono > Tocar 7 veces en "Número de compilación"

2. **Habilitar Depuración USB**
   - Ajustes > Sistema > Opciones de desarrollador > Activar:
     - "Depuración USB"
     - "Instalar vía USB" (si está disponible)
     - "Depuración USB (seguridad)" (si aplica)

3. **Conexión física**
   - Conectar el dispositivo al PC con un cable USB **de datos**
   - En el teléfono, seleccionar el modo **Transferencia de archivos (MTP)** en lugar de "MIDI" o "Carga"
   - Aceptar el mensaje de confianza si aparece

4. **Verificar conexión**
   ```bash
   adb devices
   ```

   Si no aparece nada, ejecutar:
   ```bash
   adb kill-server
   adb start-server
   adb devices
   ```

---

## Configurar Appium Server

Ejecutar el siguiente comando para iniciar el servidor de Appium:

```bash
appium
```

---

## Ejecución de la Prueba

Dentro de la carpeta raíz del proyecto, ejecuta:

```bash
ruby test_mercadolibre.rb
```

Este comando iniciará la app de Mercado Libre en el dispositivo Android, ejecutará la prueba automatizada y generará un reporte HTML con capturas de pantalla.

---

## Flujo de la Prueba

1. Abrir la app de Mercado Libre
2. Omitir pantalla de bienvenida
3. Buscar "Playstation 5"
4. Aplicar filtros
5. Ordenar por "Mayor precio"
6. Extraer nombre y precio de productos
7. Tomar capturas de pantalla en cada paso
8. Generar reporte en HTML

---

## Reporte de Pruebas

Al finalizar, se generará el archivo `reporte_pruebas.html`. Puedes abrirlo con doble clic o desde un navegador.

---

## Posibles Errores y Soluciones

1. **NoSuchElementError:**  
   Verifica si la interfaz de la app cambió. Usa UI Automator Viewer para ajustar los XPaths o IDs.

2. **Appium Server no se ejecuta:**  
   Asegúrate de iniciar Appium con el comando:
   ```bash
   appium
   ```

3. **Dispositivo no detectado:**  
   Asegúrate de:
   - Tener activada la depuración USB
   - Estar en modo MTP
   - Aceptar el cuadro de confianza
   - Ejecutar:
     ```bash
     adb devices
     ```

4. **Nombre del dispositivo incorrecto:**  
   Usa:
   ```bash
   adb shell
   ```
   Si no se conecta, verifica drivers, permisos o cambia el cable USB.


   
