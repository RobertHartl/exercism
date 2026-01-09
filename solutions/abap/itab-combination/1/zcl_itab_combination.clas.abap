CLASS zcl_itab_combination DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    TYPES: BEGIN OF alphatab_type,
             cola TYPE string,
             colb TYPE string,
             colc TYPE string,
           END OF alphatab_type.
    TYPES alphas TYPE STANDARD TABLE OF alphatab_type.

    TYPES: BEGIN OF numtab_type,
             col1 TYPE string,
             col2 TYPE string,
             col3 TYPE string,
           END OF numtab_type.
    TYPES nums TYPE STANDARD TABLE OF numtab_type.

    TYPES: BEGIN OF combined_data_type,
             colx TYPE string,
             coly TYPE string,
             colz TYPE string,
           END OF combined_data_type.
    TYPES combined_data TYPE STANDARD TABLE OF combined_data_type WITH EMPTY KEY.

    METHODS perform_combination
      IMPORTING
        alphas TYPE alphas
        nums   TYPE nums
      RETURNING
        VALUE(combined_data) TYPE combined_data.

ENDCLASS.

CLASS zcl_itab_combination IMPLEMENTATION.

METHOD perform_combination.
  DATA: wa_alpha TYPE alphatab_type,
        wa_num   TYPE numtab_type,
        wa_comb  TYPE combined_data_type,
        lv_counter TYPE i.

  lv_counter = 1.

  LOOP AT alphas INTO wa_alpha.
    READ TABLE nums INTO wa_num INDEX lv_counter.
    IF sy-subrc = 0.
      wa_comb-colx = wa_alpha-cola && wa_num-col1.
      wa_comb-coly = wa_alpha-colb && wa_num-col2.
      wa_comb-colz = wa_alpha-colc && wa_num-col3.

      APPEND wa_comb TO combined_data.
    ENDIF.
    lv_counter = lv_counter + 1.
  ENDLOOP.
ENDMETHOD.

ENDCLASS.
