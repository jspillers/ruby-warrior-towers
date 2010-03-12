class Rescuing < State
  def self.enter(player)
    player.rescue!
  end

  def self.exit(player)
  end

  def self.execute(player)
    player.current_state = Idle
  end
end
