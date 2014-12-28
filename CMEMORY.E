-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Class to implement a 1 register memory.  Memory is
--           considered empty when it contains 0.

class CALC_MEMORY

inherit MVC_MODEL

creation reset

feature

  value : STRING

  reset is
  do
    value := "0"
  end

  put_in_memory (toputin : STRING) is
  do
    value := clone (toputin)
  end

end
