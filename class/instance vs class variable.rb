Instance variable on a class:

class Parent
  @things = []
  def self.things
    @things
  end
  def things
    self.class.things
  end
end

class Child < Parent
  @things = []
end

Parent.things << :car
Child.things  << :doll
mom = Parent.new
dad = Parent.new

p Parent.things #=> [:car]
p Child.things  #=> [:doll]
p mom.things    #=> [:car]
p dad.things    #=> [:car]
Class variable:

class Parent
  @@things = []
  def self.things
    @@things
  end
  def things
    @@things
  end
end

class Child < Parent
end

Parent.things << :car
Child.things  << :doll

p Parent.things #=> [:car,:doll]
p Child.things  #=> [:car,:doll]

mom = Parent.new
dad = Parent.new
son1 = Child.new
son2 = Child.new
daughter = Child.new

[ mom, dad, son1, son2, daughter ].each{ |person| p person.things }
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]
#=> [:car, :doll]

=begin
class variables are shared between a given class and its subclasses. Class instance variables belong to exactly one class; its subclasses are separate.

Why does this behavior exist? Well, everything in Ruby is an object—even classes. That means that each class has an object of the class Class (or rather, a subclass of Class) corresponding to it. (When you say class Foo, you're really declaring a constant Foo and assigning a class object to it.) And every Ruby object can have instance variables, so class objects can have instance variables, too.

The trouble is, instance variables on class objects don't really behave the way you usually want class variables to behave. You usually want a class variable defined in a superclass to be shared with its subclasses, but that's not how instance variables work—the subclass has its own class object, and that class object has its own instance variables. So they introduced separate class variables with the behavior you're more likely to want.

In other words, class instance variables are sort of an accident of Ruby's design. You probably shouldn't use them unless you specifically know they're what you're looking for.
=end
