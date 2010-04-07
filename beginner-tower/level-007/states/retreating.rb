class Retreating < State
  def self.enter(player)
    player.walk!(player.opposite_direction) if player.feel.enemy? || player.under_attack?
  end

  def self.exit(player)
  end

  def self.execute(player)
    player.current_state = Resting
  end
end
