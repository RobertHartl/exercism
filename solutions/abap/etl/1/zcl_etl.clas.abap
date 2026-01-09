CLASS zcl_etl DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES:
      BEGIN OF ty_legacy_data,
        number TYPE i,
        string TYPE string,
      END OF ty_legacy_data,
      BEGIN OF ty_new_data,
        letter TYPE c LENGTH 1,
        number TYPE i,
      END OF ty_new_data,
      tty_legacy_data TYPE SORTED TABLE OF ty_legacy_data WITH UNIQUE KEY number,
      tty_new_data    TYPE SORTED TABLE OF ty_new_data WITH UNIQUE KEY letter.

    METHODS transform IMPORTING legacy_data     TYPE tty_legacy_data
                      RETURNING VALUE(new_data) TYPE tty_new_data.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_etl IMPLEMENTATION.
  METHOD transform.
    DATA wa_new TYPE ty_new_data.
    DATA wa_legacy TYPE ty_legacy_data.
    DATA scaled TYPE TABLE OF string.
    DATA lv_letter TYPE c LENGTH 1.
    DATA letters TYPE string_table.
    
    CLEAR new_data.

    LOOP AT legacy_data INTO wa_legacy.
      TRANSLATE wa_legacy-string TO LOWER CASE.
      SPLIT wa_legacy-string AT ',' INTO TABLE letters.
      
      LOOP AT letters INTO lv_letter.
        wa_new-letter = lv_letter.
        wa_new-number = wa_legacy-number.

        READ TABLE new_data WITH KEY letter = wa_new-letter          TRANSPORTING NO FIELDS.
        IF sy-subrc <> 0.
          INSERT wa_new INTO TABLE new_data.  
        ENDIF.
      ENDLOOP.
      
    ENDLOOP.
  ENDMETHOD.
ENDCLASS.
