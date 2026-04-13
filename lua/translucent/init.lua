local M = {}

-- ANSI base color slots (0-7)
-- Pass these to setup() config
M.BLACK   = 0
M.RED     = 1
M.GREEN   = 2
M.YELLOW  = 3
M.BLUE    = 4
M.MAGENTA = 5
M.CYAN    = 6
M.WHITE   = 7
M.GRAY    = 8

local defaults = {
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
}

local config = {}

local function resolve(slot)
  if config.variant == "bright" and slot ~= 0 and slot ~= 8 then
    return slot + 8
  else
    return slot
  end
end

function M.setup(opts)
  opts = opts or {}
  config = vim.tbl_deep_extend("force", defaults, opts)
  M.load()
end

function M.load()
  if vim.tbl_isempty(config) then
    config = vim.deepcopy(defaults)
  end

local hl = vim.api.nvim_set_hl

  -- Clear groups that should inherit default text color
  local cleared = {
    "Keyword", "Conditional", "Repeat", "Exception",
    "Statement", "Operator", "PreProc", "Include",
    "Define", "Macro", "StorageClass", "Special", "Tag",
  }
  for _, group in ipairs(cleared) do
    hl(0, group, {})
  end

  -- Transparent background
  hl(0, "Normal",   { ctermbg = "NONE" })
  hl(0, "NormalNC", { ctermbg = "NONE" })

  -- Punctuation
  hl(0, "Delimiter",              { ctermfg = resolve(config.punctuation) })
  hl(0, "@punctuation.bracket",   { ctermfg = resolve(config.punctuation) })
  hl(0, "@punctuation.delimiter", { ctermfg = resolve(config.punctuation) })
  hl(0, "@punctuation.special",   { ctermfg = resolve(config.punctuation) })

-- LSP Highlighting
hl(0, "LspReferenceText",  { ctermbg = resolve(config.highlight) })
hl(0, "LspReferenceRead",  { ctermbg = resolve(config.highlight) })
hl(0, "LspReferenceWrite", { ctermbg = resolve(config.highlight) })

  -- Values
  hl(0, "Number",        { ctermfg = resolve(config.values) })
  hl(0, "Float",         { ctermfg = resolve(config.values) })
  hl(0, "@number",       { ctermfg = resolve(config.values) })
  hl(0, "@number.float", { ctermfg = resolve(config.values) })
  hl(0, "String",        { ctermfg = resolve(config.values) })
  hl(0, "Character",     { ctermfg = resolve(config.values) })
  hl(0, "@string",       { ctermfg = resolve(config.values) })
  hl(0, "@string.escape",{ ctermfg = resolve(config.values) })
  hl(0, "@character",    { ctermfg = resolve(config.values) })

  hl(0, "Type",                    { ctermfg = resolve(config.types) })
  hl(0, "@type",                   { ctermfg = resolve(config.types) })
  hl(0, "@type.builtin",           { ctermfg = resolve(config.types) })
  hl(0, "@type.qualifier",         { ctermfg = resolve(config.types) })
  hl(0, "@lsp.type.type",          { ctermfg = resolve(config.types) })
  hl(0, "@lsp.type.typeParameter", { ctermfg = resolve(config.types) })

  hl(0, "Function",               { ctermfg = resolve(config.funcs) })
  hl(0, "@function",              { ctermfg = resolve(config.funcs) })
  hl(0, "@function.method",       { ctermfg = resolve(config.funcs) })
  --hl(0, "@constructor",           { ctermfg = resolve(config.funcs) })
  hl(0, "@lsp.type.class",        { ctermfg = resolve(config.funcs) })
  hl(0, "@lsp.type.interface",    { ctermfg = resolve(config.funcs) })
  hl(0, "@lsp.type.enum",         { ctermfg = resolve(config.funcs) })

  -- Comments
  hl(0, "Comment",        { ctermfg = resolve(config.comments) })
  hl(0, "@comment",       { ctermfg = resolve(config.comments) })
  hl(0, "@comment.line",  { ctermfg = resolve(config.comments) })
  hl(0, "@comment.block", { ctermfg = resolve(config.comment_blocks) })

  -- Diagnostics: red reserved for errors only
  hl(0, "DiagnosticError", { ctermfg = resolve(config.errors) })
  hl(0, "DiagnosticWarn",  { ctermfg = resolve(config.warnings) })
  hl(0, "DiagnosticInfo",  { ctermfg = resolve(config.info) })
  hl(0, "DiagnosticHint",  { ctermfg = resolve(config.hints) })

-- Markup
  hl(0, "@markup.heading",   { ctermfg = resolve(config.types), bold = true })
hl(0, "@markup.strong",    { bold = true })
hl(0, "@markup.italic",    { italic = true })
hl(0, "@markup.link",      { ctermfg = resolve(config.values) })
hl(0, "@markup.raw",       { ctermfg = resolve(config.comments) })
hl(0, "@markup.list",      { ctermfg = resolve(config.punctuation) })
end

return M
