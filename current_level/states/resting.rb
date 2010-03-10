class Resting < State
  def self.enter(player)
    player.rest!
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.under_attack?
      player.current_state = Advancing
    else
      if player.health_full?
        player.rest!
      else
        player.current_state = Walking
      end
    end
  end
end
