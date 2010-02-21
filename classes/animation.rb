class Animation
  
  attr_accessor :length, :i, :state, :obj
  
  def initialize(obj, args = {})
    @obj = obj
    @state = args[:state] || :stopped
    @i = 0
    @length = args[:length]
  end
  
  def aloop
    @i += 1
    if @i == 1
      @step_proc.call(obj) if @step_proc
    end
    @i = 0 if @i == @length
  end
  
  def update
    aloop if state == :running
  end
  
  def start
    @state = :running
    @start_proc.call(obj) if @start_proc
  end
  
  def stop
    @state = :stopped
    @stop_proc.call(obj) if @stop_proc
  end
  
  def on_start(&blk)
    @start_proc = blk
  end
  
  def on_stop(&blk)
    @stop_proc = blk
  end
  
  def on_step(&blk)
    @step_proc = blk
  end
  
end