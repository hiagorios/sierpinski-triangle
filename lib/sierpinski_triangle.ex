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
# https://www.jdoodle.com/execute-elixir-online/

defmodule Triangle do
  # Struct
  defstruct left_col: 0, right_col: 62, top_row: 0, height: 32
end

defmodule SierpinskiTriangle do
  use Application
  # Constants (not really)
  @columns 63
  @rows 32
  @filled_char "O"
  @empty_char "-"

  @impl true
  def start(_type, _args) do
    # Main call
    # triangles =
    SierpinskiTriangle.generate(1, :test)
  end

  def split_triangle(0, triangle, image) do
    half_trg_wd = (triangle.right_col - triangle.left_col) / 2

    new_image =
      for y <- triangle.top..(triangle.top + triangle.height) do
        for x <- triangle.left_col..triangle.right_col do
          if half_trg_wd - y <= x and x <= half_trg_wd + y do
            List.replace_at([], y * half_trg_wd * 2 + x, @filled_char)
          end
        end
      end
  end

  def split_triangle(n, triangle, image) do
    width = triangle.right_col - triangle.left_col

    top = %Triangle{
      top_row: triangle.top,
      left_col: 1 / 4 * width,
      right_col: 3 / 4 * width,
      height: triangle.height / 2
    }

    left = %Triangle{
      top_row: top.left_col,
      left_col: triangle.left_col,
      right_col: width / 2,
      height: triangle.height / 2
    }

    right = %Triangle{
      top_row: top.right_col,
      left_col: left.right_col,
      right_col: triangle.right_col,
      height: triangle.height / 2
    }

    image = split_triangle(n - 1, top, image)
    image = split_triangle(n - 1, left, image)
    split_triangle(n - 1, right, image)
  end

  def generate(0, state) do
    IO.puts("end")
  end

  def generate(n, state) do
    [head | tail] = generate(n - 1, state)
  end
end
