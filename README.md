# rodrigoalmeida.pt

Personal website of Rodrigo Almeida, built with [Hugo](https://gohugo.io/) and the
[researcher](https://github.com/ojroques/hugo-researcher) theme, deployed to GitHub Pages.

## Layout

- `content/_index.md` – home page (about, experience, publications, conferences). Written as HTML inside Markdown.
- `content/projects/` – one Markdown file per project.
- `content/posts/` – blog posts.
- `static/` – images, favicon, CNAME and the generated CV PDF.
- `latex/` – LaTeX sources for the CV and cover letter.
- `scripts/` – `generate_cv.sh` and `generate_cover_letter.sh`, which compile the LaTeX into `static/`.
- `layouts/` – overrides of the theme templates and shortcodes, including
  `robots.txt` and `index.llms.txt`, which generate `/robots.txt` and `/llms.txt`.

## Local development

```bash
git submodule update --init --recursive   # fetch the theme
hugo server                               # serve at http://localhost:1313
```

Hugo extended is required for the Sass pipeline. CI uses Hugo 0.124.1.

## CV

The CV is compiled from `latex/cv.tex` with `pdflatex`:

```bash
./scripts/generate_cv.sh
```

Escape `&` as `\&` in the LaTeX source. The script hides compiler output, so a
LaTeX error leaves the previous PDF in place without a message.

## Deployment

Pushing to `main` runs `.github/workflows/hugo.yml`, which regenerates the CV,
builds the site and publishes it to GitHub Pages.

## Machine-readable outputs

- `/llms.txt` – plain-text summary for AI agents, generated from the `llms`
  output format in `config.toml` and the `llms_summary` site parameter. Update
  that parameter when the role or focus changes.
- `/robots.txt` – allows all crawlers, lists common AI crawlers explicitly and
  points to the sitemap.
- `/index.json` – full-text index of all projects and posts.

## Editing notes

- The home page is raw HTML. Keep each `<div class="timeline-item">` flush left,
  or directly after the opening `<div class="timeline">`. A block indented four
  spaces after a blank line is rendered by Markdown as a code block.
- `.markdownlint.json` disables the lint rules that fire on HTML-in-Markdown.
