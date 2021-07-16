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
    n = 1
    empty_image = List.duplicate(@empty_char, @columns * @rows)
    image = SierpinskiTriangle.split_triangle(n, %Triangle{}, empty_image)
    SierpinskiTriangle.print(image)
  end

  def split_triangle(n, triangle, image) do
    case 0 do
      ^n ->
        # base case
        half_trg_wd = (triangle.right_col - triangle.left_col) / 2
        y = triangle.top_row
        y_final = triangle.top_row + triangle.height
        tint_image(image, y, y_final, half_trg_wd)

      _ ->
        # general case
        width = triangle.right_col - triangle.left_col

        top = %Triangle{
          top_row: triangle.top_row,
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

        image_modified = split_triangle(n - 1, top, image)
        image_modified_again = split_triangle(n - 1, left, image_modified)
        split_triangle(n - 1, right, image_modified_again)
    end
  end

  def tint_image(image, y, y_final, half_trg_wd) do
    x = half_trg_wd - y
    x_final = half_trg_wd + y
    offset = y * half_trg_wd * 2
    image_modified = tint_line(image, offset, x, x_final)

    case y do
      ^y_final ->
        image_modified

      _ ->
        tint_image(image_modified, y + 1, y_final, half_trg_wd)
    end
  end

  def tint_line(image, offset, x, x_final) do
    image_modified = List.replace_at(image, offset + x, @filled_char)

    case x do
      x_final ->
        image_modified

      _ ->
        tint_line(image_modified, offset, x + 1, x_final)
    end
  end

  def print(image) do
    for y <- 0..@rows do
      for x <- 0..@columns do
        IO.write(Enum.at(image, y * @columns + x))
      end
    end
  end
end
