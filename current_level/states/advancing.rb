class Advancing < State
  def self.enter(player)
    if player.feel.enemy?
      player.attack!
    else
      player.walk!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.health_critical?
      player.current_state = Retreating
    else
      if player.feel.enemy?
        player.attack!
      else
        if player.previously_attacking? && !player.feel.enemy? && !player.under_attack?
          player.current_state = Resting
        else
          player.walk!
        end
      end
    end
  end

end
