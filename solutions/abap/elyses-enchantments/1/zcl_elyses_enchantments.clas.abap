CLASS zcl_elyses_enchantments DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    TYPES ty_stack TYPE STANDARD TABLE OF i WITH EMPTY KEY.

    "! Get card at position
    METHODS get_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
      RETURNING VALUE(result) TYPE i.

    "! Replace card at position
    METHODS set_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
                replacement   TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "Add card to stack
    METHODS insert_item_at_top
      IMPORTING stack         TYPE ty_stack
                new_card      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "! Remove card at position
    METHODS remove_item
      IMPORTING stack         TYPE ty_stack
                position      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "! Remove top card (last row)
    METHODS remove_item_from_top
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE ty_stack.

    "! Add card to bottom of stack (first row)
    METHODS insert_item_at_bottom
      IMPORTING stack         TYPE ty_stack
                new_card      TYPE i
      RETURNING VALUE(result) TYPE ty_stack.

    "! Remove bottom card (delete first row)
    METHODS remove_item_from_bottom
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE ty_stack.

    "! Count cards
    METHODS get_size_of_stack
      IMPORTING stack         TYPE ty_stack
      RETURNING VALUE(result) TYPE i.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_elyses_enchantments IMPLEMENTATION.

  METHOD get_item.
    result = stack[ position ].
  ENDMETHOD.


  METHOD set_item.
    DATA lt_stack TYPE ty_stack.
    lt_stack = stack.
  
    lt_stack[ position ] = replacement.
  
    result = lt_stack.
  ENDMETHOD.

  METHOD insert_item_at_top.
     DATA lt_stack TYPE ty_stack.
     lt_stack = stack.
     APPEND new_card TO lt_stack.
     result = lt_stack.
  ENDMETHOD.


  METHOD get_size_of_stack.
      DATA lt_stack TYPE ty_stack.
      DATA lv_lines TYPE i.
     lt_stack = stack.
     lv_lines = lines( lt_stack ).
     result = lv_lines.
  ENDMETHOD.


  METHOD insert_item_at_bottom.
    DATA lt_stack TYPE ty_stack.
    lt_stack = stack.
    INSERT new_card INTO lt_stack INDEX 1.
    
    result = lt_stack.
  ENDMETHOD.


  METHOD remove_item.
    DATA lt_stack TYPE ty_stack.
    lt_stack = stack.
  
    " Prüfen, ob Position gültig ist
    IF position >= 1 AND position <= lines( lt_stack ).
      DELETE lt_stack INDEX position.
    ENDIF.
  
    result = lt_stack.
  ENDMETHOD.


  METHOD remove_item_from_bottom.
    DATA lt_stack TYPE ty_stack.
    lt_stack = stack.
  
    IF lines( lt_stack ) > 0.
      DELETE lt_stack INDEX 1.
    ENDIF.
  
    result = lt_stack.
  ENDMETHOD.


  METHOD remove_item_from_top.
    DATA lt_stack TYPE ty_stack.
    lt_stack = stack.
    DATA lv_index TYPE i.

    lv_index = lines( lt_stack ).
  
    IF lines( lt_stack ) > 0.
      DELETE lt_stack INDEX lv_index.
    ENDIF.
  
    result = lt_stack.
  ENDMETHOD.

ENDCLASS.
