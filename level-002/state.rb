class State

  def enter(context)
    raise "cannot call this method on the abstract class"
  end

  def exit(context)
    raise "cannot call this method on the abstract class"
  end

  def execute(context)
    raise "cannot call this method on the abstract class"
  end
end
