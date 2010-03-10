class Rescuing < State
  def self.enter(player)
    puts "entering #{self.to_s} state..."
  end

  def self.exit(player)
    puts "exiting #{self.to_s} state..."
  end

  def self.execute(player)
    if player.feel.captive?
      player.rescue!
    else
      player.current_state = Idle
    end
  end
end
