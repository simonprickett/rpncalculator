-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the C button, clears the register but NOT
--           the stack or memory.  Use ACCOMMAND to cleat the register
--           and the stack, and Min with 0 to clear the memory.

class CCOMMAND

inherit MODEL_COMMAND

feature 

  execute (notused : ANY) is
  do
    register.reset
  end

end
