-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Callback for the OK button, hides the About box.

class OKCOMMAND

inherit COMMAND

feature 

  execute (aboutbox : MESSAGE_D) is
  do
    aboutbox.popdown
  end

end
