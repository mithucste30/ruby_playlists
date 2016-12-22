# adding a workaround so that we can inherit class instance variables from a parent class.

class Ploygon
  @sides = 5
  def self.sides
    @sides
  end
end

class Triangle < Polygon
  @sides = 3
end

class Octagon < Ploygon
end

Polygon.sides #=> 5
Triangle.sides #=> 3
Octagon.sides #= nil

# now we will write a module that will help us share class instance variable among subclasses.

module ShareClassIntanceVariable
  
  def included klass
    klass.extend ClassMethods
  end
  
  module ClassMethods
    def inheritable_attributes *args
      @inheritable_attributes ||= [:inheritable_attributes] # this method (:inheritable_attributes) itself should also be inheritable.
      @inheritable_attributes += args
      args.each do |arg|
        class << self
          attr_accessor arg.to_sym
        end
      end
    end
    
    def inherited subclass
      @inheritable_attributes.each do |inheritable_attribute|
        instance_var = "@#{inheritable_attribute}"
        subclass.instance_variable_set(instance_var, instance_variable_get(instance_var))
      end
    end
  end

end



