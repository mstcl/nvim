" PATCH BEGIN
let g:colors_name="ivory_extended"
set background=light
highlight Normal guifg=#352F2F guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight! link NvimSpacing Normal
highlight AerialLine guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight AerialNormal guifg=#78675C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialLineNC AerialNormal
highlight Blue guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialBooleanIcon Boolean
highlight! link AerialFunctionIcon Boolean
highlight! link AerialMethodIcon Boolean
highlight! link @boolean Boolean
highlight Character guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link SpecialKey Character
highlight! link @character Character
highlight CmpBorder guifg=#89766A guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight CmpDocumentation guifg=NONE guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight CmpDocumentationBorder guifg=#E6E2DA guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbr guifg=#78675C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrDefault guifg=#78675C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrDeprecated guifg=#78675C guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight CmpItemAbbrDeprecatedDefault guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatch guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight CmpItemAbbrMatchDefault guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatchFuzzy guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatchFuzzyDefault guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemKind guifg=#E6E2DA guibg=#563E1A guisp=NONE blend=NONE gui=NONE
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
highlight CmpItemKindDefault guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemKindFunction guifg=#E6E2DA guibg=#553327 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindConstructor CmpItemKindFunction
highlight! link CmpItemKindEnum CmpItemKindFunction
highlight! link CmpItemKindField CmpItemKindFunction
highlight! link CmpItemKindMethod CmpItemKindFunction
highlight! link CmpItemKindOperator CmpItemKindFunction
highlight! link CmpItemKindReference CmpItemKindFunction
highlight! link CmpItemKindTypeParameter CmpItemKindFunction
highlight! link CmpItemKindUnit CmpItemKindFunction
highlight CmpItemKindInterface guifg=#E6E2DA guibg=#553327 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindColor CmpItemKindInterface
highlight! link CmpItemKindEnumMember CmpItemKindInterface
highlight! link CmpItemKindFolder CmpItemKindInterface
highlight! link CmpItemKindKeyword CmpItemKindInterface
highlight! link CmpItemKindSnippet CmpItemKindInterface
highlight CmpItemKindProperty guifg=#E6E2DA guibg=#454B39 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindEvent CmpItemKindProperty
highlight! link CmpItemKindStruct CmpItemKindProperty
highlight CmpItemKindText guifg=#E6E2DA guibg=#735057 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindConstant CmpItemKindText
highlight! link CmpItemKindModule CmpItemKindText
highlight CmpItemKindVariable guifg=#E6E2DA guibg=#535367 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindClass CmpItemKindVariable
highlight! link CmpItemKindFile CmpItemKindVariable
highlight! link CmpItemKindValue CmpItemKindVariable
highlight CmpItemMenu guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemMenuDefault guifg=#78675C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpWindowScrollThumb guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight ColorColumn guifg=NONE guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight Comment guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link BlinkCmpGhostText Comment
highlight! link Operator Comment
highlight! link @comment Comment
highlight! link @lsp.type.comment Comment
highlight! link @org.agenda.deadline Conceal
highlight! link @punctuation.bracket Conceal
highlight Conditional guifg=#563E1A guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link PreCondit Conditional
highlight! link Typedef Conditional
highlight! link @constant.builtin Conditional
highlight! link @keyword.conditional Conditional
highlight Constant guifg=#553327 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialConstantIcon Constant
highlight! link Boolean Constant
highlight! link @constant Constant
highlight! link @lsp.type.enumMember Constant
highlight CurSearch guifg=NONE guibg=#CAD6DE guisp=NONE blend=NONE gui=NONE
highlight CursorColumn guifg=NONE guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight CursorLine guifg=NONE guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight! link NeogitCursorLine CursorLine
highlight! link TreesitterContext CursorLine
highlight! link TreesitterContextLineNumber CursorLine
highlight CursorLineFold guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLineNr guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight CursorLineSign guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Cyan guifg=#563E1A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Define guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @constant.macro Define
highlight! link @define Define
highlight! link @type.definition Define
highlight Delimiter guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Conceal Delimiter
highlight! link Noise Delimiter
highlight! link NvimArrow Delimiter
highlight! link NvimColon Delimiter
highlight! link NvimComma Delimiter
highlight! link NvimParenthesis Delimiter
highlight! link NvimTreeIndentMarker Delimiter
highlight! link RenderMarkdownChecked Delimiter
highlight! link RenderMarkdownTodo Delimiter
highlight! link RenderMarkdownUnchecked Delimiter
highlight! link helpSectionDelim Delimiter
highlight! link @markup.heading.1.marker Delimiter
highlight! link @markup.heading.2.marker Delimiter
highlight! link @markup.heading.3.marker Delimiter
highlight! link @markup.heading.4.marker Delimiter
highlight! link @markup.heading.5.marker Delimiter
highlight! link @markup.heading.6.marker Delimiter
highlight! link @markup.list.checked.markdown Delimiter
highlight! link @markup.list.unchecked.markdown Delimiter
highlight! link @punctuation Delimiter
highlight! link @punctuation.delimiter.yaml Delimiter
highlight DiagnosticSignError guifg=#79241F guibg=#E8D0C2 guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignError DiagnosticSignError
highlight DiagnosticSignHint guifg=#735057 guibg=#DDD1DE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignHint DiagnosticSignHint
highlight DiagnosticSignInfo guifg=#535367 guibg=#CAD6DE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignInformation DiagnosticSignInfo
highlight DiagnosticSignOk guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiagnosticSignWarn guifg=#523427 guibg=#E6D3A2 guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignWarning DiagnosticSignWarn
highlight DiagnosticUnderlineOk guifg=NONE guibg=NONE guisp=#454B39 blend=NONE gui=undercurl
highlight DiagnosticUnnecessary guifg=NONE guibg=NONE guisp=#5B4D45 blend=NONE gui=underdotted
highlight DiffAdd guifg=NONE guibg=#CED7C8 guisp=NONE blend=NONE gui=NONE
highlight! link Added DiffAdd
highlight! link NeogitDiffAdd DiffAdd
highlight DiffChange guifg=NONE guibg=#DED1D9 guisp=NONE blend=NONE gui=NONE
highlight! link Changed DiffChange
highlight DiffDelete guifg=NONE guibg=#E7CFC9 guisp=NONE blend=NONE gui=NONE
highlight! link Removed DiffDelete
highlight! link Todo DiffDelete
highlight DiffText guifg=NONE guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelCounter guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelDeletions guifg=#844D41 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelInsertions guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelRootPath guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiffviewFilePanelSelected guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiffviewFilePanelTitle guifg=#553327 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiffviewStatusAdded guifg=#676C62 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusBroken guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusCopied guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusDeleted guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusModified guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusRenamed guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusTypeChange guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusUnknown guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusUnmerged guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialNamespaceIcon Directory
highlight! link NeogitBranch Directory
highlight! link NvimTreeFolderIcon Directory
highlight! link @module Directory
highlight! link @org.agenda.scheduled Directory
highlight Error guifg=#79241F guibg=#E8D0C2 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticError Error
highlight! link NvimInvalid Error
highlight! link @comment.error Error
highlight ErrorMsg guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingError ErrorMsg
highlight! link DiagnosticVirtualLinesError ErrorMsg
highlight! link DiagnosticVirtualTextError ErrorMsg
highlight! link NvimInvalidSpacing ErrorMsg
highlight! link @function.macro ErrorMsg
highlight! link @number.float Float
highlight FloatBorder guifg=#E6E2DA guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight! link BlinkCmpSignatureHelpBorder FloatBorder
highlight! link TelescopeBorder FloatBorder
highlight! link TelescopePreviewBorder FloatBorder
highlight FloatFooter guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight FloatShadow guifg=NONE guibg=black guisp=NONE blend=80 gui=NONE
highlight FloatShadowThrough guifg=NONE guibg=black guisp=NONE blend=100 gui=NONE
highlight FloatTitle guifg=#E6E2DA guibg=#352F2F guisp=NONE blend=NONE gui=bold
highlight FoldColumn guifg=#A99183 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Folded guifg=#A99183 guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight Function guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link RenderMarkdownH1 Function
highlight! link RenderMarkdownH2 Function
highlight! link RenderMarkdownH3 Function
highlight! link RenderMarkdownH4 Function
highlight! link RenderMarkdownH5 Function
highlight! link RenderMarkdownH6 Function
highlight! link @function Function
highlight! link @function.method Function
highlight! link @lsp.type.decorator Function
highlight! link @lsp.type.function Function
highlight! link @lsp.type.method Function
highlight FzfLuaLivePrompt guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight FzfLuaTitleFlags guifg=#EDEBE5 guibg=#553327 guisp=NONE blend=NONE gui=bold
highlight GitSignsAdd guifg=#676C62 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight GitSignsChange guifg=#93687D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight GitSignsDelete guifg=#844D41 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Green guifg=#454B39 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Hint guifg=#735057 guibg=#DDD1DE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticHint Hint
highlight! link @comment.hint Hint
highlight HintMsg guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingHint HintMsg
highlight! link DiagnosticVirtualLinesHint HintMsg
highlight! link DiagnosticVirtualTextHint HintMsg
highlight Identifier guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialVariableIcon Identifier
highlight! link NvimIdentifier Identifier
highlight! link @lsp.type.parameter Identifier
highlight! link @lsp.type.property Identifier
highlight! link @lsp.type.variable Identifier
highlight! link @punctuation.delimiter Identifier
highlight! link @variable Identifier
highlight IncSearch guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight! link Cursor IncSearch
highlight! link MatchParen IncSearch
highlight! link Search IncSearch
highlight! link Substitute IncSearch
highlight InclineNormal guifg=#EDEBE5 guibg=#563E1A guisp=NONE blend=NONE gui=bold
highlight InclineNormalNC guifg=#78675C guibg=#E6E2DA guisp=NONE blend=NONE gui=bold
highlight Include guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link @keyword.import Include
highlight Info guifg=#535367 guibg=#CAD6DE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticInfo Info
highlight! link @comment.info Info
highlight! link @comment.note Info
highlight! link @comment.ok Info
highlight InfoMsg guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingInfo InfoMsg
highlight! link DiagnosticVirtualLinesInfo InfoMsg
highlight! link DiagnosticVirtualTextInfo InfoMsg
highlight! link helpOption Keyword
highlight Label guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link Exception Label
highlight! link helpHeader Label
highlight LineNr guifg=#A99183 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link GitSignsCurrentLineBlame LineNr
highlight LspCodeLens guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoFiletype guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoList guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoTip guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoTitle guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInlayHint guifg=#89766A guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight LspSignatureActiveParameter guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Macro guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link @lsp.type.macro Macro
highlight! link @macro Macro
highlight Magenta guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonHeader guifg=#E6E2DA guibg=#352F2F guisp=NONE blend=NONE gui=bold
highlight MasonHeaderSecondary guifg=#E6E2DA guibg=#563E1A guisp=NONE blend=NONE gui=bold
highlight MasonHighlight guifg=#563E1A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightBlock guifg=#E6E2DA guibg=#535367 guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightBlockBold guifg=#E6E2DA guibg=#535367 guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockBoldSecondary guifg=#E6E2DA guibg=#4B4039 guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockSecondary guifg=#E6E2DA guibg=#4B4039 guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightSecondary guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonMuted guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonMutedBlock guifg=#4B4039 guibg=#D7D1C5 guisp=NONE blend=NONE gui=NONE
highlight MasonMutedBlockBold guifg=#4B4039 guibg=#D7D1C5 guisp=NONE blend=NONE gui=bold
highlight MoreMsg guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingOk MoreMsg
highlight! link DiagnosticVirtualLinesOk MoreMsg
highlight! link DiagnosticVirtualTextOk MoreMsg
highlight! link DiagnosticOk MsgArea
highlight NeogitBranchHead guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight NeogitDiffContext guifg=NONE guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffContextCursor guifg=NONE guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffContextHighlight guifg=NONE guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffHeader guifg=#EDEBE5 guibg=#535367 guisp=NONE blend=NONE gui=bold
highlight NeogitHunkHeader guifg=#89766A guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight NeogitHunkHeaderCursor guifg=#79241F guibg=#EDEBE5 guisp=NONE blend=NONE gui=bold
highlight! link NeogitHunkHeaderHighlight NeogitHunkHeaderCursor
highlight NeogitPopupOptionDisabled guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link NeogitPopupActionDisabled NeogitPopupOptionDisabled
highlight! link NeogitPopupConfigDisabled NeogitPopupOptionDisabled
highlight! link NeogitPopupSwitchDisabled NeogitPopupOptionDisabled
highlight NeogitPopupOptionEnabled guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link NeogitPopupConfigEnabled NeogitPopupOptionEnabled
highlight! link NeogitPopupSwitchEnabled NeogitPopupOptionEnabled
highlight NeogitPopupOptionKey guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link NeogitPopupActionKey NeogitPopupOptionKey
highlight! link NeogitPopupConfigKey NeogitPopupOptionKey
highlight! link NeogitPopupSwitchKey NeogitPopupOptionKey
highlight NeogitSectionHeader guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight NonText guifg=#E6E2DA guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiffviewDiffDeleteDim NonText
highlight! link EndOfBuffer NonText
highlight! link Ignore NonText
highlight! link MiniIndentscopeSymbol NonText
highlight! link Whitespace NonText
highlight NormalFloat guifg=#4B4039 guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight! link TelescopeNormal NormalFloat
highlight! link TelescopePreviewNormal NormalFloat
highlight! link TelescopePromptNormal NormalFloat
highlight NullLsInfoBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoHeader guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoSources guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoTitle guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Number guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Float Number
highlight! link Keyword Number
highlight! link NvimNumber Number
highlight! link Type Number
highlight! link @markup.math Number
highlight! link @number Number
highlight NvimInternalError guifg=red guibg=red guisp=NONE blend=NONE gui=NONE
highlight! link NvimFigureBrace NvimInternalError
highlight! link NvimInvalidSingleQuotedUnknownEscape NvimInternalError
highlight! link NvimSingleQuotedUnknownEscape NvimInternalError
highlight NvimTreeRootFolder guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Pmenu guifg=#4B4039 guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight! link PmenuExtra Pmenu
highlight! link PmenuKind Pmenu
highlight PmenuSbar guifg=#D7D1C5 guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight PmenuSel guifg=#4B4039 guibg=#D7D1C5 guisp=NONE blend=NONE gui=bold
highlight! link PmenuExtraSel PmenuSel
highlight! link PmenuKindSel PmenuSel
highlight! link WildMenu PmenuSel
highlight PmenuThumb guifg=#D7D1C5 guibg=#D7D1C5 guisp=NONE blend=NONE gui=NONE
highlight PreProc guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link @keyword.directive PreProc
highlight Question guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiffviewStatusUntracked Question
highlight! link @property Question
highlight QuickFixLine guifg=NONE guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight Red guifg=#553327 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight RedrawDebugClear guifg=NONE guibg=yellow guisp=NONE blend=NONE gui=NONE
highlight RedrawDebugComposed guifg=NONE guibg=green guisp=NONE blend=NONE gui=NONE
highlight RedrawDebugNormal guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight RedrawDebugRecompose guifg=NONE guibg=red guisp=NONE blend=NONE gui=NONE
highlight! link @keyword Repeat
highlight! link @keyword.function Repeat
highlight! link @keyword.repeat Repeat
highlight! link @keyword.return Repeat
highlight! link @variable.builtin Repeat
highlight SignColumn guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Special guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link manOptionDesc Special
highlight! link @lsp.type.keyword.yaml.ansible Special
highlight! link @string.special.symbol Special
highlight SpecialComment guifg=#5B4D45 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @lsp.type.keyword.lua SpecialComment
highlight SpellBad guifg=NONE guibg=NONE guisp=#79241F blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineError SpellBad
highlight SpellCap guifg=NONE guibg=NONE guisp=#735057 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineHint SpellCap
highlight SpellLocal guifg=NONE guibg=NONE guisp=#523427 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineWarn SpellLocal
highlight SpellRare guifg=NONE guibg=NONE guisp=#535367 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineInfo SpellRare
highlight Statement guifg=#563E1A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Repeat Statement
highlight! link SpecialChar Statement
highlight! link helpCommand Statement
highlight! link helpExample Statement
highlight StatusLine guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link MsgArea StatusLine
highlight! link MsgSeparator StatusLine
highlight! link StatusLineTerm StatusLine
highlight StatusLineAlt guifg=#89766A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineBlue guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineGreen guifg=#454B39 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineMagenta guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineMode guifg=#EDEBE5 guibg=#352F2F guisp=NONE blend=NONE gui=bold
highlight StatusLineModeInv guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight StatusLineModified guifg=#EDEBE5 guibg=#79241F guisp=NONE blend=NONE gui=bold
highlight StatusLineModifiedInv guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight StatusLineNC guifg=#5B4D45 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link StatusLineTermNC StatusLineNC
highlight StatusLinePink guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineRed guifg=#553327 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineScrollbar guifg=#79241F guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight StatusLineYellow guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StorageClass guifg=#553327 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link Directory StorageClass
highlight! link Structure StorageClass
highlight! link @keyword.storage StorageClass
highlight String guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link AerialStringIcon String
highlight! link NvimString String
highlight! link @string String
highlight TSPlaygroundFocus guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TSPlaygroundLang guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TSQueryLinterError guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TabLine guifg=#78675C guibg=#D7D1C5 guisp=NONE blend=NONE gui=NONE
highlight TabLineFill guifg=NONE guibg=#D7D1C5 guisp=NONE blend=NONE gui=NONE
highlight TabLineSel guifg=#5B4D45 guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight TelescopeBufferLoaded guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeFrecencyScores guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMatching guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight TelescopeMultiIcon guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMultiSelection guifg=#F2F0ED guibg=NONE guisp=NONE blend=NONE gui=bold
highlight TelescopePathSeparator guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewBlock guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link TelescopePromptBorder TelescopePreviewBorder
highlight! link TelescopeResultsBorder TelescopePreviewBorder
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
highlight TelescopePreviewTitle guifg=#EDEBE5 guibg=#352F2F guisp=NONE blend=NONE gui=bold
highlight TelescopePreviewUser guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewWrite guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptCounter guifg=#5B4D45 guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptPrefix guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link TelescopeResultsDiffUntracked TelescopePromptPrefix
highlight TelescopePromptTitle guifg=#E6E2DA guibg=#79241F guisp=NONE blend=NONE gui=bold
highlight TelescopeQueryFilter guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
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
highlight TelescopeResultsTitle guifg=#E6E2DA guibg=#454B39 guisp=NONE blend=NONE gui=bold
highlight TelescopeResultsVariable guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeSelection guifg=#352F2F guibg=#E6E2DA guisp=NONE blend=NONE gui=bold
highlight TelescopeSelectionCaret guifg=#352F2F guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight TelescopeTitle guifg=#EDEBE5 guibg=#79241F guisp=NONE blend=NONE gui=bold
highlight TermCursor guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight Terminal guifg=#352F2F guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight Title guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link helpHeadline Title
highlight Underlined guifg=#523427 guibg=NONE guisp=#523427 blend=NONE gui=underline
highlight! link Tag Underlined
highlight! link helpHyperTextJump Underlined
highlight! link @markup.underline Underlined
highlight! link @string.special.uri Underlined
highlight VertSplit guifg=#EDEBE5 guibg=#F2F0ED guisp=NONE blend=NONE gui=NONE
highlight! link WinSeparator VertSplit
highlight Visual guifg=NONE guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight! link VisualNOS Visual
highlight VisualNonText guifg=#D7D1C5 guibg=#E6E2DA guisp=NONE blend=NONE gui=NONE
highlight Warning guifg=#523427 guibg=#E6D3A2 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticWarn Warning
highlight! link @comment.warning Warning
highlight WarningMsg guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Debug WarningMsg
highlight! link DiagnosticFloatingWarn WarningMsg
highlight! link DiagnosticVirtualLinesWarn WarningMsg
highlight! link DiagnosticVirtualTextWarn WarningMsg
highlight! link ModeMsg WarningMsg
highlight WinBar guifg=NONE guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight! link WinBarNC WinBar
highlight Yellow guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight manBold guifg=#4B4039 guibg=#EDEBE5 guisp=NONE blend=NONE gui=nocombine
highlight manHeader guifg=#735057 guibg=#EDEBE5 guisp=NONE blend=NONE gui=bold
highlight manSectionHeading guifg=#535367 guibg=#EDEBE5 guisp=NONE blend=NONE gui=bold
highlight manSubHeading guifg=#563E1A guibg=#EDEBE5 guisp=NONE blend=NONE gui=bold
highlight @character.printf guifg=#79241F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @comment.todo guifg=#735057 guibg=#DED1D9 guisp=NONE blend=NONE gui=NONE
highlight @error guifg=#7c4034 guibg=NONE guisp=#844D41 blend=NONE gui=undercurl
highlight @function.builtin guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @keyword.exception guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @label guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.heading guifg=#7c4034 guibg=NONE guisp=#844D41 blend=NONE gui=bold
highlight @markup.heading.1 guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.2 guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.3 guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.4 guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.5 guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.6 guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.italic guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @markup.link.label guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.link.markdown_inline guifg=#563E1A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.link.url guifg=#454B39 guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @markup.quote guifg=#5B4D45 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @markup.raw guifg=#4B4039 guibg=#EDEBE5 guisp=NONE blend=NONE gui=NONE
highlight @markup.raw.block guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.reference guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.strikethrough guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight @markup.strong guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level1 guifg=#352F2F guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level2 guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level3 guifg=#735057 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level4 guifg=#454B39 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level5 guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level6 guifg=#563E1A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.keyword.done guifg=#454B39 guibg=#CED7C8 guisp=NONE blend=NONE gui=NONE
highlight @org.keyword.todo guifg=#735057 guibg=#DED1D9 guisp=NONE blend=NONE gui=NONE
highlight @punctuation.special guifg=#78675C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @string.escape guifg=#535367 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.special.url guifg=#454B39 guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @string.yaml guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.member guifg=#4B4039 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.parameter guifg=#523427 guibg=NONE guisp=NONE blend=NONE gui=NONE
" PATCH END

lua << EOF
vim.g.terminal_color_0 = "#f1efeb"
vim.g.terminal_color_1 = "#553327"
vim.g.terminal_color_2 = "#454B39"
vim.g.terminal_color_3 = "#543227"
vim.g.terminal_color_4 = "#535367"
vim.g.terminal_color_5 = "#735057"
vim.g.terminal_color_6 = "#563E1A"
vim.g.terminal_color_7 = "#352e2e"
vim.g.terminal_color_8 = "#e5e1da"
vim.g.terminal_color_9 = "#553327"
vim.g.terminal_color_10 = "#454B39"
vim.g.terminal_color_11 = "#543227"
vim.g.terminal_color_12 = "#535367"
vim.g.terminal_color_13 = "#735057"
vim.g.terminal_color_14 = "#563E1A"
vim.g.terminal_color_15 = "#493f37"
EOF
