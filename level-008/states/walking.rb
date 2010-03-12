class Walking < State
  def self.enter(player)
    if player.feel.wall?
      player.pivot!(player.opposite_direction)
    else
      player.walk!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    if player.feel.wall?
      player.pivot!(player.opposite_direction)
    else
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

end
