CLASS zcl_phone_number DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS clean
      IMPORTING
        !number       TYPE string
      RETURNING
        VALUE(result) TYPE string
      RAISING
        cx_parameter_invalid.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.


CLASS zcl_phone_number IMPLEMENTATION.

  METHOD clean.
  DATA cleaned TYPE string.
  cleaned = number.
  REPLACE ALL OCCURRENCES OF REGEX '[^0-9]' IN cleaned WITH ''.
  IF strlen( cleaned ) = 11 AND cleaned+0(1) = '1'.
    cleaned = cleaned+1.
  ENDIF.
  IF strlen( cleaned ) <> 10.
    RAISE EXCEPTION TYPE cx_parameter_invalid.
  ENDIF.
  IF cleaned+0(1) < '2'
   OR cleaned+3(1) < '2'.
    RAISE EXCEPTION TYPE cx_parameter_invalid.
  ENDIF.

  result = cleaned.

  ENDMETHOD.
ENDCLASS.
