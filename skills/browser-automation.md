# browser-automation

Source: Claude skill
Original path: `components/claude-skills/engineering/skills/browser-automation/SKILL.md`
Description: Use when the user asks to automate browser tasks, scrape websites, fill forms, capture screenshots, extract structured data from web pages, or build web automation workflows. NOT for testing — use playwright-pro for that.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# Browser Automation - POWERFUL

## Overview

The Browser Automation skill provides comprehensive tools and knowledge for building production-grade web automation workflows using Playwright. This skill covers data extraction, form filling, screenshot capture, session management, and anti-detection patterns for reliable browser automation at scale.

**When to use this skill:**
- Scraping structured data from websites (tables, listings, search results)
- Automating multi-step browser workflows (login, fill forms, download files)
- Capturing screenshots or PDFs of web pages
- Extracting data from SPAs and JavaScript-heavy sites
- Building repeatable browser-based data pipelines

**When NOT to use this skill:**
- Writing browser tests or E2E test suites — use **playwright-pro** instead
- Testing API endpoints — use **api-test-suite-builder** instead
- Load testing or performance benchmarking — use **performance-profiler** instead

**Why Playwright over Selenium or Puppeteer:**
- **Auto-wait built in** — no explicit `sleep()` or `waitForElement()` needed for most actions
- **Multi-browser from one API** — Chromium, Firefox, WebKit with zero config changes
- **Network interception** — block ads, mock responses, capture API calls natively
- **Browser contexts** — isolated sessions without spinning up new browser instances
- **Codegen** — `playwright codegen` records your actions and generates scripts
- **Async-first** — Python async/await for high-throughput scraping

## Core Competencies

### 1. Web Scraping Patterns

**Selector priority (most to least reliable):**
1. `data-testid`, `data-id`, or custom data attributes — stable across redesigns
2. `#id` selectors — unique but may change between deploys
3. Semantic selectors: `article`, `nav`, `main`, `section` — resilient to CSS changes
4. Class-based: `.product-card`, `.price` — brittle if classes are generated (e.g., CSS modules)
5. Positional: `nth-child()`, `nth-of-type()` — last resort, breaks on layout changes

Use XPath only when CSS cannot express the relationship (e.g., ancestor traversal, text-based selection).

**Pagination strategies:** next-button, URL-based (`?page=N`), infinite scroll, load-more button. See [data_extraction_recipes.md](references/data_extraction_recipes.md) for complete pagination handlers and scroll patterns.

### 2. Form Filling & Multi-Step Workflows

Break multi-step forms into discrete functions per step. Each function fills fields, clicks "Next"/"Continue", and waits for the next step to load (URL change or DOM element).

Key patterns: login flows, multi-page forms, file uploads (including drag-and-drop zones), native and custom dropdown handling. See [playwright_browser_api.md](references/playwright_browser_api.md) for complete API reference on `fill()`, `select_option()`, `set_input_files()`, and `expect_file_chooser()`.

### 3. Screenshot & PDF Capture

- **Full page:** `await page.screenshot(path="full.png", full_page=True)`
- **Element:** `await page.locator("div.chart").screenshot(path="chart.png")`
- **PDF (Chromium only):** `await page.pdf(path="out.pdf", format="A4", print_background=True)`
- **Visual regression:** Take screenshots at known states, store baselines in version control with naming: `{page}_{viewport}_{state}.png`

See [playwright_browser_api.md](references/playwright_browser_api.md) for full screenshot/PDF options.

### 4. Structured Data Extraction

Core extraction patterns:
- **Tables to JSON** — Extract `<thead>` headers and `<tbody>` rows into dictionaries
- **Listings to arrays** — Map repeating card elements using a field-selector map (supports `::attr()` for attributes)
- **Nested/threaded data** — Recursive extraction for comments with replies, category trees

See [data_extraction_recipes.md](references/data_extraction_recipes.md) for complete extraction functions, price parsing, data cleaning utilities, and output format helpers (JSON, CSV, JSONL).

### 5. Cookie & Session Management

- **Save/restore cookies:** `context.cookies()` and `context.add_cookies()`
- **Full storage state** (cookies + localStorage): `context.storage_state(path="state.json")` to save, `browser.new_context(storage_state="state.json")` to restore

**Best practice:** Save state after login, reuse across scraping sessions. Check session validity before starting a long job — make a lightweight request to a protected page and verify you are not redirected to login. See [playwright_browser_api.md](references/playwright_browser_api.md) for cookie and storage state API details.

### 6. Anti-Detection Patterns

Modern websites detect automation through multiple vectors. Apply these in priority order:

1. **WebDriver flag removal** — Remove `navigator.webdriver = true` via init script (critical)
2. **Custom user agent** — Rotate through real browser UAs; never use the default headless UA
3. **Realistic viewport** — Set 1920x1080 or similar real-world dimensions (default 800x600 is a red flag)
4. **Request throttling** — Add `random.uniform()` delays between actions
5. **Proxy support** — Per-browser or per-context proxy configuration

See [anti_detection_patterns.md](references/anti_detection_patterns.md) for the complete stealth stack: navigator property hardening, WebGL/canvas fingerprint evasion, behavioral simulation (mouse movement, typing speed, scroll patterns), proxy rotation strategies, and detection self-test URLs.

### 7. Dynamic Content Handling

- **SPA rendering:** Wait for content selectors (`wait_for_selector`), not the page load event
- **AJAX/Fetch waiting:** Use `page.expect_response("**/api/data*")` to intercept and wait for specific API calls
- **Shadow DOM:** Playwright pierces open Shadow DOM with `>>` operator: `page.locator("custom-element >> .inner-class")`
- **Lazy-loaded images:** Scroll elements into view with `scroll_into_view_if_needed()` to trigger loading

See [playwright_browser_api.md](references/playwright_browser_api.md) for wait strategies, network interception, and Shadow DOM details.

### 8. Error Handling & Retry Logic

- **Retry with backoff:** Wrap page interactions in retry logic with exponential backoff (e.g., 1s, 2s, 4s)
- **Fallback selectors:** On `TimeoutError`, try alternative selectors before failing
- **Error-state screenshots:** Capture `page.screenshot(path="error-state.png")` on unexpected failures for debugging
- **Rate limit detection:** Check for HTTP 429 responses and respect `Retry-After` headers

See [anti_detection_patterns.md](references/anti_detection_patterns.md) for the complete exponential backoff implementation and rate limiter class.

## Workflows

### Workflow 1: Single-Page Data Extraction

**Scenario:** Extract product data from a single page with JavaScript-rendered content.

**Steps:**
1. Launch browser in headed mode during development (`headless=False`), switch to headless for production
2. Navigate to URL and wait for content selector
3. Extract data using `query_selector_all` with field mapping
4. Validate extract

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
