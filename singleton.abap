&---------------------------------------------------------------------*
*& Report  YSINGLETON2
*&
*&---------------------------------------------------------------------*
*&Autor: Eduardo Echeverría
*&
*&---------------------------------------------------------------------*
REPORT ysingleton2.

CLASS lcl_demo DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.

    "Método para obtener la instancia
    CLASS-METHODS: get_instance RETURNING VALUE(ref_obj) TYPE REF TO lcl_demo.

    "Métodos para asignar valores a los atributos
    METHODS: set_valor IMPORTING i_valor       TYPE char30,
             get_valor RETURNING VALUE(r_valor) TYPE char30.

  PRIVATE SECTION.

    CLASS-DATA lo_obj TYPE REF TO lcl_demo.

    DATA: lv_valor(30) TYPE c.

ENDCLASS.


CLASS lcl_demo IMPLEMENTATION.

  METHOD get_instance.

    "Validación de la creación del objeto
    IF lo_obj IS INITIAL.

      CREATE OBJECT lo_obj.

    ENDIF.

    "Asignación de referencia
    ref_obj = lo_obj.

  ENDMETHOD.

  METHOD set_valor.
    lv_valor = i_valor.
  ENDMETHOD.

  METHOD get_valor.
    r_valor = me->lv_valor.
  ENDMETHOD.


ENDCLASS.


START-OF-SELECTION.

  DATA: lr_ref_1 TYPE REF TO lcl_demo.
  DATA: lr_ref_2 TYPE REF TO lcl_demo.

  DATA: lv_msj(30) TYPE c.

  "Asignación de referencia No 1
  lr_ref_1 = lcl_demo=>get_instance( ).
  lr_ref_1->set_valor('Objeto 1').

  "Asignación de referencia No 2
  lr_ref_2 = lcl_demo=>get_instance( ).

  "Obtención del atributo
  lv_msj = lr_ref_2->get_valor( ).

  WRITE lv_msj.