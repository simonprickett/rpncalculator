-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Replaces the contents of the register with the contents of the
--           memory.

class MRCOMMAND

inherit MODEL_COMMAND

feature 

  execute (notused : ANY) is
  do
    register.set_to (memory.value) 
  end

end
