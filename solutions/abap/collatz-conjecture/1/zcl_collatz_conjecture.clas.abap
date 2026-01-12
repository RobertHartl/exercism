CLASS zcl_collatz_conjecture DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    METHODS ret_steps
      IMPORTING num TYPE i
      RETURNING VALUE(steps) TYPE i
      RAISING cx_parameter_invalid.

ENDCLASS.

CLASS zcl_collatz_conjecture IMPLEMENTATION.

  METHOD ret_steps.

    DATA lv_num TYPE i.
    DATA lv_temp TYPE i.

    steps = 0.
    lv_num = num.

    " Exception für ungültige Eingabe
    IF lv_num <= 0.
      RAISE EXCEPTION TYPE cx_parameter_invalid.
    ENDIF.

    " Collatz-Loop
    WHILE lv_num > 1.
      IF lv_num MOD 2 = 0.
        lv_num = lv_num / 2.
      ELSE.
        lv_temp = lv_num * 3.
        lv_num = lv_temp + 1.
      ENDIF.
      steps = steps + 1.
    ENDWHILE.

  ENDMETHOD.

ENDCLASS.
