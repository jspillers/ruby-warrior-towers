require 'state'
require 'state_machine'
require 'sensory_extension'

# snag all the state class definitions
Dir["#{File.dirname(__FILE__)}/states/**/*.rb"].each { |f| require f }

class Player

  MAX_HEALTH = 20
  DANGER_HEALTH = 10
  CRIT_HEALTH = 3

  DIRS = [:forward, :right, :backward, :left]

  include StateMachine
  include SensoryExtension

  attr_accessor :warrior, :turn_count, :health_history, :action_history, :current_direction

  def initialize
    @current_direction = :forward
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
    @health_history << @warrior.health

    if @turn_count == 1
      self.current_state = Idle
    else
      current_state.execute(self)
    end
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

  def opposite_direction
    DIRS[DIRS.index(@current_direction) - 2]
  end

  def set_opposite_direction!
    @current_direction = DIRS[DIRS.index(@current_direction) - 2]
  end

  def feel
    @warrior.feel(@current_direction)
  end

  # this creates a method for each action type being tracked in @action_history
  # allowing the events to be put into this array in a single place rather
  # than sprinkled all throughout the various state classes...
  # after logging the event then delegate the method back to warrior 
  # (which actually performs the action)
  [:attack!, :rescue!, :walk!].each do |meth|

    action_type = meth.to_s.gsub('!','').to_sym

    define_method(meth) do |*args|

      # default to @current_direction unless told otherwise
      direction = args && args.first ? args.first : @current_direction

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

  # attempts to delegate unknown methods to the warrior object so 
  # that the player object becomes the single context interface 
  # needed within the state classes
  def method_missing(method, *args)
    if @warrior.respond_to?(method)
      @warrior.send(method.to_sym, *args)
    else
      super
    end
  end

end
