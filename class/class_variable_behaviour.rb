class Shape
  @@slides = 4
  def self.slides
    @@slides
  end
end

puts Shape.slides #=> 4

class Ploygon < Slides
  @@slides = 5
  def self.slides
    @@slides
  end
end

puts Polygon.slides #=> 5
puts Shape.slides #=> 5

