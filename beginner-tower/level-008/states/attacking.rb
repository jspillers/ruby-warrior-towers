class Attacking < State
  def self.enter(player)
    if !player.feel.enemy? && player.see_enemy? && player.los_to_nearest_enemy?
      player.shoot!
    else
      player.attack!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    if (player.health_danger? && !player.feel_archer?) || player.los_to_wizard?
      player.current_state = Retreating
    else
      if player.los_to_nearest_enemy?
        player.shoot!
      elsif player.feel.enemy?
        player.attack!
      else
        player.current_state = Walking
      end
    end
  end
end
