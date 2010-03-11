class Walking < State
  def self.enter(player)
    player.walk!
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.under_attack?
      player.current_state = Advancing
    else
      if player.feel.captive?
        player.current_state = Rescuing
      elsif player.feel.enemy?
        player.current_state = Attacking
      else
        player.walk!
      end
    end
  end

end
