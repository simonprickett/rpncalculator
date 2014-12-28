-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Supplied MVC class.

class MODEL_VIEW

inherit MVC_VIEW
        MODEL

creation make

feature

  display_area : LABEL

  make(d_a : LABEL) is  -- The interface building class will have to create us
    do 
      display_area := d_a
      register.set_dependant (Current)
    end

  update is
    do
      display_area.set_text (register.value.out)
    end

end

