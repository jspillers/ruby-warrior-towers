class Attacking < State
  def self.enter(player)
    player.attack!
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.health_danger?
      player.current_state = Retreating
    else
      if player.feel.enemy?
        player.attack!
      else
        player.current_state = Walking
      end
    end
  end
end
