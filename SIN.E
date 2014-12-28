-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback to update the register with the sin in degrees of the
--           number that was in there before.

class SINCOMMAND

inherit MODEL_COMMAND
        FUNC_IDRS

feature 

  execute (notused : ANY) is
  do
    register.one_arg_func (sin)
  end

end
