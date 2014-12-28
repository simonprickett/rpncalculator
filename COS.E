-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the COS button, calls the register op to
--           calculate the cosine of the value of the register in
--           degrees.

class COSCOMMAND

inherit MODEL_COMMAND
        FUNC_IDRS

feature 

  execute (notused : ANY) is
  do
    register.one_arg_func (cos)
  end

end
