module StateMachine

  attr_accessor :current_state, :previous_state

  def current_state=(new_state)
    if @current_state
      @prev_state = @current_state
      @current_state.exit(self)
      puts "exiting #{@prev_state.to_s} state"
    end
    @current_state = new_state
    @current_state.enter(self)
    puts "entering #{@current_state.to_s} state"
  end
end
