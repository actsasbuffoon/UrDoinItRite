class GameWindow < Gosu::Window
  
  attr_accessor :images
  
  def initialize
    super 640, 480, false
    self.caption = "My super exciting new game. Whatever. No big deal."
    
    setup_resources
    
    @map = Map.new(self, :width => 20, :height => 15)
    
    @map.create(
      @images[:tilesets][:ship_interior],
      [
        [[2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3]],
        [[2, 3], [3, 0], [3, 1], [3, 1], [3, 1], [3, 2], [2, 3], [2, 3], [2, 3], [3, 0], [3, 1], [3, 1], [3, 1], [3, 1], [3, 1], [3, 1], [3, 1], [3, 1], [3, 2], [2, 3]],
        [[2, 3], [0, 0], [0, 1], [0, 1], [0, 1], [0, 2], [2, 3], [2, 3], [2, 3], [0, 0], [0, 1], [0, 1], [0, 1], [0, 1], [0, 1], [0, 1], [0, 1], [0, 1], [0, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3], [2, 3], [2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 2], [3, 0], [3, 1], [3, 2], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [0, 1], [0, 1], [0, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [3, 0], [3, 1], [3, 1], [3, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [0, 1], [0, 1], [0, 1], [0, 2], [2, 3]],
        [[2, 3], [1, 0], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 1], [1, 2], [2, 3]],
        [[2, 3], [2, 0], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 1], [2, 2], [2, 3]],
        [[2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3], [2, 3]]
        
      ]
    )
    
    @player = Player.new(self, :model => :moustache_man, :x => 1, :y => 1, :z => 1, :move_speed => 2)
    @npcs = []
    100.times {|i| @npcs << NPC.new(self, :model => [:scientist, :king, :queen, :blue_dress, :funky_cape][rand(5)], :x => rand(800), :y => rand(600), :z => 1, :move_speed => 1)}
    @npcs.each {|npc| npc.type = :random_walk}
  end
  
  def update
    if button_down? Gosu::Button::KbRight
      @player.move :right
    elsif button_down? Gosu::Button::KbDown
      @player.move :down
    elsif button_down? Gosu::Button::KbLeft
      @player.move :left
    elsif button_down? Gosu::Button::KbUp
      @player.move :up
    end
    @npcs.each do |npc|
      npc.update
    end
  end
  
  def button_up(key)
    if [Gosu::Button::KbRight, Gosu::Button::KbDown, Gosu::Button::KbLeft, Gosu::Button::KbUp].include?(key)
      @player.stop_moving
    end
  end
  
  def draw
    @map.draw
    @player.draw
    @npcs.each {|npc| npc.draw}
  end
  
  def setup_resources
    @images = {}
    @images[:characters] = resource("characters")
    @images[:tilesets] = resource("tilesets")
  end
  
  def resource(directory)
    t = {}
    Dir.glob("resources/images/#{directory}/*").each do |dir|
      next unless File.directory?(dir)
      model = dir.split("/").last.to_sym
      t[model] = []
      Dir.glob("#{dir}/*.png").each do |img|
        name = File.basename img, ".png"
        t[model][name.split("_").first.to_i] ||= []
        begin
          t[model][name.split("_").first.to_i][name.split("_").last.to_i] = Gosu::Image.new(self, img, false)
        rescue
          puts "Couldn't load #{img}: #{$!}"
        end
      end
    end
    t
  end
  
end