class Tile
  
  attr_accessor :passable, :image
  
  def initialize(args = {})
    @image = args[:image]
    @passable = args[:passable]
  end
  
  def draw(x, y)
    @image.draw(x, y, 0)
  end
  
end