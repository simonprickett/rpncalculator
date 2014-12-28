-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Supplied MVC model class.

class MODEL

feature 

  register : CALC_REGISTER is
    once
      !!Result.reset
  end

  memory : CALC_MEMORY is
    once
      !!Result.reset
  end

end
