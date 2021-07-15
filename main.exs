# If-else
# if condition do
#   #code 
# else
#     #code
# end

# Functions:  Named functions are always defined in modules
# defmodule modulename do
#     def function_name(parameter1, parameter2) do
#         #code 
#     end
# end

# Switch-case
# case value do
#     value-1 -> #code if value matches value-1
# 	value-2 -> #code if value matches value-2
# 	value-3 -> #code if value matches value-3
# 	...
# 	_ -> #code if value does not match any of the above and is similar to default in switch
# end

# Cond: used when you want to execute a piece of code based on multiple conditions
# cond do
#   condition-1 -> #code if condition is true
#   condition-2 -> #code if condition is true
#   ...
#   true -> #code if none of the above are true
# end

# Recursion
# def hello([head|tail]) do
#   IO.write("Hello #{head}\n")
#   hello tail
# end

# def hello([]) do
# end

# ==================================
# Running on Elixir 1.9.1

defmodule Triangle do 
    # Struct
    defstruct top_left: 0, top_right: 0, bottom: 0 
end

defmodule SierpinskiTriangle do

    # Constants (not really)
    @columns 63
    @rows 32
    @filled_char "O"
    @empty_char "-"

    def generate(0, state) do
        IO.puts "end"
    end
    
    def generate(n, state) do
        IO.puts "#{n}"
        t = %Triangle{top_left: 2}
        IO.puts "#{t.top_left} #{t.top_right} #{t.bottom}"
        generate n-1, state
    end

end

IO.puts "Welcome to the Sierpinski Triangle Generator!"

# Parse the input string as Integer. n contains what could be parsed. _ is the rest
{n, _} = IO.gets("Please enter the number of iterations: ") |> Integer.parse

# Main call
SierpinskiTriangle.generate(n, :test)
