(deftemplate preguntas "Preguntas para recomendar las páginas"
    (slot producto_compra (type STRING)(default "no"))
    (slot categoria_ropa (type STRING)(default "no"))
    (slot tipo_compra_electronicos(type STRING)(default "no"))
    (slot estado_producto_electonicos(type STRING)(default "no"))
    (slot tipo_ropa (type STRING)(default "no"))
    (slot Sueteres (type STRING)(default "no"))
    (slot Pantalones (type STRING)(default "no"))
    (slot Zapatos (type STRING)(default "no"))
)


(defrule inicial
    (initial-fact)
    =>
    (printout t "¿Que tipo de producto desea comprar?" crlf)
	(printout t "(A) Ropa" crlf)
	(printout t "(B) Electronicos" crlf)
	(printout t "(C) Al por mayor" crlf)
    (bind ?product(readline))
	(assert(producto_compra ?product))
)

(defrule reglas
    (producto_compra ?product)
    =>
    ;-------------------Rama Ropa-----------------
    (if (eq ?product "A")
        then
            (printout t crlf "¿Ropa por categorias o ropa en general?" crlf)
            (printout t "(A) Ropa por categorias" crlf)
            (printout t "(B) Ropa en general" crlf)
            (bind ?cate(readline))
            (assert(categoria_ropa ?cate))
        
        (if (eq ?cate "A")
            then
                (printout t "Elija la categoria" crlf)
                (printout t "(A) Sueteres" crlf)
                (printout t "(B) Pantalones" crlf)
                (printout t "(C) Zapatos" crlf)
                (bind ?tipo_esp_ropa(readline))
                (assert (preguntas(producto_compra ?product)(categoria_ropa ?cate)(tipo_ropa ?tipo_esp_ropa)))
        )
        (if (eq ?cate "B")
            then
                (assert (preguntas(producto_compra ?product)(categoria_ropa ?cate)))
        )
    )
    ;-------------------Rama Electronicos-----------------
    (if (eq ?product "B")
        then
            (printout t crlf "¿Tipo de compra?" crlf)
            (printout t "(A) Computadoras de mesa" crlf)
            (printout t "(B) Laptops" crlf)
            (printout t "(C) Componentes y electronica" crlf)
            (bind ?tipo_compra(readline))
            (assert(tipo_compra_electronicos ?tipo_compra))
        
        (if (eq ?tipo_compra "A")
            then
                (printout t "Estado que desea del producto" crlf)
                (printout t "(A) Nuevo" crlf)
                (printout t "(B) Usado" crlf)
                (bind ?estado_producto(readline))
                (assert(estado_producto_electonicos ?estado_producto))
            
            (if (eq ?estado_producto "A")
            then
                (assert (preguntas(tipo_compra_electronicos ?tipo_compra)(estado_producto_electonicos ?estado_producto)))
            )
            (if (eq ?estado_producto "B")
            then
                (assert (preguntas(tipo_compra_electronicos ?tipo_compra)(estado_producto_electonicos ?estado_producto)))
            )
        )
    )
)

;-----------------Conclusiones Ropa--------------------

(defrule tipo_ropa_sueteres
    (preguntas(producto_compra "A")(categoria_ropa "A")(tipo_ropa "A"))
    =>
    (printout t crlf "La pagina web recomendada es: qwertee.com" crlf)
)
(defrule tipo_ropa_pantalones
    (preguntas(producto_compra "A")(categoria_ropa "A")(tipo_ropa "B"))
    =>
    (printout t crlf "La pagina web recomendada es: buy-jeans.net" crlf)
)
(defrule tipo_ropa_zapatos
    (preguntas(producto_compra "A")(categoria_ropa "A")(tipo_ropa "C"))
    =>
    (printout t crlf "La pagina web recomendada es: Sotckx.com" crlf)
)

(defrule tipo_ropa_en_general
    (preguntas(producto_compra "A")(categoria_ropa "B"))
    =>
    (printout t crlf "La pagina web recomendada es: forever21.com" crlf)
)

;-----------------Conclusiones electronicos--------------------

(defrule computadora_mesa_nueva
    (preguntas(tipo_compra_electronicos "A")(estado_producto_electonicos "A"))
    =>
    (printout t crlf "La pagina web recomendada es: newegg.com/catergoty/ID23" crlf)
)
(defrule computadora_mesa_usada
    (preguntas(tipo_compra_electronicos "A")(estado_producto_electonicos "B"))
    =>
    (printout t crlf "La pagina web recomendada es: Amazon Warehouse | Personal computers" crlf)
)