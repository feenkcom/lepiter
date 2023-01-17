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
#[ 0 6 0 9] 
#[ 0 6 0 13] 
#[ 0 6 0 17] 
#[ 0 34 0 89] 
#[ 0 6 0 249] 
#[ 0 6 0 54] 
#[ 0 17 0 58] 
#[ 0 6 0 69] 
#[ 0 6 0 62] 
#[ 0 6 0 74] 
#[ 0 69 0 78] 
#[ 0 14 0 85] 
#[ 0 14 0 34 0 89] 
#[ 0 14 0 93] 
#[ 0 14 0 97] 
#[ 0 14 0 101] 
#[ 0 14 0 105] 
#[ 0 14 0 109] 
#[ 0 14 0 113] 
#[ 0 14 0 117] 
#[ 0 14 0 121] 
#[ 0 14 0 38] 
#[ 0 14 0 125] 
#[ 0 14 0 129] 
#[ 0 14 0 133] 
#[ 0 14 1 37] 
#[ 0 14 1 41] 
#[ 0 14 0 149] 
#[ 0 14 0 153] 
#[ 0 14 0 157] 
#[ 0 14 0 161] 
#[ 0 14 0 165] 
#[ 0 130 0 134] 
#[ 0 6 1 34] 
#[ 1 46 1 145] 
#[ 1 58 1 157] 
#[ 1 82 1 213] 
#[ 1 94 1 189]
	).
]

{ #category : #parsing }
LeParser class >> annotationParsers [
	^ AnnotationParsers
		ifNil: [ AnnotationParsers := self initialAnnotationParsers ]
]

{ #category : #'generated-accessing' }
LeParser class >> cacheId [
	^'2023-01-17T10:06:30.398696-06:00'
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

annotation <annotationName>
	: <isLetter> (<isLetter> | \d)*
	;
annotation <whitespace>
	: \s+
	;

<text>
	: (<word> | [ \f\v\t])+ 
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
<word>
	: [^\[\]\(\)\s\#\:\<\>\!\{\}\*`]+
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
	| \ 	# space isn't a valid character but is included anyway
	;
<url>
	: \< (<urlCharacterWithoutParen> | \( | \))+ \>
	;
<exclamationMark>
	: \!
	;
<labelUrl>
	: \[ [^\[\]]* \]\( (<urlCharacterWithoutParen> |  (\( <urlCharacterWithoutParen>* \)) )* \)
	;
<imageUrl>
	: <exclamationMark> <labelUrl>
	;
default annotation <colon>
	:  \:
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
String
	: KeywordLink 'part' ? Lines EOLs? {{String}}
	| KeywordLink 'part' EOLs? {{String}}
	;
Lines
	: Line
	| Lines EOLs Line
	;
EOLs
	: EOL 'part' +
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
	: InnerBoldStringPart 'part' + (Star 'part' InnerBoldStringPart 'part'+)?	# What should ***** be?
	;
InnerBoldStringPart
	: InnerStringPart
	| ItalicWithoutBold
	;
ItalicWithoutBold
	: <star> 'leftStar' InnerStringPart 'part' + <star> 'rightStar' {{Italic}}
	;
Italic
	: <star> 'leftStar' InnerItalicStringPart 'part' + <star> 'rightStar' {{Italic}}
	;
InnerItalicStringPart
	: InnerStringPart
	| BoldWithoutItalic
	;
BoldWithoutItalic
	: <star> 'leftStar' <star> 'leftStar' InnerStringPart 'part' + <star> 'rightStar' <star> 'rightStar' {{Bold}}
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
	: <leftDoubleBracket> 'left' <rightDoubleBracket> 'right'  {{EmptyDoubleBracketLink}}
	| <leftDoubleBracket> 'left' <rightBracket> 'right' {{EmptyDoubleBracketLink}}
	;
DoubleBracketLink
	: SwitchToLinkText <leftDoubleBracket> 'left' SwitchToDefault <linkText> 'link' <rightDoubleBracket> 'right' {{DoubleBracketLink}}
	;
SwitchToLinkText
	: [self scope: #linkText. nil]
	;
Text
	: <text>'text' {{Text}}
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
	#(40 0 #reduceActionForPartsWithoutStars1: 1991681 false) 
	#(42 1 #reduceActionFor_hash___numberSign__1: 2067457 false) 
	#(61 1 #reduceActionForStar1: 3467265 false) 
	#(32 1 #reduceActionForString1: 1635329 false) 
	#(33 1 #reduceActionForLines1: 1733633 false) 
	#(37 1 #reduceActionForLines1: 1827842 false) 
	#(38 1 #reduceActionForLines1: 1870849 false) 
	#(74 0 #reduceActionForSwitchToLinkText1: 4628481 true) 
	#(63 0 #reduceActionForSwitchToAnnotation1: 3715073 true) 
	#(39 1 #reduceActionForLines1: 1901569 false) 
	#(46 0 #reduceActionForCodeBlockLanguage1: 2449409 true) 
	#(37 1 #reduceActionFor_hash___numberSign__1: 1827841 false) 
	#(41 1 #reduceActionForHeader2: 2057218 false) 
	#(60 1 #reduceActionFor_hash___numberSign__1: 3420161 false) 
	#(32 1 #reduceActionForString5: 1635333 false) 
	#(70 2 #reduceActionForKeywordLink1: 4091905 false) 
	#(36 1 #reduceActionForStar1: 1795073 false) 
	#(32 2 #reduceActionForString2: 1635330 false) 
	#(34 1 #reduceActionForLines1: 1770497 false) 
	#(35 1 #reduceActionFor_hash___numberSign__1: 1778689 false) 
	#(75 1 #reduceActionForStar1: 4681729 false) 
	#(76 1 #liftFirstValue: 4757510 false) 
	#(76 1 #liftFirstValue: 4757514 false) 
	#(67 1 #reduceActionForExternalUrlLink1: 3951617 false) 
	#(76 1 #liftFirstValue: 4757505 false) 
	#(69 1 #reduceActionForExternalLabelUrlLink1: 4040705 false) 
	#(68 1 #reduceActionForExternalImageLink1: 3992577 false) 
	#(76 1 #liftFirstValue: 4757506 false) 
	#(76 1 #liftFirstValue: 4757509 false) 
	#(76 1 #liftFirstValue: 4757507 false) 
	#(76 1 #liftFirstValue: 4757508 false) 
	#(44 1 #reduceActionForCode1: 2241537 false) 
	#(48 1 #reduceActionForCode1: 2545671 false) 
	#(43 1 #reduceActionForStar1: 2149381 false) 
	#(76 1 #liftFirstValue: 4757511 false) 
	#(76 1 #liftFirstValue: 4757512 false) 
	#(76 1 #liftFirstValue: 4757513 false) 
	#(76 1 #liftFirstValue: 4757516 false) 
	#(76 1 #liftFirstValue: 4757515 false) 
	#(40 2 #reduceActionForPartsWithoutStars2: 1991682 false) 
	#(43 1 #liftFirstValue: 2149380 false) 
	#(45 0 #reduceActionForCodeBlockSource1: 2398209 true) 
	#(43 1 #liftFirstValue: 2149377 false) 
	#(47 1 #liftFirstValue: 2504705 false) 
	#(43 1 #liftFirstValue: 2149378 false) 
	#(43 1 #liftFirstValue: 2149379 false) 
	#(48 1 #liftFirstValue: 2545670 false) 
	#(48 1 #liftFirstValue: 2545667 false) 
	#(66 1 #liftFirstValue: 3869698 false) 
	#(66 1 #liftFirstValue: 3869699 false) 
	#(66 1 #liftFirstValue: 3869697 false) 
	#(48 1 #liftFirstValue: 2545669 false) 
	#(48 1 #liftFirstValue: 2545668 false) 
	#(48 1 #liftFirstValue: 2545666 false) 
	#(48 1 #liftFirstValue: 2545665 false) 
	#(75 1 #reduceActionForStar1: 4681730 false) 
	#(42 2 #reduceActionForPartsWithoutStars2: 2067458 false) 
	#(41 2 #reduceActionForHeader1: 2057217 false) 
	#(39 2 #reduceActionForLineParts3: 1901571 false) 
	#(60 2 #reduceActionForStars2: 3420162 false) 
	#(32 2 #reduceActionForString3: 1635331 false) 
	#(32 2 #reduceActionForString3: 1635334 false) 
	#(33 3 #reduceActionForLines2: 1733634 false) 
	#(35 2 #reduceActionForPartsWithoutStars2: 1778690 false) 
	#(72 2 #reduceActionForEmptyDoubleBracketLink1: 4274177 false) 
	#(72 2 #reduceActionForEmptyDoubleBracketLink1: 4274178 false) 
	#(58 1 #liftFirstValue: 3218433 false) 
	#(57 1 #reduceActionFor_hash___numberSign__1: 3152897 false) 
	#(58 1 #liftFirstValue: 3218434 false) 
	#(39 3 #reduceActionForLines2: 1901570 false) 
	#(64 0 #reduceActionForSwitchToDefault1: 3772417 true) 
	#(32 3 #reduceActionForString4: 1635332 false) 
	#(71 3 #reduceActionForBlockLink1: 4163585 false) 
	#(53 1 #liftFirstValue: 2960385 false) 
	#(50 1 #reduceActionForLines1: 2834433 false) 
	#(51 1 #reduceActionFor_hash___numberSign__1: 2859009 false) 
	#(53 1 #liftFirstValue: 2960386 false) 
	#(56 3 #reduceActionForItalic1: 3124225 false) 
	#(57 2 #reduceActionForPartsWithoutStars2: 3152898 false) 
	#(55 1 #reduceActionFor_hash___numberSign__1: 3064833 false) 
	#(51 2 #reduceActionForPartsWithoutStars2: 2859010 false) 
	#(44 4 #reduceActionForCode2: 2241538 false) 
	#(65 0 #reduceActionForParseAnnotation1: 3823617 true) 
	#(54 3 #reduceActionForItalic1: 3024897 false) 
	#(55 2 #reduceActionForPartsWithoutStars2: 3064834 false) 
	#(49 5 #reduceActionForBold1: 2716673 false) 
	#(50 3 #reduceActionForInnerBoldStringParts2: 2834434 false) 
	#(52 1 #reduceActionFor_hash___numberSign__1: 2902017 false) 
	#(73 5 #reduceActionForDoubleBracketLink1: 4471809 false) 
	#(59 5 #reduceActionForBold1: 3284993 false) 
	#(52 2 #reduceActionForPartsWithoutStars2: 2902018 false) 
	#(62 7 #reduceActionForDocumenterAnnotation1: 3502081 false)
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
LeParser class >> symbolNames [
	^ #('<annotationName>' '<whitespace>' '<text>' '<leftDoubleBracket>' '<hash>' '<rightDoubleBracket>' '<doubleRightParenthesis>' '<doubleLeftParenthesis>' '<doubleColon>' '<rightBracket>' '<url>' '<exclamationMark>' '<labelUrl>' '<imageUrl>' '<colon>' '<doubleLeftBrace>' '<doubleRightBrace>' '<leftBrace>' '<rightBrace>' '<eol>' '<star>' '<linkText>' '<inlineCode>' '<blockCode>' '<backquote>' '<leftParen>' '<rightParen>' '<leftBracket>' '<gt>' '<lt>' 'B e g i n' 'String' 'Lines' 'EOLs' 'EOL ''part'' +' 'EOL' 'Line' 'NonHeaderLine' 'LineParts' 'PartsWithoutStars' 'Header' '<hash> ''numberSign''+' 'StringPart' 'Code' 'CodeBlockSource' 'CodeBlockLanguage' 'InnerStringPart' 'NonHashStringPart' 'Bold' 'InnerBoldStringParts' 'InnerBoldStringPart ''part'' +' 'InnerBoldStringPart ''part''+' 'InnerBoldStringPart' 'ItalicWithoutBold' 'InnerStringPart ''part'' +' 'Italic' 'InnerItalicStringPart ''part'' +' 'InnerItalicStringPart' 'BoldWithoutItalic' 'Stars' 'Star' 'DocumenterAnnotation' 'SwitchToAnnotation' 'SwitchToDefault' 'ParseAnnotation' 'ExternalLink' 'ExternalUrlLink' 'ExternalImageLink' 'ExternalLabelUrlLink' 'KeywordLink' 'BlockLink' 'EmptyDoubleBracketLink' 'DoubleBracketLink' 'SwitchToLinkText' 'Text' 'SpecialTextCharacters' 'E O F' 'error')
]

{ #category : #generated }
LeParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeStringNode #LeStringNode #OrderedCollection #OrderedCollection #OrderedCollection #LeTextNode #Object #OrderedCollection #OrderedCollection #OrderedCollection #LeHeaderNode #OrderedCollection #LeContentNode #LeContentNode #Object #Object #LeContentNode #LeContentNode #LeBoldNode #OrderedCollection #OrderedCollection #OrderedCollection #LeContentNode #LeItalicNode #OrderedCollection #LeItalicNode #OrderedCollection #LeContentNode #LeBoldNode #OrderedCollection #LeTextNode #LeDocumenterAnnotationNode nil nil #Object #LeExternalLinkNode #LeExternalUrlLinkNode #LeExternalImageLinkNode #LeExternalLabelUrlLinkNode #LeKeywordLinkNode #LeBlockLinkNode #LeEmptyDoubleBracketLinkNode #LeDoubleBracketLinkNode nil #LeTextNode #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeParser class >> transitionTable [
^#(
#[1 0 7 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 0 21 0 32 0 25 0 33 0 29 0 37 0 33 0 38 0 37 0 39 0 41 0 40 0 45 0 41 0 49 0 42 0 53 0 60 0 57 0 61 0 61 0 70 0 6 0 77] 
#[0 0 65 0 9] 
#[0 0 10 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 14 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 0 0 77] 
#[1 0 69 0 20 0 73 0 34 0 77 0 35 0 81 0 36 0 18 0 77] 
#[0 0 22 0 20 0 77] 
#[0 0 26 0 20 0 77] 
#[0 0 30 0 20 0 77] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 0 42 0 20 0 137 0 21 0 141 0 23 0 46 0 24 0 145 0 25 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 0 169 0 43 0 169 0 44 0 177 0 46 0 169 0 47 0 169 0 48 0 169 0 49 0 169 0 56 0 197 0 60 0 57 0 61 0 169 0 62 0 205 0 63 0 169 0 66 0 169 0 67 0 169 0 68 0 169 0 69 0 169 0 71 0 169 0 72 0 169 0 73 0 237 0 74 0 169 0 75 0 245 0 76 0 42 0 77] 
#[0 0 50 0 20 0 77] 
#[1 0 6 0 3 0 6 0 4 0 23 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 27 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 0 253 0 39 0 41 0 40 0 53 0 60 0 57 0 61 0 27 0 77] 
#[1 0 6 0 3 0 6 0 4 0 6 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 1 1 0 40 0 6 0 77] 
#[1 0 58 0 3 0 58 0 4 0 58 0 5 0 58 0 8 0 58 0 10 0 58 0 11 0 58 0 12 0 58 0 13 0 58 0 14 0 58 0 15 0 58 0 16 0 58 0 17 0 58 0 18 0 58 0 19 0 58 0 20 0 31 0 21 0 58 0 23 0 58 0 24 0 58 0 25 0 58 0 26 0 58 0 27 0 58 0 28 0 58 0 29 0 58 0 30 1 5 0 60 0 57 0 61 0 58 0 77] 
#[1 0 6 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 35 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 1 9 0 33 1 13 0 34 0 77 0 35 0 81 0 36 0 29 0 37 0 33 0 38 0 37 0 39 0 41 0 40 0 45 0 41 0 49 0 42 0 53 0 60 0 57 0 61 0 39 0 77] 
#[0 0 66 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 70 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 0 6 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 1 17 0 37 0 33 0 38 0 37 0 39 0 41 0 40 0 45 0 41 0 49 0 42 0 53 0 60 0 57 0 61 0 43 0 77] 
#[1 0 78 0 3 0 78 0 4 0 78 0 5 0 78 0 8 0 78 0 10 0 78 0 11 0 78 0 12 0 78 0 13 0 78 0 14 0 78 0 15 0 78 0 16 0 78 0 17 0 78 0 18 0 78 0 19 0 47 0 20 0 78 0 21 0 78 0 23 0 78 0 24 0 78 0 25 0 78 0 26 0 78 0 27 0 78 0 28 0 78 0 29 0 78 0 30 1 21 0 36 0 78 0 77] 
#[0 0 82 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 86 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 1 25 0 6 1 29 0 10] 
#[0 0 90 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 1 33 0 3] 
#[0 0 94 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 98 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 102 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 106 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 110 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 114 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 118 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 122 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 126 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 0 51 0 3 0 55 0 4 0 59 0 5 0 63 0 8 0 67 0 10 0 71 0 11 0 75 0 12 0 79 0 13 0 83 0 14 0 87 0 15 0 91 0 16 0 95 0 17 0 99 0 18 0 103 0 19 0 14 0 20 0 107 0 21 0 111 0 23 0 14 0 24 0 14 0 25 0 115 0 26 0 119 0 27 0 123 0 28 0 127 0 29 0 131 0 30 1 53 0 47 1 53 0 48 1 49 0 57 1 53 0 58 1 53 0 59 1 53 0 62 0 205 0 63 1 53 0 66 1 53 0 67 1 53 0 68 1 53 0 69 1 53 0 71 1 53 0 72 1 53 0 73 0 237 0 74 1 53 0 75 0 245 0 76 0 14 0 77] 
#[0 0 135 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 138 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 142 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 146 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 150 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 154 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 158 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 162 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 166 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 0 170 0 24 1 61 0 45] 
#[0 0 174 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 178 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 182 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 186 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 0 6 0 3 0 6 0 4 0 6 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 1 65 0 40 0 6 0 77] 
#[0 0 190 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 1 69 0 16] 
#[0 0 194 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 198 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 202 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 206 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 210 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 214 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 218 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 1 73 0 4] 
#[0 0 222 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 226 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 230 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 0 234 0 20 0 77] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 0 238 0 20 1 77 0 21 0 141 0 23 0 46 0 24 0 145 0 25 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 0 169 0 43 0 169 0 44 0 177 0 46 0 169 0 47 0 169 0 48 0 169 0 49 0 169 0 56 0 169 0 62 0 205 0 63 0 169 0 66 0 169 0 67 0 169 0 68 0 169 0 69 0 169 0 71 0 169 0 72 0 169 0 73 0 237 0 74 0 169 0 75 0 245 0 76 0 238 0 77] 
#[0 0 242 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 0 69 0 20 1 81 0 34 0 77 0 35 0 81 0 36 0 246 0 77] 
#[0 0 250 0 77] 
#[0 0 254 0 20 0 77] 
#[0 1 2 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 1 6 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 1 10 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 1 85 0 7] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 89 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 105 0 47 1 105 0 48 1 97 0 50 1 101 0 51 1 105 0 53 1 105 0 54 1 105 0 62 0 205 0 63 1 105 0 66 1 105 0 67 1 105 0 68 1 105 0 69 1 105 0 71 1 105 0 72 1 105 0 73 0 237 0 74 1 105 0 75 0 245 0 76] 
#[0 0 134 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 14 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 113 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 117 0 47 1 117 0 48 1 117 0 58 1 117 0 59 1 117 0 62 0 205 0 63 1 117 0 66 1 117 0 67 1 117 0 68 1 117 0 69 1 117 0 71 1 117 0 72 1 117 0 73 0 237 0 74 1 117 0 75 0 245 0 76] 
#[0 1 18 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 22 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 121 0 24] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 26 0 20 1 77 0 21 0 141 0 23 0 46 0 24 0 145 0 25 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 0 169 0 43 0 169 0 44 0 177 0 46 0 169 0 47 0 169 0 48 0 169 0 49 0 169 0 56 0 169 0 62 0 205 0 63 0 169 0 66 0 169 0 67 0 169 0 68 0 169 0 69 0 169 0 71 0 169 0 72 0 169 0 73 0 237 0 74 0 169 0 75 0 245 0 76 1 26 0 77] 
#[1 1 30 0 1 1 125 0 64] 
#[1 1 30 0 22 1 129 0 64] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 37 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 53 0 47 1 53 0 48 1 49 0 57 1 53 0 58 1 53 0 59 1 53 0 62 0 205 0 63 1 53 0 66 1 53 0 67 1 53 0 68 1 53 0 69 1 53 0 71 1 53 0 72 1 53 0 73 0 237 0 74 1 53 0 75 0 245 0 76] 
#[1 0 6 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 10 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 6 0 28 0 6 0 29 0 6 0 30 1 17 0 37 0 33 0 38 0 37 0 39 0 41 0 40 0 45 0 41 0 49 0 42 0 53 0 60 0 57 0 61 0 139 0 77] 
#[0 1 38 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 133 0 47 1 133 0 48 1 137 0 55 1 133 0 62 0 205 0 63 1 133 0 66 1 133 0 67 1 133 0 68 1 133 0 69 1 133 0 71 1 133 0 72 1 133 0 73 0 237 0 74 1 133 0 75 0 245 0 76] 
#[0 1 42 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 141 0 21] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 0 143 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 149 0 47 1 149 0 48 1 149 0 53 1 149 0 54 1 153 0 61 1 149 0 62 0 205 0 63 1 149 0 66 1 149 0 67 1 149 0 68 1 149 0 69 1 149 0 71 1 149 0 72 1 149 0 73 0 237 0 74 1 149 0 75 0 245 0 76] 
#[0 1 50 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 54 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 1 58 0 3 1 58 0 4 1 58 0 5 1 58 0 8 1 58 0 10 1 58 0 11 1 58 0 12 1 58 0 13 1 58 0 14 1 58 0 15 1 58 0 16 1 58 0 17 1 58 0 18 1 58 0 19 1 58 0 20 0 147 0 21 1 58 0 23 1 58 0 24 1 58 0 25 1 58 0 26 1 58 0 27 1 58 0 28 1 58 0 29 1 58 0 30 1 58 0 77] 
#[0 1 62 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 161 0 24] 
#[0 1 165 0 1] 
#[0 1 169 0 22] 
#[0 1 66 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 173 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 177 0 47 1 177 0 48 1 177 0 62 0 205 0 63 1 177 0 66 1 177 0 67 1 177 0 68 1 177 0 69 1 177 0 71 1 177 0 72 1 177 0 73 0 237 0 74 1 177 0 75 0 245 0 76] 
#[0 1 181 0 21] 
#[1 0 51 0 3 0 55 0 4 0 59 0 5 0 63 0 8 0 67 0 10 0 71 0 11 0 75 0 12 0 79 0 13 0 83 0 14 0 87 0 15 0 91 0 16 0 95 0 17 0 99 0 18 0 103 0 19 0 14 0 21 0 111 0 23 0 115 0 26 0 119 0 27 0 123 0 28 0 127 0 29 0 131 0 30 1 133 0 47 1 133 0 48 1 185 0 55 1 133 0 62 0 205 0 63 1 133 0 66 1 133 0 67 1 133 0 68 1 133 0 69 1 133 0 71 1 133 0 72 1 133 0 73 0 237 0 74 1 133 0 75 0 245 0 76] 
#[0 1 70 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 189 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 197 0 47 1 197 0 48 1 193 0 52 1 197 0 53 1 197 0 54 1 197 0 62 0 205 0 63 1 197 0 66 1 197 0 67 1 197 0 68 1 197 0 69 1 197 0 71 1 197 0 72 1 197 0 73 0 237 0 74 1 197 0 75 0 245 0 76] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 133 0 47 1 133 0 48 1 201 0 55 1 133 0 62 0 205 0 63 1 133 0 66 1 133 0 67 1 133 0 68 1 133 0 69 1 133 0 71 1 133 0 72 1 133 0 73 0 237 0 74 1 133 0 75 0 245 0 76] 
#[0 1 74 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 1 78 0 15 1 205 0 65] 
#[0 1 209 0 6] 
#[1 1 82 0 3 1 82 0 4 1 82 0 5 1 82 0 8 1 82 0 10 1 82 0 11 1 82 0 12 1 82 0 13 1 82 0 14 1 82 0 15 1 82 0 16 1 82 0 17 1 82 0 18 1 82 0 19 0 151 0 21 1 82 0 23 1 82 0 26 1 82 0 27 1 82 0 28 1 82 0 29 1 82 0 30] 
#[0 1 86 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 90 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 217 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 177 0 47 1 177 0 48 1 177 0 62 0 205 0 63 1 177 0 66 1 177 0 67 1 177 0 68 1 177 0 69 1 177 0 71 1 177 0 72 1 177 0 73 0 237 0 74 1 177 0 75 0 245 0 76] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 133 0 47 1 133 0 48 1 185 0 55 1 133 0 62 0 205 0 63 1 133 0 66 1 133 0 67 1 133 0 68 1 133 0 69 1 133 0 71 1 133 0 72 1 133 0 73 0 237 0 74 1 133 0 75 0 245 0 76] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 0 155 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 221 0 47 1 221 0 48 1 221 0 53 1 221 0 54 1 221 0 62 0 205 0 63 1 221 0 66 1 221 0 67 1 221 0 68 1 221 0 69 1 221 0 71 1 221 0 72 1 221 0 73 0 237 0 74 1 221 0 75 0 245 0 76] 
#[0 1 98 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[1 0 85 0 3 0 19 0 4 0 245 0 5 0 97 0 8 0 245 0 10 0 105 0 11 0 245 0 12 0 113 0 13 0 117 0 14 0 245 0 15 0 38 0 16 0 245 0 17 0 245 0 18 0 245 0 19 1 225 0 21 1 41 0 23 0 245 0 26 0 245 0 27 0 245 0 28 0 245 0 29 0 245 0 30 1 177 0 47 1 177 0 48 1 177 0 62 0 205 0 63 1 177 0 66 1 177 0 67 1 177 0 68 1 177 0 69 1 177 0 71 1 177 0 72 1 177 0 73 0 237 0 74 1 177 0 75 0 245 0 76] 
#[0 1 229 0 15] 
#[0 1 102 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77] 
#[0 1 106 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 82 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 110 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 23 0 26 0 27 0 28 0 29 0 30] 
#[0 1 213 0 21] 
#[0 1 233 0 17] 
#[0 1 114 0 3 0 4 0 5 0 8 0 10 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 28 0 29 0 30 0 77]
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
LeParser >> reduceActionForBold1: nodes [
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
LeParser >> reduceActionForCode1: nodes [
	| result |
	result := LeInlineCodeNode new.
	result code: (nodes at: 1).
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
LeParser >> reduceActionForItalic1: nodes [
	| result |
	result := LeItalicNode new.
	result leftStar: (nodes at: 1).
	result addNodes: (nodes at: 2) to: result parts.
	result rightStar: (nodes at: 3).
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
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForLines2: nodes [
	| result |
	result := nodes at: 1.
	self addAll: (nodes at: 2) to: result.
	self addAll: (nodes at: 3) to: result.
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
LeParser >> reduceActionForPartsWithoutStars2: nodes [
	| result |
	result := nodes at: 1.
	self add: (nodes at: 2) to: result.
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForStar1: nodes [
	| result |
	result := LeTextNode new.
	result text: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeParser >> reduceActionForStars2: nodes [
	| result |
	result := nodes at: 2.
	self addFirst: (nodes at: 1) to: result.
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
