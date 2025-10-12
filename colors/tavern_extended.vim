" PATCH BEGIN
let g:colors_name="tavern_extended"
set background=dark
highlight Normal guifg=#E4E2E2 guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight! link NvimSpacing Normal
highlight AerialLine guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight AerialNormal guifg=#A78B7E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialLineNC AerialNormal
highlight Blue guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialBooleanIcon Boolean
highlight! link AerialFunctionIcon Boolean
highlight! link AerialMethodIcon Boolean
highlight! link @boolean Boolean
highlight Character guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link SpecialKey Character
highlight! link @character Character
highlight CmpBorder guifg=#8A7267 guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight CmpDocumentation guifg=NONE guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight CmpDocumentationBorder guifg=#282523 guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbr guifg=#A78B7E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrDefault guifg=#A78B7E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrDeprecated guifg=#A78B7E guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight CmpItemAbbrDeprecatedDefault guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatch guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight CmpItemAbbrMatchDefault guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatchFuzzy guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemAbbrMatchFuzzyDefault guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemKind guifg=#282523 guibg=#C09579 guisp=NONE blend=NONE gui=NONE
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
highlight CmpItemKindDefault guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemKindFunction guifg=#282523 guibg=#B78481 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindConstructor CmpItemKindFunction
highlight! link CmpItemKindEnum CmpItemKindFunction
highlight! link CmpItemKindField CmpItemKindFunction
highlight! link CmpItemKindMethod CmpItemKindFunction
highlight! link CmpItemKindOperator CmpItemKindFunction
highlight! link CmpItemKindReference CmpItemKindFunction
highlight! link CmpItemKindTypeParameter CmpItemKindFunction
highlight! link CmpItemKindUnit CmpItemKindFunction
highlight CmpItemKindInterface guifg=#282523 guibg=#B78481 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindColor CmpItemKindInterface
highlight! link CmpItemKindEnumMember CmpItemKindInterface
highlight! link CmpItemKindFolder CmpItemKindInterface
highlight! link CmpItemKindKeyword CmpItemKindInterface
highlight! link CmpItemKindSnippet CmpItemKindInterface
highlight CmpItemKindProperty guifg=#282523 guibg=#9E9F8C guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindEvent CmpItemKindProperty
highlight! link CmpItemKindStruct CmpItemKindProperty
highlight CmpItemKindText guifg=#282523 guibg=#B6A0A9 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindConstant CmpItemKindText
highlight! link CmpItemKindModule CmpItemKindText
highlight CmpItemKindVariable guifg=#282523 guibg=#A1A6B1 guisp=NONE blend=NONE gui=NONE
highlight! link CmpItemKindClass CmpItemKindVariable
highlight! link CmpItemKindFile CmpItemKindVariable
highlight! link CmpItemKindValue CmpItemKindVariable
highlight CmpItemMenu guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpItemMenuDefault guifg=#A78B7E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CmpWindowScrollThumb guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight ColorColumn guifg=NONE guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight Comment guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link BlinkCmpGhostText Comment
highlight! link Operator Comment
highlight! link @comment Comment
highlight! link @lsp.type.comment Comment
highlight! link @org.agenda.deadline Conceal
highlight! link @punctuation.bracket Conceal
highlight Conditional guifg=#C09579 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link PreCondit Conditional
highlight! link Typedef Conditional
highlight! link @constant.builtin Conditional
highlight! link @keyword.conditional Conditional
highlight Constant guifg=#B78481 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialConstantIcon Constant
highlight! link Boolean Constant
highlight! link @constant Constant
highlight! link @lsp.type.enumMember Constant
highlight CurSearch guifg=NONE guibg=#2B3133 guisp=NONE blend=NONE gui=NONE
highlight CursorColumn guifg=NONE guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight CursorLine guifg=NONE guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight! link NeogitCursorLine CursorLine
highlight! link TreesitterContext CursorLine
highlight! link TreesitterContextLineNumber CursorLine
highlight CursorLineFold guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight CursorLineNr guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=bold
highlight CursorLineSign guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Cyan guifg=#C09579 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Define guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @constant.macro Define
highlight! link @define Define
highlight! link @type.definition Define
highlight Delimiter guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
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
highlight DiagnosticSignError guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignError DiagnosticSignError
highlight DiagnosticSignHint guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignHint DiagnosticSignHint
highlight DiagnosticSignInfo guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignInformation DiagnosticSignInfo
highlight DiagnosticSignOk guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiagnosticSignWarn guifg=#C09579 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link LspDiagnosticsSignWarning DiagnosticSignWarn
highlight DiagnosticUnderlineOk guifg=NONE guibg=NONE guisp=#9E9F8C blend=NONE gui=undercurl
highlight DiagnosticUnnecessary guifg=NONE guibg=NONE guisp=#C5A496 blend=NONE gui=underdotted
highlight DiffAdd guifg=NONE guibg=#2F312B guisp=NONE blend=NONE gui=NONE
highlight! link Added DiffAdd
highlight! link NeogitDiffAdd DiffAdd
highlight DiffChange guifg=NONE guibg=#382D36 guisp=NONE blend=NONE gui=NONE
highlight! link Changed DiffChange
highlight DiffDelete guifg=NONE guibg=#432A28 guisp=NONE blend=NONE gui=NONE
highlight! link Removed DiffDelete
highlight! link Todo DiffDelete
highlight DiffText guifg=NONE guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelCounter guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelDeletions guifg=#C5A3A4 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelInsertions guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewFilePanelRootPath guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiffviewFilePanelSelected guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiffviewFilePanelTitle guifg=#B78481 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight DiffviewStatusAdded guifg=#AAAD9E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusBroken guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusCopied guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusDeleted guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusModified guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusRenamed guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusTypeChange guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusUnknown guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight DiffviewStatusUnmerged guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link AerialNamespaceIcon Directory
highlight! link NeogitBranch Directory
highlight! link NvimTreeFolderIcon Directory
highlight! link @module Directory
highlight! link @org.agenda.scheduled Directory
highlight Error guifg=#F0644A guibg=#3C2D28 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticError Error
highlight! link NvimInvalid Error
highlight! link @comment.error Error
highlight ErrorMsg guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingError ErrorMsg
highlight! link DiagnosticVirtualLinesError ErrorMsg
highlight! link DiagnosticVirtualTextError ErrorMsg
highlight! link NvimInvalidSpacing ErrorMsg
highlight! link @function.macro ErrorMsg
highlight! link @number.float Float
highlight FloatBorder guifg=#282523 guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight! link BlinkCmpSignatureHelpBorder FloatBorder
highlight! link TelescopeBorder FloatBorder
highlight! link TelescopePreviewBorder FloatBorder
highlight FloatFooter guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=bold
highlight FloatShadow guifg=NONE guibg=black guisp=NONE blend=80 gui=NONE
highlight FloatShadowThrough guifg=NONE guibg=black guisp=NONE blend=100 gui=NONE
highlight FloatTitle guifg=#282523 guibg=#E4E2E2 guisp=NONE blend=NONE gui=bold
highlight FoldColumn guifg=#6E5A52 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Folded guifg=#6E5A52 guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight Function guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
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
highlight FzfLuaLivePrompt guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight FzfLuaTitleFlags guifg=#211F1D guibg=#B78481 guisp=NONE blend=NONE gui=bold
highlight GitSignsAdd guifg=#AAAD9E guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight GitSignsChange guifg=#C2A2B7 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight GitSignsDelete guifg=#C5A3A4 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Green guifg=#9E9F8C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Hint guifg=#B6A0A9 guibg=#372D3D guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticHint Hint
highlight! link @comment.hint Hint
highlight HintMsg guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingHint HintMsg
highlight! link DiagnosticVirtualLinesHint HintMsg
highlight! link DiagnosticVirtualTextHint HintMsg
highlight Identifier guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=NONE
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
highlight InclineNormal guifg=#211F1D guibg=#C09579 guisp=NONE blend=NONE gui=bold
highlight InclineNormalNC guifg=#A78B7E guibg=#282523 guisp=NONE blend=NONE gui=bold
highlight Include guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link @keyword.import Include
highlight Info guifg=#A1A6B1 guibg=#2B3133 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticInfo Info
highlight! link @comment.info Info
highlight! link @comment.note Info
highlight! link @comment.ok Info
highlight InfoMsg guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingInfo InfoMsg
highlight! link DiagnosticVirtualLinesInfo InfoMsg
highlight! link DiagnosticVirtualTextInfo InfoMsg
highlight! link helpOption Keyword
highlight Label guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link Exception Label
highlight! link helpHeader Label
highlight LineNr guifg=#6E5A52 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link GitSignsCurrentLineBlame LineNr
highlight LspCodeLens guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoFiletype guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoList guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoTip guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInfoTitle guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight LspInlayHint guifg=#8A7267 guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight LspSignatureActiveParameter guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Macro guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link @lsp.type.macro Macro
highlight! link @macro Macro
highlight Magenta guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonHeader guifg=#282523 guibg=#E4E2E2 guisp=NONE blend=NONE gui=bold
highlight MasonHeaderSecondary guifg=#282523 guibg=#C09579 guisp=NONE blend=NONE gui=bold
highlight MasonHighlight guifg=#C09579 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightBlock guifg=#282523 guibg=#A1A6B1 guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightBlockBold guifg=#282523 guibg=#A1A6B1 guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockBoldSecondary guifg=#282523 guibg=#D6C3BB guisp=NONE blend=NONE gui=bold
highlight MasonHighlightBlockSecondary guifg=#282523 guibg=#D6C3BB guisp=NONE blend=NONE gui=NONE
highlight MasonHighlightSecondary guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonMuted guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight MasonMutedBlock guifg=#D6C3BB guibg=#191715 guisp=NONE blend=NONE gui=NONE
highlight MasonMutedBlockBold guifg=#D6C3BB guibg=#191715 guisp=NONE blend=NONE gui=bold
highlight MoreMsg guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticFloatingOk MoreMsg
highlight! link DiagnosticVirtualLinesOk MoreMsg
highlight! link DiagnosticVirtualTextOk MoreMsg
highlight! link DiagnosticOk MsgArea
highlight NeogitBranchHead guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=bold,underline
highlight NeogitDiffContext guifg=NONE guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffContextCursor guifg=NONE guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffContextHighlight guifg=NONE guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight NeogitDiffHeader guifg=#211F1D guibg=#A1A6B1 guisp=NONE blend=NONE gui=bold
highlight NeogitHunkHeader guifg=#8A7267 guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight NeogitHunkHeaderCursor guifg=#F0644A guibg=#211F1D guisp=NONE blend=NONE gui=bold
highlight! link NeogitHunkHeaderHighlight NeogitHunkHeaderCursor
highlight NeogitPopupOptionDisabled guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link NeogitPopupActionDisabled NeogitPopupOptionDisabled
highlight! link NeogitPopupConfigDisabled NeogitPopupOptionDisabled
highlight! link NeogitPopupSwitchDisabled NeogitPopupOptionDisabled
highlight NeogitPopupOptionEnabled guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link NeogitPopupConfigEnabled NeogitPopupOptionEnabled
highlight! link NeogitPopupSwitchEnabled NeogitPopupOptionEnabled
highlight NeogitPopupOptionKey guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link NeogitPopupActionKey NeogitPopupOptionKey
highlight! link NeogitPopupConfigKey NeogitPopupOptionKey
highlight! link NeogitPopupSwitchKey NeogitPopupOptionKey
highlight NeogitSectionHeader guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=bold
highlight NonText guifg=#282523 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiffviewDiffDeleteDim NonText
highlight! link EndOfBuffer NonText
highlight! link Ignore NonText
highlight! link MiniIndentscopeSymbol NonText
highlight! link Whitespace NonText
highlight NormalFloat guifg=#D6C3BB guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight! link TelescopeNormal NormalFloat
highlight! link TelescopePreviewNormal NormalFloat
highlight! link TelescopePromptNormal NormalFloat
highlight NullLsInfoBorder guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoHeader guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoSources guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight NullLsInfoTitle guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight Number guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=NONE
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
highlight NvimTreeRootFolder guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight Pmenu guifg=#D6C3BB guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight! link PmenuExtra Pmenu
highlight! link PmenuKind Pmenu
highlight PmenuSbar guifg=#191715 guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight PmenuSel guifg=#D6C3BB guibg=#191715 guisp=NONE blend=NONE gui=bold
highlight! link PmenuExtraSel PmenuSel
highlight! link PmenuKindSel PmenuSel
highlight! link WildMenu PmenuSel
highlight PmenuThumb guifg=#191715 guibg=#191715 guisp=NONE blend=NONE gui=NONE
highlight PreProc guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link @keyword.directive PreProc
highlight Question guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link DiffviewStatusUntracked Question
highlight! link @property Question
highlight QuickFixLine guifg=NONE guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight Red guifg=#B78481 guibg=NONE guisp=NONE blend=NONE gui=NONE
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
highlight Special guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link manOptionDesc Special
highlight! link @lsp.type.keyword.yaml.ansible Special
highlight! link @string.special.symbol Special
highlight SpecialComment guifg=#C5A496 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link @lsp.type.keyword.lua SpecialComment
highlight SpellBad guifg=NONE guibg=NONE guisp=#F0644A blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineError SpellBad
highlight SpellCap guifg=NONE guibg=NONE guisp=#B6A0A9 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineHint SpellCap
highlight SpellLocal guifg=NONE guibg=NONE guisp=#B1877D blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineWarn SpellLocal
highlight SpellRare guifg=NONE guibg=NONE guisp=#A1A6B1 blend=NONE gui=undercurl
highlight! link DiagnosticUnderlineInfo SpellRare
highlight Statement guifg=#C09579 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Repeat Statement
highlight! link SpecialChar Statement
highlight! link helpCommand Statement
highlight! link helpExample Statement
highlight StatusLine guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link MsgArea StatusLine
highlight! link MsgSeparator StatusLine
highlight! link StatusLineTerm StatusLine
highlight StatusLineAlt guifg=#8A7267 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineBlue guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineGreen guifg=#9E9F8C guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineMagenta guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineMode guifg=#211F1D guibg=#E4E2E2 guisp=NONE blend=NONE gui=bold
highlight StatusLineModeInv guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight StatusLineModified guifg=#211F1D guibg=#F0644A guisp=NONE blend=NONE gui=bold
highlight StatusLineModifiedInv guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight StatusLineNC guifg=#C5A496 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link StatusLineTermNC StatusLineNC
highlight StatusLinePink guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineRed guifg=#B78481 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StatusLineScrollbar guifg=#F0644A guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight StatusLineYellow guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight StorageClass guifg=#B78481 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link Directory StorageClass
highlight! link Structure StorageClass
highlight! link @keyword.storage StorageClass
highlight String guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=italic
highlight! link AerialStringIcon String
highlight! link NvimString String
highlight! link @string String
highlight TSPlaygroundFocus guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TSPlaygroundLang guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TSQueryLinterError guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TabLine guifg=#A78B7E guibg=#191715 guisp=NONE blend=NONE gui=NONE
highlight TabLineFill guifg=NONE guibg=#191715 guisp=NONE blend=NONE gui=NONE
highlight TabLineSel guifg=#C5A496 guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight TelescopeBufferLoaded guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeFrecencyScores guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMatching guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight TelescopeMultiIcon guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeMultiSelection guifg=#1D1B19 guibg=NONE guisp=NONE blend=NONE gui=bold
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
highlight TelescopePreviewTitle guifg=#211F1D guibg=#E4E2E2 guisp=NONE blend=NONE gui=bold
highlight TelescopePreviewUser guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePreviewWrite guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptCounter guifg=#C5A496 guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight TelescopePromptPrefix guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link TelescopeResultsDiffUntracked TelescopePromptPrefix
highlight TelescopePromptTitle guifg=#282523 guibg=#F0644A guisp=NONE blend=NONE gui=bold
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
highlight TelescopeResultsTitle guifg=#282523 guibg=#9E9F8C guisp=NONE blend=NONE gui=bold
highlight TelescopeResultsVariable guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight TelescopeSelection guifg=#E4E2E2 guibg=#282523 guisp=NONE blend=NONE gui=bold
highlight TelescopeSelectionCaret guifg=#E4E2E2 guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight TelescopeTitle guifg=#211F1D guibg=#F0644A guisp=NONE blend=NONE gui=bold
highlight TermCursor guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=reverse
highlight Terminal guifg=#E4E2E2 guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight Title guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight! link helpHeadline Title
highlight Underlined guifg=#B1877D guibg=NONE guisp=#B1877D blend=NONE gui=underline
highlight! link Tag Underlined
highlight! link helpHyperTextJump Underlined
highlight! link @markup.underline Underlined
highlight! link @string.special.uri Underlined
highlight VertSplit guifg=#211F1D guibg=#1D1B19 guisp=NONE blend=NONE gui=NONE
highlight! link WinSeparator VertSplit
highlight Visual guifg=NONE guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight! link VisualNOS Visual
highlight VisualNonText guifg=#191715 guibg=#282523 guisp=NONE blend=NONE gui=NONE
highlight Warning guifg=#B1877D guibg=#362F28 guisp=NONE blend=NONE gui=NONE
highlight! link DiagnosticWarn Warning
highlight! link @comment.warning Warning
highlight WarningMsg guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight! link Debug WarningMsg
highlight! link DiagnosticFloatingWarn WarningMsg
highlight! link DiagnosticVirtualLinesWarn WarningMsg
highlight! link DiagnosticVirtualTextWarn WarningMsg
highlight! link ModeMsg WarningMsg
highlight WinBar guifg=NONE guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight! link WinBarNC WinBar
highlight Yellow guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight manBold guifg=#D6C3BB guibg=#211F1D guisp=NONE blend=NONE gui=nocombine
highlight manHeader guifg=#B6A0A9 guibg=#211F1D guisp=NONE blend=NONE gui=bold
highlight manSectionHeading guifg=#A1A6B1 guibg=#211F1D guisp=NONE blend=NONE gui=bold
highlight manSubHeading guifg=#C09579 guibg=#211F1D guisp=NONE blend=NONE gui=bold
highlight @character.printf guifg=#F0644A guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @comment.todo guifg=#B6A0A9 guibg=#382D36 guisp=NONE blend=NONE gui=NONE
highlight @error guifg=#7c4034 guibg=NONE guisp=#C5A3A4 blend=NONE gui=undercurl
highlight @function.builtin guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @keyword.exception guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @label guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.heading guifg=#7c4034 guibg=NONE guisp=#C5A3A4 blend=NONE gui=bold
highlight @markup.heading.1 guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.2 guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.3 guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.4 guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.5 guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.heading.6 guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @markup.italic guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @markup.link.label guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.link.markdown_inline guifg=#C09579 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.link.url guifg=#9E9F8C guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @markup.quote guifg=#C5A496 guibg=NONE guisp=NONE blend=NONE gui=italic
highlight @markup.raw guifg=#D6C3BB guibg=#211F1D guisp=NONE blend=NONE gui=NONE
highlight @markup.raw.block guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.reference guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @markup.strikethrough guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=strikethrough
highlight @markup.strong guifg=NONE guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level1 guifg=#E4E2E2 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level2 guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level3 guifg=#B6A0A9 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level4 guifg=#9E9F8C guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level5 guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.headline.level6 guifg=#C09579 guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @org.keyword.done guifg=#9E9F8C guibg=#2F312B guisp=NONE blend=NONE gui=NONE
highlight @org.keyword.todo guifg=#B6A0A9 guibg=#382D36 guisp=NONE blend=NONE gui=NONE
highlight @punctuation.special guifg=#A78B7E guibg=NONE guisp=NONE blend=NONE gui=bold
highlight @string.escape guifg=#A1A6B1 guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @string.special.url guifg=#9E9F8C guibg=NONE guisp=NONE blend=NONE gui=underline
highlight @string.yaml guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.member guifg=#D6C3BB guibg=NONE guisp=NONE blend=NONE gui=NONE
highlight @variable.parameter guifg=#B1877D guibg=NONE guisp=NONE blend=NONE gui=NONE
" PATCH END

lua << EOF
vim.g.terminal_color_0 = "#1C1B19"
vim.g.terminal_color_1 = "#B0877D"
vim.g.terminal_color_2 = "#9E9F8C"
vim.g.terminal_color_3 = "#B1877D"
vim.g.terminal_color_4 = "#A1A6B1"
vim.g.terminal_color_5 = "#B6A0A9"
vim.g.terminal_color_6 = "#C09579"
vim.g.terminal_color_7 = "#E4E2E2"
vim.g.terminal_color_8 = "#282523"
vim.g.terminal_color_9 = "#B0877D"
vim.g.terminal_color_10 = "#9E9F8C"
vim.g.terminal_color_11 = "#B1877D"
vim.g.terminal_color_12 = "#A1A6B1"
vim.g.terminal_color_13 = "#B6A0A9"
vim.g.terminal_color_14 = "#C09579"
vim.g.terminal_color_15 = "#D6C3BB"
EOF
