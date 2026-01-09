CLASS zcl_high_scores DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES integertab TYPE STANDARD TABLE OF i WITH EMPTY KEY.
    METHODS constructor
      IMPORTING
        scores TYPE integertab.

    METHODS list_scores
      RETURNING
        VALUE(result) TYPE integertab.

    METHODS latest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personalbest
      RETURNING
        VALUE(result) TYPE i.

    METHODS personaltopthree
      RETURNING
        VALUE(result) TYPE integertab.
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA scores_list TYPE integertab.

ENDCLASS.


CLASS zcl_high_scores IMPLEMENTATION.

  METHOD constructor.
    me->scores_list = scores.
  ENDMETHOD.

  METHOD list_scores.
    result = scores_list.
  ENDMETHOD.

  METHOD latest.
  DATA lv_length TYPE i.
    lv_length = LINES( scores_list ).
    READ TABLE scores_list INDEX lv_length INTO result.
  ENDMETHOD.

  METHOD personalbest.
    DATA lv_best TYPE i.
    DATA lv_score TYPE i.
    lv_best = scores_list[ 1 ].
    LOOP AT scores_list INTO lv_score.
      if lv_score > lv_best.
        lv_best = lv_score.
      endif.
    ENDLOOP.
    result = lv_best. 
  ENDMETHOD.

  METHOD personaltopthree.
    DATA scores_copy TYPE integertab.
    DATA counter TYPE i.
    DATA lv_score TYPE i.
    scores_copy = scores_list.
    SORT scores_copy DESCENDING.
    counter = 0.
    LOOP AT scores_copy INTO lv_score.
      counter = counter + 1.
      APPEND lv_score TO result.
      IF counter = 3.
        EXIT.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.


ENDCLASS.
