-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the ENTER button, inserts the register value 
--           into the stack.

class ENTERCOMMAND

inherit MODEL_COMMAND
        FUNC_IDRS

feature 

  execute (notused : ANY) is
  do
    register.enter
  end

end
