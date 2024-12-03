defmodule AOC2024.Input do
  def read(path) do
    if File.exists?(path) do
      File.read!(path)
    else
      session = System.get_env("AOC_SESSION")
      day_value = Regex.run(~r/(\d+)/, path) |> hd |> String.to_integer()

      if session do
        case HTTPoison.get!("https://adventofcode.com/2024/day/#{day_value}/input", [
               {"Cookie", "session=#{session}"}
             ]) do
          %HTTPoison.Response{status_code: 200, body: body} ->
            stripped = body |> String.trim()
            File.write!(path, stripped)
            stripped

          _ ->
            IO.puts("Failed to fetch input")
            System.halt(1)
        end
      else
        IO.puts("No input file found and no session cookie set")
        System.halt(1)
      end
    end
  end
end
