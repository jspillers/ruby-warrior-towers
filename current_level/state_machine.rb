module StateMachine

  attr_accessor :current_state, :previous_state

  def current_state=(new_state)
    if @current_state
      @prev_state = @current_state
      @current_state.exit(self)
    end
    @current_state = new_state
    @current_state.enter(self)
  end
end
