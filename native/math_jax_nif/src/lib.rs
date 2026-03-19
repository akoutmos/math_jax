use rustler::{Binary, Env, NewBinary, NifResult};

/// Converts a LaTeX math expression to an SVG string (display mode).
#[rustler::nif(schedule = "DirtyCpu")]
fn render_svg(expression: String) -> NifResult<String> {
    mathjax_svg::convert_to_svg(&expression)
        .map_err(|e| rustler::Error::Term(Box::new(format!("{e}"))))
}

/// Converts a LaTeX math expression to an SVG string (inline mode).
#[rustler::nif(schedule = "DirtyCpu")]
fn render_svg_inline(expression: String) -> NifResult<String> {
    mathjax_svg::convert_to_svg_inline(&expression)
        .map_err(|e| rustler::Error::Term(Box::new(format!("{e}"))))
}

/// Converts a LaTeX math expression to a PNG binary (display mode).
///
/// `scale` controls the resolution multiplier (e.g. 2.0 for 2x retina).
#[rustler::nif(schedule = "DirtyCpu")]
fn render_png<'a>(env: Env<'a>, expression: String, scale: f64) -> NifResult<Binary<'a>> {
    let svg_string = mathjax_svg::convert_to_svg(&expression)
        .map_err(|e| rustler::Error::Term(Box::new(format!("{e}"))))?;

    svg_to_png(env, &svg_string, scale as f32)
}

/// Converts a LaTeX math expression to a PNG binary (inline mode).
///
/// `scale` controls the resolution multiplier (e.g. 2.0 for 2x retina).
#[rustler::nif(schedule = "DirtyCpu")]
fn render_png_inline<'a>(env: Env<'a>, expression: String, scale: f64) -> NifResult<Binary<'a>> {
    let svg_string = mathjax_svg::convert_to_svg_inline(&expression)
        .map_err(|e| rustler::Error::Term(Box::new(format!("{e}"))))?;

    svg_to_png(env, &svg_string, scale as f32)
}

/// Internal helper: rasterize an SVG string into a PNG binary using resvg + tiny-skia.
fn svg_to_png<'a>(env: Env<'a>, svg_string: &str, scale: f32) -> NifResult<Binary<'a>> {
    let opt = usvg::Options::default();
    let tree = usvg::Tree::from_str(svg_string, &opt)
        .map_err(|e| rustler::Error::Term(Box::new(format!("SVG parse error: {e}"))))?;

    let size = tree.size();
    let width = (size.width() * scale).ceil() as u32;
    let height = (size.height() * scale).ceil() as u32;

    if width == 0 || height == 0 {
        return Err(rustler::Error::Term(Box::new(
            "SVG has zero dimensions".to_string(),
        )));
    }

    let mut pixmap = tiny_skia::Pixmap::new(width, height)
        .ok_or_else(|| rustler::Error::Term(Box::new("Failed to create pixmap".to_string())))?;

    // White background; remove this line if you want transparent PNGs.
    pixmap.fill(tiny_skia::Color::WHITE);

    let transform = tiny_skia::Transform::from_scale(scale, scale);
    resvg::render(&tree, transform, &mut pixmap.as_mut());

    let png_data = pixmap
        .encode_png()
        .map_err(|e| rustler::Error::Term(Box::new(format!("PNG encode error: {e}"))))?;

    let mut binary = NewBinary::new(env, png_data.len());
    binary.as_mut_slice().copy_from_slice(&png_data);
    Ok(binary.into())
}

rustler::init!("Elixir.MathJax.Native");
