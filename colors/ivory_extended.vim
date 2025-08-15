" PATCH BEGIN
let g:colors_name="ivory_extended"
set background=light
highlight Normal guifg=#352e2e guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight Boolean guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link @boolean Boolean
highlight Character guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link SpecialKey Character
highlight! link @character Character
highlight CmpBorder guifg=#9e8d7f guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight CmpDocumentation guifg=NONE guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight CmpDocumentationBorder guifg=#edeae4 guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbr guifg=#746458 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrDefault guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrDeprecated guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight CmpItemAbbrDeprecatedDefault guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatchDefault guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatchFuzzy guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatchFuzzyDefault guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemKind guifg=#e5e1d9 guibg=#573e1a guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindClassDefault CmpItemKind
highlight! link CmpItemKindColorDefault CmpItemKind
highlight! link CmpItemKindConstantDefault CmpItemKind
highlight! link CmpItemKindConstructorDefault CmpItemKind
highlight! link CmpItemKindEnumDefault CmpItemKind
highlight! link CmpItemKindEnumMemberDefault CmpItemKind
highlight! link CmpItemKindEventDefault CmpItemKind
highlight! link CmpItemKindFieldDefault CmpItemKind
highlight! link CmpItemKindFileDefault CmpItemKind
highlight! link CmpItemKindFolderDefault CmpItemKind
highlight! link CmpItemKindFunctionDefault CmpItemKind
highlight! link CmpItemKindInterfaceDefault CmpItemKind
highlight! link CmpItemKindKeywordDefault CmpItemKind
highlight! link CmpItemKindMethodDefault CmpItemKind
highlight! link CmpItemKindModuleDefault CmpItemKind
highlight! link CmpItemKindOperatorDefault CmpItemKind
highlight! link CmpItemKindPropertyDefault CmpItemKind
highlight! link CmpItemKindReferenceDefault CmpItemKind
highlight! link CmpItemKindSnippetDefault CmpItemKind
highlight! link CmpItemKindStructDefault CmpItemKind
highlight! link CmpItemKindTextDefault CmpItemKind
highlight! link CmpItemKindTypeParameterDefault CmpItemKind
highlight! link CmpItemKindUnitDefault CmpItemKind
highlight! link CmpItemKindValueDefault CmpItemKind
highlight! link CmpItemKindVariableDefault CmpItemKind
highlight CmpItemKindDefault guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemKindFunction guifg=#e5e1d9 guibg=#735057 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindConstructor CmpItemKindFunction
highlight! link CmpItemKindEnum CmpItemKindFunction
highlight! link CmpItemKindField CmpItemKindFunction
highlight! link CmpItemKindMethod CmpItemKindFunction
highlight! link CmpItemKindOperator CmpItemKindFunction
highlight! link CmpItemKindReference CmpItemKindFunction
highlight! link CmpItemKindTypeParameter CmpItemKindFunction
highlight! link CmpItemKindUnit CmpItemKindFunction
highlight CmpItemKindInterface guifg=#e5e1d9 guibg=#543227 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindColor CmpItemKindInterface
highlight! link CmpItemKindEnumMember CmpItemKindInterface
highlight! link CmpItemKindFolder CmpItemKindInterface
highlight! link CmpItemKindKeyword CmpItemKindInterface
highlight! link CmpItemKindSnippet CmpItemKindInterface
highlight CmpItemKindProperty guifg=#e5e1d9 guibg=#464c3a guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindEvent CmpItemKindProperty
highlight! link CmpItemKindStruct CmpItemKindProperty
highlight CmpItemKindText guifg=#e5e1d9 guibg=#735057 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindConstant CmpItemKindText
highlight! link CmpItemKindModule CmpItemKindText
highlight CmpItemKindVariable guifg=#e5e1d9 guibg=#545468 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindClass CmpItemKindVariable
highlight! link CmpItemKindFile CmpItemKindVariable
highlight! link CmpItemKindValue CmpItemKindVariable
highlight CmpItemMenuDefault guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight ColorColumn guifg=NONE guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight! link debugPC ColorColumn
highlight Comment guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link BlinkCmpGhostText Comment
highlight! link @comment Comment
highlight! link @lsp.type.comment Comment
highlight! link @org.agenda.deadline Conceal
highlight! link @punctuation.bracket Conceal
highlight Conditional guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link PreCondit Conditional
highlight! link Typedef Conditional
highlight! link @constant.builtin Conditional
highlight! link @keyword.conditional Conditional
highlight Constant guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link @constant Constant
highlight! link @lsp.type.enumMember Constant
highlight CurSearch guifg=NONE guibg=#dfe1e6 guisp=NONE blend=NONE gui=NONE
highlight CursorColumn guifg=NONE guibg=#493f37 guisp=NONE blend=NONE gui=NONE
highlight CursorLine guifg=NONE guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight! link NeogitCursorLine CursorLine
highlight! link QuickFixLine CursorLine
highlight CursorLineFold guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLineNr guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight CursorLineSign guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Define guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @constant.macro Define
highlight! link @define Define
highlight! link @type.definition Define
highlight Delimiter guifg=#9e8d7f guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemMenu Delimiter
highlight! link CmpWindowScrollThumb Delimiter
highlight! link Conceal Delimiter
highlight! link Noise Delimiter
highlight! link @markup.heading.1.marker Delimiter
highlight! link @markup.heading.2.marker Delimiter
highlight! link @markup.heading.3.marker Delimiter
highlight! link @markup.heading.4.marker Delimiter
highlight! link @markup.heading.5.marker Delimiter
highlight! link @markup.heading.6.marker Delimiter
highlight! link @punctuation Delimiter
highlight! link @punctuation.delimiter.yaml Delimiter
highlight DiagnosticSignError guifg=#79241f guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignError DiagnosticSignError
highlight DiagnosticSignHint guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignHint DiagnosticSignHint
highlight DiagnosticSignInfo guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignInformation DiagnosticSignInfo
highlight DiagnosticSignOk guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiagnosticSignWarn guifg=#573e1a guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignWarning DiagnosticSignWarn
highlight DiagnosticUnderlineOk guifg=NONE guibg=NONE guisp=#464c3a blend=NONE gui=undercurl
highlight DiagnosticUnnecessary guifg=NONE guibg=NONE guisp=#574b42 blend=NONE gui=underdotted
highlight DiffAdd guifg=#686d63 guibg=#d5dbcd guisp=NONE blend=NONE gui=NONE
highlight! link Added DiffAdd
highlight! link NeogitDiffAdd DiffAdd
highlight! link diffAdded DiffAdd
highlight DiffChange guifg=#97757B guibg=#f1e8ea guisp=NONE blend=NONE gui=NONE
highlight! link Changed DiffChange
highlight DiffDelete guifg=#834c40 guibg=#ecd5d3 guisp=NONE blend=NONE gui=NONE
highlight! link Removed DiffDelete
highlight! link Todo DiffDelete
highlight! link diffRemoved DiffDelete
highlight DiffFGAdd guifg=#686d63 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffFGChange guifg=#97757B guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffFGDelete guifg=#834c40 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffFGText guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffText guifg=#493f37 guibg=#e5e1d9 guisp=NONE blend=NONE gui=NONE
highlight Directory guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @module Directory
highlight! link @org.agenda.scheduled Directory
highlight Error guifg=#79241f guibg=#dcb2a7 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticError Error
highlight! link @comment.error Error
highlight ErrorMsg guifg=#79241f guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingError ErrorMsg
highlight! link DiagnosticVirtualLinesError ErrorMsg
highlight! link DiagnosticVirtualTextError ErrorMsg
highlight! link debugBreakpoint ErrorMsg
highlight! link @function.macro ErrorMsg
highlight Exception guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight FlashBackdrop guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight FlashLabel guifg=#545468 guibg=#dfe1e6 guisp=NONE blend=NONE gui=NONE
highlight FlashPromptIcon guifg=#edeae4 guibg=#834c40 guisp=NONE blend=NONE gui=bold
highlight! link @number.float Float
highlight FloatBorder guifg=#e5e1d9 guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight! link BlinkCmpSignatureHelpBorder FloatBorder
highlight! link TelescopeBorder FloatBorder
highlight! link TelescopePreviewBorder FloatBorder
highlight FloatFooter guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight FloatShadow guifg=NONE guibg=black guisp=NONE blend=80 gui=NONE
highlight FloatShadowThrough guifg=NONE guibg=black guisp=NONE blend=100 gui=NONE
highlight FloatTitle guifg=#e5e1d9 guibg=#79241f guisp=NONE blend=NONE gui=bold
highlight FoldColumn guifg=#9e8d7f guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Folded guifg=#9e8d7f guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight Function guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @function Function
highlight! link @function.method Function
highlight! link @lsp.type.decorator Function
highlight! link @lsp.type.function Function
highlight! link @lsp.type.method Function
highlight FzfLuaLivePrompt guifg=#574b42 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight FzfLuaTitleFlags guifg=#edeae4 guibg=#834c40 guisp=NONE blend=NONE gui=bold
highlight Hint guifg=#735057 guibg=#dbc4c8 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticHint Hint
highlight! link @comment.hint Hint
highlight HintMsg guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingHint HintMsg
highlight! link DiagnosticVirtualLinesHint HintMsg
highlight! link DiagnosticVirtualTextHint HintMsg
highlight Identifier guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link @lsp.type.parameter Identifier
highlight! link @lsp.type.property Identifier
highlight! link @lsp.type.variable Identifier
highlight! link @punctuation.delimiter Identifier
highlight! link @variable Identifier
highlight IncSearch guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight! link Cursor IncSearch
highlight! link MatchParen IncSearch
highlight Include guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link @keyword.import Include
highlight Info guifg=#545468 guibg=#dfe1e6 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticInfo Info
highlight! link @comment.info Info
highlight! link @comment.note Info
highlight! link @comment.ok Info
highlight InfoMsg guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingInfo InfoMsg
highlight! link DiagnosticVirtualLinesInfo InfoMsg
highlight! link DiagnosticVirtualTextInfo InfoMsg
highlight Keyword guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Label guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight LineNr guifg=#9e8d7f guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoFiletype guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoList guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoTip guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoTitle guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInlayHint guifg=#837163 guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight LspSignatureActiveParameter guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Macro guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link @lsp.type.macro Macro
highlight! link @macro Macro
highlight MasonHeader guifg=#edeae4 guibg=#735057 guisp=NONE blend=NONE gui=bold
highlight MasonHeaderSecondary guifg=#edeae4 guibg=#545468 guisp=NONE blend=NONE gui=bold
highlight MasonHighlight guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightBlock guifg=#edeae4 guibg=#545468 guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightBlockBold guifg=#edeae4 guibg=#545468 guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockBoldSecondary guifg=#edeae4 guibg=#493f37 guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockSecondary guifg=#edeae4 guibg=#493f37 guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightSecondary guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonMuted guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonMutedBlock guifg=#493f37 guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight MasonMutedBlockBold guifg=#493f37 guibg=#d7d3cb guisp=NONE blend=NONE gui=bold
highlight MoreMsg guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingOk MoreMsg
highlight! link DiagnosticVirtualLinesOk MoreMsg
highlight! link DiagnosticVirtualTextOk MoreMsg
highlight! link DiagnosticOk MsgArea
highlight NavicSeparator guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffContext guifg=NONE guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffContextCursor guifg=NONE guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffContextHighlight guifg=NONE guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffHeader guifg=#79241f guibg=#e5e1d9 guisp=NONE blend=NONE gui=bold
highlight NeogitHunkHeader guifg=#79241f guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight NeogitHunkHeaderCursor guifg=#79241f guibg=#edeae4 guisp=NONE blend=NONE gui=bold
highlight NeogitHunkHeaderHighlight guifg=#79241f guibg=#edeae4 guisp=NONE blend=NONE gui=bold
highlight NeogitSectionHeader guifg=#545468 guibg=#dfe1e6 guisp=NONE blend=NONE gui=bold
highlight NonText guifg=#e5e1d9 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link EndOfBuffer NonText
highlight! link Ignore NonText
highlight! link Whitespace NonText
highlight NormalFloat guifg=#493f37 guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight! link TelescopeNormal NormalFloat
highlight! link TelescopePreviewNormal NormalFloat
highlight NullLsInfoBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoHeader guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoSources guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoTitle guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Number guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Float Number
highlight! link Type Number
highlight! link @markup.math Number
highlight! link @number Number
highlight Operator guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Pmenu guifg=#493f37 guibg=#e5e1d9 guisp=NONE blend=NONE gui=NONE
highlight! link PmenuExtra Pmenu
highlight! link PmenuKind Pmenu
highlight! link WhichKeyFloat Pmenu
highlight PmenuSbar guifg=#d7d3cb guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight PmenuSel guifg=#493f37 guibg=#d7d3cb guisp=NONE blend=NONE gui=bold
highlight! link PmenuExtraSel PmenuSel
highlight! link PmenuKindSel PmenuSel
highlight! link WildMenu PmenuSel
highlight PmenuThumb guifg=#d7d3cb guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight PreProc guifg=#573e1a guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link @keyword.directive PreProc
highlight Question guifg=#573e1a guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link @property Question
highlight RedrawDebugClear guifg=NONE guibg=yellow guisp=NONE blend=NONE gui=NONE
highlight RedrawDebugComposed guifg=NONE guibg=green guisp=NONE blend=NONE gui=NONE
highlight RedrawDebugNormal guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight RedrawDebugRecompose guifg=NONE guibg=red guisp=NONE blend=NONE gui=NONE
highlight Repeat guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link SpecialChar Repeat
highlight! link @keyword Repeat
highlight! link @keyword.function Repeat
highlight! link @keyword.repeat Repeat
highlight! link @keyword.return Repeat
highlight! link @variable.builtin Repeat
highlight Search guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight! link Substitute Search
highlight SignColumn guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Special guifg=#79241f guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link CmpItemAbbrMatch Special
highlight! link DressingSelectIdx Special
highlight! link @lsp.type.keyword.yaml.ansible Special
highlight! link @string.special.symbol Special
highlight SpecialComment guifg=#574b42 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @lsp.type.keyword.lua SpecialComment
highlight SpellBad guifg=NONE guibg=NONE guisp=#79241f blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineError SpellBad
highlight SpellCap guifg=NONE guibg=NONE guisp=#735057 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineHint SpellCap
highlight SpellLocal guifg=NONE guibg=NONE guisp=#543227 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineWarn SpellLocal
highlight SpellRare guifg=NONE guibg=NONE guisp=#545468 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineInfo SpellRare
highlight Statement guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLine guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link MsgArea StatusLine
highlight! link MsgSeparator StatusLine
highlight! link StatusLineTerm StatusLine
highlight StatusLineNC guifg=#574b42 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link NavicText StatusLineNC
highlight! link StatusLineTermNC StatusLineNC
highlight Statusline guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslineAlt guifg=#837163 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslineBlue guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslineGreen guifg=#464c3a guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslineMagenta guifg=#673d58 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslineMode guifg=#edeae4 guibg=#352e2e guisp=NONE blend=NONE gui=bold
highlight StatuslineModified guifg=#edeae4 guibg=#79241f guisp=NONE blend=NONE gui=bold
highlight StatuslineModifiedInv guifg=#79241f guibg=NONE guisp=NONE blend=NONE gui=bold
highlight StatuslineOrange guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslinePink guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslineRed guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatuslineScrollbar guifg=#79241f guibg=#e5e1d9 guisp=NONE blend=NONE gui=NONE
highlight StatuslineYellow guifg=#573e1a guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StorageClass guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link Structure StorageClass
highlight! link @keyword.storage StorageClass
highlight String guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link @string String
highlight TSPlaygroundFocus guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TSPlaygroundLang guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TSQueryLinterError guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TabLine guifg=#746458 guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight TabLineFill guifg=NONE guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight TabLineSel guifg=#574b42 guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight TelescopeBufferLoaded guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeFrecencyScores guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMatching guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight TelescopeMultiIcon guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMultiSelection guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold
highlight TelescopePathSeparator guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewBlock guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewCharDev guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewDate guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewDirectory guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewExecute guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewGroup guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewHyphen guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewLine guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewLink guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewMatch guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewMessage guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewMessageFillchar guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewPipe guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewRead guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewSize guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewSocket guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewSticky guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewTitle guifg=#edeae4 guibg=#352e2e guisp=NONE blend=NONE gui=bold
highlight TelescopePreviewUser guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewWrite guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptBorder guifg=#d7d3cb guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptCounter guifg=#574b42 guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptNormal guifg=NONE guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptPrefix guifg=#7c4034 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link TelescopeResultsDiffUntracked TelescopePromptPrefix
highlight TelescopePromptTitle guifg=#e5e1d9 guibg=#79241f guisp=NONE blend=NONE gui=bold
highlight TelescopeQueryFilter guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsBorder guifg=#e5e1d9 guibg=#e5e1d9 guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsClass guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsComment guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsConstant guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsDiffAdd guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsDiffChange guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsDiffDelete guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsField guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsFunction guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsIdentifier guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsLineNr guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsMethod guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsNormal guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsNumber guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsOperator guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsSpecialComment guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsStruct guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeResultsTitle guifg=#e5e1d9 guibg=#464c3a guisp=NONE blend=NONE gui=bold
highlight TelescopeResultsVariable guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeSelection guifg=#352e2e guibg=#e5e1d9 guisp=NONE blend=NONE gui=bold
highlight TelescopeSelectionCaret guifg=#352e2e guibg=#d7d3cb guisp=NONE blend=NONE gui=NONE
highlight TelescopeTitle guifg=#edeae4 guibg=#79241f guisp=NONE blend=NONE gui=bold
highlight TermCursor guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight Terminal guifg=#352e2e guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight Title guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Underlined guifg=#573e1a guibg=NONE guisp=#573e1a blend=NONE gui=underline
highlight! link Tag Underlined
highlight! link @markup.underline Underlined
highlight! link @string.special.uri Underlined
highlight VertSplit guifg=#edeae4 guibg=#f1efeb guisp=NONE blend=NONE gui=NONE
highlight! link WinSeparator VertSplit
highlight Visual guifg=NONE guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight! link VisualNOS Visual
highlight Warning guifg=#573e1a guibg=#d6c890 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticWarn Warning
highlight! link @comment.warning Warning
highlight WarningMsg guifg=#573e1a guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Debug WarningMsg
highlight! link DiagnosticFloatingWarn WarningMsg
highlight! link DiagnosticVirtualLinesWarn WarningMsg
highlight! link DiagnosticVirtualTextWarn WarningMsg
highlight! link ModeMsg WarningMsg
highlight WhichKey guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeyBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeyDesc guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeyGroup guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeySeparator guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WhichKeyValue guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight WinBar guifg=NONE guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight! link WinBarNC WinBar
highlight lCursor guifg=bg guibg=fg guisp=NONE blend=NONE gui=NONE
highlight @character.printf guifg=#79241f guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @comment.todo guifg=#735057 guibg=#dbc4c8 guisp=NONE blend=NONE gui=NONE
highlight @error guifg=#7c4034 guibg=NONE guisp=#7c4034 blend=NONE gui=undercurl
highlight @function.builtin guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @keyword.exception guifg=#8e3d63 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @label guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.heading guifg=#7c4034 guibg=NONE guisp=#7c4034 blend=NONE gui=bold,underline
highlight @markup.heading.1 guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight @markup.heading.2 guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight @markup.heading.3 guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight @markup.heading.4 guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight @markup.heading.5 guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight @markup.heading.6 guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight @markup.italic guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @markup.link.label guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.link.url guifg=#464c3a guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @markup.quote guifg=#574b42 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @markup.raw guifg=#493f37 guibg=#edeae4 guisp=NONE blend=NONE gui=NONE
highlight @markup.raw.block guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.reference guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.strikethrough guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight @markup.strong guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level1 guifg=#352e2e guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level2 guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level3 guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level4 guifg=#464c3a guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level5 guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level6 guifg=#573e1a guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.keyword.done guifg=#464c3a guibg=#d0d8cc guisp=NONE blend=NONE gui=NONE
highlight @org.keyword.todo guifg=#735057 guibg=#dbc4c8 guisp=NONE blend=NONE gui=NONE
highlight @punctuation.special guifg=#746458 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @string.escape guifg=#545468 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.special.url guifg=#464c3a guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @string.yaml guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.member guifg=#493f37 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.parameter guifg=#543227 guibg=NONE guisp=NONE blend=NONE gui=NONE
" PATCH END

lua << EOF
vim.g.terminal_color_0 = "#f1efeb"
vim.g.terminal_color_1 = "#735057"
vim.g.terminal_color_2 = "#543227"
vim.g.terminal_color_3 = "#545468"
vim.g.terminal_color_4 = "#464c3a"
vim.g.terminal_color_5 = "#735057"
vim.g.terminal_color_6 = "#673d58"
vim.g.terminal_color_7 = "#352e2e"
vim.g.terminal_color_8 = "#e5e1da"
vim.g.terminal_color_9 = "#7c4034"
vim.g.terminal_color_10 = "#464c3a"
vim.g.terminal_color_11 = "#543227"
vim.g.terminal_color_12 = "#545468"
vim.g.terminal_color_13 = "#735057"
vim.g.terminal_color_14 = "#673d58"
vim.g.terminal_color_15 = "#493f37"
EOF
