defmodule MathJaxTest do
  use ExUnit.Case

  describe "The render/2 function" do
    test "should render a valid mathematical expression as an SVG" do
      assert {:ok, result} = MathJax.render("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :svg)
      assert is_binary(result)
    end

    test "should render a valid mathematical expression as an PNG" do
      assert {:ok, result} = MathJax.render("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :png)
      assert is_binary(result)
    end

    test "should return an error tuple when an invalid expression is provided to render to an SVG" do
      assert {:error, "Extra close brace or missing open brace"} =
               MathJax.render("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :svg)
    end

    test "should return an error tuple when an invalid expression is provided to render to an PNG" do
      assert {:error, "Extra close brace or missing open brace"} =
               MathJax.render("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :png)
    end
  end

  describe "The render!/2 function" do
    test "should render a valid mathematical expression as an SVG" do
      assert result = MathJax.render!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :svg)
      assert is_binary(result)
    end

    test "should render a valid mathematical expression as an PNG" do
      assert result = MathJax.render!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :png)
      assert is_binary(result)
    end

    test "should return an error tuple when an invalid expression is provided to render to an SVG" do
      assert_raise RuntimeError, "MathJax rendering failed: \"Extra close brace or missing open brace\"", fn ->
        MathJax.render!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :svg)
      end
    end

    test "should return an error tuple when an invalid expression is provided to render to an PNG" do
      assert_raise RuntimeError, "MathJax rendering failed: \"Extra close brace or missing open brace\"", fn ->
        MathJax.render!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :png)
      end
    end
  end

  describe "The render_inline/2 function" do
    test "should render a valid mathematical expression as an SVG" do
      assert {:ok, result} = MathJax.render_inline("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :svg)
      assert is_binary(result)
    end

    test "should render a valid mathematical expression as an PNG" do
      assert {:ok, result} = MathJax.render_inline("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :png)
      assert is_binary(result)
    end

    test "should return an error tuple when an invalid expression is provided to render to an SVG" do
      assert {:error, "Extra close brace or missing open brace"} =
               MathJax.render_inline("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :svg)
    end

    test "should return an error tuple when an invalid expression is provided to render to an PNG" do
      assert {:error, "Extra close brace or missing open brace"} =
               MathJax.render_inline("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :png)
    end
  end

  describe "The render_inline!/2 function" do
    test "should render a valid mathematical expression as an SVG" do
      assert result = MathJax.render_inline!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :svg)
      assert is_binary(result)
    end

    test "should render a valid mathematical expression as an PNG" do
      assert result = MathJax.render_inline!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}", :png)
      assert is_binary(result)
    end

    test "should return an error tuple when an invalid expression is provided to render to an SVG" do
      assert_raise RuntimeError, "MathJax rendering failed: \"Extra close brace or missing open brace\"", fn ->
        MathJax.render_inline!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :svg)
      end
    end

    test "should return an error tuple when an invalid expression is provided to render to an PNG" do
      assert_raise RuntimeError, "MathJax rendering failed: \"Extra close brace or missing open brace\"", fn ->
        MathJax.render_inline!("SMA = {P_1 + P_2 + P_3 + {..}. + P_n \over n}}}", :png)
      end
    end
  end
end
