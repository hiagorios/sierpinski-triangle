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
  defstruct top_row_idx: 0, top_col_idx: 31, height: 32, width: 63
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
    n = 3
    IO.puts("Doing #{n} iterations")
    empty_line = List.duplicate(@empty_char, @columns)
    empty_image = List.duplicate(empty_line, @rows)
    image = SierpinskiTriangle.split_triangle(n, %Triangle{}, empty_image)
    SierpinskiTriangle.print(image)

    # Precisa para não dar erro
    Supervisor.start_link([], strategy: :one_for_one, name: A.Supervisor)
  end

  def split_triangle(n, triangle, image) do
    case 0 do
      ^n ->
        # base case
        y = triangle.top_row_idx
        y_final = triangle.top_row_idx + triangle.height - 1
        tint_image(image, 0, y, y_final, triangle.top_col_idx)

      _ ->
        # general case
        child_height = (triangle.height / 2) |> floor
        child_width = (triangle.width / 2) |> floor

        top = %Triangle{
          top_row_idx: triangle.top_row_idx,
          top_col_idx: triangle.top_col_idx,
          height: child_height,
          width: child_width
        }

        left = %Triangle{
          # Using parent top row/col index as offset of new row/col
          top_row_idx: ((1 / 2 * triangle.height) |> floor) + triangle.top_row_idx,
          top_col_idx: top.top_col_idx - ((1 / 4 * triangle.width) |> floor) - 1,
          height: child_height,
          width: child_width
        }

        right = %Triangle{
          # Using parent top row/col index as offset of new row/col
          top_row_idx: left.top_row_idx,
          top_col_idx: ((1 / 4 * triangle.width) |> floor) + top.top_col_idx + 1,
          height: child_height,
          width: child_width
        }

        image_modified = split_triangle(n - 1, top, image)
        image_modified = split_triangle(n - 1, left, image_modified)
        split_triangle(n - 1, right, image_modified)
    end
  end

  # Start from top of row and middle of col and work the way down increasing the lateral range by 1
  def tint_image(image, offset_idx, y, y_final, start_index) do
    x = start_index - offset_idx
    x_final = start_index + offset_idx
    line_at_y = Enum.at(image, y)
    new_image = List.replace_at(image, y, tint_line(line_at_y, x, x_final))

    case y do
      # base case
      ^y_final ->
        new_image

      _ ->
        # general case
        tint_image(new_image, offset_idx + 1, y + 1, y_final, start_index)
    end
  end

  def tint_line(image, x, x_final) do
    image_modified = List.replace_at(image, x, @filled_char)

    case x do
      # base image
      ^x_final ->
        image_modified

      _ ->
        # general case
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
