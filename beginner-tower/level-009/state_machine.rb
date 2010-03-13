module StateMachine

  attr_accessor :current_state, :previous_state

  def current_state=(new_state)
    if @current_state
      puts "exiting #{@prev_state.to_s} state"

      @prev_state = @current_state
      @current_state.exit(self)
    end

    @current_state = new_state

    puts "entering #{@current_state.to_s} state"
    @current_state.enter(self)
  end
end
