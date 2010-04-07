require 'state'
require 'state_machine'
Dir["#{File.dirname(__FILE__)}/states/**/*.rb"].each { |f| require f }

class Player

  include StateMachine

  attr_accessor :warrior

  def initialize
    @current_state = Walking
  end

  def play_turn(warrior)
    @warrior = warrior
    current_state.execute(self)
  end
end
