-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the 2 button, inserts a 2 into the number
--           being made up in the register.

class B2COMMAND

inherit MODEL_COMMAND

feature 

  execute (notused : ANY) is
  do
    register.insert ("2")
  end

end
