module StateMachine

  attr_accessor :current_state

  def current_state=(new_state)
    if @current_state
      puts "exiting #{@current_state.class.to_s}..."
      @current_state.exit(self)
    end

    @current_state = new_state

    puts "entering #{@current_state.class.to_s}..."

    @current_state.enter(self)
  end
end
