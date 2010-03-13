require 'state'
require 'state_machine'
Dir["#{File.dirname(__FILE__)}/states/**/*.rb"].each { |f| require f }

class Player

  MAX_HEALTH = 20
  DANGER_HEALTH = 10
  CRIT_HEALTH = 3

  include StateMachine

  attr_accessor :warrior, :prev_health

  def initialize
    @current_state = Walking
    @prev_health = MAX_HEALTH
  end

  def play_turn(warrior)
    @warrior = warrior
    current_state.execute(self)
  end

  def under_attack?
    @warrior.health < @prev_health
  end

  def health_full?
    @warrior.health == MAX_HEALTH
  end

  def health_danger?
    @warrior.health <= DANGER_HEALTH
  end

  def health_critical?
    @warrior.health <= CRIT_HEALTH
  end
end
