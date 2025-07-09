
# Automatización de Pruebas con Appium en Mercado Libre (Ruby + Appium)

Este repositorio contiene un script en Ruby para automatizar pruebas en la aplicación **Mercado Libre** (Android) usando **Appium**, **Selenium-WebDriver** y **UiAutomator2**.  
El flujo realiza:

1. Búsqueda de **“Playstation 5”**  
2. Aplicación de filtros y orden “Mayor precio”  
3. Captura de nombre y precio de los primeros productos  
4. Generación de un **reporte HTML** con capturas de pantalla

---

## Estructura del repositorio

| Carpeta / Archivo          | Descripción                                                                    |
|----------------------------|--------------------------------------------------------------------------------|
| `screenshots/`             | Capturas de pantalla tomadas durante la prueba                                 |
| `Gemfile` / `Gemfile.lock` | Dependencias Ruby del proyecto                                                 |
| `test_mercadolibre.rb`     | Script principal de la prueba                                                  |
| `reporte_pruebas.html`     | Reporte generado tras la ejecución                                             |

---

## 1. Prerrequisitos

### 1.1. Instalar Node.js + Appium

```bash
npm install -g appium
npm install -g appium-doctor
appium-doctor      # comprueba dependencias
```

### 1.2. Instalar **UiAutomator2** (driver Android para Appium)

```bash
appium driver install uiautomator2
appium driver list --installed   # verifica que aparezca uiautomator2
```

### 1.3. Instalar Ruby + Bundler

1. Descarga de <https://rubyinstaller.org>  
2. Durante la instalación marca **“Add Ruby executables to your PATH”**
3. Verifica:

```bash
ruby -v
gem -v
```

4. Instala dependencias del proyecto:

```bash
gem install bundler
bundle install      # estando en la carpeta que contiene el Gemfile
```

### 1.4. Instalar Android SDK + ADB

1. Descarga **Platform Tools**: <https://developer.android.com/studio/releases/platform-tools>  
2. Extrae en una ubicación fija. Ejemplo:

```
F:\Escuela\Android\Sdk
```

3. **Variables de entorno**  
   - Crea `ANDROID_HOME` (o `ANDROID_SDK_ROOT`) = `F:\Escuela\Android\Sdk`  
   - Edita `Path` y agrega:

     ```
     %ANDROID_HOME%\platform-tools
     %ANDROID_HOME%\tools   # (si existe)
     ```

4. Reinicia la terminal y verifica:

```bash
echo %ANDROID_HOME%
adb devices
```

---

## 2. Configurar el dispositivo Android

| Paso | Acción |
|------|--------|
| 1 | Activa **Opciones de desarrollador** (toca 7 × “Número de compilación”) |
| 2 | Habilita **Depuración USB** y (si existe) **Depuración USB (seguridad)** / **Instalar vía USB** |
| 3 | Conecta el teléfono con **cable de datos** y selecciona **Transferencia de archivos (MTP)** |
| 4 | Acepta el aviso “¿Permitir depuración USB desde este ordenador?” |

Comprueba conexión:

```bash
adb devices
# Debe listar tu dispositivo como "device"
```

---

## 3. Iniciar Appium Server

En una terminal independiente:

```bash
appium
```

Salida esperada:

```
[Appium] Appium REST http interface listener started on 0.0.0.0:4723
```

---

## 4. Ejecutar la prueba

En otra terminal, dentro de la carpeta del proyecto:

```bash
ruby test_mercadolibre.rb
```

Al finalizar encontrarás `reporte_pruebas.html` y capturas en `screenshots/`.

---

## 5. Flujo detallado de la prueba

1. Abre la app de Mercado Libre  
2. Omitir bienvenida  
3. Buscar “Playstation 5”  
4. Aplicar filtros definidos en el script  
5. Ordenar resultados por **“Mayor precio”**  
6. Capturar nombre y precio de los primeros productos  
7. Guardar capturas y generar reporte

---

## 6. Solución de problemas frecuentes

| Error | Causa | Solución |
|-------|-------|----------|
| `Could not locate Gemfile` | Ejecución en carpeta equivocada | Ve a la carpeta donde está el `Gemfile` |
| `uiautomator2 driver… not installed` | Falta driver Android | `appium driver install uiautomator2` |
| `Neither ANDROID_HOME nor ANDROID_SDK_ROOT…` | Variable de entorno no definida | Crear `ANDROID_HOME` apuntando al SDK y agregar `platform-tools` al `Path` |
| `ECONNREFUSED 127.0.0.1:4723` | Appium Server no iniciado | Ejecuta `appium` antes de correr el script |
| `adb no se reconoce…` | ADB fuera del `Path` | Instalar platform‑tools y agregar al `Path` |
| Dispositivo no aparece con `adb devices` | Sin depuración USB / drivers | Activar Depuración USB, aceptar huella RSA, reinstalar drivers |

---

## 7. Ajustes rápidos de capabilities

Las “desired capabilities” se encuentran en `test_mercadolibre.rb`:

```ruby
caps = {
  platformName:  'Android',
  automationName:'UiAutomator2',
  deviceName:    'Android Device',   # usa el ID mostrado por adb devices
  appPackage:    'com.mercadolibre.android',
  appActivity:   '.app.MainActivity',
  noReset:       true
}
```

---

¡Listo! Con esta guía completa podrás clonar, configurar y ejecutar la automatización sin inconvenientes.
