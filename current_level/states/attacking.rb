class Attacking < State
  def self.enter(player)
    if !player.feel.enemy? && !player.all_enemies_in_los.empty?
      player.shoot!(player.all_enemies_in_los.first[0])
    else
      player.attack!
    end
  end

  def self.exit(player)
  end

  def self.execute(player)
    puts player.all_enemies_in_los.map {|e| e[1].class.to_s}.inspect

    if player.health_danger?
      player.current_state = Retreating
    else
      if !player.all_enemies_in_los.empty?
        player.shoot!(player.all_enemies_in_los.first[0])
      elsif player.feel.enemy?
        player.attack!
      else
        player.current_state = Walking
      end
    end
  end
end
