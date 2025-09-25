# 📚 Sistema de Gestión Académica en Racket

Este proyecto implementa un sistema académico básico en **Racket** que permite a **profesores** y **coordinadores** gestionar estudiantes y notas en distintas materias.

## 🚀 Funcionalidades principales

### 👨‍🏫 Para Profesores
- Ingresar o actualizar notas de estudiantes.
- Visualizar la lista de estudiantes con sus notas.
- Calcular el promedio de notas de su materia.

### 🧑‍💼 Para Coordinadores
- Agregar estudiantes a una materia.
- Eliminar estudiantes de una materia.
- Mostrar la lista de estudiantes.
- Calcular el promedio de notas de la materia.

### 🔑 Sistema de Login
- Profesores y coordinadores ingresan con **código y contraseña**.
- Cada usuario está asociado a una materia específica.  
- Si un profesor o coordinador no tiene materia asignada, no puede acceder a los menús de gestión.

---

## 📂 Estructura de Datos

- **Profesores** y **coordinadores** se representan como listas con la forma:  
  ```racket
  (list codigo contraseña materia)

