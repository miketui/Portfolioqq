Here’s the updated **README.md** with your requested **Summary Table** included:

---

# Manus.im Automated Book Production

## Overview

**Manus.im** is an autonomous AI-driven publishing pipeline for transforming manuscript content and project assets into a professional, validated, multi-format book package—ready for digital distribution and print-on-demand.

The system ingests structured files, asset maps, and templates, then automatically edits, formats, validates, and compiles your book into **EPUB 3, Kindle MOBI/AZW3, and print-ready PDF** formats, using industry-standard best practices.

---

## Key Features

* **Best-Seller Level Editing**
  Automated grammar, spelling, style, and fact-checking at the level of top publishing houses.

* **Advanced Templating**
  Dynamic generation of XHTML and EPUB core files using Jinja2 templates, YAML mapping, and CSS.

* **Multi-Format Output**
  Generates and validates EPUB, MOBI, and PDF outputs, including all required core files:

  * `content.opf`
  * `container.xml`
  * `mimetype`
  * `nav.xhtml`

* **Fully Automated Workflow**
  Zero manual intervention required after upload. All tasks are mapped, orchestrated, and logged for full traceability.

* **Comprehensive Validation**
  Runs EPUBCheck, accessibility (DAISY ACE), and format validation on all outputs.

* **Asset and Navigation Mapping**
  References `file-map.yaml` for all file order, asset linkage, navigation structure, and template usage.

---

## Project Structure

```
project-root/
├── 44-xhtml-files/              
├── css/                          
│   ├── fonts.css
│   └── style.css
├── images/                       
├── fonts/                        
├── templates/                   
├── file-map.yaml                
├── epub_compilation_metadata.yaml
├── todo.md                      
├── setup-epub-tools.sh          
├── PERFECT_COMBINED_BOOK.md     
├── toc.ncx                      
└── output/                     
```

---

## Tool Summary Table

| Tool                | Purpose                                                         |
| ------------------- | --------------------------------------------------------------- |
| **pandoc**          | Format conversion (MD/DOCX → XHTML/EPUB) ([gist.github.com][1]) |
| **epubcheck**       | EPUB 3 validation                                               |
| **prince**          | Professional PDF from XHTML/CSS                                 |
| **kindlegen**       | Kindle MOBI generation                                          |
| **kindlepreviewer** | Modern Kindle file generation                                   |
| **stylelint**       | CSS linting/validation                                          |
| **htmllint**        | HTML/XHTML validation                                           |
| **tidy**            | Clean/validate XHTML                                            |
| **fonttools**       | Font embedding/subsetting                                       |
| **imagemagick**     | Image optimization                                              |
| **yq, pyyaml**      | YAML parsing and scripting                                      |
| **ace**             | EPUB accessibility check                                        |
| **make, bash**      | Build scripting                                                 |
| **python3, nodejs** | Scripting/toolchain support                                     |

---

## How the System Works

1. **Environment Setup**

   * Run `setup-epub-tools.sh` to install Pandoc, EPUBCheck, DAISY ACE, PrinceXML/WeasyPrint, KindleGen/Previewer, and all supporting utilities.
   * Verify all dependencies are installed.

2. **Ingestion & Mapping**

   * Parse `file-map.yaml` to load navigation, section order, asset linkage, templates, and placeholder mapping.
   * Load metadata from `epub_compilation_metadata.yaml`.
   * Use `todo.md` as a step-by-step build manifest.

3. **Editing & Fact-Checking**

   * AI performs advanced editing and fact-checking on all manuscript content for accuracy, style, and consistency.

4. **Template Rendering & Styling**

   * Generate all XHTML and EPUB core files (`content.opf`, `container.xml`, `mimetype`, `nav.xhtml`) using Jinja2 templates and YAML mappings.
   * Enforce centralized CSS (`fonts.css`, `style.css`)—no inline styles allowed.

5. **Validation**

   * Validate each XHTML file (semantic markup, W3C compliant).
   * Run EPUBCheck and DAISY ACE on the EPUB.
   * Verify all asset links, images, fonts, and navigation.

6. **Multi-Format Compilation**

   * Assemble EPUB package (with all validated content and assets).
   * Convert to Kindle MOBI/AZW3 using KindleGen/Previewer.
   * Generate print-ready PDF using PrinceXML or WeasyPrint.

7. **Final Output & Reporting**

   * Deliver all outputs in an organized folder structure per `file-map.yaml`.
   * Include validation reports, asset manifest, and a Markdown build log.

---

## Required Tools

Included in the **Tool Summary Table** above—please ensure all are installed via `setup-epub-tools.sh`.

---

## Quick Start

```bash
bash setup-epub-tools.sh
# Place your manuscript files, assets, mapping, and templates in project-root
# Upload or run Manus.im to execute the build
# Retrieve outputs from output/ directory
```

---

## Output Checklist

* [x] 44 XHTML files, edited and validated
* [x] Centralized and updated CSS
* [x] All images and fonts embedded
* [x] `content.opf`, `container.xml`, `mimetype`, `nav.xhtml` (all error-free)
* [x] EPUB, MOBI, and print-ready PDF compiled and validated
* [x] Asset/Navigation manifest included
* [x] Markdown build log/report

---

## Support

For advanced usage, custom templating, or integration with CI/CD pipelines, please see `todo.md` or contact your Manus.im admin.

---

**Manus.im delivers a fully automated, best-in-class book production workflow—ready for any author or publisher.**

[1]: https://gist.github.com/caseywatts/3d8150fe04e0d8462cfc4d51b9856d39?permalink_comment_id=4423306&utm_source=chatgpt.com "Self-Publishing via Markdown - GitHub Gist"
