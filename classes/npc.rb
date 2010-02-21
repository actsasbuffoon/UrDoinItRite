class NPC < Character
  
  attr_accessor :type, :random_direction
  
  def initialize(window, args = {})
    super window, args
    @walk_directions = [:left, :right, :up, :down]
    @random_walk_animation = Animation.new(self, :length => 30)
    
    @random_walk_animation.on_step do |c|
      @random_direction = @walk_directions[rand(@walk_directions.length)]
    end
    
    @random_walk_animation.start
  end
  
  def update
    @random_walk_animation.update
    
    if type == :random_walk
      move(@random_direction)
    end
  end
  
end