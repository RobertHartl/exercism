CLASS zcl_prime_factors DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS factors
      IMPORTING
        input         TYPE int8
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS zcl_prime_factors IMPLEMENTATION.

  METHOD factors.
    DATA siegessucht TYPE integertab.
    DATA divisor TYPE i VALUE 2.

    WHILE input > 1.
      IF input MOD divisor = 0.
        APPEND divisor TO siegessucht.
        input = input / divisor.
      ELSE.
        divisor = divisor + 1.
      ENDIF.
    ENDWHILE.

    result = siegessucht.
  ENDMETHOD.

ENDCLASS.

