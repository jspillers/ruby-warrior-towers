require 'ap'
require 'state_machine'

class Player

  DIRECTIONS     = [:forward, :backward, :left, :right]
  MAX_HEALTH     = 20
  MILD_WOUND     = 15
  WOUND          = 10
  CRITICAL_WOUND = 6

  def initialize
    @spaces = {}
    super
  end

  state_machine :state, :initial => :resting do
    state :resting
    state :patrolling
    state :attacking

    before_transition any => any do |obj, transition|
      puts "TRANSITIONING FROM: #{transition.from} TO: #{transition.to} EVENT: #{transition.event}"
    end

    event :fully_healed do
      transition :resting => :patrolling
    end

    event :mildly_wounded do
      transition :attacking  => same,     :if => :enemy_near?
      transition :attacking  => :resting, :if => :no_enemy_near?
      transition :resting    => :patrolling, :if => :health_full?
      transition :resting    => same
      transition :patrolling => :resting
    end

    event :wounded do
      transition :resting => :patrolling, :if => :health_full?
      transition :resting => same
      transition [:attacking, :patrolling] => :resting
    end

    event :target_aquired do
      transition [:patrolling, :resting] => :attacking
    end

    event :target_lost do
      transition :attacking => :patrolling
    end

    state :attacking do
      def take_action
        @warrior.attack! @targets.first
      end
    end

    state :patrolling do
      def take_action
      end
    end

    state :resting do
      def take_action
        @warrior.rest!
      end
    end
  end

  def play_turn(warrior)
    @warrior = warrior
    puts "CURRENT HEALTH: #{@warrior.health}"
    observe_surroundings
    decide_action
    take_action
  end

  private

  def observe_surroundings
    @targets = []
    DIRECTIONS.each do |d|
      s = @warrior.feel(d)
      @targets << d if s.enemy?
      @spaces[s.location.join(",")] = s
    end
  end

  def decide_action
    target_aquired if @targets.size > 0
    target_lost    if @targets.size == 0
    wounded        if wounded?
    mildly_wounded if mild_wound?
    fully_healed   if health_full?
  end

  def no_enemy_near?
    enemy_near == false
  end

  def enemy_near?
    @targets.any?
  end

  def health_full?
    @warrior.health == MAX_HEALTH
  end

  def wounded?
    @warrior.health < WOUND
  end

  def mild_wound?
    @warrior.health < MILD_WOUND
  end

  def critical_wound?
    @warrior.health < CRITICAL_WOUND
  end
end
