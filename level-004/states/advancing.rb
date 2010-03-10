class Advancing < State
  def self.enter(player)
    if player.warrior.feel.enemy?
      player.warrior.attack!
    else
      player.warrior.walk!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.health_critical?
      player.current_state = Retreating
    else
      if player.warrior.feel.enemy?
        player.warrior.attack!
      else
        player.warrior.walk!
      end
    end
  end

end
