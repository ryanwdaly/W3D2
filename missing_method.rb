class MissingMethod

  def hello(anything)
    puts "hello #{anything}"
  end

  def method_missing(method_name)
    method_name = method_name.to_s
    if method_name.start_with?('hello')
      hello(method_name['hello'.length...method_name.length])
    else
      "you messed up"
    end

  end
end

a = MissingMethod.new

a.hello_dolly

a.hello_JollyJohn
