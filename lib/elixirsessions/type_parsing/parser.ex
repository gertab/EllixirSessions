defmodule ElixirSessions.Parser do
  @moduledoc """
  Documentation for ElixirSessions.Parser.
  """

  @doc """
  Parses a session type from a string to an Elixir datatype.

  ## Examples

      iex> ElixirSessions.hello()
      :world

      iex> s = "send '{number()}' . receive '{number()}'"
      ...> ElixirSessions.Parser.parse(s)
      {:ok, [send: '{number()}', recv: '{number()}']}

  """
  def parse(string) when is_bitstring(string), do: string |> String.to_charlist() |> parse()

  def parse(string) do
    with {:ok, tokens, _} <- lexer(string) do
      parser(tokens)
    else
      err -> err
    end
  end

  defp lexer(string) do
    # IO.inspect tokens
    :lexer.string(string)
  end

  defp parser(tokens) do
    :parse.parse(tokens)
  end

  # recompile && ElixirSessions.Parser.run
  def run() do
    :leex.file('src/lexer.xrl')
    source = "branch<neg: send 'any', neg2: send 'any'>"
    # source = "send '{:ping, pid}' . receive '{:pong}'"
    # source = "send '{string}' . choice<neg: send '{number, pid}' . receive '{number}'>"
    # source = " send 'any'.  rec X ( send 'any' . receive 'any' . rec Y. ( send '{number}' . receive '{any}' . rec Z . ( Z ) . receive '{any}' . Y ) . X )"
    parse(source)
  end
end
