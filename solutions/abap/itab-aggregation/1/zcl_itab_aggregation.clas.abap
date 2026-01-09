CLASS zcl_itab_aggregation DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_numbers_type,
             group  TYPE group,
             number TYPE i,
           END OF initial_numbers_type,
           initial_numbers TYPE STANDARD TABLE OF initial_numbers_type WITH EMPTY KEY.

    TYPES: BEGIN OF aggregated_data_type,
             group   TYPE group,
             count   TYPE i,
             sum     TYPE i,
             min     TYPE i,
             max     TYPE i,
             average TYPE f,
           END OF aggregated_data_type,
           aggregated_data TYPE STANDARD TABLE OF aggregated_data_type WITH EMPTY KEY.

    METHODS perform_aggregation
      IMPORTING
        initial_numbers        TYPE initial_numbers
      RETURNING
        VALUE(aggregated_data) TYPE aggregated_data.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_itab_aggregation IMPLEMENTATION.
  METHOD perform_aggregation.
    DATA sum TYPE i.
    DATA count TYPE i.
    DATA min TYPE i.
    DATA max TYPE i.
    DATA ls_agg TYPE aggregated_data_type.
    SORT initial_numbers BY group.
    LOOP AT initial_numbers INTO DATA(ls_number).
      AT NEW group.
        count = 0.
        sum = 0.
        min = ls_number-number.
        max = ls_number-number.
      ENDAT.
      
      count = count + 1.
      sum = sum + ls_number-number.
      if ls_number-number < min.
        min = ls_number-number.
      endif.
      if ls_number-number > max.
        max = ls_number-number.
      endif.
      AT END OF group.
        ls_agg-group = ls_number-group.
        ls_agg-min = min.
        ls_agg-max = max.
        ls_agg-sum = sum.
        ls_agg-count = count.
        ls_agg-average = sum / count.
        APPEND ls_agg TO aggregated_data.
      ENDAT.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
