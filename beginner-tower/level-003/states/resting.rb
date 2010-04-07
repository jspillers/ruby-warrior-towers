class Resting < State
  def self.enter(context)
    context.warrior.rest!
  end

  def self.exit(context)
  end

  def self.execute(context)
    if context.warrior.health < context.class::MAX_HEALTH
      context.warrior.rest!
    else
      context.current_state = Walking
    end
  end
end
