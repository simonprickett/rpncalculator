-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback to update the register with the log base 10 of the
--           number that was in there before.

class LOG10COMMAND

inherit MODEL_COMMAND
        FUNC_IDRS

feature 

  execute (notused : ANY) is
  do
    register.one_arg_func (log10_)
  end

end
