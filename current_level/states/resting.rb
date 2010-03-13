class Resting < State
  def self.enter(player)
    if !player.all_enemies_in_los.empty?
      player.current_state = Attacking
    else
      player.rest!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    if !player.all_enemies_in_los.empty?
      player.current_state = Attacking
    else
      if !player.health_full?
        player.rest!
      else
        player.current_state = Walking
      end
    end
  end
end
