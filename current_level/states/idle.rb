# idle state is the default state to drop into when exiting other states
# often the transition will be from a more specific state to another more specific
# state but very often you need a more general state that can transition into any state
class Idle < State
  def self.enter(player)
    puts "entering #{self.to_s} state..."
  end

  def self.exit(player)
    puts "exiting #{self.to_s} state..."
  end

  def self.execute(player)
    # if engaged with enemy and not below health danger threshold
    # then attack the enemy
    if player.feel.enemy? && !player.health_danger?
      player.current_state = Attacking
    end

    # if there is a captive in front of you and not an enemy then
    # rescue that poor sap
    if player.feel.captive? && !player.feel.enemy?
      player.current_state = Rescuing
    end

    # if under attack but no enemy touching then charge!
    if player.under_attack? && !player.feel.enemy?
      player.current_state = Advancing
    end

    # im all rested up and ready to move on
    if player.health_full? && !player.feel.enemy? && !player.under_attack?
      player.current_state = Walking
    end

    # not under attack or adjacent to any enemy but not full health
    if !player.health_full? && !player.feel.enemy? && !player.under_attack?
      player.current_state = Resting
    end

    # health is at a dangerous level and there is an enemy near me
    if player.health_danger? && player.feel.enemy?
      player.current_state = Retreating
    end

    # health is critical
    if player.health_critical?
      if player.under_attack? || player.feel.enemy?
        player.current_state = Retreating
      else
        player.current_state = Resting
      end
    end

  end
end
