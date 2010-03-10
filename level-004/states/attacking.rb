class Attacking < State
  def self.enter(player)
    player.warrior.attack!
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.health_danger?
      player.current_state = Retreating
    else
      if player.warrior.feel.enemy?
        player.warrior.attack!
      else
        player.current_state = Walking
      end
    end
  end
end
