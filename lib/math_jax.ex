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
    Native.render_svg(expression)
  end

  def render(expression, :png) do
    render(expression, {:png, 2.0})
  end

  def render(expression, {:png, scale}) do
    Native.render_png(expression, scale)
  end

  @doc """
  Render a mathematical expression inline. The rendered
  expression has tighter margins and the display is much tighter.
  """
  def render_inline(expression, :svg) do
    Native.render_svg_inline(expression)
  end

  def render_inline(expression, :png) do
    render_inline(expression, {:png, 2.0})
  end

  def render_inline(expression, {:png, scale}) do
    Native.render_png_inline(expression, scale)
  end
end
