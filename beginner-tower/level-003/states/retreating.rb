class Retreating < State
  def self.enter(context)
    context.warrior.walk!(:backward) if context.warrior.feel.enemy?
  end

  def self.exit(context)
  end

  def self.execute(context)
    context.current_state = Resting
  end
end
