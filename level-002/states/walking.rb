class Walking < State
  def self.enter(context)
    context.warrior.walk!
  end

  def self.exit(context)
  end

  def self.execute(context)
    if context.warrior.feel.enemy?
      context.current_state = Attacking
    else
      context.warrior.walk!
    end
  end
end
