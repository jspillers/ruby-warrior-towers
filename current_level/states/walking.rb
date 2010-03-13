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
      if !player.all_enemies_in_los.empty?
        player.current_state = Attacking
      else
        if player.feel.enemy?
          player.current_state = Attacking
        elsif player.feel.captive?
          player.current_state = Rescuing
        else
          player.walk!
        end
      end
    end
  end

end
