-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the + button, calls the op to
--           calculate the top stack value + the register value.

class ADDCOMMAND

inherit MODEL_COMMAND
        FUNC_IDRS

feature 

  execute (notused : ANY) is
  do
    register.two_arg_func (add)
  end

end
