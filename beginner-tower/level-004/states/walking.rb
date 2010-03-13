class Walking < State
  def self.enter(player)
    if player.warrior.feel.enemy?
      player.current_state = Attacking
    else
      player.warrior.walk!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.under_attack?
      player.current_state = Advancing
    else
      if player.warrior.feel.enemy?
        player.current_state = Attacking
      else
        player.warrior.walk!
      end
    end
  end
end
