class Walking < State
  def enter(context)
  end

  def exit(context)
  end

  def execute(context)
    context.warrior.walk!
  end
end
