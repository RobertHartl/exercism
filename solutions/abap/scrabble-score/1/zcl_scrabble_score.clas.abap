CLASS zcl_scrabble_score DEFINITION PUBLIC .

  PUBLIC SECTION.
    METHODS score
      IMPORTING
        input         TYPE string OPTIONAL
      RETURNING
        VALUE(result) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.


CLASS zcl_scrabble_score IMPLEMENTATION.
  METHOD score.
  DATA char TYPE c LENGTH 1.
  DATA input_upper TYPE string.
  DATA len TYPE i.
  DATA idx TYPE i.

  IF input IS INITIAL.
    result = 0.
    RETURN.
  ENDIF.

  input_upper = input.
  TRANSLATE input_upper TO UPPER CASE.
  len = strlen( input_upper ).
  result = 0.

  DO len TIMES.
    idx = sy-index - 1.
    char = input_upper+idx(1).

    " Hier kommt die kurze Logik
    IF char = 'A' OR char = 'E' OR char = 'I' OR char = 'O' OR char = 'U' OR
       char = 'L' OR char = 'N' OR char = 'R' OR char = 'S' OR char = 'T'.
      result = result + 1.
    ELSEIF char = 'D' OR char = 'G'.
      result = result + 2.
    ELSEIF char = 'B' OR char = 'C' OR char = 'M' OR char = 'P'.
      result = result + 3.
    ELSEIF char = 'F' OR char = 'H' OR char = 'V' OR char = 'W' OR char = 'Y'.
      result = result + 4.
    ELSEIF char = 'K'.
      result = result + 5.
    ELSEIF char = 'J' OR char = 'X'.
      result = result + 8.
    ELSEIF char = 'Q' OR char = 'Z'.
      result = result + 10.
    ENDIF.
  ENDDO.

ENDMETHOD.



ENDCLASS.
