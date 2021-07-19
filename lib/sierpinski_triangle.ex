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
  defstruct top_row: 0, top_col: 31, height: 32, width: 63
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
    IO.puts("Doing #{n} iterations")
    empty_image = List.duplicate(@empty_char, @columns)
    new_empty = List.duplicate(empty_image, @rows)
    image = SierpinskiTriangle.split_triangle(n, %Triangle{}, new_empty)
    SierpinskiTriangle.print(image)
  end

  def split_triangle(n, triangle, image) do
    case 0 do
      ^n ->
        # base case
        y = triangle.top_row
        y_final = triangle.top_row + triangle.height - 1
        final_image = tint_image(image, 0, y, y_final, triangle.top_col)
        # _ = IO.puts("\n\n")
        # _ = print(final_image)
        final_image

      _ ->
        # general case
        new_height = (triangle.height / 2) |> floor
        new_width = (triangle.width / 2) |> floor

        top = %Triangle{
          top_row: triangle.top_row,
          top_col: triangle.top_col,
          height: new_height,
          width: new_width
        }

        left = %Triangle{
          top_row: (1 / 2 * triangle.height) |> floor,
          top_col: (1 / 4 * triangle.width) |> floor,
          height: new_height,
          width: new_width
        }

        right = %Triangle{
          top_row: left.top_row,
          top_col: (3 / 4 * triangle.width) |> floor,
          height: new_height,
          width: new_width
        }

        image_modified = split_triangle(n - 1, top, image)
        image_modified_again = split_triangle(n - 1, left, image_modified)
        split_triangle(n - 1, right, image_modified_again)
    end
  end

  def tint_image(image, idx, y, y_final, start_at) do
    x = start_at - idx
    x_final = start_at + idx
    new_image = Enum.at(image, y)
    image_modified = List.replace_at(image, y, tint_line(new_image, x, x_final))

    case y do
      ^y_final ->
        image_modified

      _ ->
        tint_image(image_modified, idx + 1, y + 1, y_final, start_at)
    end
  end

  def tint_line(image, x, x_final) do
    image_modified = List.replace_at(image, x, @filled_char)

    case x do
      ^x_final ->
        image_modified

      _ ->
        tint_line(image_modified, x + 1, x_final)
    end
  end

  def print(image) do
    Enum.each(image, fn y ->
      Enum.each(y, fn x ->
        IO.write(x)
      end)

      IO.write("\n")
    end)
  end
end
