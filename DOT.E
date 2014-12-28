-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the . button, inserts a decimal point into the number
--           being made up in the register if this is allowed.

class DOTCOMMAND

inherit MODEL_COMMAND

feature 

  execute (notused : ANY) is
  do
    register.insert (".")
  end

end
