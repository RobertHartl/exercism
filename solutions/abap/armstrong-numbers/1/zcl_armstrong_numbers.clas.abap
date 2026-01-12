CLASS zcl_armstrong_numbers DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    METHODS is_armstrong_number
      IMPORTING num TYPE i
      RETURNING VALUE(result) TYPE abap_bool.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_armstrong_numbers IMPLEMENTATION.
  METHOD is_armstrong_number.
    DATA number_string TYPE string.
    DATA number_solution TYPE i.

    number_string = |{ num }|.
    DATA lv_len TYPE i.
    lv_len = strlen( number_string ).

    DO lv_len TIMES.
      DATA lv_pos TYPE i.
      DATA lv_digit TYPE i.
      lv_pos = sy-index - 1.
      lv_digit = number_string+lv_pos(1).  " extract 1 character
      number_solution += lv_digit ** lv_len.
    ENDDO.

    IF number_solution = num.
      result = abap_true.
    ELSE.
      result = abap_false.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
