-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Set of unique identifiers to identify the functions that
--           can be applied to the register and register & stack.

class FUNC_IDRS

feature

  cos, sin, tan, sqrt_, log_, log2_, log10_, add, mult, sub, 
  div : INTEGER is unique

end
