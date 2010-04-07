class Retreating < State
  def self.enter(player)
    player.warrior.walk!(:backward) if player.warrior.feel.enemy?
  end

  def self.exit(player)
  end

  def self.execute(player)
    player.current_state = Resting
  end
end
