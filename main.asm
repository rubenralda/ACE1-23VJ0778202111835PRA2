.MODEL SMALL 
.RADIX 16
.STACK ;; PILA

.DATA ;; Variables | Memoria Ram
usac db "Universidad de San Carlos de Guatemala", 0a, "$"
facultad db "Facultad de Ingenieria", 0a, "$"
escuela db "Escuela de vacaciones", 0a, "$"
curso db "Arquitectura de Computadoras y Ensambladores 1", 0a, "$"
saltos db 0a, 0a, "$"
nombre db "Nombre: Ruben", 0a, "$"
carnet db "Carnet: 202111835", 0a, "$"
;;

.CODE
.STARTUP ;; Codigo
            ;;Inicio encabezado
            mov DX, offset usac
            mov AH, 09
            int 21
            mov DX, offset facultad
            mov AH, 09
            int 21
            mov DX, offset escuela
            mov AH, 09
            int 21
            mov DX, offset curso
            mov AH, 09
            int 21
            mov DX, offset saltos
            mov AH, 09
            int 21
            mov DX, offset nombre
            mov AH, 09
            int 21
            mov DX, offset carnet
            mov AH, 09
            int 21
            ;;Fin encabezado
acceso:
manu_productos:
menu_ventas:
menu_herramientas:
fin:
.EXIT
END