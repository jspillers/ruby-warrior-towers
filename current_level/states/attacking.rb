class Attacking < State
  def self.enter(player)
    if !player.feel.enemy? && player.see_enemy? && player.first_enemy_in_los
      player.shoot!
    else
      player.attack!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.health_danger?
      player.current_state = Retreating
    else
      if player.sorted_threats
        player.shoot!(sorted_threats.first[0])
      elsif player.feel.enemy?
        player.attack!
      else
        player.current_state = Walking
      end
    end
  end
end
