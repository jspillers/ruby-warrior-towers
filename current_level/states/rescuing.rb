class Rescuing < State
  def self.enter(player)
    if !player.see_captive?.empty?
      player.walk!(player.see_captive?.first)
    else
      player.rescue!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    captive_direction = player.see_captive?.first

    if !player.all_enemies_in_los.empty?
      player.current_state = Attacking
    elsif captive_direction && !player.feel(captive_direction).captive?
      player.walk!(captive_direction)
    elsif player.feel(captive_direction).captive?
      player.rescue!(captive_direction)
    else
      player.current_state = Idle
    end
  end
end
