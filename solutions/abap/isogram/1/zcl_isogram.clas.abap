CLASS zcl_isogram DEFINITION PUBLIC.
  PUBLIC SECTION.
    METHODS is_isogram
      IMPORTING
        VALUE(phrase) TYPE string
      RETURNING
        VALUE(result) TYPE abap_bool.
ENDCLASS.

CLASS zcl_isogram IMPLEMENTATION.

  METHOD is_isogram.
    DATA seen_letters TYPE STANDARD TABLE OF string WITH EMPTY KEY.
    DATA letter TYPE string.
    DATA lower_phrase TYPE string.

    result = abap_true.

    lower_phrase = phrase.
    TRANSLATE lower_phrase TO LOWER CASE.

    WHILE strlen( lower_phrase ) > 0.
      letter = lower_phrase+0(1).

      IF letter = ' ' OR letter = '-'.
        " Buchstabe ignorieren
      ELSE.
        READ TABLE seen_letters WITH KEY table_line = letter TRANSPORTING NO FIELDS.
        IF sy-subrc = 0.
          result = abap_false.
          RETURN.
        ENDIF.
        APPEND letter TO seen_letters.
      ENDIF.

      " ersten Buchstaben entfernen
      lower_phrase = lower_phrase+1.
    ENDWHILE.

  ENDMETHOD.

ENDCLASS.
