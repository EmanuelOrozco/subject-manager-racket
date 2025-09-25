#lang racket

;Lista de datos para ingreso, ojo se asocia la materia
(define profesores
  (list
   (list 1 "pass1" "Programación")
   (list 2 "pass2" "Bases de Datos")
   (list 3 "pass3" #f))) ;; #f indica que no tiene materia asignada

;Lista de datos para ingreso, ojo se asocia la materia
(define coordinadores
  (list
   (list 1 "samu" "Programación")
   (list 2 "juangui" "Bases de Datos")
   (list 3 "emma" #f))) ;; #f indica que no tiene materia asignada

; Lista de Materias con sus estudiantes y notas
(define materias
  (list
   (list "Programación" '())
   (list "Bases de Datos" '())))

;Acá se busca el profe con contraseña
(define (buscar-profesor codigo clave)
  (define encontrado
    (filter (lambda (p)
              (and (= (first p) codigo)
                   (string=? (second p) clave)))
            profesores))
  (if (null? encontrado)
      #f
      (first encontrado)))

;Acá se busca el cordi con contraseña
(define (buscar-coordinador codigo clave)
  (define encontrado
    (filter (lambda (p)
              (and (= (first p) codigo)
                   (string=? (second p) clave)))
            coordinadores))
  (if (null? encontrado)
      #f
      (first encontrado)))

;Se busca materia por nombre
(define (buscar-materia nombre)
  (define encontrado
    (filter (lambda (m) (string=? (first m) nombre)) materias))
  (if (null? encontrado)
      #f
      (first encontrado)))

;Agregar el estu
(define (agregar-estudiante materia nombre-estudiante)
  (define m (buscar-materia materia))
  (if m
      (set! materias
            (map (lambda (mat)
                   (if (string=? (first mat) materia)
                       (list (first mat)
                             (cons (list nombre-estudiante 0) (second mat)))
                       mat))
                 materias))
      (printf "La materia no existe\n")))

;Eliminar estu
(define (eliminar-estudiante materia nombre-estudiante)
  (define m (buscar-materia materia))
  (if m
      (set! materias
            (map (lambda (mat)
                   (if (string=? (first mat) materia)
                       (list (first mat)
                             (filter (lambda (e)
                                       (not (string=? (first e) nombre-estudiante)))
                                     (second mat)))
                       mat))
                 materias))
      (printf "La materia no existe\n")))

;Insert/update de materia
(define (actualizar-nota materia nombre-estudiante nota)
  (if (and (>= nota 0) (<= nota 5))
      (set! materias
            (map (lambda (mat)
                   (if (string=? (first mat) materia)
                       (list (first mat)
                             (map (lambda (e)
                                    (if (string=? (first e) nombre-estudiante)
                                        (list (first e) nota)
                                        e))
                                  (second mat)))
                       mat))
                 materias))
      (printf "Error: La nota debe estar entre 0 y 5\n")))


;Lista de estudiantes con la nota que fue asignada seguramente sacan 0
(define (mostrar-estudiantes materia)
  (define m (buscar-materia materia))
  (if m
      (begin
        (printf "Estudiantes en ~a:\n" materia)
        (for-each (lambda (e)
                    (printf "- ~a: ~a\n" (first e) (second e)))
                  (second m)))
      (printf "La materia no existe\n")))


;Opcional, el promedio de notas de una materia
(define (promedio-materia materia)
  (define m (buscar-materia materia))
  (if (and m (not (null? (second m))))
      (let* ((notas (map second (second m)))
             (suma (apply + notas))
             (prom (/ suma (length notas))))
        (printf "El promedio de ~a es: ~a\n" materia prom))
      (printf "No hay estudiantes en la materia o no existe\n")))

;Se define el menú grande para las materias coordinadores
(define (menu-coordinador-materia materia)
  (let loop ()
    (printf "\n--- Menú de ~a ---\n" materia)
    (printf "1. Agregar estudiante\n");c
    (printf "2. Eliminar estudiante\n");c
    (printf "3. Mostrar estudiantes\n");a
    (printf "4. Mostrar promedio\n");a
    (printf "5. Volver al menú principal\n");a
    (printf "Seleccione una opción: ")
    (define opcion (string->number (read-line)))
    (cond
      [(= opcion 1)
       (printf "Nombre del estudiante: ")
       (define nombre (read-line))
       (agregar-estudiante materia nombre)
       (loop)]
      [(= opcion 2)
       (printf "Nombre del estudiante a eliminar: ")
       (define nombre (read-line))
       (eliminar-estudiante materia nombre)
       (loop)]
      [(= opcion 3)
       (mostrar-estudiantes materia)
       (loop)]
      [(= opcion 4)
       (promedio-materia materia)
       (loop)]
      [(= opcion 5)
       (printf "Volviendo al menú principal...\n")]
      (main-menu)
      [else
       (printf "Opción inválida\n")
       (loop)])))

;Se define el menú grande para las materias profesor
(define (menu-profesor-materia materia)
  (let loop ()
    (printf "\n--- Menú de ~a ---\n" materia)
    (printf "1. Ingresar/Actualizar nota\n");p
    (printf "2. Mostrar estudiantes\n");a
    (printf "3. Mostrar promedio\n");a
    (printf "4. Volver al menú principal\n");a
    (printf "Seleccione una opción: ")
    (define opcion (string->number (read-line)))
    (cond
      [(= opcion 1)
       (printf "Nombre del estudiante: ")
       (define nombre (read-line))
       (printf "Nota (0 a 5): ")
       (define nota (string->number (read-line)))
       (actualizar-nota materia nombre nota)
       (loop)]
      [(= opcion 2)
       (mostrar-estudiantes materia)
       (loop)]
      [(= opcion 3)
       (promedio-materia materia)
       (loop)]
      [(= opcion 4)
       (printf "Volviendo al menú principal...\n")]
      (main-menu)
      [else
       (printf "Opción inválida\n")
       (loop)])))


;Se define el menú principal
(define (main-menu)
  (let loop ()
    (printf "\n--- Menú del sistema ---\n")
    (printf "1. Ingresar como coordinador\n")
    (printf "2. Ingresar como profesor\n")
    (printf "3. Salir del sistema\n")
    (printf "Seleccione una opción: ")
    (define opcion (string->number (read-line)))
    (cond
      [(= opcion 1)
       (printf "Ingrese su código de coordinador: ")
       (define codigo (string->number (read-line)))
       (printf "Ingrese su contraseña: ")
       (define clave (read-line))
       (define coordinador (buscar-coordinador codigo clave))
       (if coordinador
           (let ((materia (third coordinador)))
             (if materia
                 (menu-coordinador-materia materia)
            (printf "Error: No tiene materia asignada\n")))
           (printf "Credenciales inválidas\n"))
       (loop)]
      [(= opcion 2)
       (printf "Ingrese su código de profesor: ")
       (define codigo (string->number (read-line)))
       (printf "Ingrese su contraseña: ")
       (define clave (read-line))
       (define profesor (buscar-profesor codigo clave))
       (if profesor
           (let ((materia (third profesor)))
             (if materia
                 (menu-profesor-materia materia)
            (printf "Error: No tiene materia asignada\n")))
           (printf "Credenciales inválidas\n"))
       (loop)]
      [(= opcion 3)
       (printf "Chao ps...\n")]
      [else
       (printf "Opción inválida\n")
       (loop)])))
(main-menu)