--
-- Built with,
--
--        ,gggg,
--       d8" "8I                         ,dPYb,
--       88  ,dP                         IP'`Yb
--    8888888P"                          I8  8I
--       88                              I8  8'
--       88        gg      gg    ,g,     I8 dPgg,
--  ,aa,_88        I8      8I   ,8'8,    I8dP" "8I
-- dP" "88P        I8,    ,8I  ,8'  Yb   I8P    I8
-- Yb,_,d88b,,_   ,d8b,  ,d8b,,8'_   8) ,d8     I8,
--  "Y8P"  "Y888888P'"Y88P"`Y8P' "YY8P8P88P     `Y8
--

-- This is a starter colorscheme for use with Lush,
-- for usage guides, see :h lush or :LushRunTutorial

--
-- Note: Because this is a lua file, vim will append it to the runtime,
--       which means you can require(...) it in other lua code (this is useful),
--       but you should also take care not to conflict with other libraries.
--
--       (This is a lua quirk, as it has somewhat poor support for namespacing.)
--
--       Basically, name your file,
--
--       "super_theme/lua/lush_theme/super_theme_dark.lua",
--
--       not,
--
--       "super_theme/lua/dark.lua".
--
--       With that caveat out of the way...
--

-- Enable lush.ify on this file, run:
--
--  `:Lushify`
--
--  or
--
--  `:lua require('lush').ify()`

local lush = require("lush")
local hsl = lush.hsl

local white = hsl("#ffffff")
local black = hsl("#000000")
local blue = hsl("#01fdfe")
local red = hsl("#ff3a3a")
local yellow = hsl("#ffef00")
local magenta = hsl("#A91079")
local bright_magenta = hsl("#F806CC")

-- LSP/Linters mistakenly show `undefined global` errors in the spec, they may
-- support an annotation like the following. Consult your server documentation.
---@diagnostic disable: undefined-global
local theme = lush(function(injected_functions)
	local sym = injected_functions.sym
	return {
		-- The following are the Neovim (as of 0.8.0-dev+100-g371dfb174) highlight
		-- groups, mostly used for styling UI elements.
		-- Comment them out and add your own properties to override the defaults.
		-- An empty definition `{}` will clear all styling, leaving elements looking
		-- like the 'Normal' group.
		-- To be able to link to a group, it must already be defined, so you may have
		-- to reorder items as you go.
		--
		-- See :h highlight-groups
		--
		Added({ fg = yellow.da(50) }),
		Removed({ fg = red.da(50) }),
		Changed({ fg = blue.da(50) }),
		-- Conceal{}, -- Placeholder characters substituted for concealed text (see 'conceallevel')
		ColorColumn({ bg = "#101010", fg = red }), -- Columns set with 'colorcolumn'
		CodeBlock({ bg = "#101010" }),
		-- Cursor{}, -- Character under the cursor
		CurSearch({ bg = yellow, fg = black, gui = "bold" }), -- Highlighting a search pattern under the cursor (see 'hlsearch')
		-- lCursor {} , -- Character under the cursor when |language-mapping| is used (see 'guicursor')
		-- CursorIM       { }, -- Like Cursor, but used when in IME mode |CursorIM|
		-- CursorColumn   { }, -- Screen-column at the cursor, when 'cursorcolumn' is set.
		-- Directory({}), -- Directory names (and other special names in listings)
		DiffAdd({ fg = yellow }), -- Diff mode: Added line |diff.txt|
		DiffChange({ fg = blue }), -- Diff mode: Changed line |diff.txt|
		DiffDelete({ fg = red }), -- Diff mode: Deleted line |diff.txt|
		-- DiffText{}, -- Diff mode: Changed text within a changed line |diff.txt|
		-- EndOfBuffer    { }, -- Filler lines (~) after the end of the buffer. By default, this is highlighted like |hl-NonText|.
		-- TermCursor     { }, -- Cursor in a focused terminal
		-- TermCursorNC   { }, -- Cursor in an unfocused terminal
		-- ErrorMsg({}), -- Error messages on the command line
		VertSplit({ gui = "bold" }), -- Column separating vertically split windows
		-- Folded({}), -- Line used for closed folds
		-- FoldColumn({}), -- 'foldcolumn'
		-- SignColumn({}), -- Column where |signs| are displayed
		IncSearch({ fg = blue, bg = blue.da(85).de(20) }), -- 'incsearch' highlighting; also used for the text replaced with ":s///c"
		Substitute({ fg = blue, bg = blue.da(85).de(20) }), -- |:substitute| replacement text highlighting
		-- LineNr({ fg = blue.da(90) }), -- Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
		LineNrAbove({ fg = blue.da(60).ro(10) }), -- Line number for when the 'relativenumber' option is set, above the cursor line
		LineNrBelow({ fg = blue.da(60).ro(10) }), -- Line number for when the 'relativenumber' option is set, below the cursor line
		CursorLineNr({ fg = blue.da(30).ro(10) }), -- Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
		-- CursorLineFold({ fg = blue }), -- Like FoldColumn when 'cursorline' is set for the cursor line
		-- CursorLineSign({ fg = blue }), -- Like SignColumn when 'cursorline' is set for the cursor line
		MatchParen({ bg = blue.da(30), fg = yellow, gui = "bold" }), -- Character under the cursor or just before it, if it is a paired bracket, and its match. |pi_paren.txt|
		ModeMsg({}), -- 'showmode' message (e.g., "-- INSERT -- ")
		MsgArea({ fg = blue }), -- Area for messages and cmdline
		-- MsgSeparator({ fg = blue, bg = black }), -- Separator for scrolled messages, `msgsep` flag of 'display'
		-- MoreMsg{}, -- |more-prompt|
		NonText({ fg = red }), -- '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line). See also |hl-EndOfBuffer|.
		Normal({ bg = black, fg = blue }), -- Normal text
		NormalFloat({}), -- Normal text in floating windows.
		-- FloatBorder({ }), -- Border of floating windows.
		FloatTitle({}), -- Title of floating windows.
		-- NormalNC({}), -- normal text in non-current windows
		Pmenu({ bg = blue.da(90).ro(17) }), -- Popup menu: Normal item.
		PmenuSel({ bg = yellow, fg = black }), -- Popup menu: Selected item.
		-- PmenuKind{}, -- Popup menu: Normal item "kind"
		-- PmenuKindSel   { }, -- Popup menu: Selected item "kind"
		-- PmenuExtraSel  { }, -- Popup menu: Selected item "extra text"
		-- PmenuExtra     { }, -- Popup menu: Normal item "extra text"
		-- PmenuSbar      { }, -- Popup menu: Scrollbar.
		-- PmenuThumb     { }, -- Popup menu: Thumb of the scrollbar.
		-- Question{}, -- |hit-enter| prompt and yes/no questions
		-- QuickFixLine{}, -- Current |quickfix| item in the quickfix window. Combined with |hl-CursorLine| when the cursor is there.
		NoiceCmdlinePopupBorderCmdline({ fg = blue, gui = "bold" }),
		NoiceCmdlineIconCmdline({ fg = blue, gui = "bold" }),
		NoiceCmdlinePopupBorderHelp({ fg = blue, gui = "bold" }),
		NoiceCmdlineIconHelp({ fg = blue, gui = "bold" }),
		NoiceCmdlinePopupTitle({ fg = blue, gui = "bold" }),
		Search({ fg = black, bg = yellow.de(40).da(20) }), -- Last search pattern highlighting (see 'hlsearch'). Also used for similar items that need to stand out.
		-- SpecialKey{}, -- Unprintable characters: text displayed differently from what it really is. But not 'listchars' whitespace. |hl-Whitespace|
		-- SpellBad{}, -- Word that is not recognized by the spellchecker. |spell| Combined with the highlighting used otherwise.
		-- SpellCap       { }, -- Word that should start with a capital. |spell| Combined with the highlighting used otherwise.
		-- SpellLocal{ fg = red }, -- Word that is recognized by the spellchecker as one that is used in another region. |spell| Combined with the highlighting used otherwise.
		-- SpellRare      { }, -- Word that is recognized by the spellchecker as one that is hardly ever used. |spell| Combined with the highlighting used otherwise.
		StatusLine({}), -- Status line of current window
		-- StatusLineNC   { }, -- Status lines of not-current windows. Note: If this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
		-- TabLine        { }, -- Tab pages line, not active tab page label
		-- TabLineFill    { }, -- Tab pages line, where there are no labels
		-- TabLineSel     { }, -- Tab pages line, active tab page label
		Title({}), -- Titles for output from ":set all", ":autocmd" etc.
		Visual({ bg = blue.da(65).ro(13) }), -- Visual mode selection
		-- VisualNOS      { }, -- Visual mode selection when vim is "Not Owning the Selection".
		-- WarningMsg     { }, -- Warning messages
		Whitespace({ fg = blue }), -- "nbsp", "space", "tab" and "trail" in 'listchars'
		-- Winseparator   { }, -- Separator between window splits. Inherts from |hl-VertSplit| by default, which it will replace eventually.
		-- WildMenu       { }, -- Current match in 'wildmenu' completion
		-- WinBar         { }, -- Window bar of current window
		-- WinBarNC       { }, -- Window bar of not-current windows

		CursorLine({ bg = blue.da(85).ro(20) }), --- Screen-line at the cursor, when 'cursorline' is set. Low-priority if foreground (ctermfg OR guifg) is not set.

		-- Common vim syntax groups used for all kinds of code and markup.
		-- Commented-out groups should chain up to their preferred (*) group
		-- by default.
		--
		-- See :h group-name
		--
		-- Uncomment and edit if you want more specific syntax highlighting.

		-- Comment({ fg = hsl("#0094a6") }), -- Any comment
		Comment({ fg = blue.da(50).ro(10) }), -- Any comment

		Constant({ fg = blue }), -- (*) Any constant
		String({ fg = blue }), --   A string constant: "this is a string"
		-- Character      { }, --   A character constant: 'c', '\n'
		-- Number         { }, --   A number constant: 234, 0xff
		-- Boolean        { }, --   A boolean constant: TRUE, false
		-- Float          { }, --   A floating point constant: 2.3e10

		Identifier({ fg = blue }), -- (*) Any variable name
		Function({ fg = red, gui = "bold" }), --   Function name (also: methods for classes)

		Statement({ fg = red, gui = "bold" }), -- (*) Any statement
		-- Conditional    { }, --   if, then, else, endif, switch, etc.
		-- Repeat         { }, --   for, do, while, etc.
		-- Label          { }, --   case, default, etc.
		Operator({ fg = red }), --   "sizeof", "+", "*", etc.
		-- Keyword        { }, --   any other keyword
		-- Exception      { }, --   try, catch, throw

		PrePro({ Statement }), -- (*) Generic Preprocessor
		-- Include        { }, --   Preprocessor #include
		-- Define         { }, --   Preprocessor #define
		-- Macro          { }, --   Same as Define
		-- PreCondit      { }, --   Preprocessor #if, #else, #endif, etc.

		Type({ fg = red }), -- (*) int, long, char, etc.
		StorageClass({ Type }), --   static, register, volatile, etc.
		Structure({ fg = red, gui = "bold" }), --   struct, union, enum, etc.
		Typedef({ Structure }), --   A typedef

		Special({ fg = red, gui = "bold" }), -- (*) Any special symbol
		-- SpecialChar({}), --   Special character in a constant
		-- Tag            { }, --   You can use CTRL-] on this
		Delimiter({ fg = red }), --   Character that needs attention
		-- SpecialComment { }, --   Special things inside a comment (e.g. '\n')
		-- Debug          { }, --   Debugging statements
		Underlined({ gui = "underline, bold" }), -- Text that stands out, HTML links
		-- Ignore({}), -- Left blank, hidden |hl-Ignore| (NOTE: May be invisible here in template)
		-- UError({ bg = red, fg = white, gui = "bold" }), -- Any erroneous construct
		Todo({ bg = yellow, fg = black, gui = "bold" }), -- Anything that needs extra attention; mostly the keywords TODO FIXME and XXX

		-- These groups are for the native LSP client and diagnostic system. Some
		-- other LSP clients may use these groups, or use their own. Consult your
		-- LSP client's documentation.

		-- See :h lsp-highlight, some groups may not be listed, submit a PR fix to lush-template!
		--
		LspReferenceText({ bg = red }), -- Used for highlighting "text" references
		LspReferenceRead({ bg = red }), -- Used for highlighting "read" references
		LspReferenceWrite({ bg = red }), -- Used for highlighting "write" references
		LspCodeLens({ fg = red }), -- Used to color the virtual text of the codelens. See |nvim_buf_set_extmark()|.
		LspCodeLensSeparator({ fg = red }), -- Used to color the seperator between two or more code lens.
		LspSignatureActiveParameter({ fg = red }), -- Used to highlight the active parameter in the signature help. See |vim.lsp.handlers.signature_help()|.

		-- See :h diagnostic-highlights, some groups may not be listed, submit a PR fix to lush-template!
		--
		DiagnosticError({ fg = red, bg = red.da(83).de(20), gui = "bold" }), -- U fg = yellow, bg = yellow.da(85).de(20)sed as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticWarn({ fg = yellow, bg = yellow.da(85).de(20) }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticInfo({ fg = blue, bg = blue.da(85).de(20) }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticHint({ fg = blue, bg = blue.da(85).de(20) }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticOk({ fg = blue, bg = blue.da(85).de(20) }), -- Used as the base highlight group. Other Diagnostic highlights link to this by default (except Underline)
		DiagnosticVirtualTextError({ fg = red, bg = red.da(83).de(20), gui = "bold" }),
		DiagnosticVirtualTextWarn({ fg = yellow, bg = yellow.da(83).de(20) }), -- Used for "Warn" diagnostic virtual text.
		DiagnosticVirtualTextInfo({ fg = blue, bg = blue.da(85).de(20) }), -- Used for "Info" diagnostic virtual text.
		DiagnosticVirtualTextHint({ fg = blue, bg = blue.da(85).de(20) }), -- Used for "Hint" diagnostic virtual text.
		DiagnosticVirtualTextOk({ fg = blue, bg = blue.da(85).de(20) }), -- Used for "Ok" diagnostic virtual text.
		DiagnosticUnderlineError({ fg = red, bg = red.da(83).de(20), gui = "bold" }), -- Used to underline "Error" diagnostics.
		DiagnosticUnderlineWarn({ fg = yellow, bg = yellow.da(83).de(20) }), -- Used to underline "Warn" diagnostics.
		DiagnosticUnderlineInfo({ fg = blue, bg = blue.da(85).de(20) }), -- Used to underline "Info" diagnostics.
		DiagnosticUnderlineHint({ fg = blue, bg = blue.da(85).de(20) }), -- Used to underline "Hint" diagnostics.
		DiagnosticUnderlineOk({ fg = blue, bg = blue.da(85).de(20) }), -- Used to underline "Ok" diagnostics.
		DiagnosticFloatingError({ fg = red, bg = red.da(83).de(20), gui = "bold" }), -- Used to color "Error" diagnostic messages in diagnostics float. See |vim.diagnostic.open_float()|
		DiagnosticFloatingWarn({ fg = yellow, bg = yellow.da(83).de(20) }), -- Used to color "Warn" diagnostic messages in diagnostics float.
		DiagnosticFloatingInfo({ fg = blue, bg = blue.da(85).de(20) }), -- Used to color "Info" diagnostic messages in diagnostics float.
		DiagnosticFloatingHint({ fg = blue, bg = blue.da(85).de(20) }), -- Used to color "Hint" diagnostic messages in diagnostics float.
		DiagnosticFloatingOk({ fg = blue, bg = blue.da(85).de(20) }), -- Used to color "Ok" diagnostic messages in diagnostics float.
		DiagnosticSignError({ fg = red, bg = red.da(83).de(20), gui = "bold" }), -- Used for "Error" signs in sign column.
		DiagnosticSignWarn({ fg = yellow, bg = yellow.da(83).de(20) }), -- Used for "Warn" signs in sign column.
		DiagnosticSignInfo({ fg = blue, bg = blue.da(85).de(20) }), -- Used for "Info" signs in sign column.
		DiagnosticSignHint({ fg = blue, bg = blue.da(85).de(20) }), -- Used for "Hint" signs in sign column.
		DiagnosticSignOk({ fg = blue, bg = blue.da(85).de(20) }), -- Used for "Ok" signs in sign column.

		-- NeoTree
		NeoTreeIndentMarker({ fg = blue.da(50) }),
		NeoTreeExpander({ fg = blue.da(30) }),
		NeoTreeModified({ fg = yellow }),
		NeoTreeFileName({ fg = blue }),
		NeoTreeDirectoryName({ fg = blue }),
		NeoTreeGitModified({ fg = red }),
		NeoTreeGitUntracked({ fg = red }),
		NeoTreeFileIcon({ bg = black }),

		GitSignsStagedAdd({ fg = black }),
		GitSignsStagedChange({ fg = black }),
		GitSignsStagedDelete({ fg = black }),

		-- Icons
		MiniIconsYellow({ fg = yellow }),
		MiniIconsOrange({ fg = yellow }),
		MiniIconsBlue({ fg = blue }),
		MiniIconsCyan({ fg = blue }),
		MiniIconsGreen({ fg = blue }),
		MiniIconsRed({ fg = red }),
		MiniIconsPurple({ fg = red }),
		MiniIconsGrey({ fg = red }),
		MiniIconsAzure({ fg = red }),

		-- Markdown
		RenderMarkdownH1({ fg = red }),
		RenderMarkdownH1Bg({ fg = red, bg = black.li(10) }),

		-- Tree-Sitter syntax groups.
		--
		-- See :h treesitter-highlight-groups, some groups may not be listed,
		-- submit a PR fix to lush-template!
		--
		-- Tree-Sitter groups are defined with an "@" symbol, which must be
		-- specially handled to be valid lua code, we do this via the special
		-- sym function. The following are all valid ways to call the sym function,
		-- for more details see https://www.lua.org/pil/5.html
		--
		-- sym("@text.literal")
		-- sym('@text.literal')
		-- sym"@text.literal"
		-- sym'@text.literal'
		--
		-- For more information see https://github.com/rktjmp/lush.nvim/issues/109

		sym("@attribute")({ fg = red }),
		sym("@diff.plus")({ fg = yellow }),
		sym("@diff.minus")({ fg = red }),
		sym("@diff.delta")({ fg = blue }),
		-- sym"@text.literal"      { }, -- Comment
		-- sym("@text.reference")({ fg = red }), -- Identifier
		-- sym"@text.title"        { }, -- Title
		-- sym"@text.uri"          { }, -- Underlined
		-- sym"@text.underline"    { }, -- Underlined
		-- sym"@text.todo"         { }, -- Todo
		-- sym"@comment"           { }, -- Comment
		-- sym"@punctuation"       { }, -- Delimiter
		-- sym"@constant"          { }, -- Constant
		-- sym"@constant.builtin"  { }, -- Special
		-- sym"@constant.macro"    { }, -- Define
		-- sym"@define"            { }, -- Define
		-- sym"@macro"             { }, -- Macro
		sym("@string")({ fg = red.da(45).ro(10) }), -- String
		-- sym("@string.escape")({}), -- SpecialChar
		-- sym("@string.special")({ fg = hsl("#00607d") }), -- SpecialChar
		sym("@character")({}), -- Character
		sym("@character.special")({}), -- SpecialChar
		sym("@number")({}), -- Number
		-- sym"@boolean"           { }, -- Boolean
		-- sym"@float"             { }, -- Float
		sym("@function")({ fg = red }), -- Function
		-- sym"@function.builtin"  { }, -- Special
		-- sym"@function.macro"    { }, -- Macro
		sym("@parameter")({}), -- Identifier
		sym("@method")({ fg = blue }), -- Function
		-- sym"@field"             { }, -- Identifier
		-- sym"@property"          { }, -- Identifier
		-- sym"@constructor"       { }, -- Special
		-- sym"@conditional"       { }, -- Conditional
		-- sym"@repeat"            { }, -- Repeat
		-- sym"@label"             { }, -- Label
		sym("@operator")({ fg = red }), -- Operator
		-- sym"@keyword"           { }, -- Keyword
		-- sym"@exception"         { }, -- Exception
		sym("@variable")({ fg = blue }), -- Identifier
		sym("@type")({ fg = red }), -- Type
		sym("@type.definition")({}), -- Typedef
		-- sym"@storageclass"      { }, -- StorageClass
		-- sym"@structure"         { }, -- Structure
		-- sym"@namespace"         { }, -- Identifier
		-- sym"@include"           { }, -- Include
		-- sym"@preproc"           { }, -- PreProc
		-- sym"@debug"             { }, -- Debug
		-- sym"@tag"               { }, -- Tag
	}
end)

-- Return our parsed theme for extension or use elsewhere.
return theme

-- vi:nowrap
