class Character
  
  attr_accessor :x, :y, :z, :window, :model, :direction, :walk_phase, :move_speed, :target_x, :target_y
  
  def initialize(window, args = {})
    @window = window
    args.each_pair {|k, v| send("#{k}=", v)}
    @walk_phase ||= 0
    @walk_order = [1, 0, 1, 2]
    @target_x = @x / 32
    @target_y = @y / 32
    
    @walk_animation = Animation.new(self, :length => 10)
    @walk_animation.on_step {|c| c.walk_phase += 1}
    @walk_animation.on_stop {|c| c.walk_phase = 0}
  end
  
  def move(d)
    if @target_x * 32 == @x && @target_y * 32 == @y
      @direction = d
      case d
      when :up
        @target_y -= 1
      when :down
        @target_y += 1
      when :left
        @target_x -= 1
      when :right
        @target_x += 1
      end
    end
    
    @walk_animation.start unless @walk_animation.state == :running
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
  
  def update
    @walk_animation.update
    if @target_x * 32 > @x
      @x += [@move_speed, @target_x * 32 - @x].min
    elsif @target_x * 32 < @x
      @x -= [@move_speed, @x - @target_x * 32].min
    elsif @target_y * 32 > @y
      @y += [@move_speed, @target_y * 32 - @y].min
    elsif @target_y * 32 < @y
      @y -= [@move_speed, @y - @target_y * 32].min
    else
      stop_moving if @walk_animation.state == :running
    end
  end
  
  def draw
    update
    window.images[:characters][model][facing][walk_state].draw(x, y, z)
  end
  
end