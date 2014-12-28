-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the +/- button, forces the number in the
--           register to change sign.

class CSCOMMAND

inherit MODEL_COMMAND

feature 

  execute (notused : ANY) is
  do
    register.change_sign
  end

end
