-- CS313 Object-Oriented Design
-- Coursework Part 2
-- Date    : 12 March 1996
-- Student : Simon Prickett
-- Marker  : Dr E F Elsworth

-- Purpose : Supplied MVC class.

class MVC_MODEL

feature
  dependant : MVC_VIEW

  set_dependant (v : MVC_VIEW) is do dependant := v end

  notify_dependant is 
   do 
     if dependant /= void then 
        dependant.update 
     end 
   end

end
