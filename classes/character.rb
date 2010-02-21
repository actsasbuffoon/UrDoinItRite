class Character
  
  attr_accessor :x, :y, :z, :window, :model, :direction, :walk_phase, :move_speed
  
  def initialize(window, args = {})
    @window = window
    args.each_pair {|k, v| send("#{k}=", v)}
    @walk_phase ||= 0
    @walk_order = [1, 0, 1, 2]
    
    @walk_animation = Animation.new(self, :length => 10)
    @walk_animation.on_step {|c| c.walk_phase += 1}
    @walk_animation.on_stop {|c| c.walk_phase = 0}
  end
  
  def move(d)
    @direction = d
    case d
    when :up
      @y -= @move_speed
    when :down
      @y += @move_speed
    when :left
      @x -= @move_speed
    when :right
      @x += @move_speed
    end
    
    @walk_animation.start unless @walk_animation.state == :running
    @walk_animation.update
  end
  
  def facing
    case @direction || :down
    when :up
      0
    when :right
      1
    when :down
      2
    when :left
      3
    end
  end
  
  def walk_state
    @walk_phase = 0 if @walk_phase > 3
    @walk_order[@walk_phase]
  end
  
  def stop_moving
    @walk_animation.stop
  end
  
  def draw
    window.images[:characters][model][facing][walk_state].draw(x, y, z)
  end
  
end