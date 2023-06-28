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
no_existe db 0A,"El producto no fue encontrado", 0a, "$"
mensaje_salida db 0a,"Ejecucion terminada", "$"
mensaje_borrado db "Producto eliminado", "$"
mensaje_agregado db 0a, "Producto agregado", 0a, "$"
nueva_lin db 0A, "$"
;;
mensaje_codigo_error db 0a, "Caracter invalido, [A-Z0-9]", 0a, "$"
mensaje_desc_error db 0a, "Caracter invalido, [A-Za-z0-9,.!]", 0a, "$"
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
cod_prod_imprimir    db    05 dup (0)
cod_desc_imprimir   db    21 dup (0)
;;
nombre_archivo_productos db "PROD.BIN", 00
handle_prods dw 0000
;;; temps
codigo_buscado    db    04 dup (0)
puntero_temp     dw    0000
puntero_temp_buscar     dw    0000
;;
caracter_leido    db   00, "$"
buffer_entrada   db  25, 00
    db  25 dup (0)
numero db   05 dup (30), "$"
contador_cinco db 01
mensaje_mostrar db 0a,'Presiona ENTER para continuar o "q" para terminar', 0a, "$"
;; Ventas
cancelar_venta db "fin"
buffer_codigo db 05, 00
    db 05 dup (0)
buffer_unidad db 04, 00
    db 04 dup (0)
mostrar_contador db 0A, "Contador: ", "$"
mensaje_separador_venta db 0a, "------------------------------", "$"
fuera_de_rango db 0a, "Las unidades no deben superar los 255", 0a, "$"
contador_diez db 01
nombre_archivo_ventas db "VENT.BIN", 00
handle_ventas dw 0000
; Estructura 10 item Venta
dia db 00
mes db 00
anio db 00
hora db 00
min db 00
codigo_venta_temp db 04 dup (0)
unidades_temp db 00
;
registro_venta db 64 dup (0)
monto_venta dw 0000
;
mensaje_compra db 0a, 0a, "Confirmar compra?"
    db    0a, "(Y)confirmar"
    db    0a, "(N)cancelar", 0a,"$"
mensaje_no_hay_existencias db    0a, "No hay suficientes unidades del producto", 0a, "$"
mensaje_actualizado db 0A, "Producto actualizado", 0a, "$"
mensaje_monto db 0a, "Monto: ", "$"
;  herramientas
nombre_archivo_catalogo db "CATALG.HTM", 00
handle_catalogo      dw   0000
nombre_archivo_alfabetico db "ABC.HTM", 00
handle_alfabetico      dw   0000
nombre_archivo_rep_ventas db "REP.TXT", 00
handle_rep_ventas      dw   0000
nombre_archivo_existencias db "FALTA.HTM", 00
; catalogo
tam_encabezado_html    db     0c
encabezado_html        db     "<html><body>"
tam_inicializacion_tabla   db   5e
inicializacion_tabla   db     '<table border="1"><tr><td>codigo</td><td>descripcion</td><td>Precio</td><td>Unidades</td></tr>'
tam_cierre_tabla       db     8
cierre_tabla           db     "</table>"
tam_footer_html        db     0e
footer_html            db     "</body></html>"
td_html                db     "<td>"
tdc_html               db     "</td>"
tr_html                db     "<tr>"
trc_html               db     "</tr>"
h1_html                db     "<h1>"
h1c_html                db     "</h1>"
separador db "/"
separador_espacio db " "
separador_dos_puntos db ":"
posicion_fecha dw 0000
; abc
tam_inicializacion_tabla_abc   db   38
inicializacion_tabla_abc   db     '<table border="1"><tr><td>Letra</td><td>Conteo</td></tr>'
conteo_abecedario db 1A dup(0)
    db 00
conteo_letra db 00
conteo_letra_mostrar db 00
; productos
mensaje_ya_existe  db  0A,"El codigo del producto ya existe", 0a, "$"
; reporte ventas
separador_tipo_venta db 0A, "============================================="
separador_venta db 0a, "---------------------------------------------"
salida_ultimas_ventas db 0a, "ULTIMAS VENTAS:", 0a
salida_venta_mayor db 0a, "VENTA CON MAYOR MONTO:", 0a
salida_venta_menor db 0a, "VENTA CON MENOR MONTO:", 0a
salida_fecha db 0a, "Fecha:", 0A
salida_monto db 0a, "Monto:", 0a
offset_venta dw 0000
venta_mayor dw 0000
venta_menor dw 0000
;
dia_mayor db 00
mes_mayor db 00
anio_mayor db 00
hora_mayor db 00
min_mayor db 00
;
dia_menor db 00
mes_menor db 00
anio_menor db 00
hora_menor db 00
min_menor db 00
;
mensaje_reporte db 0a, "Reporte terminado", 0a, "$"

.CODE ; segmento de codigo
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
    ; probar abrirlo normal
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_productos
    int 21
    ; si no abre regresamos al menu principal
    jc menu_principal
    ; si abre guardamos el handle
    mov [handle_prods], AX
    mov [monto_venta], 0000
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
mensaje_desc_invalido:
    mov DX, offset mensaje_desc_error
    mov AH, 09
    int 21 ; imprimir
    jmp pedir_descripcion

mensaje_codigo_invalido:
    mov DX, offset mensaje_codigo_error
    mov AH, 09
    int 21 ; imprimir
    jmp pedir_codigo
    
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
    call limpiar_estructura
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
    call comprobar_caracter_codigo
    cmp AH, 00
    je mensaje_codigo_invalido
    inc SI
    inc DI
    loop copiar_codigo ; restarle 1 a CX, verificar que CX no sea 0, si no es 0 va a la etiqueta, 
    ; la cadena ingresada en la estructura
    jmp pedir_descripcion

pedir_descripcion:
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
    call limpiar_descripcion
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
    call comprobar_caracter_descripcion
    cmp AH, 00
    je mensaje_desc_invalido
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

ciclo_existe:
	mov BX, [handle_prods]
	mov CX, 0028
	mov DX, offset cod_prod_temp
	moV AH, 3f
	int 21
    cmp AX, 0000 ; si lee 0 bytes es que no existe
	je poner_puntero_inicio
    ; verificar si ya existe
    mov SI, offset cod_prod_temp
    mov DI, offset cod_prod
    mov CX, 0004
    call cadenas_iguales
    cmp DL, 0ff
    je codigo_ya_existe
	jmp ciclo_existe

poner_puntero_inicio:
    mov AL, 00
    mov BX, [handle_prods]
    mov CX, 0000
    mov DX, 0000
    mov AH, 42
    int 21

ciclo_espacio_disponible:
	mov BX, [handle_prods]
	mov CX, 0028
	mov DX, offset cod_prod_temp
	moV AH, 3f
	int 21
    cmp AX, 0000 ; si lee 0 bytes se ingresa al final
	je espacio_a_ingresar
	mov AL, 00 ; verificar si es el codigo 00
	cmp [cod_prod_temp], AL
	je espacio_a_ingresar
    ;
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
    ;
    jmp finalizar_ingreso

codigo_ya_existe:
    mov DX, offset mensaje_ya_existe
    mov AH, 09
    int 21 ; imprimir

finalizar_ingreso:
    ; cerrar archivo
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    ;
    mov DX, offset mensaje_agregado
    mov AH, 09
    int 21 ; imprimir
    call limpiar_estructura
    jmp menu_productos
;-------------------------eliminar producto-----------------------------------
mensaje_codigo_invalido_eliminar:
    mov DX, offset mensaje_codigo_error
    mov AH, 09
    int 21 ; imprimir codigo:

eliminar_producto:
    mov DX, 0000
	mov [puntero_temp], DX
    mov DI, offset codigo_buscado
    mov CX, 0004
    call memset

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
    call comprobar_caracter_codigo
    cmp AH, 00
    je mensaje_codigo_invalido_eliminar
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
iniciar_contador:
    mov [contador_cinco], 01
    
ciclo_mostrar:
    call limpiar_estructura
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
    cmp contador_cinco, 05
    jge continuar_mostrando
    inc contador_cinco
    jmp ciclo_mostrar

continuar_mostrando:
    mov DX, offset mensaje_mostrar
    mov AH, 09
    int 21
    ;
    mov AH, 08
    int 21 ; AL = CARACTER LEIDO
    cmp AL, 0D ; ENTER minúscula ascii
    je iniciar_contador
    cmp AL, 71 ; q minúscula ascii
    je fin_mostrar 
    jmp continuar_mostrando

fin_mostrar:
    call limpiar_estructura
    jmp menu_productos
; ----------------------Ventas----------------------------------------------
unidades_rango:
    mov DX, offset fuera_de_rango
    mov AH, 09
    int 21 ; imprimir
    jmp pedir_unidades1

mensaje_codigo_invalido_ventas:
    mov DX, offset mensaje_codigo_error
    mov AH, 09
    int 21 ; imprimir codigo:
    jmp pedir_codigo1

producto_no_existe:
    mov DX, offset no_existe
    mov AH, 09
    int 21 ; imprimir el producto no fue encontrado
    jmp pedir_codigo1
    
ventas:
    call limpiar_estructura
    call limpiar_estructura_ventas
    mov AH, 00
    mov AL, [contador_diez]
    call numAcadena
    ;
    mov DX, offset mostrar_contador
	mov AH, 09
	int 21 ; imprimir
    ;
    mov DX, offset numero
    add DX, 0003
    mov AH, 09
    int 21 ; imprimir el contador
    ;
    mov DX, offset mensaje_monto
    mov AH, 09
    int 21 ; imprimir
    ;
    mov AX, [monto_venta]
    call numAcadena
    ;
    mov DX, offset numero
    mov AH, 09
    int 21 ; imprimir el monto
    mov DX, offset nueva_lin
    mov AH, 09
    int 21 ; imprimir salto

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
    call limpiar_codigo_venta_temp
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
	mov CX, 0003
	call cadenas_iguales
	;;;; << DL == 0ff si son iguales
	cmp DL, 0ff
	je confirmar_venta 
    ; guardar el codigo en variable temporal
    mov SI, offset codigo_venta_temp
    mov DI, offset buffer_codigo
    inc DI
    mov CH, 00
    mov CL, [DI]
    inc DI  ; me posiciono en el contenido del buffer
    
copiar_codigo_venta:	
    mov AL, [DI]
    mov [SI], AL
    call comprobar_caracter_codigo
    cmp AH, 00 ; compruebo el resultado devuelto
    je mensaje_codigo_invalido_ventas
    inc SI
    inc DI
    loop copiar_codigo_venta

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
    jb validar_campos ; jb --> jump if below
    jmp pedir_unidades1

validar_campos: ; buffer_unidad y buffer_codigo llenos
    ; convertir unidades a numero
    mov DI, offset buffer_unidad
    inc DI
    mov CH, 00
    mov CL, [DI]
    inc DI
    call cadenaAnum
    ; AX -> cadena convertida
    cmp AX, 00ff
    jg unidades_rango ; si es mayor a un byte
    mov [unidades_temp], AL
    ; muevo el puntero del fichero al inicio
    mov AL, 00
    mov BX, [handle_prods]
    mov CX, 0000
    mov DX, 0000
    mov AH, 42
    int 21
    ;
   
ciclo_encontrar_codigo: ; comprueba si el codigo existe
	mov BX, [handle_prods]
	mov CX, 0028
	mov DX, offset cod_prod
	moV AH, 3f
	int 21
    cmp AX, 0000 ; si llego al final de archivo no se encontro
	je producto_no_existe
	; verificar si es producto válido
	mov AL, 00
	cmp [cod_prod], AL
	je ciclo_encontrar_codigo
	; verificar el código
	mov SI, offset codigo_venta_temp
	mov DI, offset cod_prod
	mov CX, 0004
	call cadenas_iguales
	;;;; <<
	cmp DL, 0ff
	je guardar_item_venta
	jmp ciclo_encontrar_codigo

mensaje_sin_existencias:
    mov DX, offset mensaje_no_hay_existencias
    mov AH, 09
    int 21 ; imprimir
    jmp pedir_codigo1

guardar_item_venta:
    ; compruebo si hay existencias
    mov AH, 00
    mov AL, [unidades_temp]
    cmp [cod_units], AX
    jb mensaje_sin_existencias
    ; calcular monto de venta
    mov AH, 00
    mov AL, [unidades_temp]
    mov BX, [cod_price]
    mul BX
    add [monto_venta] , AX
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
    sub CX, 07D0
    mov [anio], CL

guardar_venta:
    mov SI, offset registro_venta
    add SI, [puntero_temp] ; MUEVO EL PUNTERO A LA PROXIMA UBICACION VACIA
    mov DI, offset dia
    mov CX, 000A

copiar_item_temporal:	
    mov AL, [DI]
    mov [SI], AL
    inc SI
    inc DI
    loop copiar_item_temporal
    ; le agrego al offset(puntero_temp) 10 bytes
    mov DX, [puntero_temp]
	add DX, 000A
	mov [puntero_temp], DX
    ; incrementar el contador hasta el numero a comparar
    mov DX, offset mensaje_separador_venta
    mov AH, 09
    int 21
    ;
    cmp contador_diez, 0A
    jge confirmar_venta
    inc contador_diez
    jmp ventas

confirmar_venta:
    mov DX, offset mensaje_compra
    mov AH, 09
    int 21
    ;
    mov AH, 08
    int 21 ; AL = CARACTER LEIDO
    cmp AL, 79 ; y minúscula ascii
    je abrir_archivo_ventas
    cmp AL, 6E ; n minúscula ascii
    je cancelar_compra 
    jmp confirmar_venta

abrir_archivo_ventas: ; probar abrirlo normal
    ; cerrar archivo productos
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    ;
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
    mov [handle_ventas], AX
    ; se posiciona el puntero hasta el final
    mov DX, 0000
	mov CX, 0000
	mov BX, [handle_ventas]
	mov AL, 02
	mov AH, 42
	int 21
	; puntero posicionado, escribir la venta
    mov CX, 0066 ; [puntero_temp] si solo se quiere escribir lo necesario
    mov DX, offset registro_venta
    mov AH, 40
    int 21
    ; cerrar archivo
    mov BX, [handle_ventas]
    mov AH, 3e
    int 21

abrir_archivo_productos_segunda:
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_productos
    int 21
    mov [handle_prods], AX

ciclo_actualizar_existencias:
    cmp [puntero_temp], 0000
    je cancelar_compra ; si es igual a cero se termino de actualizar
    call limpiar_estructura
    ; muevo el puntero del fichero al inicio
    mov AL, 00
    mov BX, [handle_prods]
    mov CX, 0000
    mov DX, 0000
    mov AH, 42
    int 21
    ; coloco el conteo al principio
    mov AX, [puntero_temp_buscar]
    mov AX, 0000
    mov [puntero_temp_buscar], AX
    ; me coloco en la proxima venta
    mov AX, [puntero_temp]
    sub AX, 000A
    mov [puntero_temp], AX
    ; copiar la venta al temporal
    mov DI, offset registro_venta
    add DI, [puntero_temp] ; MUEVO EL PUNTERO A LA UBICACION DE LA VENTA
    mov SI, offset dia
    mov CX, 000A

copiar_venta:	
    mov AL, [DI]
    mov [SI], AL
    inc SI
    inc DI
    loop copiar_venta

ciclo_buscar_actualizar:
	mov BX, [handle_prods]
	mov CX, 0028
	mov DX, offset cod_prod
	moV AH, 3f
	int 21
    cmp AX, 0000 ; si llego al final de archivo(no deberia pasar)
	je cancelar_compra
	; verificar el código
	mov SI, offset codigo_venta_temp
	mov DI, offset cod_prod
	mov CX, 0004
	call cadenas_iguales
	cmp DL, 0ff ; lo de vuelve la subrutina si son iguales
	je actualizar_existencia
    ;
    mov AX, [puntero_temp_buscar]
    add AX, 0028
    mov [puntero_temp_buscar], AX
    ;
	jmp ciclo_buscar_actualizar

actualizar_existencia:
    ; resto las unidades
    mov AX, [cod_units]
    mov BH, 00
    mov BL, [unidades_temp]
    sub AX, BX
    mov [cod_units], AX
    ; posiciono el puntero en el byte a escribir
	mov DX, [puntero_temp_buscar]
	mov CX, 0000
	mov BX, [handle_prods]
	mov AL, 00
	mov AH, 42
	int 21
	;;; puntero posicionado
	mov CX, 0028
	mov DX, offset cod_prod
	mov AH, 40
	int 21
    mov DX, offset mensaje_actualizado
    mov AH, 09
    int 21 ; imprimir
    jmp ciclo_actualizar_existencias

cancelar_compra:
    ; cerrar archivo productos
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    ;
    call limpiar_registro_ventas
    jmp menu_principal

; ----------------------Menu herramientas------------------------------------
; ----------------------catalogo---------------------------------------------
catalogo_completo:
    ; probamos abrir el archivo productos
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_productos
    int 21
    ; si no abre regresamos
    jc menu_principal
    ; si abre seguimos
    mov [handle_prods], AX
    ; crear archivo para borrar el anterior siempre
    mov AH, 3c
    mov CX, 0000
    mov DX, offset nombre_archivo_catalogo
    int 21
    ; guardamos handle
    mov [handle_catalogo], AX
    ;
    mov BX, AX
    mov AH, 40
    mov CH, 00
    mov CL, [tam_encabezado_html]
    mov DX, offset encabezado_html
    int 21

poner_fecha:
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
    sub CX, 07D0
    mov [anio], CL
    ;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset h1_html
    int 21
    ; me posiciono en el valor de dia
    mov DI, offset dia
    mov [posicion_fecha], DI
    mov SI, 0001 ; contador

escribir_fecha:
    mov AH, 00
    mov DI, [posicion_fecha]
    mov AL, [DI]
    call numAcadena
    ;
    mov DX, offset numero
    add DX, 0003
    mov CX, 0002
    mov BX, [handle_catalogo]
    mov AH, 40
    int 21
    ;
    cmp SI, 0005
    je poner_tabla
    cmp SI, 0003
    jb poner_separador_fecha
    je poner_espacio_hora
    jg poner_dos_puntos

incrementar_posiones_fecha:
    inc SI
    ; me muevo a la siguiente fecha
    inc [posicion_fecha]
    jmp escribir_fecha

poner_dos_puntos:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_dos_puntos
    int 21
    jmp incrementar_posiones_fecha

poner_espacio_hora:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_espacio
    int 21
    jmp incrementar_posiones_fecha

poner_separador_fecha:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador
    int 21
    jmp incrementar_posiones_fecha

poner_tabla:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset h1c_html
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_inicializacion_tabla]
    mov DX, offset inicializacion_tabla
    int 21

ciclo_mostrar_rep1:
    ; puntero cierta posición
    mov BX, [handle_prods]
    mov CX, 0028     ;; leer 28h bytes
    mov DX, offset cod_prod
    mov AH, 3f
    int 21
    cmp AX, 00 ; cantidad de bytes leidos
    je fin_mostrar_rep1
    ; ver si es producto válido
    mov AL, 00
    cmp [cod_prod], AL
    je ciclo_mostrar_rep1
    ; producto en estructura
    call imprimir_estructura_html
    jmp ciclo_mostrar_rep1

fin_mostrar_rep1:
    ; cerrar archivo productos
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    ;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_cierre_tabla]
    mov DX, offset cierre_tabla
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_footer_html]
    mov DX, offset footer_html
    int 21
    ; cerrar archivo catalogo
    mov AH, 3e
    int 21
    ;
    mov DX, offset mensaje_reporte
    mov AH, 09
    int 21 ; imprimir
    jmp menu_principal

;-----------------------fin catalogo------------------------------------------
;------------------------Alfabetico------------------------------------------
productos_alfabeticos:
    ; probamos abrir el archivo productos
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_productos
    int 21
    ; si no abre regresamos
    jc menu_principal
    ; si abre seguimos
    mov [handle_prods], AX
    ; crear archivo para borrar el anterior siempre
    mov AH, 3c
    mov CX, 0000
    mov DX, offset nombre_archivo_alfabetico
    int 21
    ; guardamos handle
    mov [handle_alfabetico], AX
    ;
    mov BX, AX
    mov AH, 40
    mov CH, 00
    mov CL, [tam_encabezado_html]
    mov DX, offset encabezado_html
    int 21

poner_fecha1:
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
    sub CX, 07D0
    mov [anio], CL
    ;
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset h1_html
    int 21
    ; me posiciono en el valor de dia
    mov DI, offset dia
    mov [posicion_fecha], DI
    mov SI, 0001 ; contador

escribir_fecha1:
    mov AH, 00
    mov DI, [posicion_fecha]
    mov AL, [DI]
    call numAcadena
    ;
    mov DX, offset numero
    add DX, 0003
    mov CX, 0002
    mov BX, [handle_alfabetico]
    mov AH, 40
    int 21
    ;
    cmp SI, 0005
    je poner_tabla1
    cmp SI, 0003
    jb poner_separador_fecha1
    je poner_espacio_hora1
    jg poner_dos_puntos1

incrementar_posiones_fecha1:
    inc SI
    ; me muevo a la siguiente fecha
    inc [posicion_fecha]
    jmp escribir_fecha1

poner_dos_puntos1:
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_dos_puntos
    int 21
    jmp incrementar_posiones_fecha1

poner_espacio_hora1:
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_espacio
    int 21
    jmp incrementar_posiones_fecha1

poner_separador_fecha1:
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador
    int 21
    jmp incrementar_posiones_fecha1

poner_tabla1:
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset h1c_html
    int 21
    ;;
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_inicializacion_tabla_abc]
    mov DX, offset inicializacion_tabla_abc
    int 21
    ; inicializar contador
    mov DI, offset conteo_abecedario
    mov DX, 001a
    call memset

ciclo_conteo_letras:
    ; puntero cierta posición
    mov BX, [handle_prods]
    mov CX, 0028     ;; leer 28h bytes
    mov DX, offset cod_prod
    mov AH, 3f
    int 21
    cmp AX, 00 ; cantidad de bytes leidos
    je escribir_conteo_letras
    ; ver si es producto válido
    mov AL, 00
    cmp [cod_prod], AL
    je ciclo_conteo_letras
    ; producto en estructura
    mov AL, [cod_desc]
    cmp AL, 41 ; si es mayor al ASCII A es letra
    jge incrementar_dependiendo_tipo
    jmp ciclo_conteo_letras

incrementar_dependiendo_tipo:
    cmp AL, 61 ; si es mayor al ASCII a es letra minuscula
    jge incrementar_como_minuscula
    mov DI, offset conteo_abecedario
    mov AH, 00
    sub AL, 41
    add DI, AX ; estoy en el byte a incrementar
    mov AX, [DI]
    inc AX
    mov [DI], AX
    jmp ciclo_conteo_letras

incrementar_como_minuscula:
    mov DI, offset conteo_abecedario
    mov AH, 00
    sub AL, 61
    add DI, AX ; estoy en el byte a incrementar
    mov AX, [DI]
    inc AX
    mov [DI], AX
    jmp ciclo_conteo_letras

escribir_conteo_letras:
    ; cerrar archivo productos
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    ;
    call imprimir_estructura_abc

cerrar_archivo_abc:
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_cierre_tabla]
    mov DX, offset cierre_tabla
    int 21
    ;;
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_footer_html]
    mov DX, offset footer_html
    int 21
    ; cerrar archivo catalogo
    mov AH, 3e
    int 21
    mov DX, offset mensaje_reporte
    mov AH, 09
    int 21 ; imprimir
    jmp menu_principal
; ------------------------------------------------------------------------------
;---------------------------------reporte de ventas-----------------------------
reporte_ventas:
    ; abrir archivo ventas
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_ventas
    int 21
    ; si no abre
    jc menu_principal
    ; guardamos handle
    mov [handle_ventas], AX
    ; crear archivo para borrar el anterior siempre
    mov AH, 3c
    mov CX, 0000
    mov DX, offset nombre_archivo_rep_ventas
    int 21
    ; guardamos handle
    mov [handle_rep_ventas], AX
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
    sub CX, 07D0
    mov [anio], CL
    mov DI, offset dia
    call poner_fecha_venta
    ;
    mov DX, offset separador_tipo_venta
    mov CX, 002E
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov DX, offset salida_ultimas_ventas
    mov CX, 0011
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ; inicializar contador
    mov [contador_cinco], 01
    ; puntero al final
    mov AL, 02
    mov BX, [handle_ventas]
    mov CX, 0000
    mov DX, 0000
    mov AH, 42
    int 21
    ;
    mov [offset_venta], AX ;guardo la nueva posicion

ciclo_ultimas_ventas:
    sub [offset_venta], 0066 ; para leer el primero
    ; puntero posicionar
    mov AL, 00
    mov BX, [handle_ventas]
    mov CX, 0000
    mov DX, [offset_venta]
    mov AH, 42
    int 21
    ; leo los datos
    mov DX, offset registro_venta
    mov CX, 0066
    mov BX, [handle_ventas]
    mov AH, 3f
    int 21
    cmp AX, 0000 ; si lee 0 bytes termino
	je buscar_venta
    ; poner fecha
    mov DX, offset salida_fecha
    mov CX, 0008
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov DI, offset registro_venta
    call poner_fecha_venta
    ; poner monto
    mov DX, offset salida_monto
    mov CX, 0008
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov AX, [monto_venta]
    call escribir_monto
    ;
    mov DX, offset separador_venta
    mov CX, 002E
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    ;incrementar contado y comparar si es mayor a 6
    inc [contador_cinco]
    cmp [contador_cinco], 06
    je buscar_venta
    jmp ciclo_ultimas_ventas

buscar_venta:
    ; puntero al inicio
    mov AL, 00
    mov BX, [handle_ventas]
    mov CX, 0000
    mov DX, 0000
    mov AH, 42
    int 21
    ;
    ;mov [venta_mayor], 0003
    mov AL, 0ff
    mov AH, 0ff
    mov [venta_menor], AX

ciclo_buscar_monto:
    ; leo los datos
    mov DX, offset registro_venta
    mov CX, 0066
    mov BX, [handle_ventas]
    mov AH, 3f
    int 21
    cmp AX, 0000 ; si lee 0 bytes termino
	je escribir_mayor_menor
    ; los esta comparando mal
    int 3
    mov AX, [monto_venta]
    mov BX, [venta_mayor]
    cmp BX, AX
    jb actualizar_mayor

punto_mayor:
    int 3
    mov AX, [monto_venta]
    mov BX, [venta_menor]
    cmp AX, BX
    jb actualizar_menor

punto_menor:
    jmp ciclo_buscar_monto

actualizar_mayor:
    mov AX, [monto_venta]
    mov DI, offset venta_mayor
    mov [DI], AX
    ;
    mov DI, offset registro_venta
    mov SI, offset dia_mayor
    mov CX, 0005
guardar_fecha_mayor:
    mov AL, [DI]
    mov [SI], AL
    inc DI
    inc SI
    loop guardar_fecha_mayor
    jmp punto_mayor

actualizar_menor:
    mov AX, [monto_venta]
    mov DI, offset venta_menor
    mov [DI], AX
    ;
    mov DI, offset registro_venta
    mov SI, offset dia_menor
    mov CX, 0005
guardar_fecha_menor:
    mov AL, [DI]
    mov [SI], AL
    inc DI
    inc SI
    loop guardar_fecha_menor
    jmp punto_menor

escribir_mayor_menor:
    ;
    mov DX, offset separador_tipo_venta
    mov CX, 002E
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov DX, offset salida_venta_mayor
    mov CX, 0018
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ; poner fecha
    mov DX, offset salida_fecha
    mov CX, 0008
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov DI, offset dia_mayor
    call poner_fecha_venta
    ; poner monto
    mov DX, offset salida_monto
    mov CX, 0008
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov AX, [venta_mayor]
    call escribir_monto
    ;
    mov DX, offset separador_tipo_venta
    mov CX, 002E
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    mov DX, offset salida_venta_menor
    mov CX, 0018
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ; poner fecha
    mov DX, offset salida_fecha
    mov CX, 0008
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov DI, offset dia_menor
    call poner_fecha_venta
    ; poner monto
    mov DX, offset salida_monto
    mov CX, 0008
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    mov AX, [venta_menor]
    call escribir_monto
    ;


cerrar_archivo_re_ventas:
    ; cerrar archivo ventas
    mov BX, [handle_ventas]
    mov AH, 3e
    int 21
    ; cerrar archivo de reporte
    mov BX, [handle_rep_ventas]
    mov AH, 3e
    int 21
    ;
    mov DX, offset mensaje_reporte
    mov AH, 09
    int 21 ; imprimir
    jmp menu_principal


;;; Entrada:
;;  AX -> montoventa
;; salidas:
;; escribe en archivo rep.txt
escribir_monto:
    call numAcadena
    ;
    mov DX, offset numero
    mov CX, 0005
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    ret

;;; Entrada:
;;  DI, -> registro_venta
;; salidas:
;; escribe en archivo rep.txt
poner_fecha_venta:
    mov [posicion_fecha], DI
    mov SI, 0001 ; contador

escribir_fecha_venta:
    mov AH, 00
    mov DI, [posicion_fecha]
    mov AL, [DI]
    call numAcadena
    ;
    mov DX, offset numero
    add DX, 0003
    mov CX, 0002
    mov BX, [handle_rep_ventas]
    mov AH, 40
    int 21
    ;
    cmp SI, 0005
    je terminar_fecha
    cmp SI, 0003
    jb poner_separador_fecha_venta
    je poner_espacio_hora_venta
    jg poner_dos_puntos_venta

incrementar_posiones_fecha_venta:
    inc SI
    ; me muevo a la siguiente fecha
    inc [posicion_fecha]
    jmp escribir_fecha_venta

poner_dos_puntos_venta:
    mov BX, [handle_rep_ventas]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_dos_puntos
    int 21
    jmp incrementar_posiones_fecha_venta

poner_espacio_hora_venta:
    mov BX, [handle_rep_ventas]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_espacio
    int 21
    jmp incrementar_posiones_fecha_venta

poner_separador_fecha_venta:
    mov BX, [handle_rep_ventas]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador
    int 21
    jmp incrementar_posiones_fecha_venta

terminar_fecha:
    ret
;---------------------------------sin existencias------------------------------    
productos_sin_existencia:
    ; probamos abrir el archivo productos
    mov AL, 02
    mov AH, 3d
    mov DX, offset nombre_archivo_productos
    int 21
    ; si no abre regresamos
    jc menu_principal
    ; si abre seguimos
    mov [handle_prods], AX
    ; crear archivo para borrar el anterior siempre
    mov AH, 3c
    mov CX, 0000
    mov DX, offset nombre_archivo_existencias
    int 21
    ; guardamos handle
    mov [handle_catalogo], AX ; para no hacer otro handle
    ;
    mov BX, AX
    mov AH, 40
    mov CH, 00
    mov CL, [tam_encabezado_html]
    mov DX, offset encabezado_html
    int 21

poner_fecha2:
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
    sub CX, 07D0
    mov [anio], CL
    ;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset h1_html
    int 21
    ; me posiciono en el valor de dia
    mov DI, offset dia
    mov [posicion_fecha], DI
    mov SI, 0001 ; contador

escribir_fecha2:
    mov AH, 00
    mov DI, [posicion_fecha]
    mov AL, [DI]
    call numAcadena
    ;
    mov DX, offset numero
    add DX, 0003
    mov CX, 0002
    mov BX, [handle_catalogo]
    mov AH, 40
    int 21
    ;
    cmp SI, 0005
    je poner_tabla2
    cmp SI, 0003
    jb poner_separador_fecha2
    je poner_espacio_hora2
    jg poner_dos_puntos2

incrementar_posiones_fecha2:
    inc SI
    ; me muevo a la siguiente fecha
    inc [posicion_fecha]
    jmp escribir_fecha2

poner_dos_puntos2:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_dos_puntos
    int 21
    jmp incrementar_posiones_fecha2

poner_espacio_hora2:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador_espacio
    int 21
    jmp incrementar_posiones_fecha2

poner_separador_fecha2:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CX, 0001
    mov DX, offset separador
    int 21
    jmp incrementar_posiones_fecha2

poner_tabla2:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset h1c_html
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_inicializacion_tabla]
    mov DX, offset inicializacion_tabla
    int 21

ciclo_mostrar_rep2:
    ; puntero cierta posición
    mov BX, [handle_prods]
    mov CX, 0028 ; leer 28h bytes
    mov DX, offset cod_prod
    mov AH, 3f
    int 21
    cmp AX, 00 ; cantidad de bytes leidos
    je fin_mostrar_rep2
    ; ver si es producto válido
    mov AL, 00
    cmp [cod_prod], AL
    je ciclo_mostrar_rep2
    ; producto en estructura
    cmp [cod_units], 0000
    int 3
    je llamar_imprimir
    jmp ciclo_mostrar_rep2

llamar_imprimir:
    call imprimir_estructura_html
    jmp ciclo_mostrar_rep2

fin_mostrar_rep2:
     ; cerrar archivo productos
    mov BX, [handle_prods]
    mov AH, 3e
    int 21
    ;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_cierre_tabla]
    mov DX, offset cierre_tabla
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, [tam_footer_html]
    mov DX, offset footer_html
    int 21
    ; cerrar archivo catalogo
    mov AH, 3e
    int 21
    ;
    mov DX, offset mensaje_reporte
    mov AH, 09
    int 21 ; imprimir
    jmp menu_principal
; -----------------------------------------------------------------------------


;; imprimir_estructura - ...
;; ENTRADAS:
;; SALIDAS:
;;     o Impresión de estructura
imprimir_estructura:
    mov DX, offset prompt_code
    mov AH, 09
    int 21
    mov SI, offset cod_prod_imprimir
    mov DI, offset cod_prod
    mov CX, 0004

ciclo_poner_dolar_1:
    mov AL, [DI]
    cmp AL, 00
    je poner_dolar_1
    mov [SI], AL
	inc SI
    inc DI
    loop ciclo_poner_dolar_1
poner_dolar_1:
    mov AL, 24 ; dólar
    mov [SI], AL
    ; imprimir normal
    mov DX, offset cod_prod_imprimir
    mov AH, 09
    int 21
    ; inicio imprimir descripcion
    mov DX, offset prompt_desc
    mov AH, 09
    int 21
    mov SI, offset cod_desc_imprimir
    mov DI, offset cod_desc
    mov CX, 0020
ciclo_poner_dolar:
    mov AL, [DI]
    cmp AL, 00
    je poner_dolar
    mov [SI], AL
    inc SI
    inc DI
    loop ciclo_poner_dolar
poner_dolar:
    mov AL, 24 ; dólar
    mov [SI], AL
    mov DX, offset cod_desc_imprimir
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
    cmp AX, 0000
    je retorno_convertirAcadena
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
    mov DI, offset cod_prod_imprimir
    mov CX, 0026
    call memset
    ret

limpiar_estructura_ventas:
    mov DI, offset dia
    mov CX, 000A
    call memset
    ret

limpiar_codigo_venta_temp:
    mov DI, offset codigo_venta_temp
    mov CX, 0004
    call memset
    ret

limpiar_registro_ventas:
    mov DI, offset registro_venta
    mov CX, 000A
    call memset
    ret
limpiar_descripcion:
    mov DI, offset cod_desc
    mov CX, 0020
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

;;; ENTRADA:
;;    BX -> handle
imprimir_estructura_html:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset tr_html
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset td_html
    int 21
    ;;
    mov DX, offset cod_prod
    mov SI, 0000

ciclo_escribir_codigo:
    mov DI, DX
    mov AL, [DI]
    cmp AL, 00
    je escribir_desc
    cmp SI, 0004
    je escribir_desc
    mov CX, 0001
    mov BX, [handle_catalogo]
    mov AH, 40
    int 21
    inc DX
    inc SI
    jmp ciclo_escribir_codigo

escribir_desc:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset tdc_html
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset td_html
    int 21
    ;;
    mov DX, offset cod_desc
    mov SI, 0000

ciclo_escribir_desc:
    mov DI, DX
    mov AL, [DI]
    cmp AL, 00
    je escribir_price
    cmp SI, 0020
    je escribir_price
    mov CX, 0001
    mov BX, [handle_catalogo]
    mov AH, 40
    int 21
    inc DX
    inc SI
    jmp ciclo_escribir_desc

escribir_price:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset tdc_html
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset td_html
    int 21
    ;;
    mov AX, [cod_price]
    call numAcadena
    mov DX, offset numero
    mov SI, 0000

ciclo_escribir_price:
    mov DI, DX
    mov AL, [DI]
    cmp AL, 00 ; tal vez cambiar a 30
    je escribir_unidades
    cmp SI, 0005
    je escribir_unidades
    mov CX, 0001
    mov BX, [handle_catalogo]
    mov AH, 40
    int 21
    inc DX
    inc SI
    jmp ciclo_escribir_price

escribir_unidades:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset tdc_html
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset td_html
    int 21
    ;;
    mov AX, [cod_units]
    call numAcadena
    mov DX, offset numero
    mov SI, 0000

ciclo_escribir_unidades:
    mov DI, DX
    mov AL, [DI]
    cmp AL, 00
    je cerrar_tags
    cmp SI, 0005
    je cerrar_tags
    mov CX, 0001
    mov BX, [handle_catalogo]
    mov AH, 40
    int 21
    inc DX
    inc SI
    jmp ciclo_escribir_unidades

cerrar_tags:
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset tdc_html
    int 21
    ;;
    mov BX, [handle_catalogo]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset trc_html
    int 21
    ;;
    ret
;;; ENTRADA:
;;    BX -> handle
imprimir_estructura_abc:
    ;pongo el conteo en 0 y la letra en A
    mov [conteo_letra], 00
    mov [conteo_letra_mostrar], 41
    
ciclo_agregar_fila_abc:
    ; abro la etiqueta tr
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset tr_html
    int 21
    ;; abro la etiqueta td
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset td_html
    int 21
    ; escribir la letra
    mov DX, offset conteo_letra_mostrar
    mov CX, 0001
    mov BX, [handle_alfabetico]
    mov AH, 40
    int 21
    ; cierro la etiqueta td
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset tdc_html
    int 21
    ; abro la etiqueta td
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 04
    mov DX, offset td_html
    int 21
    ; convierto el conteo a cadena
    mov DI, offset conteo_abecedario
    mov BH, 00
    mov BL, [conteo_letra]
    add DI, BX
    mov AH, 00
    mov AL, [DI]
    int 3
    call numAcadena
    int 3
    ; escribo el numero
    mov DX, offset numero
    mov CX, 0005
    mov BX, [handle_alfabetico]
    mov AH, 40
    int 21
    ; cierro la etiqueta td
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset tdc_html
    int 21
    ; cierro etiqueta tr
    mov BX, [handle_alfabetico]
    mov AH, 40
    mov CH, 00
    mov CL, 05
    mov DX, offset trc_html
    int 21
    ;incremento variables
    inc [conteo_letra]
    inc [conteo_letra_mostrar]
    ; si ya escribio todas las letras
    mov AL, [conteo_letra_mostrar]
    cmp AL, 5B
    je terminar_abc
    jmp ciclo_agregar_fila_abc

terminar_abc:
    ret
; ENTRADA
;; AL -> caracter
; SALIDA
;; AH -> 00 rechazado
;; AH -> 0FF aceptada
comprobar_caracter_codigo:
    ; si es mayuscula
    cmp AL, 41 ; letra A
    jge terminar_comprobar
    ; si es numero
    sub AL, 30
    cmp AL, 09
    jbe aceptar_caracter
    ; si no rechazar
    mov AH, 00
    ret

terminar_comprobar:
    ; si es menor es mayuscula
    cmp AL, 5A ; letra Z
    jbe aceptar_caracter
    ; si no rechazar
    mov AH, 00
    ret

aceptar_caracter:
    mov AH, 0FF
    ret

; ENTRADA
;; AL -> caracter
; SALIDA
;; AH -> 00 rechazado
;; AH -> 0FF aceptada
comprobar_caracter_descripcion:
    ; si es caracter especial
    cmp AL, 2c ; ascii coma
    je aceptar_caracter_desc
    cmp AL, 2e ; ascii punto
    je aceptar_caracter_desc
    cmp AL, 21 ; ascii !
    je aceptar_caracter_desc
    ; si es mayuscula
    cmp AL, 41 ; letra A
    jge terminar_comprobar_mayus
    ; si es numero
    sub AL, 30
    cmp AL, 09
    jbe aceptar_caracter_desc
    ; si no rechazar
    mov AH, 00
    ret

terminar_comprobar_mayus:
    ; si es menor es mayuscula
    cmp AL, 5A ; letra Z
    jbe aceptar_caracter_desc
    ; si no comprobar si es minuscula
    cmp AL, 61 ; letra a
    jge terminar_comprobar_minus
    ; si no rechazar
    mov AH, 00
    ret

terminar_comprobar_minus:
    ; si es menor es minuscula
    cmp AL, 7A ; letra z
    jbe aceptar_caracter_desc
    ; si no rechazar
    mov AH, 00
    ret

aceptar_caracter_desc:
    mov AH, 0FF
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