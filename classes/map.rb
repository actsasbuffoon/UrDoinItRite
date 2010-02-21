class Map
  
  attr_accessor :tiles, :width, :height, :window
  
  def initialize(window, args = {})
    @window = window
    args.each_pair {|k, v| send("#{k}=", v)}
    @tiles = []
    height.times {@tiles << []}
  end
  
  def draw
    @tiles.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        tile.draw(y * 32, x * 32, 0) if tile
      end
    end
  end
  
  def create(tileset, int_map)
    int_map.each_with_index do |row, x|
      row.each_with_index do |tile, y|
        @tiles[x][y] = tileset[tile[0]][tile[1]]
      end
    end
  end
  
end