-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Performs AC command - clears the register and the stack 
--           but NOT the memory.  The memory is reset by performing a memory
--           in operation on the number 0.

class ACCOMMAND

inherit MODEL_COMMAND

feature 

  execute (notused : ANY) is
  do
    register.complete_reset
  end

end
