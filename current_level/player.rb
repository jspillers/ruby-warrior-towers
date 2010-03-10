require 'state'
require 'state_machine'
Dir["#{File.dirname(__FILE__)}/states/**/*.rb"].each { |f| require f }

class Player

  MAX_HEALTH = 20
  DANGER_HEALTH = 10
  CRIT_HEALTH = 3

  include StateMachine

  attr_accessor :warrior, :current_action, :turn_count, :health_history, :action_history

  def initialize
    @current_state = Idle
    @turn_count = 0
    @health_history = [MAX_HEALTH]
    @action_history = {
      :attack => [nil],
      :walk   => [nil],
      :rescue => [nil]
    }
  end

  def play_turn(warrior)
    @turn_count += 1
    @warrior = warrior
    current_state.execute(self)
    @health_history << @warrior.health
  end

  def under_attack?
    @warrior.health < previous_health
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

  def previous_health
    @health_history[@turn_count - 1]
  end

  # this creates a method for each action we are trying to track.
  # We first start by calling these actions on the player object 
  # rather than the warrior object so that we can log their occurence
  # in time and then delegate back to the warrior object that 
  # actually performs the action
  [:attack!, :rescue!, :walk!].each do |meth|

    action_type = meth.to_s.gsub('!','').to_sym

    define_method(meth) do |*args|

      # default to :forward unless told otherwise
      direction = args && args.first ? args.first : :forward 

      # remove the '!' so we can use the symbol as a key to group our actions by

      # log the direction of the action (implied truth) for the given turn count
      # any turn where a given action didn't happen will be nil
      @action_history[action_type][@turn_count] = direction

      # pass along the method to the warrior object
      @warrior.send(meth, direction)
    end

    define_method("previously_#{action_type}ing?".to_sym) do
      @action_history[action_type][@turn_count - 1]
    end
  end

  # attempt to delegate methods to the warrior
  # class to make state implementations cleaner
  # and allow tracking of said method calls where 
  # needed (ie: in @action_history)
  def method_missing(method, *args)
    if @warrior.respond_to?(method)
      @warrior.send(method.to_sym, *args)
    else
      super
    end
  end

end
