defmodule MathJax do
  @moduledoc """
  This library provides an Elixir wrapper around the Rust
  [mathjax_svg](https://github.com/gw31415/mathjax_svg) library. This allows you
  render SVGs and PNGs of mathematical expressions right in Elixir.
  """

  alias MathJax.Native

  @doc """
  Render a mathematical expression as a standalone block. The rendered
  expression has looser margins and is meant to be displayed as a
  standalone figure versus inline with text. If you need to render
  expressions inline with text, take a look at the `render_inline/2`
  function.
  """
  def render(expression, :svg) do
    expression
    |> Native.render_svg()
    |> wrap_result()
  end

  def render(expression, :png) do
    render(expression, {:png, 3.0})
  end

  def render(expression, {:png, scale}) do
    expression
    |> Native.render_png(scale)
    |> wrap_result()
  end

  @doc """
  Same as `render/1` but raises on error and returns
  just the result on success.
  """
  def render!(expression, format) do
    case render(expression, format) do
      {:ok, result} -> result
      {:error, reason} -> raise "MathJax rendering failed: #{inspect(reason)}"
    end
  end

  @doc """
  Render a mathematical expression inline. The rendered
  expression has tighter margins and the display is much tighter.
  """
  def render_inline(expression, :svg) do
    expression
    |> Native.render_svg_inline()
    |> wrap_result()
  end

  def render_inline(expression, :png) do
    render_inline(expression, {:png, 2.0})
  end

  def render_inline(expression, {:png, scale}) do
    expression
    |> Native.render_png_inline(scale)
    |> wrap_result()
  end

  @doc """
  Same as `render_inline/1` but raises on error and returns
  just the result on success.
  """
  def render_inline!(expression, format) do
    case render_inline(expression, format) do
      {:ok, result} -> result
      {:error, reason} -> raise "MathJax rendering failed: #{inspect(reason)}"
    end
  end

  # ---- Private helpers ----
  defp wrap_result(result) when is_binary(result) do
    {:ok, result}
  end

  defp wrap_result(error) do
    error
  end
end
