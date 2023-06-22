.MODEL SMALL 
.RADIX 16
.STACK ;; PILA

.DATA ;; Variables | Memoria Ram | segemento de datos
encabezado db "Universidad de San Carlos de Guatemala", 0a
    db "Facultad de Ingenieria", 0a
    db "Escuela de vacaciones", 0a
    db "Arquitectura de Computadoras y Ensambladores 1", 0a, 0a, 0a
    db "Nombre: Ruben", 0a
    db "Carnet: 202111835", 0a, "$"
;;
saltos db 0a, 0a, "$"
credenciales db '[credenciales]usuario="rmejia"clave="202111835"', "$"
mensaje_correcto db "Credenciales correctas, presiona ENTER", 0a, "$"
;;
nombre_credenciales db "PRAII.CON", 00
handle_prods dw   0000
error db "El archivo no existe", 0a, "$"
mensaje_salida db "Ejecucion terminada", "$"
;;
mensaje_menu_principal db "-----------Menu principal------------", 0A 
    db  "(P)roductos", 0a
    db  "(V)entas", 0a
    db  "(H)erramientas",0a
    db  "(S)alir", 0a,"$"
;;
mensaje_menu_productos db "-----------Menu Productos------------", 0A 
    db "(I)ngreso de productos", 0A
    db "(E)liminacion de productos", 0A
    db "(V)isualizacion de productos", 0A
    db "(R)egresar", 0A, "$"
;;
mensaje_menu_herra db "-----------Menu Herramientas------------", 0A 
    db "(G)eneracion de catalogo completo", 0a
    db  "(A)reporte alfabetico de productos", 0A
    db  "(V)reporte de ventas", 0A
    db  "(S)reporte de productos sin existencias", 0A
    db  "(R)egresar", 0a, "$"
;;
mensaje_menu_ventas db "-----------Ventas------------", 0A, "$"
;;
prompt     db    "Elija una opcion:",0a,"$"
prompt_code      db    "Codigo: ","$"
prompt_name      db    "Nombre: ","$"
prompt_price     db    "Precio: ","$"
prompt_units     db    "Unidades: ","$"
caracter_leido    db   00, "$"

.CODE ; segemento de codigo
.STARTUP
    mov DX, offset encabezado
    mov AH, 09
    int 21 ; imprimir encabezado
; ------------------------------Login----------------------------------------
acceso: ; abrir archivo
    mov AH, 3D
    mov AL, 02
    mov DX, offset nombre_credenciales
    int 21 ; abrir archivo
    JC sin_acceso ; si hay error, no existe y salta hasta el final
    mov [handle_prods], AX ; guardamos el handle
    mov SI, offset credenciales ; puntero al primer caracter de credenciales

ciclo_comprobar_credenciales: ; comprueba las credenciales
    mov BX, [handle_prods]
    mov CX, 0001 ; leer 1 byte
    mov DX, offset caracter_leido
    mov AH, 3f
    int 21 ; leer archivo
    cmp AX, 00 ; si se leyeron 0 bytes entonces se terminó el archivo
    je caracteres_faltantes
    
    ; verificar si es el caracter correcto
    mov AL, [SI]
    mov BL, [caracter_leido]
    cmp AL, BL
    jne quitar_saltos ; si no son iguales se verifica si son saltos...
    ; mov DX, offset caracter_leido
    ; mov AH, 09
    ; int 21
    inc SI ; muevo el puntero al siguiente caracter
    jmp ciclo_comprobar_credenciales

quitar_saltos: ;comprueba si es salto, espacio, inicio de linea etc
    cmp BL, 08
    je ciclo_comprobar_credenciales
    cmp BL, 0D
    je ciclo_comprobar_credenciales
    cmp BL, 0B
    je ciclo_comprobar_credenciales
    cmp BL, 0A
    je ciclo_comprobar_credenciales
    cmp BL, 20
    je ciclo_comprobar_credenciales
    jmp fin

caracteres_faltantes: ; verifica si llego al final de la cadena
    mov AL, [SI]
    cmp AL, 24 ; si es dolar llego al fin de cadena
    jne fin

esperando_enter:
    mov DX, offset mensaje_correcto
    mov AH, 09
    int 21
    ;;
    mov AH, 08
    int 21 ; AL = CARACTER LEIDO
    cmp AL, 0D ; ENTER ascii
    je menu_principal
    jmp esperando_enter

; ---------------------------Menus-----------------------------------------
menu_principal:
    mov DX, offset mensaje_menu_principal
    mov AH, 09
    int 21 ; imprimir menu
    ; leer caracter
    mov AH, 08
    int 21 ; AL = CARACTER LEIDO
    cmp AL, 70 ; p minúscula ascii
    je menu_productos
    cmp AL, 76 ; v minúscula ascii
    je menu_ventas 
    cmp AL, 68 ; h minúscula ascii
    je menu_herramientas
    cmp AL, 73 ; s minúscula ascii
    je fin
    jmp menu_principal
menu_productos:
    mov DX, offset saltos
    mov AH, 09
    int 21 ; imprimir saltos
    mov DX, offset mensaje_menu_productos
    mov AH, 09
    int 21 ; imprimir menu
    ; leer caracter
    mov AH, 08
    int 21 ; AL = CARACTER LEIDO
    cmp AL, 69 ; i minúscula ascii
    je ingreso_producto
    cmp AL, 65 ; e minúscula ascii
    je eliminar_producto 
    cmp AL, 76 ; v minúscula ascii
    je mostrar_productos 
    cmp AL, 72 ; r minúscula ascii
    je menu_principal
    jmp menu_productos
menu_ventas:
    mov DX, offset saltos
    mov AH, 09
    int 21 ; imprimir saltos
    mov DX, offset mensaje_menu_ventas
    mov AH, 09
    int 21 ; imprimir menu
    jmp fin
menu_herramientas:
    mov DX, offset saltos
    mov AH, 09
    int 21 ; imprimir saltos
    mov DX, offset mensaje_menu_herra
    mov AH, 09
    int 21 ; imprimir menu
    ; leer caracter
    mov AH, 08
    int 21 ; AL = CARACTER LEIDO
    cmp AL, 67 ; g minúscula ascii
    je catalogo_completo
    cmp AL, 61 ; a minúscula ascii
    je productos_alfabeticos 
    cmp AL, 76 ; v minúscula ascii
    je reporte_ventas
    cmp AL, 73 ; s minúscula ascii
    je productos_sin_existencia 
    cmp AL, 72 ; r minúscula ascii
    je menu_principal
    jmp menu_herramientas
    
; ----------------------Menu productos-------------------------------------
ingreso_producto:
eliminar_producto:
mostrar_productos:
    jmp fin
; ----------------------Ventas----------------------------------------------

; ----------------------Menu herramientas------------------------------------
catalogo_completo:
productos_alfabeticos:
reporte_ventas:
productos_sin_existencia:
    jmp fin
; -----------------------------------------------------
imprimir_estructura:
	mov DI, offset caracter_leido
ciclo_poner_dolar_1:
    mov AL, [DI]
    cmp AL, 00
    int 3
    je poner_dolar_1
    inc DI
    jmp ciclo_poner_dolar_1
poner_dolar_1:
    mov AL, 24  ;; dólar
    mov [DI], AL
    ;; imprimir normal
    mov DX, offset caracter_leido
    mov AH, 09
    int 21
    ret
; --------------------Finalizacion------------------------------------------
sin_acceso:
    mov DX, offset error
    mov AH, 09
    int 21
fin:
    mov DX, offset mensaje_salida
    mov AH, 09
    int 21
.EXIT
END