Class {
	#name : #LeParser,
	#superclass : #SmaCCGLRParser,
	#classVars : [
		'AnnotationParsers'
	],
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeParser class >> ambiguousTransitions [
^#(
#[ 0 6 0 13] 
#[ 0 6 0 10 0 17] 
#[ 0 6 0 21] 
#[ 0 6 0 25] 
#[ 0 6 0 29] 
#[ 0 6 0 33] 
#[ 0 6 0 37] 
#[ 0 6 0 41] 
#[ 0 6 0 45] 
#[ 0 6 0 49] 
#[ 0 6 0 14] 
#[ 0 6 0 53] 
#[ 0 6 0 57] 
#[ 0 6 0 61] 
#[ 0 6 0 65] 
#[ 0 6 0 69] 
#[ 0 6 0 73] 
#[ 0 6 0 77] 
#[ 0 6 0 81] 
#[ 0 6 0 85] 
#[ 0 6 0 89] 
#[ 0 6 0 93] 
#[ 0 6 0 18] 
#[ 0 6 0 97] 
#[ 0 10 0 17] 
#[ 0 26 0 30] 
#[ 0 70 0 229] 
#[ 0 10 0 17 0 70] 
#[ 0 70 0 233] 
#[ 0 25 0 70] 
#[ 0 29 0 70] 
#[ 0 33 0 70] 
#[ 0 37 0 70] 
#[ 0 41 0 70] 
#[ 0 45 0 70] 
#[ 0 49 0 70] 
#[ 0 14 0 70] 
#[ 0 53 0 70] 
#[ 0 57 0 70] 
#[ 0 61 0 70] 
#[ 0 70 1 5] 
#[ 0 69 0 70] 
#[ 0 70 0 77] 
#[ 0 70 0 81] 
#[ 0 70 0 85] 
#[ 0 70 0 89] 
#[ 0 70 0 93] 
#[ 0 130 1 53] 
#[ 0 6 1 217] 
#[ 0 6 0 166] 
#[ 0 6 1 221] 
#[ 0 170 1 221] 
#[ 0 6 0 229] 
#[ 0 6 1 65] 
#[ 0 6 0 194] 
#[ 0 6 2 33] 
#[ 0 6 1 6] 
#[ 1 10 1 65] 
#[ 0 70 1 81] 
#[ 0 70 1 85] 
#[ 0 70 1 89] 
#[ 0 70 1 93] 
#[ 0 70 1 97] 
#[ 0 70 1 101] 
#[ 0 70 1 105] 
#[ 0 70 1 109] 
#[ 0 70 2 97] 
#[ 0 70 2 101] 
#[ 0 70 1 125] 
#[ 0 70 1 129] 
#[ 0 70 1 133] 
#[ 0 70 1 137] 
#[ 0 70 1 141] 
#[ 0 70 1 145] 
#[ 0 70 1 149] 
#[ 0 70 1 153] 
#[ 1 50 1 54] 
#[ 1 194 2 161] 
#[ 1 226 2 173] 
#[ 1 230 2 185] 
#[ 0 6 2 6] 
#[ 2 22 3 21] 
#[ 2 50 3 49] 
#[ 2 62 3 61] 
#[ 2 74 3 77] 
#[ 2 130 3 133] 
#[ 2 142 3 117]
	).
]

{ #category : #parsing }
LeParser class >> annotationParsers [
	^ AnnotationParsers
		ifNil: [ AnnotationParsers := self initialAnnotationParsers ]
]

{ #category : #'generated-accessing' }
LeParser class >> cacheId [
	^'2026-11-02T23:15:21.196826+01:00'
]

{ #category : #generated }
LeParser class >> definitionComment [
"%glr;

%root Content;
%prefix Le;
%suffix Node;
%hierarchy Link ( EmptyLink DefinedLink );
%hierarchy EmptyLink ( EmptyDoubleBracketLink );
%hierarchy DefinedLink ( PageLink BlockLink );
%hierarchy PageLink ( DoubleBracketLink KeywordLink );
%hierarchy ExternalLink ( ExternalLabelUrlLink ExternalUrlLink ExternalImageLink);

%excludes annotation linkText;
%start Table;
%hierarchy TableCell (TableDelimiterCell);

annotation <annotationName>
	: <isLetter> (<isLetter> | \d)*
	;
annotation <whitespace>
	: \s+
	;
<text>
	: ([^\[\]\(\) \f\v\t\r\n\x85\#\:\<\>\!\{\}\*`\|\\] | \\ [^\r\n] | [ \f\v\t])+
	;
<leftDoubleBracket>
	: \[\[
	;
<hash>
	: \#
	;
<rightDoubleBracket>
	: \]\]
	;
<doubleRightParenthesis>
	: \)\)
	;
<doubleLeftParenthesis>
	: \(\(
	;
<doubleColon>
	: \:\:
	;
<rightBracket>
	: \]
	;
<urlCharacterWithoutParen>
	: <isLetter>
	| <isDigit>
	| [\-\._\~\:\/\?\#\[\]\@\!\$\&\'\*\+\,\;\%\=]
	| \ 
	;
<url>
	: \< (<urlCharacterWithoutParen> | \( | \))+ \>
	;
<exclamationMark>
	: \!
	;
<labelUrl>
	: \[ [^\[\]]* \]\( (<urlCharacterWithoutParen> | (\( <urlCharacterWithoutParen>* \)))* \)
	;
<imageUrl>
	: <exclamationMark> <labelUrl>
	;
default annotation <colon>
	: \:
	;
<doubleLeftBrace>
	: \{\{
	;
<doubleRightBrace>
	: \}\}
	;
<leftBrace>
	: \{
	;
<rightBrace>
	: \}
	;
<eol>
	: (\r\n? | \n | \x85)
	;
<star>
	: \*
	;
linkText <linkText>
	: ([^\[\]] | (\[ [^\[\]]) | (\] [^\]]))+
	;
<inlineCode>
	: ` [^`\r\n]+ `
	| `` ([^`\r\n] | ` [^`\r\n])+ ``
	;
<blockCode>
	: ```
	;
<backquote>
	: `
	;
<leftParen>
	: \(
	;
<rightParen>
	: \)
	;
<leftBracket>
	: \[
	;
<gt>
	: \>
	;
<lt>
	: \<
	;
<tablePipe>
	: [[self tableAtLineStart not]] \| [[self tableAtLineEnd not]]
	;
<tableLeftPipe>
	: [[self tableAtLineStart]] \|
	;
<tableRightPipe>
	: [[self tableAtLineStart not]] \| [[self tableAtLineEnd]]
	;
<tableEndEol>
	: <eol> [[self tableRowFollows not]]
	;
<tableLeftAlignment>
	: [[self tableSeparatorMatchesHeader]] [ \t]* \: \-+ [ \t]*
	;
<tableCenterAlignment>
	: [[self tableSeparatorMatchesHeader]] [ \t]* \: \-+ \: [ \t]*
	;
<tableRightAlignment>
	: [[self tableSeparatorMatchesHeader]] [ \t]* \-+ \: [ \t]*
	;
<tableDefaultAlignment>
	: [[self tableSeparatorMatchesHeader]] [ \t]* \-+ [ \t]*
	;

String
	: KeywordLink 'part'? Lines EOLs? {{String}}
	| KeywordLink 'part' EOLs? {{String}}
	;
# Prefer continuation of a table to ending it and parsing following rows as text.
TableRows
	: TableRows <eol> 'eol' TableRow 'row'
	| <eol> 'eol' TableRow 'row'
	;
Table
	: TableRow 'header' <eol> 'headerEol' TableSeparator 'separator' TableRows {{Table}}
	| TableRow 'header' <eol> 'headerEol' TableSeparator 'separator' {{Table}}
	;
TableRow
	: <tableLeftPipe> 'leftPipe' TableCells <tableRightPipe> 'rightPipe' {{TableRow}}
	| <tableLeftPipe> 'leftPipe' TableCells {{TableRow}}
	| TableCells <tableRightPipe> 'rightPipe' {{TableRow}}
	| TableCell 'cell' <tablePipe> 'pipe' TableCell 'cell' (<tablePipe> 'pipe' TableCell 'cell')* {{TableRow}}
	;
TableCells
	: TableCell 'cell' (<tablePipe> 'pipe' TableCell 'cell')*
	;
TableSeparator
	: <tableLeftPipe> 'leftPipe' TableDelimiterCells <tableRightPipe> 'rightPipe' {{TableSeparator}}
	| <tableLeftPipe> 'leftPipe' TableDelimiterCells {{TableSeparator}}
	| TableDelimiterCells <tableRightPipe> 'rightPipe' {{TableSeparator}}
	| TableDelimiterCell 'cell' <tablePipe> 'pipe' TableDelimiterCell 'cell' (<tablePipe> 'pipe' TableDelimiterCell 'cell')* {{TableSeparator}}
	;
TableDelimiterCells
	: TableDelimiterCell 'cell' (<tablePipe> 'pipe' TableDelimiterCell 'cell')*
	;
TableDelimiterCell
	: <tableLeftAlignment> 'leftAlignment' {{TableDelimiterCell}}
	| <tableCenterAlignment> 'centerAlignment' {{TableDelimiterCell}}
	| <tableRightAlignment> 'rightAlignment' {{TableDelimiterCell}}
	| <tableDefaultAlignment> 'defaultAlignment' {{TableDelimiterCell}}
	;
CellBold
	: <star> 'leftStar' <star> 'leftStar' CellBoldInner 'part'+ <star> 'rightStar' <star> 'rightStar' {{Bold}}
	;
CellItalic
	: <star> 'leftStar' CellItalicInner 'part'+ <star> 'rightStar' {{Italic}}
	;
CellBoldInner
	: CellInner
	| CellItalicWithoutBold
	;
CellItalicWithoutBold
	: <star> 'leftStar' CellInner 'part'+ <star> 'rightStar' {{Italic}}
	;
CellItalicInner
	: CellInner
	| CellBoldWithoutItalic
	;
CellBoldWithoutItalic
	: <star> 'leftStar' <star> 'leftStar' CellInner 'part'+ <star> 'rightStar' <star> 'rightStar' {{Bold}}
	;
CellPart
	: CellBold
	| CellItalic
	| CellInner
	| <backquote> 'text' {{Text}}
	;
CellInner
	: CellText
	| DoubleBracketLink
	| ExternalLink
	| EmptyDoubleBracketLink
	| BlockLink
	| DocumenterAnnotation
	| <inlineCode> 'code' {{InlineCode}}
	;
CellText
	: <text> 'text' {{Text}}
	| CellSpecial 'text' {{Text}}
	;
CellSpecial
	: <exclamationMark>
	| <colon>
	| <leftBrace>
	| <rightBrace>
	| <doubleRightBrace>
	| <hash>
	| <leftParen>
	| <rightParen>
	| <leftBracket>
	| <rightBracket>
	| <lt>
	| <gt>
	;
TableCell
	: CellPart 'part'+ {{TableCell}}
	| {{TableCell}}
	;
Lines
	: Lines EOLs Table 'part' TableFollowing
	| Table 'part' TableFollowing
	| Lines EOLs Line
	| Line
	;
EOLs
	: EOL 'part'+
	;
EOL
	: <eol> 'text' {{Text}}
	;
Line
	: Header 'part'
	| NonHeaderLine
	;
NonHeaderLine
	: LineParts
	;
LineParts
	: PartsWithoutStars (Stars PartsWithoutStars)?
	| Stars PartsWithoutStars
	;
PartsWithoutStars
	:
	| PartsWithoutStars StringPart 'part'
	;
Header
	: <hash> 'numberSign'+ LineParts {{Header}}
	| <hash> 'numberSign'+ {{Header}}
	;
StringPart
	: InnerStringPart
	| Bold
	| Italic
	| Code
	| <backquote> 'text' {{Text}}
	;
Code
	: <inlineCode> 'code' {{InlineCode}}
	| CodeBlockLanguage 'language' CodeBlockSource 'code' <blockCode> 'begin' <blockCode> 'end' {{CodeBlock}}
	;
CodeBlockSource
	: [self parseCodeBlockSource]
	;
CodeBlockLanguage
	: [self parseCodeBlockLanguage]
	;
InnerStringPart
	: NonHashStringPart
	;
NonHashStringPart
	: Text
	| DoubleBracketLink
	| ExternalLink
	| EmptyDoubleBracketLink
	| BlockLink
	| DocumenterAnnotation
	| <inlineCode> 'code' {{InlineCode}}
	;
Bold
	: <star> 'leftStar' <star> 'leftStar' InnerBoldStringParts <star> 'rightStar' <star> 'rightStar' {{Bold}}
	;
InnerBoldStringParts
	: InnerBoldStringPart 'part'+ (Star 'part' InnerBoldStringPart 'part'+)?
	;
InnerBoldStringPart
	: InnerStringPart
	| ItalicWithoutBold
	;
ItalicWithoutBold
	: <star> 'leftStar' InnerStringPart 'part'+ <star> 'rightStar' {{Italic}}
	;
Italic
	: <star> 'leftStar' InnerItalicStringPart 'part'+ <star> 'rightStar' {{Italic}}
	;
InnerItalicStringPart
	: InnerStringPart
	| BoldWithoutItalic
	;
BoldWithoutItalic
	: <star> 'leftStar' <star> 'leftStar' InnerStringPart 'part'+ <star> 'rightStar' <star> 'rightStar' {{Bold}}
	;
Stars
	: Star 'part'
	| Star 'part' Stars
	;
Star
	: <star> 'text' {{Text}}
	;
DocumenterAnnotation
	: SwitchToAnnotation <doubleLeftBrace> 'left' SwitchToDefault <annotationName> 'name' ParseAnnotation 'annotation' <colon> 'colon' <doubleRightBrace> 'right' {{DocumenterAnnotation}}
	;
SwitchToAnnotation
	: [self scope: #annotation. nil]
	;
SwitchToDefault
	: [self scope: #default. nil]
	;
ParseAnnotation
	: [self parseAnnotation]
	;
ExternalLink
	: ExternalLabelUrlLink
	| ExternalUrlLink
	| ExternalImageLink
	;
ExternalUrlLink
	: <url> 'link' {{}}
	;
ExternalImageLink
	: <imageUrl> 'link' {{}}
	;
ExternalLabelUrlLink
	: <labelUrl> 'link' {{}}
	;
KeywordLink
	: <text> 'link' <doubleColon> 'colon' {{KeywordLink}}
	;
BlockLink
	: <doubleLeftParenthesis> 'left' <text> 'link' <doubleRightParenthesis> 'right' {{BlockLink}}
	;
EmptyDoubleBracketLink
	: <leftDoubleBracket> 'left' <rightDoubleBracket> 'right' {{EmptyDoubleBracketLink}}
	| <leftDoubleBracket> 'left' <rightBracket> 'right' {{EmptyDoubleBracketLink}}
	;
DoubleBracketLink
	: SwitchToLinkText <leftDoubleBracket> 'left' SwitchToDefault <linkText> 'link' <rightDoubleBracket> 'right' {{DoubleBracketLink}}
	;
SwitchToLinkText
	: [self scope: #linkText. nil]
	;
Text
	: <text> 'text' {{Text}}
	| SpecialTextCharacters 'text' {{Text}}
	;
SpecialTextCharacters
	: <exclamationMark>
	| <colon>
	| <leftBrace>
	| <rightBrace>
	| <doubleRightBrace>
	| <hash>
	| <leftParen>
	| <rightParen>
	| <leftBracket>
	| <rightBracket>
	| <lt>
	| <gt>
	| <tablePipe>
	| <tableLeftPipe>
	| <tableRightPipe>
	;
TableFollowing
	: TableEndEOL 'part' Line
	|
	;
TableEndEOL
	: <tableEndEol> 'text' {{Text}}
	;"
]

{ #category : #parsing }
LeParser class >> initialAnnotationParsers [
	| parsers |
	parsers := Dictionary new.
	parsers
		at: 'gtClass'
		put: [ :parser | 
			parser
				spawnParser: LeAnnotationParser
				startingAt: LeAnnotationParser startingStateForClassAnnotation ].
	parsers
		at: 'gtPackage'
		put: [ :parser | 
			parser
				spawnParser: LeAnnotationParser
				startingAt: LeAnnotationParser startingStateForPackageAnnotation ].
	parsers
		at: 'gtMethod'
		put: [ :parser | 
			parser
				spawnParser: LeAnnotationParser
				startingAt: LeAnnotationParser startingStateForMethodAnnotation ].
	parsers
		at: 'gtChanges'
		put: [ :parser | 
			parser
				spawnParser: LeAnnotationParser
				startingAt: LeAnnotationParser startingStateForChangesAnnotation ].
	parsers
		at: 'gtExample'
		put: [ :parser | 
			parser
				spawnParser: LeAnnotationParser
				startingAt: LeAnnotationParser startingStateForExampleAnnotation ].
	parsers
		at: 'gtPage'
		put: [ :parser | 
			parser
				spawnParser: LeAnnotationParser
				startingAt: LeAnnotationParser startingStateForPageAnnotation ].
	parsers
		at: 'gtTodo'
		put: [ :parser | 
			parser
				spawnParser: LeAnnotationParser
				startingAt: LeAnnotationParser startingStateForTodoAnnotation ].
	^ parsers
]

{ #category : #'class initialization' }
LeParser class >> initialize [
	self maxParallelParses: 100
]

{ #category : #parsing }
LeParser class >> parseAnnotation: aString from: aParser [
	^ (self annotationParsers
		at: aString
		ifAbsent: [ [ :parser | 
			SmaCCErrorNode new
				errorToken: parser currentToken;
				dismissedTokens: #();
				stackContents: #();
				yourself ] ]) value: aParser
]

{ #category : #generated }
LeParser class >> reduceTable [
^#(
	#(74 0 #reduceActionForPartsWithoutStars1: 5378049 false) 
	#(107 0 #reduceActionForSwitchToLinkText1: 7983105 true) 
	#(96 0 #reduceActionForSwitchToAnnotation1: 7070721 true) 
	#(65 0 #reduceActionForTableCell2: 4980738 false) 
	#(63 1 #reduceActionForCellText1: 4713473 false) 
	#(64 1 #liftFirstValue: 4784134 false) 
	#(76 1 #reduceActionFor_hash___numberSign__1: 5452801 false) 
	#(64 1 #liftFirstValue: 4784138 false) 
	#(100 1 #reduceActionForExternalUrlLink1: 7307265 false) 
	#(64 1 #liftFirstValue: 4784129 false) 
	#(102 1 #reduceActionForExternalLabelUrlLink1: 7396353 false) 
	#(101 1 #reduceActionForExternalImageLink1: 7348225 false) 
	#(64 1 #liftFirstValue: 4784130 false) 
	#(64 1 #liftFirstValue: 4784133 false) 
	#(64 1 #liftFirstValue: 4784131 false) 
	#(64 1 #liftFirstValue: 4784132 false) 
	#(94 1 #reduceActionForCellText1: 6822913 false) 
	#(62 1 #reduceActionForCellInner7: 4546567 false) 
	#(61 1 #reduceActionForCellText1: 4462596 false) 
	#(64 1 #liftFirstValue: 4784135 false) 
	#(64 1 #liftFirstValue: 4784136 false) 
	#(64 1 #liftFirstValue: 4784137 false) 
	#(64 1 #liftFirstValue: 4784140 false) 
	#(64 1 #liftFirstValue: 4784139 false) 
	#(110 0 #reduceActionForPartsWithoutStars1: 8375298 false) 
	#(61 1 #liftFirstValue: 4462593 false) 
	#(61 1 #liftFirstValue: 4462594 false) 
	#(66 1 #reduceActionFor_hash___numberSign__1: 4994049 false) 
	#(61 1 #liftFirstValue: 4462595 false) 
	#(62 1 #liftFirstValue: 4546561 false) 
	#(63 1 #reduceActionForCellText1: 4713474 false) 
	#(45 0 #reduceActionFor__tablePipe___pipe__TableCell__cell___1: 2972673 false) 
	#(65 1 #reduceActionForTableCell1: 4980737 false) 
	#(40 1 #reduceActionForString1: 2267137 false) 
	#(67 1 #reduceActionForLines4: 5046276 false) 
	#(71 1 #reduceActionForLines4: 5214210 false) 
	#(72 1 #reduceActionForLines4: 5257217 false) 
	#(73 1 #reduceActionForLines4: 5287937 false) 
	#(80 0 #reduceActionForCodeBlockLanguage1: 5834753 true) 
	#(71 1 #reduceActionFor_hash___numberSign__1: 5214209 false) 
	#(75 1 #reduceActionForHeader2: 5442562 false) 
	#(93 1 #reduceActionFor_hash___numberSign__1: 6776833 false) 
	#(62 1 #liftFirstValue: 4546566 false) 
	#(62 1 #liftFirstValue: 4546563 false) 
	#(99 1 #liftFirstValue: 7225346 false) 
	#(99 1 #liftFirstValue: 7225347 false) 
	#(99 1 #liftFirstValue: 7225345 false) 
	#(40 1 #reduceActionForString5: 2267141 false) 
	#(62 1 #liftFirstValue: 4546565 false) 
	#(62 1 #liftFirstValue: 4546564 false) 
	#(62 1 #liftFirstValue: 4546562 false) 
	#(103 2 #reduceActionForKeywordLink1: 7447553 false) 
	#(105 2 #reduceActionForEmptyDoubleBracketLink1: 7629825 false) 
	#(105 2 #reduceActionForEmptyDoubleBracketLink1: 7629826 false) 
	#(55 1 #reduceActionFor_hash___numberSign__1: 4061185 false) 
	#(59 1 #liftFirstValue: 4272130 false) 
	#(59 1 #liftFirstValue: 4272129 false) 
	#(43 2 #reduceActionForTableRow2: 2708482 false) 
	#(111 1 #reduceActionForCellText1: 8424449 false) 
	#(67 2 #reduceActionForLines2: 5046274 false) 
	#(43 2 #reduceActionForTableRow3: 2708483 false) 
	#(46 2 #reduceActionForTableCells1: 3028993 false) 
	#(66 2 #reduceActionForCellPart__part__2: 4994050 false) 
	#(70 1 #reduceActionForCellText1: 5181441 false) 
	#(40 2 #reduceActionForString2: 2267138 false) 
	#(68 1 #reduceActionForLines4: 5157889 false) 
	#(69 1 #reduceActionFor_hash___numberSign__1: 5166081 false) 
	#(108 1 #reduceActionForCellText1: 8036353 false) 
	#(109 1 #liftFirstValue: 8113158 false) 
	#(109 1 #liftFirstValue: 8113162 false) 
	#(109 1 #liftFirstValue: 8113153 false) 
	#(109 1 #liftFirstValue: 8113154 false) 
	#(109 1 #liftFirstValue: 8113157 false) 
	#(109 1 #liftFirstValue: 8113155 false) 
	#(109 1 #liftFirstValue: 8113156 false) 
	#(82 1 #reduceActionForCellInner7: 5931015 false) 
	#(78 1 #reduceActionForCellInner7: 5626881 false) 
	#(77 1 #reduceActionForCellText1: 5534725 false) 
	#(109 1 #liftFirstValue: 8113159 false) 
	#(109 1 #liftFirstValue: 8113160 false) 
	#(109 1 #liftFirstValue: 8113161 false) 
	#(109 1 #liftFirstValue: 8113164 false) 
	#(109 1 #liftFirstValue: 8113163 false) 
	#(109 1 #liftFirstValue: 8113165 false) 
	#(109 1 #liftFirstValue: 8113166 false) 
	#(109 1 #liftFirstValue: 8113167 false) 
	#(74 2 #reduceActionForCellPart__part__2: 5378050 false) 
	#(77 1 #liftFirstValue: 5534724 false) 
	#(79 0 #reduceActionForCodeBlockSource1: 5783553 true) 
	#(77 1 #liftFirstValue: 5534721 false) 
	#(81 1 #liftFirstValue: 5890049 false) 
	#(77 1 #liftFirstValue: 5534722 false) 
	#(77 1 #liftFirstValue: 5534723 false) 
	#(82 1 #liftFirstValue: 5931014 false) 
	#(82 1 #liftFirstValue: 5931011 false) 
	#(82 1 #liftFirstValue: 5931013 false) 
	#(82 1 #liftFirstValue: 5931012 false) 
	#(82 1 #liftFirstValue: 5931010 false) 
	#(82 1 #liftFirstValue: 5931009 false) 
	#(108 1 #reduceActionForCellText1: 8036354 false) 
	#(76 2 #reduceActionForCellPart__part__2: 5452802 false) 
	#(75 2 #reduceActionForHeader1: 5442561 false) 
	#(73 2 #reduceActionForLineParts3: 5287939 false) 
	#(93 2 #reduceActionForLines2: 6776834 false) 
	#(97 0 #reduceActionForSwitchToDefault1: 7128065 true) 
	#(40 2 #reduceActionForString3: 2267139 false) 
	#(40 2 #reduceActionForString3: 2267142 false) 
	#(104 3 #reduceActionForBlockLink1: 7519233 false) 
	#(53 1 #reduceActionFor_hash___numberSign__1: 3954689 false) 
	#(56 1 #liftFirstValue: 4119554 false) 
	#(56 1 #liftFirstValue: 4119553 false) 
	#(54 3 #reduceActionForCellItalic1: 4028417 false) 
	#(55 2 #reduceActionForCellPart__part__2: 4061186 false) 
	#(43 3 #reduceActionForTableRow1: 2708481 false) 
	#(110 2 #reduceActionForLines2: 8375297 false) 
	#(51 1 #reduceActionForTableDelimiterCell1: 3612673 false) 
	#(51 1 #reduceActionForTableDelimiterCell2: 3612674 false) 
	#(51 1 #reduceActionForTableDelimiterCell3: 3612675 false) 
	#(51 1 #reduceActionForTableDelimiterCell4: 3612676 false) 
	#(42 3 #reduceActionForTable2: 2533378 false) 
	#(49 0 #reduceActionFor__tablePipe___pipe__TableCell__cell___1: 3438593 false) 
	#(45 2 #reduceActionFor__tablePipe___pipe__TableCell__cell___2: 2972674 false) 
	#(67 3 #reduceActionForLines3: 5046275 false) 
	#(69 2 #reduceActionForCellPart__part__2: 5166082 false) 
	#(91 1 #liftFirstValue: 6576129 false) 
	#(90 1 #reduceActionFor_hash___numberSign__1: 6511617 false) 
	#(91 1 #liftFirstValue: 6576130 false) 
	#(73 3 #reduceActionForLines3: 5287938 false) 
	#(40 3 #reduceActionForString4: 2267140 false) 
	#(58 1 #reduceActionFor_hash___numberSign__1: 4219905 false) 
	#(53 2 #reduceActionForCellPart__part__2: 3954690 false) 
	#(47 2 #reduceActionForTableSeparator2: 3103746 false) 
	#(42 4 #reduceActionForTable1: 2533377 false) 
	#(47 2 #reduceActionForTableSeparator3: 3103747 false) 
	#(50 2 #reduceActionForTableCells1: 3510273 false) 
	#(43 4 #reduceActionForTableRow4: 2708484 false) 
	#(44 2 #reduceActionFor__tablePipe___pipe__TableCell__cell__1: 2972673 false) 
	#(67 4 #reduceActionForLines1: 5046273 false) 
	#(86 1 #liftFirstValue: 6320129 false) 
	#(84 1 #reduceActionForLines4: 6219777 false) 
	#(85 1 #reduceActionFor_hash___numberSign__1: 6244353 false) 
	#(86 1 #liftFirstValue: 6320130 false) 
	#(89 3 #reduceActionForCellItalic1: 6482945 false) 
	#(90 2 #reduceActionForCellPart__part__2: 6511618 false) 
	#(98 0 #reduceActionForParseAnnotation1: 7179265 true) 
	#(57 3 #reduceActionForCellItalic1: 4175873 false) 
	#(58 2 #reduceActionForCellPart__part__2: 4219906 false) 
	#(52 5 #reduceActionForCellBold1: 3905537 false) 
	#(47 3 #reduceActionForTableSeparator1: 3103745 false) 
	#(41 2 #reduceActionForTableRows2: 2448386 false) 
	#(49 2 #reduceActionFor__tablePipe___pipe__TableCell__cell___2: 3438594 false) 
	#(88 1 #reduceActionFor_hash___numberSign__1: 6424577 false) 
	#(85 2 #reduceActionForCellPart__part__2: 6244354 false) 
	#(78 4 #reduceActionForCode2: 5626882 false) 
	#(106 5 #reduceActionForDoubleBracketLink1: 7826433 false) 
	#(60 5 #reduceActionForCellBold1: 4330497 false) 
	#(41 3 #reduceActionForTableRows1: 2448385 false) 
	#(47 4 #reduceActionForTableSeparator4: 3103748 false) 
	#(48 2 #reduceActionFor__tablePipe___pipe__TableCell__cell__1: 3438593 false) 
	#(87 3 #reduceActionForCellItalic1: 6384641 false) 
	#(88 2 #reduceActionForCellPart__part__2: 6424578 false) 
	#(83 5 #reduceActionForCellBold1: 6102017 false) 
	#(84 3 #reduceActionForInnerBoldStringParts2: 6219778 false) 
	#(92 5 #reduceActionForCellBold1: 6642689 false) 
	#(95 7 #reduceActionForDocumenterAnnotation1: 6857729 false)
	).
]

{ #category : #'generated-accessing' }
LeParser class >> scannerClass [
	^LeScanner
]

{ #category : #generated }
LeParser class >> startingStateForString [
	^ 1
]

{ #category : #generated }
LeParser class >> startingStateForTable [
	^ 2
]

{ #category : #generated }
LeParser class >> symbolNames [
	^ #('<annotationName>' '<whitespace>' '<text>' '<leftDoubleBracket>' '<hash>' '<rightDoubleBracket>' '<doubleRightParenthesis>' '<doubleLeftParenthesis>' '<doubleColon>' '<rightBracket>' '<url>' '<exclamationMark>' '<labelUrl>' '<imageUrl>' '<colon>' '<doubleLeftBrace>' '<doubleRightBrace>' '<leftBrace>' '<rightBrace>' '<eol>' '<star>' '<linkText>' '<inlineCode>' '<blockCode>' '<backquote>' '<leftParen>' '<rightParen>' '<leftBracket>' '<gt>' '<lt>' '<tablePipe>' '<tableLeftPipe>' '<tableRightPipe>' '<tableEndEol>' '<tableLeftAlignment>' '<tableCenterAlignment>' '<tableRightAlignment>' '<tableDefaultAlignment>' 'B e g i n' 'String' 'TableRows' 'Table' 'TableRow' '(<tablePipe> ''pipe'' TableCell ''cell'')' '(<tablePipe> ''pipe'' TableCell ''cell'')*' 'TableCells' 'TableSeparator' '(<tablePipe> ''pipe'' TableDelimiterCell ''cell'')' '(<tablePipe> ''pipe'' TableDelimiterCell ''cell'')*' 'TableDelimiterCells' 'TableDelimiterCell' 'CellBold' 'CellBoldInner ''part''+' 'CellItalic' 'CellItalicInner ''part''+' 'CellBoldInner' 'CellItalicWithoutBold' 'CellInner ''part''+' 'CellItalicInner' 'CellBoldWithoutItalic' 'CellPart' 'CellInner' 'CellText' 'CellSpecial' 'TableCell' 'CellPart ''part''+' 'Lines' 'EOLs' 'EOL ''part''+' 'EOL' 'Line' 'NonHeaderLine' 'LineParts' 'PartsWithoutStars' 'Header' '<hash> ''numberSign''+' 'StringPart' 'Code' 'CodeBlockSource' 'CodeBlockLanguage' 'InnerStringPart' 'NonHashStringPart' 'Bold' 'InnerBoldStringParts' 'InnerBoldStringPart ''part''+' 'InnerBoldStringPart' 'ItalicWithoutBold' 'InnerStringPart ''part''+' 'Italic' 'InnerItalicStringPart ''part''+' 'InnerItalicStringPart' 'BoldWithoutItalic' 'Stars' 'Star' 'DocumenterAnnotation' 'SwitchToAnnotation' 'SwitchToDefault' 'ParseAnnotation' 'ExternalLink' 'ExternalUrlLink' 'ExternalImageLink' 'ExternalLabelUrlLink' 'KeywordLink' 'BlockLink' 'EmptyDoubleBracketLink' 'DoubleBracketLink' 'SwitchToLinkText' 'Text' 'SpecialTextCharacters' 'TableFollowing' 'TableEndEOL' 'E O F' 'error')
]

{ #category : #generated }
LeParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeStringNode #LeStringNode #OrderedCollection #LeTableNode #LeTableRowNode #OrderedCollection #OrderedCollection #OrderedCollection #LeTableSeparatorNode #OrderedCollection #OrderedCollection #OrderedCollection #LeTableDelimiterCellNode #LeBoldNode #OrderedCollection #LeItalicNode #OrderedCollection #LeContentNode #LeItalicNode #OrderedCollection #LeContentNode #LeBoldNode #LeContentNode #LeContentNode #LeTextNode #SmaCCToken #LeTableCellNode #OrderedCollection #OrderedCollection #OrderedCollection #OrderedCollection #LeTextNode #Object #OrderedCollection #OrderedCollection #OrderedCollection #LeHeaderNode #OrderedCollection #LeContentNode #LeContentNode #Object #Object #LeContentNode #LeContentNode #LeBoldNode #OrderedCollection #OrderedCollection #LeContentNode #LeItalicNode #OrderedCollection #LeItalicNode #OrderedCollection #LeContentNode #LeBoldNode #OrderedCollection #LeTextNode #LeDocumenterAnnotationNode nil nil #Object #LeExternalLinkNode #LeExternalUrlLinkNode #LeExternalImageLinkNode #LeExternalLabelUrlLinkNode #LeKeywordLinkNode #LeBlockLinkNode #LeEmptyDoubleBracketLinkNode #LeDoubleBracketLinkNode nil #LeTextNode #SmaCCToken #OrderedCollection #LeTextNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeParser class >> transitionTable [
^#(
#[1 0 7 0 3 0 11 0 4 0 15 0 5 0 19 0 8 0 23 0 10 0 27 0 11 0 31 0 12 0 35 0 13 0 39 0 14 0 43 0 15 0 47 0 16 0 51 0 17 0 55 0 18 0 59 0 19 0 6 0 20 0 63 0 21 0 67 0 23 0 6 0 24 0 71 0 25 0 75 0 26 0 79 0 27 0 83 0 28 0 87 0 29 0 91 0 30 0 95 0 31 0 99 0 32 0 95 0 33 0 101 0 40 0 105 0 42 0 109 0 43 0 113 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 0 141 0 65 0 145 0 66 0 149 0 67 0 153 0 71 0 157 0 72 0 161 0 73 0 165 0 74 0 169 0 75 0 173 0 76 0 177 0 93 0 181 0 94 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 209 0 103 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107 0 6 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 237 0 21 0 69 0 23 0 73 0 25 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 0 18 0 31 0 97 0 32 0 18 0 33 0 241 0 42 0 109 0 43 0 113 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 0 141 0 65 0 145 0 66 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107] 
#[1 0 22 0 3 0 22 0 4 0 22 0 5 0 22 0 8 0 245 0 9 0 22 0 10 0 22 0 11 0 22 0 12 0 22 0 13 0 22 0 14 0 22 0 15 0 22 0 16 0 22 0 17 0 22 0 18 0 22 0 19 0 22 0 21 0 22 0 23 0 22 0 25 0 22 0 26 0 22 0 27 0 22 0 28 0 22 0 29 0 22 0 30 0 22 0 31 0 22 0 33] 
#[1 0 249 0 6 0 253 0 10] 
#[1 0 107 0 3 0 107 0 4 0 107 0 5 0 107 0 8 0 107 0 10 0 107 0 11 0 107 0 12 0 107 0 13 0 107 0 14 0 107 0 15 0 107 0 16 0 107 0 17 0 107 0 18 0 107 0 19 0 30 0 20 0 107 0 21 0 107 0 23 0 30 0 24 0 107 0 25 0 107 0 26 0 107 0 27 0 107 0 28 0 107 0 29 0 107 0 30 0 107 0 31 0 30 0 32 0 107 0 33 0 30 0 112] 
#[0 1 1 0 3] 
#[0 0 34 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 38 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 0 42 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 46 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 0 50 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 0 54 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 58 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 62 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 66 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[1 0 111 0 3 0 115 0 4 0 119 0 5 0 123 0 8 0 127 0 10 0 131 0 11 0 135 0 12 0 139 0 13 0 143 0 14 0 147 0 15 0 151 0 16 0 155 0 17 0 159 0 18 0 163 0 19 0 70 0 20 0 167 0 21 0 171 0 23 0 70 0 24 0 70 0 25 0 175 0 26 0 179 0 27 0 183 0 28 0 187 0 29 0 191 0 30 0 70 0 31 0 70 0 32 0 70 0 33 1 9 0 55 1 13 0 59 1 13 0 60 1 13 0 62 1 13 0 63 0 137 0 64 1 13 0 95 0 189 0 96 1 13 0 99 1 13 0 100 1 13 0 101 1 13 0 102 1 13 0 104 1 13 0 105 1 13 0 106 0 225 0 107 0 70 0 112] 
#[0 0 74 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 78 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 82 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 86 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 90 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 94 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 98 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 18 0 20 0 237 0 21 0 69 0 23 0 73 0 25 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 0 18 0 31 0 18 0 33 0 18 0 34 1 25 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 1 29 0 65 0 145 0 66 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107 0 18 0 112] 
#[0 0 0 0 112] 
#[1 0 102 0 20 1 33 0 34 1 37 0 110 1 41 0 111 0 102 0 112] 
#[0 1 45 0 20] 
#[0 1 49 0 33] 
#[0 0 106 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 110 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 114 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 118 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 122 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 126 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[1 0 195 0 31 0 130 0 33 1 57 0 45] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 134 0 20 0 237 0 21 0 69 0 23 0 73 0 25 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 0 134 0 31 0 134 0 33 0 134 0 34 1 61 0 52 1 61 0 54 1 61 0 61 1 61 0 62 1 61 0 63 0 137 0 64 1 61 0 95 0 189 0 96 1 61 0 99 1 61 0 100 1 61 0 101 1 61 0 102 1 61 0 104 1 61 0 105 1 61 0 106 0 225 0 107 0 134 0 112] 
#[1 1 65 0 20 1 69 0 68 1 73 0 69 1 77 0 70 0 138 0 112] 
#[0 0 142 0 20 0 112] 
#[0 0 146 0 20 0 112] 
#[0 0 150 0 20 0 112] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 0 154 0 20 1 113 0 21 1 117 0 23 0 158 0 24 1 121 0 25 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 1 157 0 77 1 157 0 78 1 165 0 80 1 157 0 81 1 157 0 82 1 157 0 83 1 157 0 89 1 185 0 93 0 181 0 94 1 157 0 95 0 189 0 96 1 157 0 99 1 157 0 100 1 157 0 101 1 157 0 102 1 157 0 104 1 157 0 105 1 157 0 106 0 225 0 107 1 157 0 108 1 213 0 109 0 154 0 112] 
#[0 0 162 0 20 0 112] 
#[1 0 6 0 3 0 6 0 4 0 199 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 203 0 20 0 207 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 0 6 0 31 0 6 0 32 0 6 0 33 1 225 0 73 0 165 0 74 0 177 0 93 0 181 0 94 0 203 0 112] 
#[1 0 6 0 3 0 6 0 4 0 6 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 0 6 0 31 0 6 0 32 0 6 0 33 1 229 0 74 0 6 0 112] 
#[1 0 170 0 3 0 170 0 4 0 170 0 5 0 170 0 8 0 170 0 10 0 170 0 11 0 170 0 12 0 170 0 13 0 170 0 14 0 170 0 15 0 170 0 16 0 170 0 17 0 170 0 18 0 170 0 19 0 170 0 20 0 211 0 21 0 170 0 23 0 170 0 24 0 170 0 25 0 170 0 26 0 170 0 27 0 170 0 28 0 170 0 29 0 170 0 30 0 170 0 31 0 170 0 32 0 170 0 33 1 233 0 93 0 181 0 94 0 170 0 112] 
#[0 0 174 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 1 237 0 16] 
#[0 0 178 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 182 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 0 186 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 0 190 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[1 0 215 0 3 0 11 0 4 0 15 0 5 0 19 0 8 0 23 0 10 0 27 0 11 0 31 0 12 0 35 0 13 0 39 0 14 0 43 0 15 0 47 0 16 0 51 0 17 0 55 0 18 0 59 0 19 0 219 0 20 0 63 0 21 0 67 0 23 0 6 0 24 0 71 0 25 0 75 0 26 0 79 0 27 0 83 0 28 0 87 0 29 0 91 0 30 0 95 0 31 0 99 0 32 0 95 0 33 0 105 0 42 0 109 0 43 0 113 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 0 141 0 65 0 145 0 66 1 241 0 67 1 245 0 68 1 73 0 69 1 77 0 70 0 153 0 71 0 157 0 72 0 161 0 73 0 165 0 74 0 169 0 75 0 173 0 76 0 177 0 93 0 181 0 94 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107 0 223 0 112] 
#[0 0 198 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 202 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 206 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 1 249 0 4] 
#[0 0 22 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 0 26 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 1 5 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 1 9 0 55 1 13 0 59 1 13 0 60 1 13 0 62 1 13 0 63 0 137 0 64 1 13 0 95 0 189 0 96 1 13 0 99 1 13 0 100 1 13 0 101 1 13 0 102 1 13 0 104 1 13 0 105 1 13 0 106 0 225 0 107] 
#[0 0 0 0 112] 
#[0 0 210 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 0 214 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 0 218 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 1 253 0 7] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 2 1 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 2 5 0 53 2 9 0 56 2 9 0 57 2 9 0 62 2 9 0 63 0 137 0 64 2 9 0 95 0 189 0 96 2 9 0 99 2 9 0 100 2 9 0 101 2 9 0 102 2 9 0 104 2 9 0 105 2 9 0 106 0 225 0 107] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 2 21 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 2 25 0 59 2 25 0 60 2 25 0 62 2 25 0 63 0 137 0 64 2 25 0 95 0 189 0 96 2 25 0 99 2 25 0 100 2 25 0 101 2 25 0 102 2 25 0 104 2 25 0 105 2 25 0 106 0 225 0 107] 
#[0 0 222 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 0 226 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 0 230 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 0 234 0 20 2 29 0 33 0 234 0 34 0 234 0 112] 
#[1 0 130 0 20 0 130 0 31 0 130 0 33 0 130 0 34 1 57 0 45 0 130 0 112] 
#[0 0 238 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 0 242 0 20 0 112] 
#[1 0 6 0 3 0 6 0 4 0 227 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 207 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 0 6 0 31 0 6 0 32 0 6 0 33 2 37 0 71 0 157 0 72 0 161 0 73 0 165 0 74 0 169 0 75 0 173 0 76 0 177 0 93 0 181 0 94 0 6 0 112] 
#[1 2 41 0 32 2 45 0 35 2 49 0 36 2 53 0 37 2 57 0 38 2 61 0 47 2 65 0 50 2 69 0 51] 
#[0 0 246 0 20 0 34 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 18 0 20 0 237 0 21 0 69 0 23 0 73 0 25 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 0 18 0 31 0 18 0 34 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 2 73 0 65 0 145 0 66 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107 0 18 0 112] 
#[1 0 250 0 20 2 77 0 31 0 250 0 33 0 250 0 34 2 81 0 44 0 250 0 112] 
#[0 0 254 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[0 1 2 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[1 0 215 0 3 0 11 0 4 0 15 0 5 0 19 0 8 0 23 0 10 0 27 0 11 0 31 0 12 0 35 0 13 0 39 0 14 0 43 0 15 0 47 0 16 0 51 0 17 0 55 0 18 0 59 0 19 0 6 0 20 0 63 0 21 0 67 0 23 0 6 0 24 0 71 0 25 0 75 0 26 0 79 0 27 0 83 0 28 0 87 0 29 0 91 0 30 0 95 0 31 0 99 0 32 0 95 0 33 2 85 0 42 0 109 0 43 0 113 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 0 141 0 65 0 145 0 66 2 89 0 71 0 157 0 72 0 161 0 73 0 165 0 74 0 169 0 75 0 173 0 76 0 177 0 93 0 181 0 94 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107 0 231 0 112] 
#[1 1 10 0 3 1 10 0 4 1 10 0 5 1 10 0 8 1 10 0 10 1 10 0 11 1 10 0 12 1 10 0 13 1 10 0 14 1 10 0 15 1 10 0 16 1 10 0 17 1 10 0 18 1 10 0 19 0 235 0 20 1 10 0 21 1 10 0 23 1 10 0 24 1 10 0 25 1 10 0 26 1 10 0 27 1 10 0 28 1 10 0 29 1 10 0 30 1 10 0 31 1 10 0 32 1 10 0 33 2 93 0 70 1 10 0 112] 
#[0 1 14 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 18 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 22 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 26 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 30 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 34 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 38 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 42 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 46 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[1 0 239 0 3 0 115 0 4 0 243 0 5 0 123 0 8 0 247 0 10 0 131 0 11 0 251 0 12 0 139 0 13 0 143 0 14 0 255 0 15 0 151 0 16 1 3 0 17 1 7 0 18 1 11 0 19 0 70 0 20 1 15 0 21 1 19 0 23 0 70 0 24 0 70 0 25 1 23 0 26 1 27 0 27 1 31 0 28 1 35 0 29 1 39 0 30 1 43 0 31 1 47 0 32 1 51 0 33 2 113 0 81 2 113 0 82 2 109 0 90 2 113 0 91 2 113 0 92 2 113 0 95 0 189 0 96 2 113 0 99 2 113 0 100 2 113 0 101 2 113 0 102 2 113 0 104 2 113 0 105 2 113 0 106 0 225 0 107 2 113 0 108 1 213 0 109 0 70 0 112] 
#[0 1 55 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 58 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 62 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 66 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 70 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 74 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 78 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 82 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 86 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 90 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 94 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 98 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[1 1 102 0 24 2 121 0 79] 
#[0 1 106 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 110 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 114 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 118 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[1 0 6 0 3 0 6 0 4 0 6 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 0 6 0 31 0 6 0 32 0 6 0 33 2 125 0 74 0 6 0 112] 
#[0 1 122 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 126 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 130 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 134 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 138 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 142 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 146 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 150 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 0 70 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 154 0 20 0 112] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 1 158 0 20 2 129 0 21 1 117 0 23 0 158 0 24 1 121 0 25 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 1 157 0 77 1 157 0 78 1 165 0 80 1 157 0 81 1 157 0 82 1 157 0 83 1 157 0 89 1 157 0 95 0 189 0 96 1 157 0 99 1 157 0 100 1 157 0 101 1 157 0 102 1 157 0 104 1 157 0 105 1 157 0 106 0 225 0 107 1 157 0 108 1 213 0 109 1 158 0 112] 
#[0 1 162 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[1 1 166 0 1 2 133 0 97] 
#[1 1 65 0 20 2 137 0 68 1 73 0 69 1 77 0 70 1 170 0 112] 
#[0 1 174 0 112] 
#[1 1 166 0 22 2 141 0 97] 
#[0 1 178 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 2 145 0 58 2 149 0 62 2 149 0 63 0 137 0 64 2 149 0 95 0 189 0 96 2 149 0 99 2 149 0 100 2 149 0 101 2 149 0 102 2 149 0 104 2 149 0 105 2 149 0 106 0 225 0 107] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 2 153 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 2 157 0 56 2 157 0 57 2 157 0 62 2 157 0 63 0 137 0 64 2 157 0 95 0 189 0 96 2 157 0 99 2 157 0 100 2 157 0 101 2 157 0 102 2 157 0 104 2 157 0 105 2 157 0 106 0 225 0 107] 
#[0 1 182 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 186 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 190 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 1 194 0 3 1 194 0 4 1 194 0 5 1 194 0 8 1 194 0 10 1 194 0 11 1 194 0 12 1 194 0 13 1 194 0 14 1 194 0 15 1 194 0 16 1 194 0 17 1 194 0 18 1 194 0 19 1 194 0 20 1 59 0 21 1 194 0 23 1 194 0 25 1 194 0 26 1 194 0 27 1 194 0 28 1 194 0 29 1 194 0 30 1 194 0 31 1 194 0 33 1 194 0 34 1 194 0 112] 
#[0 1 198 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 202 0 20 0 34 0 112] 
#[0 0 30 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 1 206 0 20 0 112] 
#[1 2 45 0 35 2 49 0 36 2 53 0 37 2 57 0 38 2 165 0 50 2 169 0 51] 
#[0 1 210 0 20 0 31 0 33 0 34 0 112] 
#[0 1 214 0 20 0 31 0 33 0 34 0 112] 
#[0 1 218 0 20 0 31 0 33 0 34 0 112] 
#[0 1 222 0 20 0 31 0 33 0 34 0 112] 
#[1 1 63 0 20 1 226 0 34 2 177 0 41 1 226 0 112] 
#[0 2 181 0 33] 
#[1 1 67 0 31 1 230 0 33 2 189 0 49] 
#[1 0 130 0 20 0 130 0 31 0 130 0 34 2 193 0 45 0 130 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 18 0 20 0 237 0 21 0 69 0 23 0 73 0 25 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 0 18 0 31 0 18 0 33 0 18 0 34 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 2 197 0 65 0 145 0 66 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107 0 18 0 112] 
#[0 1 234 0 20 0 31 0 33 0 34 0 112] 
#[1 0 102 0 20 1 33 0 34 2 201 0 110 1 41 0 111 0 102 0 112] 
#[0 1 238 0 20 0 112] 
#[0 1 242 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 2 205 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 2 221 0 81 2 221 0 82 2 213 0 84 2 217 0 85 2 221 0 86 2 221 0 87 2 221 0 95 0 189 0 96 2 221 0 99 2 221 0 100 2 221 0 101 2 221 0 102 2 221 0 104 2 221 0 105 2 221 0 106 0 225 0 107 2 221 0 108 1 213 0 109] 
#[0 1 50 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 1 246 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 2 229 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 2 233 0 81 2 233 0 82 2 233 0 91 2 233 0 92 2 233 0 95 0 189 0 96 2 233 0 99 2 233 0 100 2 233 0 101 2 233 0 102 2 233 0 104 2 233 0 105 2 233 0 106 0 225 0 107 2 233 0 108 1 213 0 109] 
#[0 1 250 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 1 254 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 2 237 0 24] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 2 2 0 20 2 129 0 21 1 117 0 23 0 158 0 24 1 121 0 25 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 1 157 0 77 1 157 0 78 1 165 0 80 1 157 0 81 1 157 0 82 1 157 0 83 1 157 0 89 1 157 0 95 0 189 0 96 1 157 0 99 1 157 0 100 1 157 0 101 1 157 0 102 1 157 0 104 1 157 0 105 1 157 0 106 0 225 0 107 1 157 0 108 1 213 0 109 2 2 0 112] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 2 97 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 2 113 0 81 2 113 0 82 2 109 0 90 2 113 0 91 2 113 0 92 2 113 0 95 0 189 0 96 2 113 0 99 2 113 0 100 2 113 0 101 2 113 0 102 2 113 0 104 2 113 0 105 2 113 0 106 0 225 0 107 2 113 0 108 1 213 0 109] 
#[0 2 241 0 1] 
#[1 0 215 0 3 0 11 0 4 0 15 0 5 0 19 0 8 0 23 0 10 0 27 0 11 0 31 0 12 0 35 0 13 0 39 0 14 0 43 0 15 0 47 0 16 0 51 0 17 0 55 0 18 0 59 0 19 0 6 0 20 0 63 0 21 0 67 0 23 0 6 0 24 0 71 0 25 0 75 0 26 0 79 0 27 0 83 0 28 0 87 0 29 0 91 0 30 0 95 0 31 0 99 0 32 0 95 0 33 2 85 0 42 0 109 0 43 0 113 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 0 141 0 65 0 145 0 66 2 89 0 71 0 157 0 72 0 161 0 73 0 165 0 74 0 169 0 75 0 173 0 76 0 177 0 93 0 181 0 94 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107 1 71 0 112] 
#[0 2 245 0 22] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 2 249 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 2 253 0 62 2 253 0 63 0 137 0 64 2 253 0 95 0 189 0 96 2 253 0 99 2 253 0 100 2 253 0 101 2 253 0 102 2 253 0 104 2 253 0 105 2 253 0 106 0 225 0 107] 
#[0 2 10 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 3 1 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 3 5 0 58 2 149 0 62 2 149 0 63 0 137 0 64 2 149 0 95 0 189 0 96 2 149 0 99 2 149 0 100 2 149 0 101 2 149 0 102 2 149 0 104 2 149 0 105 2 149 0 106 0 225 0 107] 
#[0 2 14 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 3 9 0 58 2 149 0 62 2 149 0 63 0 137 0 64 2 149 0 95 0 189 0 96 2 149 0 99 2 149 0 100 2 149 0 101 2 149 0 102 2 149 0 104 2 149 0 105 2 149 0 106 0 225 0 107] 
#[1 2 18 0 20 3 13 0 33 2 18 0 34 2 18 0 112] 
#[1 1 230 0 20 1 230 0 31 1 230 0 33 1 230 0 34 2 189 0 49 1 230 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 237 0 21 0 69 0 23 0 73 0 25 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 0 18 0 31 0 97 0 32 0 18 0 33 3 17 0 43 0 113 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 0 141 0 65 0 145 0 66 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107] 
#[1 1 75 0 20 2 22 0 34 2 22 0 112] 
#[0 2 26 0 20 0 34 0 112] 
#[1 2 45 0 35 2 49 0 36 2 53 0 37 2 57 0 38 3 25 0 51] 
#[1 2 30 0 20 3 29 0 31 2 30 0 33 2 30 0 34 3 33 0 48 2 30 0 112] 
#[1 2 34 0 20 2 77 0 31 2 34 0 34 2 81 0 44 2 34 0 112] 
#[0 2 38 0 20 0 31 0 33 0 34 0 112] 
#[0 2 42 0 20 0 112] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 37 0 81 3 37 0 82 3 41 0 88 3 37 0 95 0 189 0 96 3 37 0 99 3 37 0 100 3 37 0 101 3 37 0 102 3 37 0 104 3 37 0 105 3 37 0 106 0 225 0 107 3 37 0 108 1 213 0 109] 
#[0 2 46 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 3 45 0 21] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 1 79 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 53 0 81 3 53 0 82 3 53 0 86 3 53 0 87 3 57 0 94 3 53 0 95 0 189 0 96 3 53 0 99 3 53 0 100 3 53 0 101 3 53 0 102 3 53 0 104 3 53 0 105 3 53 0 106 0 225 0 107 3 53 0 108 1 213 0 109] 
#[0 2 54 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 2 58 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[1 2 62 0 3 2 62 0 4 2 62 0 5 2 62 0 8 2 62 0 10 2 62 0 11 2 62 0 12 2 62 0 13 2 62 0 14 2 62 0 15 2 62 0 16 2 62 0 17 2 62 0 18 2 62 0 19 2 62 0 20 1 83 0 21 2 62 0 23 2 62 0 24 2 62 0 25 2 62 0 26 2 62 0 27 2 62 0 28 2 62 0 29 2 62 0 30 2 62 0 31 2 62 0 32 2 62 0 33 2 62 0 112] 
#[0 2 66 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 3 65 0 24] 
#[1 2 70 0 15 3 69 0 98] 
#[0 3 73 0 6] 
#[1 2 74 0 3 2 74 0 4 2 74 0 5 2 74 0 8 2 74 0 10 2 74 0 11 2 74 0 12 2 74 0 13 2 74 0 14 2 74 0 15 2 74 0 16 2 74 0 17 2 74 0 18 2 74 0 19 1 87 0 21 2 74 0 23 2 74 0 26 2 74 0 27 2 74 0 28 2 74 0 29 2 74 0 30] 
#[0 2 78 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 2 82 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 33 0 34 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 3 81 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 2 253 0 62 2 253 0 63 0 137 0 64 2 253 0 95 0 189 0 96 2 253 0 99 2 253 0 100 2 253 0 101 2 253 0 102 2 253 0 104 2 253 0 105 2 253 0 106 0 225 0 107] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 3 85 0 21 0 69 0 23 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 2 253 0 62 2 253 0 63 0 137 0 64 2 253 0 95 0 189 0 96 2 253 0 99 2 253 0 100 2 253 0 101 2 253 0 102 2 253 0 104 2 253 0 105 2 253 0 106 0 225 0 107] 
#[0 2 86 0 20 0 34 0 112] 
#[0 2 90 0 20 0 34 0 112] 
#[1 0 229 0 3 0 103 0 4 0 137 0 5 0 25 0 8 0 137 0 10 0 33 0 11 0 137 0 12 0 41 0 13 0 45 0 14 0 137 0 15 0 14 0 16 0 137 0 17 0 137 0 18 0 137 0 19 0 237 0 21 0 69 0 23 0 73 0 25 0 137 0 26 0 137 0 27 0 137 0 28 0 137 0 29 0 137 0 30 0 18 0 31 0 97 0 32 0 18 0 33 3 89 0 43 0 113 0 46 0 125 0 52 0 125 0 54 0 125 0 61 0 125 0 62 0 125 0 63 0 137 0 64 0 141 0 65 0 145 0 66 0 125 0 95 0 189 0 96 0 125 0 99 0 125 0 100 0 125 0 101 0 125 0 102 0 125 0 104 0 125 0 105 0 125 0 106 0 225 0 107] 
#[1 1 230 0 20 1 230 0 31 1 230 0 34 3 93 0 49 1 230 0 112] 
#[1 2 45 0 35 2 49 0 36 2 53 0 37 2 57 0 38 3 97 0 51] 
#[0 2 94 0 20 0 31 0 33 0 34 0 112] 
#[0 2 98 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 3 101 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 105 0 81 3 105 0 82 3 105 0 95 0 189 0 96 3 105 0 99 3 105 0 100 3 105 0 101 3 105 0 102 3 105 0 104 3 105 0 105 3 105 0 106 0 225 0 107 3 105 0 108 1 213 0 109] 
#[0 3 109 0 21] 
#[1 0 239 0 3 0 115 0 4 0 243 0 5 0 123 0 8 0 247 0 10 0 131 0 11 0 251 0 12 0 139 0 13 0 143 0 14 0 255 0 15 0 151 0 16 1 3 0 17 1 7 0 18 1 11 0 19 0 70 0 21 1 19 0 23 1 23 0 26 1 27 0 27 1 31 0 28 1 35 0 29 1 39 0 30 1 43 0 31 1 47 0 32 1 51 0 33 3 37 0 81 3 37 0 82 3 113 0 88 3 37 0 95 0 189 0 96 3 37 0 99 3 37 0 100 3 37 0 101 3 37 0 102 3 37 0 104 3 37 0 105 3 37 0 106 0 225 0 107 3 37 0 108 1 213 0 109] 
#[0 2 102 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 3 117 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 2 221 0 81 2 221 0 82 3 121 0 85 2 221 0 86 2 221 0 87 2 221 0 95 0 189 0 96 2 221 0 99 2 221 0 100 2 221 0 101 2 221 0 102 2 221 0 104 2 221 0 105 2 221 0 106 0 225 0 107 2 221 0 108 1 213 0 109] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 37 0 81 3 37 0 82 3 125 0 88 3 37 0 95 0 189 0 96 3 37 0 99 3 37 0 100 3 37 0 101 3 37 0 102 3 37 0 104 3 37 0 105 3 37 0 106 0 225 0 107 3 37 0 108 1 213 0 109] 
#[0 2 106 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[0 3 129 0 15] 
#[0 2 110 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112] 
#[0 2 114 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 2 74 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 3 77 0 21] 
#[0 2 118 0 20 0 34 0 112] 
#[1 2 122 0 20 3 29 0 31 2 122 0 34 3 33 0 48 2 122 0 112] 
#[0 2 126 0 20 0 31 0 33 0 34 0 112] 
#[1 2 130 0 3 2 130 0 4 2 130 0 5 2 130 0 8 2 130 0 10 2 130 0 11 2 130 0 12 2 130 0 13 2 130 0 14 2 130 0 15 2 130 0 16 2 130 0 17 2 130 0 18 2 130 0 19 1 91 0 21 2 130 0 23 2 130 0 26 2 130 0 27 2 130 0 28 2 130 0 29 2 130 0 30 2 130 0 31 2 130 0 32 2 130 0 33] 
#[0 2 134 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 2 138 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 112] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 3 137 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 105 0 81 3 105 0 82 3 105 0 95 0 189 0 96 3 105 0 99 3 105 0 100 3 105 0 101 3 105 0 102 3 105 0 104 3 105 0 105 3 105 0 106 0 225 0 107 3 105 0 108 1 213 0 109] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 37 0 81 3 37 0 82 3 113 0 88 3 37 0 95 0 189 0 96 3 37 0 99 3 37 0 100 3 37 0 101 3 37 0 102 3 37 0 104 3 37 0 105 3 37 0 106 0 225 0 107 3 37 0 108 1 213 0 109] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 1 95 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 53 0 81 3 53 0 82 3 53 0 86 3 53 0 87 3 53 0 95 0 189 0 96 3 53 0 99 3 53 0 100 3 53 0 101 3 53 0 102 3 53 0 104 3 53 0 105 3 53 0 106 0 225 0 107 3 53 0 108 1 213 0 109] 
#[1 1 81 0 3 0 103 0 4 1 213 0 5 0 25 0 8 1 213 0 10 0 33 0 11 1 213 0 12 0 41 0 13 0 45 0 14 1 213 0 15 0 14 0 16 1 213 0 17 1 213 0 18 1 213 0 19 3 141 0 21 2 101 0 23 1 213 0 26 1 213 0 27 1 213 0 28 1 213 0 29 1 213 0 30 1 213 0 31 1 213 0 32 1 213 0 33 3 105 0 81 3 105 0 82 3 105 0 95 0 189 0 96 3 105 0 99 3 105 0 100 3 105 0 101 3 105 0 102 3 105 0 104 3 105 0 105 3 105 0 106 0 225 0 107 3 105 0 108 1 213 0 109] 
#[0 3 145 0 17] 
#[0 2 146 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 2 130 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33] 
#[0 3 133 0 21] 
#[0 2 150 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 31 0 32 0 33 0 34 0 112]
	).
]

{ #category : #parsing }
LeParser >> handleEmbeddedError: aSmaCCParserError [
	| errorNode embeddedParser nodeClass visitorTrait |
	embeddedParser := aSmaCCParserError parser.
	nodeClass := SmaCCParseNode subclasses
			detect: [ :e | e parserClass = embeddedParser class ]
			ifNone: [  ].
	visitorTrait := nodeClass
			ifNil: [ TLeAnnotationParseNodeVisitor ]
			ifNotNil: [ nodeClass visitorTrait ].
	errorNode := SmaCCErrorNode new
			stackContents: aSmaCCParserError parser nodeStack copy;
			dismissedTokens: #();
			visitorTrait: visitorTrait.
	(aSmaCCParserError parser currentToken value beginsWith: '}')
		ifTrue: [ self position: aSmaCCParserError parser currentToken startPosition - 1.
			errorNode
				errorToken: (SmaCCToken
						value: ''
						start: aSmaCCParserError parser currentToken startPosition
						ids: #()) ]
		ifFalse: [ self position: aSmaCCParserError parser scanner position.
			errorNode errorToken: aSmaCCParserError parser currentToken ].
	^ errorNode
]

{ #category : #parsing }
LeParser >> parseAnnotation [
	| name node position stream |
	name := self nodeStack last value.
	node := self class parseAnnotation: name from: self.
	stream := scanner stream.
	position := stream position.
	stream skipSeparators.
	(stream peek = $})
		ifTrue: [ stream position: position.
			stream skipSeparators.
			self position: stream position ]
		ifFalse: [ node := self skipToEndAnnotationFor: node ].
	^ node
]

{ #category : #parsing }
LeParser >> parseCodeBlockLanguage [
	| stream char position outputStream |
	stream := scanner stream.
	[ stream atEnd not
		and: [ (char := stream peek) isSeparator and: [ char isLineBreak not ] ] ]
		whileTrue: [ stream next ].
	position := stream position.
	outputStream := WriteStream on: String new.
	[ stream atEnd not
		and: [ (char := stream peek) isLineBreak not and: [ char ~= $` ] ] ]
		whileTrue: [ outputStream nextPut: stream next ].
	^ outputStream position > 0
		ifTrue:
			[ SmaCCToken value: outputStream contents start: position + 1 ids: #() ]
]

{ #category : #parsing }
LeParser >> parseCodeBlockSource [
	| stream source position |
	stream := scanner stream.
	position := stream position.
	source := stream upToAll: '```'.
	self position: stream position - 3.
	^ SmaCCToken value: source start: position + 1 ids: #()
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForBlockLink1: nodes [
	| result |
	result := LeBlockLinkNode new.
	result left: (nodes at: 1).
	result link: (nodes at: 2).
	result right: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCellBold1: nodes [
	| result |
	result := LeBoldNode new.
	result addToken: (nodes at: 1) to: result leftStars.
	result addToken: (nodes at: 2) to: result leftStars.
	result addNodes: (nodes at: 3) to: result parts.
	result addToken: (nodes at: 4) to: result rightStars.
	result addToken: (nodes at: 5) to: result rightStars.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCellInner7: nodes [
	| result |
	result := LeInlineCodeNode new.
	result code: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCellItalic1: nodes [
	| result |
	result := LeItalicNode new.
	result leftStar: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result parts.
	result rightStar: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCellPart__part__2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCellText1: nodes [
	| result |
	result := LeTextNode new.
	result text: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCode2: nodes [
	| result |
	result := LeCodeBlockNode new.
	result language: (nodes at: 1).
	result code: (nodes at: 2).
	result begin: (nodes at: 3).
	result end: (nodes at: 4).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCodeBlockLanguage1: nodes [
	^ self parseCodeBlockLanguage
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForCodeBlockSource1: nodes [
	^ self parseCodeBlockSource
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForDocumenterAnnotation1: nodes [
	| result |
	result := LeDocumenterAnnotationNode new.
	result left: (nodes at: 2).
	result name: (nodes at: 4).
	result annotation: (nodes at: 5).
	result colon: (nodes at: 6).
	result right: (nodes at: 7).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForDoubleBracketLink1: nodes [
	| result |
	result := LeDoubleBracketLinkNode new.
	result left: (nodes at: 2).
	result link: (nodes at: 4).
	result right: (nodes at: 5).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForEmptyDoubleBracketLink1: nodes [
	| result |
	result := LeEmptyDoubleBracketLinkNode new.
	result left: (nodes at: 1).
	result right: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForExternalImageLink1: nodes [
	| result |
	result := LeExternalImageLinkNode new.
	result link: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForExternalLabelUrlLink1: nodes [
	| result |
	result := LeExternalLabelUrlLinkNode new.
	result link: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForExternalUrlLink1: nodes [
	| result |
	result := LeExternalUrlLinkNode new.
	result link: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForHeader1: nodes [
	| result |
	result := LeHeaderNode new.
	result addTokens: (nodes at: 1) to: result numberSigns.
	result addNodes: (nodes at: 2) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForHeader2: nodes [
	| result |
	result := LeHeaderNode new.
	result addTokens: (nodes at: 1) to: result numberSigns.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForInnerBoldStringParts2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	self addAll: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForKeywordLink1: nodes [
	| result |
	result := LeKeywordLinkNode new.
	result link: (nodes at: 1).
	result colon: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForLineParts3: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForLines1: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	self add: (nodes at: 3) to: result.
	self addAll: (nodes at: 4) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForLines2: nodes [
	| result |
	result := nodes at: 2.
	self addFirst: (nodes at: 1) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForLines3: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	self addAll: (nodes at: 3) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForLines4: nodes [
	| result |
	result := nodes at: 1.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForParseAnnotation1: nodes [
	^ self parseAnnotation
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForPartsWithoutStars1: nodes [
	| result |
	result := OrderedCollection new: 2.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForString1: nodes [
	| result |
	result := LeStringNode new.
	result addNodes: (nodes at: 1) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForString2: nodes [
	| result |
	result := LeStringNode new.
	result addNodes: (nodes at: 1) to: result parts.
	result addNodes: (nodes at: 2) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForString3: nodes [
	| result |
	result := LeStringNode new.
	result addNode: (nodes at: 1) to: result parts.
	result addNodes: (nodes at: 2) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForString4: nodes [
	| result |
	result := LeStringNode new.
	result addNode: (nodes at: 1) to: result parts.
	result addNodes: (nodes at: 2) to: result parts.
	result addNodes: (nodes at: 3) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForString5: nodes [
	| result |
	result := LeStringNode new.
	result addNode: (nodes at: 1) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForSwitchToAnnotation1: nodes [
	self scope: #annotation.
	^ nil
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForSwitchToDefault1: nodes [
	self scope: #default.
	^ nil
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForSwitchToLinkText1: nodes [
	self scope: #linkText.
	^ nil
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTable1: nodes [
	| result |
	result := LeTableNode new.
	result header: (nodes at: 1).
	result headerEol: (nodes at: 2).
	result separator: (nodes at: 3).
	result addTokens: ((nodes at: 4) at: 1) to: result eols.
	result addNodes: ((nodes at: 4) at: 2) to: result rows.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTable2: nodes [
	| result |
	result := LeTableNode new.
	result header: (nodes at: 1).
	result headerEol: (nodes at: 2).
	result separator: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableCell1: nodes [
	| result |
	result := LeTableCellNode new.
	result addNodes: (nodes at: 1) to: result parts.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableCell2: nodes [
	| result |
	result := LeTableCellNode new.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableCells1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	self addAll: ((nodes at: 2) at: 1) to: (result at: 2).
	self addAll: ((nodes at: 2) at: 2) to: (result at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableDelimiterCell1: nodes [
	| result |
	result := LeTableDelimiterCellNode new.
	result leftAlignment: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableDelimiterCell2: nodes [
	| result |
	result := LeTableDelimiterCellNode new.
	result centerAlignment: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableDelimiterCell3: nodes [
	| result |
	result := LeTableDelimiterCellNode new.
	result rightAlignment: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableDelimiterCell4: nodes [
	| result |
	result := LeTableDelimiterCellNode new.
	result defaultAlignment: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableRow1: nodes [
	| result |
	result := LeTableRowNode new.
	result leftPipe: (nodes at: 1).
	result addNodes: ((nodes at: 2) at: 1) to: result cells.
	result addTokens: ((nodes at: 2) at: 2) to: result pipes.
	result rightPipe: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableRow2: nodes [
	| result |
	result := LeTableRowNode new.
	result leftPipe: (nodes at: 1).
	result addNodes: ((nodes at: 2) at: 1) to: result cells.
	result addTokens: ((nodes at: 2) at: 2) to: result pipes.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableRow3: nodes [
	| result |
	result := LeTableRowNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result cells.
	result addTokens: ((nodes at: 1) at: 2) to: result pipes.
	result rightPipe: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableRow4: nodes [
	| result |
	result := LeTableRowNode new.
	result addNode: (nodes at: 1) to: result cells.
	result addToken: (nodes at: 2) to: result pipes.
	result addNode: (nodes at: 3) to: result cells.
	result addTokens: ((nodes at: 4) at: 1) to: result pipes.
	result addNodes: ((nodes at: 4) at: 2) to: result cells.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableRows1: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: (result at: 1).
	self add: (nodes at: 3) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableRows2: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	self add: (nodes at: 1) to: (result at: 1).
	self add: (nodes at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableSeparator1: nodes [
	| result |
	result := LeTableSeparatorNode new.
	result leftPipe: (nodes at: 1).
	result addNodes: ((nodes at: 2) at: 1) to: result cells.
	result addTokens: ((nodes at: 2) at: 2) to: result pipes.
	result rightPipe: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableSeparator2: nodes [
	| result |
	result := LeTableSeparatorNode new.
	result leftPipe: (nodes at: 1).
	result addNodes: ((nodes at: 2) at: 1) to: result cells.
	result addTokens: ((nodes at: 2) at: 2) to: result pipes.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableSeparator3: nodes [
	| result |
	result := LeTableSeparatorNode new.
	result addNodes: ((nodes at: 1) at: 1) to: result cells.
	result addTokens: ((nodes at: 1) at: 2) to: result pipes.
	result rightPipe: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForTableSeparator4: nodes [
	| result |
	result := LeTableSeparatorNode new.
	result addNode: (nodes at: 1) to: result cells.
	result addToken: (nodes at: 2) to: result pipes.
	result addNode: (nodes at: 3) to: result cells.
	result addTokens: ((nodes at: 4) at: 1) to: result pipes.
	result addNodes: ((nodes at: 4) at: 2) to: result cells.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionFor__tablePipe___pipe__TableCell__cell__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionFor__tablePipe___pipe__TableCell__cell___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionFor__tablePipe___pipe__TableCell__cell___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionFor_hash___numberSign__1: nodes [
	| result |
	result := OrderedCollection new: 2.
	self add: (nodes at: 1) to: result.
	^ result
]

{ #category : #parsing }
LeParser >> skipToEndAnnotationFor: aNode [
	| stream position max ch tokens output start |
	stream := scanner stream.
	position := stream position.
	max := 100.
	[ max > 0
		and: [ stream atEnd not
				and: [ ('{}' includes: (ch := stream next)) not and: [ ch isLineBreak not ] ] ] ]
		whileTrue: [ max := max - 1 ].
	stream position: position.
	ch = $}
		ifTrue: [ tokens := OrderedCollection new.
			[ stream peek = $} ]
				whileFalse: [ output := WriteStream on: String new.
					stream skipSeparators.
					start := stream position.
					[ (ch := stream next) isSeparator or: [ '}|=' includes: ch ] ]
						whileFalse: [ output nextPut: ch ].
					output contents
						ifNotEmpty: [ :str | 
							tokens
								add: (SmaCCToken
										value: str
										start: start + 1
										ids: #()) ].
					('|=' includes: ch)
						ifTrue: [ tokens
								add: (SmaCCToken
										value: (String with: ch)
										start: stream position
										ids: #()) ].
					ch = $} ifTrue: [ stream position: stream position - 1 ] ].
			self position: stream position.
			aNode isErrorNode
				ifTrue: [ aNode dismissedTokens: aNode dismissedTokens , tokens ]
				ifFalse: [ ^ SmaCCErrorNode new
						stackContents: {aNode};
						dismissedTokens: tokens;
						visitorTrait: aNode visitorTrait;
						errorToken: (SmaCCToken
								value: ''
								start: stream position + 1
								ids: #()) ] ].
	^ aNode
]

{ #category : #testing }
LeParser >> tryAllTokens [
	^ true
]
