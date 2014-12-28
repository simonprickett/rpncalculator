-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Redefinition of the Eiffel PUSH_B class to make it more
--           appropriate for the calculator buttons which need a 
--           colour and a text value.

class CALC_BUTTON

inherit PUSH_B
  rename make as make_pushb end
  
creation make

feature
  
  make (name : STRING; colour : COLOR; form : FORM) is
  do
    -- Make a push button.
    
    make_pushb (name, form)
    
    -- Set it up with a text and a colour.
    
    set_text (name)
    set_background_color (colour)
  end
  
end
    
