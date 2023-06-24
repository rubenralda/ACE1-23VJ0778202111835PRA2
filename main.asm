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
mensaje_menu_ventas db "-----------Ventas------------", "$"
;;
saltos db 0a, 0a, "$"
credenciales db '[credenciales]usuario="rmejia"clave="202111835"', "$"
mensaje_correcto db "Credenciales correctas, presiona ENTER", 0a, "$"
;;
nombre_credenciales db "PRAII.CON", 00
handle_crede dw 0000
error db 0A,"El archivo no existe", "$"
no_existe db 0A,"El producto no fue encontrado", "$"
mensaje_salida db 0a,"Ejecucion terminada", "$"
mensaje_borrado db "Producto eliminado", "$"
nueva_lin db 0A, "$"
;;
prompt     db    "Elija una opcion:",0a,"$"
prompt_code      db    0a, "Codigo: ","$"
prompt_desc      db    0a, "Descripcion: ","$"
prompt_price     db    0a, "Precio: ","$"
prompt_units     db    0a, "Unidades: ","$"
;; "ESTRUCTURA PRODUCTO"
cod_prod    db    04 dup (0)
cod_desc    db    20 dup (0)
cod_price   dw    0000
cod_units   dw    0000
    db "$"
num_price   db    02 dup (0)
num_units   db    02 dup (0)
ceros       db    28 dup (0)
;; "ESTRUCTURA PRODUCTO temporal"
cod_prod_temp    db    04 dup (0)
cod_desc_temp    db    20 dup (0)
cod_price_temp   dw    0000
cod_units_temp   dw    0000
;;
nombre_archivo_productos db "PROD.BIN", 00
handle_prods dw 0000
;;; temps
codigo_buscado    db    04 dup (0)
puntero_temp     dw    0000
;;
caracter_leido    db   00, "$"
buffer_entrada   db  25, 00
    db  25 dup (0)
numero db   05 dup (30)
;; Ventas
cancelar_venta db "fin"
buffer_codigo db 05, 00
    db 05 dup (0)
buffer_unidad db 04, 00
    db 04 dup (0)
mostrar_contador db 0A, 00, "$"
contador_diez db 01
monto_venta dw 0000
nombre_archivo_ventas db "VENT.BIN", 00
handle_ventas dw 0000
; Estructura 10 item Venta
dia db 00
mes db 00
anio db 00
hora db 00
min db 00
unidades_temp db 00
registro_venta db 0A dup (0)

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
    mov [handle_crede], AX ; guardamos el handle
    mov SI, offset credenciales ; puntero al primer caracter de credenciales

ciclo_comprobar_credenciales: ; comprueba las credenciales
    mov BX, [handle_crede]
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
    mov DX, offset saltos
    mov AH, 09
    int 21 ; imprimir saltos
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
    je pedir_codigo
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
    ; mov CX, 000A
    mov [contador_diez], 01
    mov DX, 0000
	mov [puntero_temp], DX
    jmp ventas

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
    
; ----------------------Ingresar producto-------------------------------------
pedir_codigo:
    ;limpiar buffer
    mov DI, offset buffer_entrada
    mov CH, 00
    mov CL, [DI]
    inc DI
    mov AL, [DI]
    mov AL, 00
    mov [DI], AL
    inc DI
    call memset
    ;
    mov DX, offset prompt_code
    mov AH, 09
    int 21 ; imprimir codigo:
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ; verificar que el tamaño del codigo no sea mayor a 4 y menor a 0
    mov DI, offset buffer_entrada
    inc DI
    mov AL, [DI]
    cmp AL, 00
    je  pedir_codigo
    cmp AL, 05
    jb  aceptar_tam_cod  ; jb --> jump if below
    jmp pedir_codigo
    ; mover al campo codigo en la estructura producto

aceptar_tam_cod:
    mov SI, offset cod_prod
    mov DI, offset buffer_entrada
    inc DI
    mov CH, 00
    mov CL, [DI]
    inc DI  ; me posiciono en el contenido del buffer

copiar_codigo:	
    mov AL, [DI]
    mov [SI], AL
    inc SI
    inc DI
    loop copiar_codigo ; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
    ; la cadena ingresada en la estructura

pedir_descripcion:
    ;limpiar buffer
    mov DI, offset buffer_entrada
    mov CH, 00
    mov CL, [DI]
    inc DI
    mov AL, [DI]
    mov AL, 00
    mov [DI], AL
    inc DI
    call memset
    ;
    mov DX, offset prompt_desc
    mov AH, 09
    int 21 ; imprimir descripcion:
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ; verificar que el tamaño del codigo no sea mayor a 20h
    mov DI, offset buffer_entrada
    inc DI
    mov AL, [DI]
    cmp AL, 00
    je  pedir_descripcion
    cmp AL, 21
    jb  aceptar_tam_desc ; si es menor a 20
    jmp pedir_descripcion
    ; mover al campo codigo en la estructura producto

aceptar_tam_desc:
    mov SI, offset cod_desc
    mov DI, offset buffer_entrada
    inc DI
    mov CH, 00
    mov CL, [DI]
    inc DI  ; me posiciono en el contenido del buffer

copiar_desc:	
    mov AL, [DI]
    mov [SI], AL
    inc SI
    inc DI
    loop copiar_desc ; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
    ; la cadena ingresada en la estructura

pedir_precio:
    ; limpiar buffer
    mov DI, offset buffer_entrada
    mov CH, 00
    mov CL, [DI]
    inc DI
    mov AL, [DI]
    mov AL, 00
    mov [DI], AL
    inc DI
    call memset
    ;
    mov DX, offset prompt_price
    mov AH, 09
    int 21 ; imprimir "precio:"
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ; verificar que el tamaño del codigo no sea mayor a 2
    mov DI, offset buffer_entrada
    inc DI
    mov AL, [DI]
    cmp AL, 00
    je  pedir_precio
    cmp AL, 06 ; menor a 5 digitos para representar 2 byte
    jb  aceptar_tam_precio ; jb --> jump if below
    jmp pedir_precio
    ; mover al campo precio en la estructura producto

aceptar_tam_precio:
    mov DI, offset buffer_entrada
    inc DI
    mov CH, 00
    mov CL, [DI] 
    inc DI
    call cadenaAnum
    ;; AX -> numero convertido
    ; cmp AX, ffff
    ; jg pedir_precio
    mov [cod_price], AX
    
pedir_unidades:
    ; limpiar buffer
    mov DI, offset buffer_entrada
    mov CH, 00
    mov CL, [DI]
    inc DI
    mov AL, [DI]
    mov AL, 00
    mov [DI], AL
    inc DI
    call memset
    ;
    mov DX, offset prompt_units
    mov AH, 09
    int 21 ; imprimir "unidades:"
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ; verificar que el tamaño de byte no sea mayor a 2
    mov DI, offset buffer_entrada
    inc DI
    mov AL, [DI]
    cmp AL, 00
    je pedir_unidades
    cmp AL, 06  ; menor a 5 digitos para representar 2 byte
    jb aceptar_tam_unidades ; jb --> jump if below
    jmp pedir_unidades
    ; mover al campo codigo en la estructura producto
aceptar_tam_unidades:
    mov DI, offset buffer_entrada
    inc DI
    mov CH, 00
    mov CL, [DI] 
    inc DI
    call cadenaAnum
    ;; AX -> numero convertido
    ; cmp AX, ffff
    ; jg pedir_unidades
    mov [cod_units], AX
    ;
;--------------------------Guardar producto-----------------------------------
abrir_archivo_productos: ; probar abrirlo normal
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_productos
    int 21
    ; si no lo cremos
    jc crear_archivo_prod
    ; si abre escribimos
    jmp guardar_handle_prod
crear_archivo_prod:
    mov CX, 0000
    mov DX, offset nombre_archivo_productos
    mov AH, 3c
    int 21
    ; archivo abierto
guardar_handle_prod:
    ; guardamos handle
    mov [handle_prods], AX
    mov DX, 0000
	mov [puntero_temp], DX

ciclo_espacio_disponible:
	mov BX, [handle_prods]
	mov CX, 0028
	mov DX, offset cod_prod_temp
	moV AH, 3f
	int 21
    cmp AX, 0000 ; si lee 0 bytes se ingresa al final
	je espacio_a_ingresar
	mov AL, 00 ; verificar si es el codigo es 00
	cmp [cod_prod_temp], AL
	je espacio_a_ingresar
    mov DX, [puntero_temp]
	add DX, 0028
	mov [puntero_temp], DX
	jmp ciclo_espacio_disponible

espacio_a_ingresar:
    mov DX, [puntero_temp]
	mov CX, 0000
	mov BX, [handle_prods]
	mov AL, 00
	mov AH, 42
	int 21
	; puntero posicionado, escribir el producto en el archivo
    mov CX, 0028
    mov DX, offset cod_prod
    mov AH, 40
    int 21
    ; cerrar archivo
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    ;
    call limpiar_estructura
    jmp menu_productos
;-------------------------eliminar producto-----------------------------------
eliminar_producto:
    mov DX, 0000
	mov [puntero_temp], DX

pedir_codigo_buscar:
	mov DX, offset prompt_code
    mov AH, 09
    int 21 ; imprimir codigo:
    mov DX, offset buffer_entrada
    mov AH, 0a
    int 21
    ;;
    mov DI, offset buffer_entrada
    inc DI
    mov AL, [DI]
    cmp AL, 00
    je  pedir_codigo_buscar
    cmp AL, 05
    jb  aceptar_codigo_buscar  ;; jb --> jump if below
    jmp pedir_codigo_buscar
		
aceptar_codigo_buscar: ; mover al campo codigo en la estructura producto
	mov SI, offset codigo_buscado
	mov DI, offset buffer_entrada
    inc DI
    mov CH, 00
    mov CL, [DI]
    inc DI  ;; me posiciono en el contenido del buffer

copiar_codigo_encontrado:	
    mov AL, [DI]
	mov [SI], AL
	inc SI
	inc DI
	loop copiar_codigo_encontrado ; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
	; la cadena ingresada en la estructura
    mov AL, 02 ; <<<<<  lectura/escritura
    mov DX, offset nombre_archivo_productos
    mov AH, 3d
    int 21
    jc error_crear_antes_archivo
    mov [handle_prods], AX

ciclo_encontrar:
	mov BX, [handle_prods]
	mov CX, 0028
	mov DX, offset cod_prod
	moV AH, 3f
	int 21
    int 3
    cmp AX, 0000 ; se acaba cuando el archivo se termina
	je no_encontrado_eliminar
	mov DX, [puntero_temp]
	add DX, 0028
	mov [puntero_temp], DX
	; verificar si es producto válido
	mov AL, 00
	cmp [cod_prod], AL
	je ciclo_encontrar
	; verificar el código
	mov SI, offset codigo_buscado
	mov DI, offset cod_prod
	mov CX, 0004
	call cadenas_iguales
	;;;; <<
	cmp DL, 0ff
	je borrar_encontrado
	jmp ciclo_encontrar

borrar_encontrado:
	mov DX, [puntero_temp]
	sub DX, 0028
	mov CX, 0000
	mov BX, [handle_prods]
	mov AL, 00
	mov AH, 42
	int 21
	;;; puntero posicionado
	mov CX, 0028
	mov DX, offset ceros
	mov AH, 40
	int 21
    mov DX, offset mensaje_borrado
    mov AH, 09
    int 21 ; imprimir Producto eliminado
    jmp finalizar_borrar

no_encontrado_eliminar:
    mov DX, offset no_existe
    mov AH, 09
    int 21 ; imprimir el producto no fue encontrado
finalizar_borrar:
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    call limpiar_estructura
    jmp menu_productos

error_crear_antes_archivo:
    mov DX, offset error
    mov AH, 09
    int 21 ; imprimir el archivo no existe
    jmp menu_productos

;-------------------------mostrar producto------------------------------------
mostrar_productos:
    mov DX, offset nueva_lin
    mov AH, 09
    int 21
    ;
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_productos
    int 21 ;; leemos
    mov [handle_prods], AX
    
ciclo_mostrar:
		; puntero cierta posición
		mov BX, [handle_prods]
		mov CX, 0028 ; leer 28h bytes
		mov DX, offset cod_prod
		mov AH, 3f
		int 21
		;; ¿cuántos bytes leímos?
		;; si se leyeron 0 bytes entonces se terminó el archivo...
		cmp AX, 0000
		je fin_mostrar
		;; ver si es producto válido
		mov AL, 00
		cmp [cod_prod], AL
		je ciclo_mostrar
		;; producto en estructura
		call imprimir_estructura
		jmp ciclo_mostrar
		
fin_mostrar:
        call limpiar_estructura
		jmp menu_productos
; ----------------------Ventas----------------------------------------------
ventas:
    mov BL, [contador_diez]
    add BL, 30 ; le sumo 30 para obtener el caracter correspiente al numero
    mov DI, offset mostrar_contador
    inc DI ; me muevo al caracter a mostrar
    mov [DI], BL
    mov DX, offset mostrar_contador
	mov AH, 09
	int 21 ; imprimo la iteracion

pedir_codigo1:
    ; limpiar buffer
    mov DI, offset buffer_codigo
    mov CH, 00
    mov CL, [DI]
    inc DI
    mov AL, [DI]
    mov AL, 00
    inc DI
    call memset
    ;
    mov DX, offset prompt_code
    mov AH, 09
    int 21 ; imprimir codigo:
    mov DX, offset buffer_codigo
    mov AH, 0a
    int 21
    ;
    mov DI, offset buffer_codigo
    inc DI
    mov AL, [DI]
    cmp AL, 00
    je pedir_codigo1 ; verificar que el tamaño del codigo no sea menor a 0
    cmp AL, 05
    jb comprobar_fin  ; verificar que el tamaño del codigo no sea mayor a 4
    jmp pedir_codigo1

comprobar_fin:
    ; verificar el código
	mov SI, offset cancelar_venta
    inc DI
	; mov DI, offset cancelar_venta
	mov CX, 0003
	call cadenas_iguales
	;;;; << DL == 0ff si son iguales
	cmp DL, 0ff
	je confirmar_venta 

pedir_unidades1:
    ; limpiar buffer
    mov DI, offset buffer_unidad
    mov CH, 00
    mov CL, [DI]
    inc DI
    mov AL, [DI]
    mov AL, 00
    inc DI
    call memset
    ;
    mov DX, offset prompt_units
    mov AH, 09
    int 21 ; imprimir "unidades:"
    mov DX, offset buffer_unidad
    mov AH, 0a
    int 21
    ; verificar que el tamaño de byte no sea mayor a 3
    mov DI, offset buffer_unidad
    inc DI
    mov AL, [DI]
    cmp AL, 00
    je pedir_unidades1
    cmp AL, 04  ; tamaño máximo del campo
    jb sumar_contador ; jb --> jump if below
    jmp pedir_unidades1

sumar_contador: ; buffer_unidad y buffer_codigo llenos
    ; aqui comprobar las unidades y codigo para modificar el archivo productos
    ; obtengo la hora
    mov AH, 2C
    int 21
    mov [hora], CH
    mov [min], CL
    ; obtengo la fecha
    mov AH, 2A
    int 21
    mov [dia], DL
    mov [mes], DH
    mov [anio], CL
abrir_archivo_ventas: ; probar abrirlo normal
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_ventas
    int 21
    ; si no lo cremos
    jc crear_archivo_ventas
    ; si abre escribimos
    jmp guardar_handle_ventas
crear_archivo_ventas:
    mov CX, 0000
    mov DX, offset nombre_archivo_ventas
    mov AH, 3c
    int 21
    ; archivo abierto
guardar_handle_ventas:
    ; guardamos handle
    int 3
    mov [handle_ventas], AX
    mov DX, 0000
	mov CX, 0000
	mov BX, [handle_ventas]
	mov AL, 02
	mov AH, 42
	int 21
	; puntero posicionado, escribir la venta
    mov CX, 0005
    mov DX, offset dia
    mov AH, 40
    int 21
    ;escribir codigo
    mov CX, 0004
    mov DX, offset buffer_codigo
    inc DX
    inc DX
    mov AH, 40
    int 21
    ; convertir unidades a numero
    mov DI, offset buffer_unidad
    inc DI
    inc DI
    mov CX, 0003
    call cadenaAnum
    ; AX -> cadena convertida
    mov [unidades_temp], AL
    ; escribir unidades
    mov CX, 0001
    mov DX, offset unidades_temp
    mov AH, 40
    int 21
    ; cerrar archivo
    mov BX, [handle_ventas]
    mov AH, 3e
    int 21
    ;
    call limpiar_estructura_ventas
    ; incrementar el contador hasta el numero a comparar
    cmp contador_diez, 02
    jge confirmar_venta
    inc contador_diez 
    jmp ventas

confirmar_venta:
    jmp menu_principal
; ----------------------Menu herramientas------------------------------------
catalogo_completo:
productos_alfabeticos:
reporte_ventas:
productos_sin_existencia:
    jmp fin
; -----------------------------------------------------------------------------
;; imprimir_estructura - ...
;; ENTRADAS:
;; SALIDAS:
;;     o Impresión de estructura
imprimir_estructura:
        mov DX, offset prompt_code
		mov AH, 09
		int 21
		mov DI, offset cod_prod
ciclo_poner_dolar_1:
		mov AL, [DI]
		cmp AL, 00
		je poner_dolar_1
		inc DI
		jmp ciclo_poner_dolar_1
poner_dolar_1:
		mov AL, 24 ; dólar
		mov [DI], AL
		; imprimir normal
		mov DX, offset cod_prod
		mov AH, 09
		int 21
        ; inicio imprimir descripcion
        mov DX, offset prompt_desc
		mov AH, 09
		int 21
        mov DI, offset cod_desc
ciclo_poner_dolar:
		mov AL, [DI]
		cmp AL, 00
		je poner_dolar
		inc DI
		jmp ciclo_poner_dolar
poner_dolar:
		mov AL, 24 ; dólar
		mov [DI], AL
        mov DX, offset cod_desc
		mov AH, 09
		int 21
        mov DX, offset nueva_lin
		mov AH, 09
		int 21
		ret

;; cadenaAnum
;; ENTRADA:
;;    DI -> dirección a una cadena numérica
;;    CX -> cantidad de digitos o bytes
;; SALIDA:
;;    AX -> número convertido
cadenaAnum:
		mov AX, 0000    ; inicializar la salida
		; mov CX, 0005    ; inicializar contador
		;;
seguir_convirtiendo:
		mov BL, [DI]
		cmp BL, 00
		je retorno_cadenaAnum
		sub BL, 30      ; BL es el valor numérico del caracter
		mov DX, 000a
		mul DX          ; AX * DX -> DX:AX
		mov BH, 00
		add AX, BX 
		inc DI          ; puntero en la cadena
		loop seguir_convirtiendo
retorno_cadenaAnum:
		ret

;; numAcadena
;; ENTRADA:
;;     AX -> número a convertir    
;; SALIDA:
;;    [numero] -> numero convertido en cadena
numAcadena:
    mov CX, 0005
    mov DI, offset numero

ciclo_poner30s:
    mov BL, 30
    mov [DI], BL
    inc DI
    loop ciclo_poner30s
    ;; tenemos '0' en toda la cadena
    mov CX, AX    ; inicializar contador
    mov DI, offset numero
    add DI, 0004
    
ciclo_convertirAcadena:
    mov BL, [DI]
    inc BL
    mov [DI], BL
    cmp BL, 3a
    je aumentar_siguiente_digito_primera_vez
    loop ciclo_convertirAcadena
    jmp retorno_convertirAcadena

aumentar_siguiente_digito_primera_vez:
	push DI

aumentar_siguiente_digito:
    mov BL, 30     ; poner en '0' el actual
    mov [DI], BL
    dec DI         ; puntero a la cadena
    mov BL, [DI]
    inc BL
    mov [DI], BL
    cmp BL, 3a
    je aumentar_siguiente_digito
    pop DI         ; se recupera DI
    loop ciclo_convertirAcadena
retorno_convertirAcadena:
	ret

;; memset
;; ENTRADA:
;;    DI -> dirección de la cadena
;;    CX -> tamaño de la cadena
memset:
    mov AL, 00
    mov [DI], AL
    inc DI
    loop memset
    ret
;;
limpiar_estructura:
    mov DI, offset cod_prod
    mov CX, 0028
    call memset
    ret
limpiar_estructura_ventas:
    mov DI, offset dia
    mov CX, 0006
    call memset
    ret
;; cadenas_iguales -
;; ENTRADA:
;;    SI -> dirección a cadena 1
;;    DI -> dirección a cadena 2
;;    CX -> tamaño máximo
;; SALIDA:
;;    DL -> 00 si no son iguales

;;         0ff si si lo son
cadenas_iguales:
    mov AL, [SI]
    cmp [DI], AL
    jne no_son_iguales
    inc DI
    inc SI
    loop cadenas_iguales
    ;;;;; <<<
    mov DL, 0ff
    ret
no_son_iguales:	mov DL, 00
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