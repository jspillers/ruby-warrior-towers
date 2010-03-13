# idle state is the default state to drop into when exiting other states
# often the transition will be from a more specific state to another more specific
# state but very often you need a more general state that can transition into any state
class Idle < State
  def self.enter(player)

    # enemies in range?
    if !player.all_enemies_in_los.empty?
      player.current_state = Attacking

    elsif !player.see_captive?.empty? && !player.see_archer? && !player.see_wizard? && player.health_full?
      player.current_state = Rescuing

    # not under attack or adjacent to any enemy but not full health
    elsif !player.health_full? && player.all_enemies_in_los.empty?
      player.current_state = Resting

    # im all rested up and ready to move on
    else
      player.current_state = Walking
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    # should never execute in idle... idle should only change to another state on enter
    # idle is more or less a 'what should i do next' decision state
  end
end
