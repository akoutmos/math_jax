defmodule MathJaxTest do
  use ExUnit.Case

  describe "The render/2 function" do
    test "should render a valid mathematical expression as an SVG" do
      assert is_binary(MathJax.render("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :svg))
    end

    test "should render a valid mathematical expression as an PNG" do
      assert is_binary(MathJax.render("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :png))
    end
  end

  describe "The render_inline/2 function" do
    test "should render a valid mathematical expression as an SVG" do
      assert is_binary(MathJax.render_inline("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :svg))
    end

    test "should render a valid mathematical expression as an PNG" do
      assert is_binary(MathJax.render_inline("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :png))
    end
  end
end
