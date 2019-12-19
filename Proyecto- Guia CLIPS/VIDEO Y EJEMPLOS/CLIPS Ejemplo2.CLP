(deffacts inicio
    (materiales A papel madera tela)
    (materiales B aceite gas lubricante)
    (materiales C magnesio sodio potasio)
    (extintores A agua sustancia-quimica-seca)
    (extintores B co2 sustancia-quimica-seca)
    (extintores C co2 espuma)
)
 
(defrule tipo-incendio
    (se-quema ?material)
    (materiales ?tipo $? ?material $?)
    =>
    (assert (incendio-tipo ?tipo))
    (printout t "Hay un incendio de tipo " ?tipo crlf)
    (printout t "De que es el extintor?" crlf)
    (assert (tengo-extintor-de (read)))
)
 
(defrule tipo-extintor
    (tengo-extintor-de ?x)
    (extintores ?tipo $? ?x $?)
    =>
    (assert (tengo-extintor ?tipo ?x))
    (printout t "Tenemos un extintor de " ?x " que es de tipo " ?tipo crlf)
)
 
(defrule puedo-apagar
    (incendio-tipo ?tipo)
    (tengo-extintor ?tipo ?x)
    =>
    (assert (puedo-apagar))
    (printout t "El incendio se puede apagar con el extintor de " ?x crlf)
)
 
(defrule inicio
    (initial-fact)
    =>
    (printout t "Que se quema? " crlf)
    (assert (se-quema (read)))
)
