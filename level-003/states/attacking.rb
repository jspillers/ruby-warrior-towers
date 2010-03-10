class Attacking < State
  def self.enter(context)
    context.warrior.attack!
  end

  def self.exit(context)
  end

  def self.execute(context)
    if context.warrior.feel.enemy?
      context.warrior.attack!
    elsif context.warrior.health < context.class::DANGER_HEALTH
      context.current_state = Retreating
    else
      context.current_state = Walking
    end
  end
end
