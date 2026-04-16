# translucent.nvim

A minimal Neovim colorscheme that owns structure and semantics, but lets your terminal palette own the actual colors.

Inspired by [Tonsky's syntax highlighting philosophy](https://tonsky.me/blog/syntax-highlighting/): highlight landmarks, not everything. If everything is highlighted, nothing is.

## Philosophy

Most colorschemes hardcode hex values and fight your terminal theme. Translucent maps semantic roles to ANSI color slots — your terminal decides what green, blue, and yellow actually look like. Switch your terminal theme, Neovim follows automatically.

**Semantic roles:**
- **Types** - Method and Class Declarations
- **Funcs** - Functions
- **Values** - Numbers, strings, etc.
- **Comments** - Single line comments and block comments handled independently
- **Punctuation**
- **Highlighting** - For LSP Auto Highlighting
- **Diagnostics** - Diagnostic Errors, Warnings, Info and Hints are handled independently

## Installation
```lua
-- lazy.nvim
{ "nicholasjcollins/translucent.nvim" }
```
## Usage

### Simple — just use it as a colorscheme:
```lua
vim.cmd.colorscheme("translucent")
```
Role values map to standard ANSI base slots (0–7). Translucent automatically uses the bright variant (slot + 8) where appropriate — you never need to specify bright slots manually.

| Constant           | Slot | Typical color |
|--------------------|------|---------------|
| `translucent.BLACK`   | 0    | Black         |
| `translucent.RED`     | 1    | Red           |
| `translucent.GREEN`   | 2    | Green         |
| `translucent.YELLOW`  | 3    | Yellow        |
| `translucent.BLUE`    | 4    | Blue          |
| `translucent.MAGENTA` | 5    | Magenta       |
| `translucent.CYAN`    | 6    | Cyan          |
| `translucent.WHITE`   | 7    | White         |
| `translucent.GRAY`    | 8    | Gray (Bright Black) |

### You can also remap the following attributes in your configuration using these named constraints (Defaults are provided below):
```lua
local t = require('translucent')
t.setup({
    variant         = "bright",
    types           = M.BLUE,
    funcs           = M.CYAN,
    values          = M.GREEN,
    comments        = M.YELLOW,
    punctuation     = M.GRAY,
    highlight       = M.GRAY,
    comment_blocks  = M.GRAY,
    errors          = M.RED,
    warnings        = M.YELLOW,
    info            = M.BLUE,
    hints           = M.GRAY,
})
```
> [!warn] Compatability
> Depending on your theme (or themes) of choice, you may run into issues with their color handling, contrast, etc. Overriding certain colors or adding `variant = "dim"` to your config may help mitigate this, but certain terminal themes are likely just not going to work well with this approach. I've tested with Gruvbox and Catpuccin and like the results.

## Requirements

- Neovim 0.8+
- `termguicolors` must be **off** (Translucent sets this automatically)
- Treesitter parsers for your languages (recommended, not required)

```sql
SELECT * FROM TABLE WHERE FIELD = 'name';
```
