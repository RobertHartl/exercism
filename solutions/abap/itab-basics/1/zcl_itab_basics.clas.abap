CLASS zcl_itab_basics DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    TYPES group TYPE c LENGTH 1.
    TYPES: BEGIN OF initial_type,
             group       TYPE group,
             number      TYPE i,
             description TYPE string,
           END OF initial_type,
           itab_data_type TYPE STANDARD TABLE OF initial_type WITH EMPTY KEY.

    METHODS fill_itab
           RETURNING
             VALUE(initial_data) TYPE itab_data_type.

    METHODS add_to_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.

    METHODS sort_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
            VALUE(updated_data) TYPE itab_data_type.

    METHODS search_itab
           IMPORTING initial_data TYPE itab_data_type
           RETURNING
             VALUE(result_index) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_itab_basics IMPLEMENTATION.
  METHOD fill_itab.
     initial_data = value #( 
     ( group = 'A' number = 10  description = 'Group A-2' ) 
     ( group = 'B' number = 5  description = 'Group B' ) 
     ( group = 'A' number = 6  description = 'Group A-1' ) 
     ( group = 'C' number = 22  description = 'Group C-1' ) 
     ( group = 'A' number = 13  description = 'Group A-3' ) 
     ( group = 'C' number = 500  description = 'Group C-2' ) 
     ).
  ENDMETHOD.

  METHOD add_to_itab.
     DATA new_line TYPE initial_type.
     
    updated_data = initial_data.
  
    new_line-group       = 'A'.
    new_line-number      = 19.
    new_line-description = 'Group A-4'.
  
    APPEND new_line TO updated_data.
  ENDMETHOD.

  METHOD sort_itab.
    updated_data = initial_data.
    "add solution here
    sort updated_data by group ascending number descending.
  ENDMETHOD.

  METHOD search_itab.
    DATA ls_line TYPE initial_type.

  READ TABLE initial_data
    INTO ls_line
    WITH KEY number = 6.

  IF sy-subrc = 0.
    result_index = sy-tabix.
  ELSE.
    result_index = 0.
  ENDIF.
  ENDMETHOD.

ENDCLASS.
