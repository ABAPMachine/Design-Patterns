*&---------------------------------------------------------------------*
*& Report  ZTEST_EAEZ_DECORATOR
*&
*&---------------------------------------------------------------------*
*&
*&
*&---------------------------------------------------------------------*
REPORT ZTEST_EAEZ_DECORATOR.

* Clase Abstracta
CLASS output DEFINITION ABSTRACT.
  PUBLIC SECTION.
    METHODS:
      process_output ABSTRACT.
ENDCLASS.

* Impresión de ALV
CLASS alvoutput DEFINITION INHERITING FROM output.
  PUBLIC SECTION.
    METHODS:
      process_output REDEFINITION.
ENDCLASS.

CLASS alvoutput IMPLEMENTATION.
  METHOD process_output.
    WRITE: / 'Standard ALV output'.
  ENDMETHOD.                    "process_output
ENDCLASS.                    "alvoutput IMPLEMENTATION

* File in server
CLASS fileserver DEFINITION INHERITING FROM output.
  PUBLIC SECTION.
    METHODS:
      process_output REDEFINITION.
ENDCLASS.

CLASS fileserver IMPLEMENTATION.
  METHOD  process_output.
    WRITE: / 'File to server'.
  ENDMETHOD.                    "process_output
ENDCLASS.                    "alvoutput IMPLEMENTATION

* Decorator pattern

CLASS opdecorator DEFINITION INHERITING FROM output.
  PUBLIC SECTION.
    METHODS:
      constructor
        IMPORTING io_decorator TYPE REF TO output,
      process_output REDEFINITION.
  PRIVATE SECTION.
    DATA: o_decorator TYPE REF TO output.
ENDCLASS.                    "opdecorator DEFINITION

CLASS opdecorator IMPLEMENTATION.
  METHOD constructor.
    super->constructor( ).
    me->o_decorator = io_decorator.
  ENDMETHOD.                    "constructor
  METHOD process_output.
    CHECK o_decorator IS BOUND.
    o_decorator->process_output( ).
  ENDMETHOD.                    "process_output
ENDCLASS.                    "opdecorator IMPLEMENTATION

* =====
CLASS op_pdf DEFINITION INHERITING FROM opdecorator.
  PUBLIC SECTION.
    METHODS: process_output REDEFINITION.
ENDCLASS.                    "op_pdf DEFINITION

*
CLASS op_pdf IMPLEMENTATION.
  METHOD process_output.
    super->process_output( ).
    WRITE: /(10) space, 'Generating PDF'.
  ENDMETHOD.                    "process_output
ENDCLASS.                    "op_pdf IMPLEMENTATION


START-OF-SELECTION.

  DATA(lo_alv) = new alvoutput( ).

  new op_pdf( lo_alv )->process_output( ).

  DATA(lo_serv) = new fileserver( ).

  new op_pdf( lo_serv )->process_output( ).