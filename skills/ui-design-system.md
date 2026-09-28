# ui-design-system

Source: Claude skill
Original path: `components/claude-skills/product-team/skills/ui-design-system/SKILL.md`
Description: UI design system toolkit for Senior UI Designer including design token generation, component documentation, responsive design calculations, and developer handoff tools. Use for creating design systems, maintaining visual consistency, and facilitating design-dev collaboration.

## How to use in non-Claude agents

Use this guidance when the user request matches the description. Prefer local project conventions over Claude-specific mechanics.

## Portable guidance

# UI Design System

Generate design tokens, create color palettes, calculate typography scales, build component systems, and prepare developer handoff documentation.

---

## Table of Contents

- [Trigger Terms](#trigger-terms)
- [Workflows](#workflows)
  - [Workflow 1: Generate Design Tokens](#workflow-1-generate-design-tokens)
  - [Workflow 2: Create Component System](#workflow-2-create-component-system)
  - [Workflow 3: Responsive Design](#workflow-3-responsive-design)
  - [Workflow 4: Developer Handoff](#workflow-4-developer-handoff)
- [Tool Reference](#tool-reference)
- [Quick Reference Tables](#quick-reference-tables)
- [Knowledge Base](#knowledge-base)

---

## Trigger Terms

Use this skill when you need to:

- "generate design tokens"
- "create color palette"
- "build typography scale"
- "calculate spacing system"
- "create design system"
- "generate CSS variables"
- "export SCSS tokens"
- "set up component architecture"
- "document component library"
- "calculate responsive breakpoints"
- "prepare developer handoff"
- "convert brand color to palette"
- "check WCAG contrast"
- "build 8pt grid system"

---

## Workflows

### Workflow 1: Generate Design Tokens

**Situation:** You have a brand color and need a complete design token system.

**Steps:**

1. **Identify brand color and style**
   - Brand primary color (hex format)
   - Style preference: `modern` | `classic` | `playful`

2. **Generate tokens using script**
   ```bash
   python scripts/design_token_generator.py "#0066CC" modern json
   ```

3. **Review generated categories**
   - Colors: primary, secondary, neutral, semantic, surface
   - Typography: fontFamily, fontSize, fontWeight, lineHeight
   - Spacing: 8pt grid-based scale (0-64)
   - Borders: radius, width
   - Shadows: none through 2xl
   - Animation: duration, easing
   - Breakpoints: xs through 2xl

4. **Export in target format**
   ```bash
   # CSS custom properties
   python scripts/design_token_generator.py "#0066CC" modern css > design-tokens.css

   # SCSS variables
   python scripts/design_token_generator.py "#0066CC" modern scss > _design-tokens.scss

   # JSON for Figma/tooling
   python scripts/design_token_generator.py "#0066CC" modern json > design-tokens.json
   ```

5. **Validate accessibility**
   - Check color contrast meets WCAG AA (4.5:1 normal, 3:1 large text)
   - Verify semantic colors have contrast colors defined

---

### Workflow 2: Create Component System

**Situation:** You need to structure a component library using design tokens.

**Steps:**

1. **Define component hierarchy**
   - Atoms: Button, Input, Icon, Label, Badge
   - Molecules: FormField, SearchBar, Card, ListItem
   - Organisms: Header, Footer, DataTable, Modal
   - Templates: DashboardLayout, AuthLayout

2. **Map tokens to components**

   | Component | Tokens Used |
   |-----------|-------------|
   | Button | colors, sizing, borders, shadows, typography |
   | Input | colors, sizing, borders, spacing |
   | Card | colors, borders, shadows, spacing |
   | Modal | colors, shadows, spacing, z-index, animation |

3. **Define variant patterns**

   Size variants:
   ```
   sm: height 32px, paddingX 12px, fontSize 14px
   md: height 40px, paddingX 16px, fontSize 16px
   lg: height 48px, paddingX 20px, fontSize 18px
   ```

   Color variants:
   ```
   primary: background primary-500, text white
   secondary: background neutral-100, text neutral-900
   ghost: background transparent, text neutral-700
   ```

4. **Document component API**
   - Props interface with types
   - Variant options
   - State handling (hover, active, focus, disabled)
   - Accessibility requirements

5. **Reference:** See `references/component-architecture.md`

---

### Workflow 3: Responsive Design

**Situation:** You need breakpoints, fluid typography, or responsive spacing.

**Steps:**

1. **Define breakpoints**

   | Name | Width | Target |
   |------|-------|--------|
   | xs | 0 | Small phones |
   | sm | 480px | Large phones |
   | md | 640px | Tablets |
   | lg | 768px | Small laptops |
   | xl | 1024px | Desktops |
   | 2xl | 1280px | Large screens |

2. **Calculate fluid typography**

   Formula: `clamp(min, preferred, max)`

   ```css
   /* 16px to 24px between 320px and 1200px viewport */
   font-size: clamp(1rem, 0.5rem + 2vw, 1.5rem);
   ```

   Pre-calculated scales:
   ```css
   --fluid-h1: clamp(2rem, 1rem + 3.6vw, 4rem);
   --fluid-h2: clamp(1.75rem, 1rem + 2.3vw, 3rem);
   --fluid-h3: clamp(1.5rem, 1rem + 1.4vw, 2.25rem);
   --fluid-body: clamp(1rem, 0.95rem + 0.2vw, 1.125rem);
   ```

3. **Set up responsive spacing**

   | Token | Mobile | Tablet | Desktop |
   |-------|--------|--------|---------|
   | --space-md | 12px | 16px | 16px |
   | --space-lg | 16px | 24px | 32px |
   | --space-xl | 24px | 32px | 48px |
   | --space-section | 48px | 80px | 120px |

4. **Reference:** See `references/responsive-calculations.md`

---

### Workflow 4: Developer Handoff

**Situation:** You need to hand off design tokens to development team.

**Steps:**

1. **Export tokens in required formats**
   ```bash
   # For CSS projects
   python scripts/design_token_generator.py "#0066CC" modern css

   # For SCSS projects
   python scripts/design_token_generator.py "#0066CC" modern scss

   # For JavaScript/TypeScript
   python scripts/design_token_generator.py "#0066CC" modern json
   ```

2. **Prepare framework integration**

   **React + CSS Variables:**
   ```tsx
   import './design-tokens.css';

   <button className="btn btn-primary">Click</button>
   ```

   **Tailwind Config:**
   ```javascript
   const tokens = require('./design-tokens.json');

   module.exports = {
     theme: {
       colors: tokens.colors,
       fontFamily: tokens.typography.fontFamily
     }
   };
   ```

   **styled-components:**
   ```typescript
   import tokens from './design-tokens.json';

   const Button = styled.button`
     background: ${tokens.colors.primary['500']};
     padding: ${tokens.spacing['2']} ${tokens.spacing['4']};
   `;
   ```

3. **Sync with Figma**
   - Install Tokens Studio plugin
   - Import design-tokens.json
   - Tokens sync automatically with Figma styles

4. **Handoff checklist**
   - [ ] Token files added to project
   - [ ] Build pipeline configured
   - [ ] Theme/CSS variables imported
   - [ ] Component library aligned
   - [ ] Documentation generated

5. **Reference:** See `references/developer-handoff.md`

---

## Tool Reference

### design_token_generator.py

Generates complete design token system from brand color.

| Argument | Values | Default | Description |
|----------|--------|---------|-------------|
| brand_color | Hex color | #0066CC | Primary brand color |
| style | modern, classic, playful | modern | Design style preset |
| format | json, css, scss, summary | json | Output format |

**Examples:**

```bash
# Generate JSON tokens (default)
python scripts/design_token_generator.py "#0066CC"

# Classic style with CSS output
python scripts/design_token_generator.py "#8

...[truncated for portable export]

## Limits

Claude-only slash commands, hooks, or tool names may need manual adaptation for this target tool.
