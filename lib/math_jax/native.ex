defmodule MathJax.Native do
  @moduledoc false

  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :math_jax,
    crate: :math_jax_nif,
    base_url: "https://github.com/akoutmos/math_jax/releases/download/v#{version}",
    force_build: System.get_env("RUSTLER_FORCE_BUILD") in ["1", "true"],
    targets: Enum.uniq(["aarch64-unknown-linux-musl" | RustlerPrecompiled.Config.default_targets()]),
    version: version

  @doc false
  def render_svg(_expression), do: :erlang.nif_error(:nif_not_loaded)
  def render_svg_inline(_expression), do: :erlang.nif_error(:nif_not_loaded)
  def render_png(_expression, _scale), do: :erlang.nif_error(:nif_not_loaded)
  def render_png_inline(_expression, _scale), do: :erlang.nif_error(:nif_not_loaded)
end
