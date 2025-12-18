# 💡 Ideapp

## App destinada a prueba técnica de **Digiral Arena SAS**

> Generá ideas random con IA, elegí una y convertí el caos mental en objetivos claros.

---

## 🚀 ¿Qué es Ideapp?

**Ideapp** es una app mobile construida en **Flutter** que usa **Inteligencia Artificial** para generar ideas aleatorias.  
Vos elegís la que te vibra y la transformás en un objetivo concreto, tipo TODO.

Pensada para:
- Desbloquear creatividad
- Definir objetivos claros
- Dejar de procrastinar con estilo


Así se ve **Ideapp** en acción:

<p align="center">
  <img src="assets/demo.gif" width="300" alt="Ideapp demo" />
</p>
---

## ✨ Features principales

- **Generación de ideas con IA**
- **Sistema de objetivos tipo TODO**
- Marcar ideas como **completas / incompletas**
- Eliminar ideas desde menú contextual
- Persistencia local
- Arquitectura limpia y escalable

---

## 🏗️ Arquitectura

La app está desarrollada siguiendo:

- **Clean Architecture**
- **Feature-first approach**
- **BLoC / Cubit** para manejo de estado
- **Repository pattern**
- Dominio desacoplado de UI y data

---

## 🛠️ Tecnologías usadas

- **Flutter**
- **Dart**
- **IA vía API**
- **flutter_bloc**
- **Hive**
- **GoRouter**
- Clean Architecture

---

## 📱 Flujo de la app

1. Generás ideas random con IA  
2. Explorás las opciones  
3. Elegís una idea  
4. Se convierte en objetivo  
5. La completás o eliminás  

---

## 📦 Estado del proyecto

🟢 En desarrollo activo  
🔜 Mejoras UI/UX  
🔜 Más personalización  
🔜 Sincronización futura

---

## 👨‍💻 Autor

**Alan Rosales**  
Frontend / Flutter Dev  

---

## ⭐ ¿Te gustó?

Dejá una ⭐, cloná el repo o usalo como base.  
Las ideas quieren salir a caminar.

---

## ▶️ Cómo correr el proyecto

### 📋 Requisitos

- 🐦 Flutter (canal stable)
- 🧰 Android Studio o VS Code
- 📱 Emulador o dispositivo físico
- 🔐 API Key (si usás generación de ideas con IA)

### Verificá que Flutter esté bien instalado:
```bash
flutter doctor
```

## 📥 Clonar el repositorio

```bash
git clone https://github.com/tu-usuario/ideapp.git
cd ideapp
```

## 📦 Instalar dependencias

```bash
flutter pub get
```

## 🔑 Variables de entorno

Si usás IA, creá un archivo .env en la raíz del proyecto:
```bash
API_KEY=tu_api_key_acá
```

## 🚀 Ejecutar la app

```bash
flutter run
```
