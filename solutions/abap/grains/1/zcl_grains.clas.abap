CLASS zcl_grains DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES type_result TYPE p LENGTH 16 DECIMALS 0.
    METHODS square
      IMPORTING
        input         TYPE i
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
    METHODS total
      RETURNING
        VALUE(result) TYPE type_result
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_grains IMPLEMENTATION.
  METHOD square.
    IF input <= 0 OR input > 64.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.
    input = input - 1.
    result = 2 ** CONV p( input ).
  ENDMETHOD.

  METHOD total.
    result = 2 ** 64.
  ENDMETHOD.


ENDCLASS.
