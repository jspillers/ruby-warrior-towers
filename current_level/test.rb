class Foo
  attr_accessor :foos

  def initialize
    @foos = []
  end

  def set_foos(index, value)
    new_array = instance_variable_get(:@foos)
    new_array[index] = value
    instance_variable_set(:@foos, new_array)
  end
end

f=Foo.new
f.set_foos(2, "yeah!")
puts f.foos.inspect
