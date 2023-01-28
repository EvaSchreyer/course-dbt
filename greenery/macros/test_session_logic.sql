{% test session_logic(model, column_name1, column_name2) %}


   select *
   from {{ model }}
   where {{column_name1}} > {{column_name2}}


{% endtest %}