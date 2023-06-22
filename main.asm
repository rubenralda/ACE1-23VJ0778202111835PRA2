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
credenciales db '[credenciales]usuario="rmejia"clave="202111835"', 0a,"$"
;;
nombre_credenciales db "PRAII.CON", 00
handle_prods dw   0000, "$"
error db "El archivo no existe", 0a, "$"
mensaje_salida db "Ejecucion terminada", "$"
mensajito db "Funcionando", "$"
;;
productos  db    "(P)roductos",0a,"$"
ventas     db    "(V)entas",0a,"$"
herramientas db  "(H)erramientas",0a,"$"
;;
titulo_producto db  "PRODUCTOS",0a,"$"
sub_prod        db  "=========",0a,"$"
titulo_ventas   db  "VENTAS",0a,"$"
sub_vent        db  "======",0a,"$"
titulo_herras   db  "HERRAMIENTAS",0a,"$"
sub_herr        db  "============",0a,"$"
prompt     db    "Elija una opcion:",0a,"$"
prompt_code      db    "Codigo: ","$"
prompt_name      db    "Nombre: ","$"
prompt_price     db    "Precio: ","$"
prompt_units     db    "Unidades: ","$"
caracter_leido    db   00

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
    ; abrir archivo
    mov AH, 3D
    mov AL, 02
    mov DX, offset nombre_credenciales
    int 21
    JC sin_acceso ; si hay error, no existe y salta al final
    mov [handle_prods], AX ; guardamos el handle
    ; comprobamos las credenciales
    mov SI, offset credenciales
ciclo_mostrar:
    mov BX, [handle_prods]
    mov CX, 0001 ;; leer 1 byte
    mov DX, offset caracter_leido
    mov AH, 3f
    int 21
    cmp AX, 00 ;; si se leyeron 0 bytes entonces se terminó el archivo...
    je menu_principal
    mov AL, [SI]
    mov BL, [caracter_leido]
    cmp AL, BL
    jne quitar_saltos
    inc SI
    ;; mostrar los datos
    call imprimir_estructura
    ;;
    jmp ciclo_mostrar
menu_principal:
            ; encabezado productos
            mov DX, offset productos
            mov AH, 09
            int 21
            mov DX, offset ventas
            mov AH, 09
            int 21
            mov DX, offset herramientas
            mov AH, 09
            int 21
            ; fin encabezado productos
            ; leer caracter
            mov AH, 08
            int 21
            ;; AL = CARACTER LEIDO
            cmp AL, 70 ;; p minúscula ascii
            je menu_productos
            cmp AL, 76 ;; v minúscula ascii
            je menu_ventas 
            cmp AL, 68 ;; h minúscula ascii
            je menu_herramientas 
            jmp menu_principal
menu_productos:
menu_ventas: 
menu_herramientas:
            jmp fin
; -----------------------------------------------------------
imprimir_estructura:
	mov DI, offset caracter_leido
ciclo_poner_dolar_1:
    mov AL, [DI]
    cmp AL, 00
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
quitar_saltos:
    int 3
    cmp BL, 08
    je ciclo_mostrar
    cmp BL, 0D
    je ciclo_mostrar
    cmp BL, 0B
    je ciclo_mostrar
    cmp BL, 0A
    je ciclo_mostrar
    cmp BL, 20
    je ciclo_mostrar
    jmp fin
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