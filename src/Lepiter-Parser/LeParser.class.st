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
#[ 0 6 0 233] 
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
#[ 0 14 0 38] 
#[ 0 14 0 121] 
#[ 0 14 0 125] 
#[ 0 14 0 129] 
#[ 0 14 1 21] 
#[ 0 14 0 145] 
#[ 0 14 0 149] 
#[ 0 6 1 14] 
#[ 1 26 1 125] 
#[ 1 38 1 137] 
#[ 1 62 1 193] 
#[ 1 74 1 169]
	).
]

{ #category : #parsing }
LeParser class >> annotationParsers [
	^ AnnotationParsers
		ifNil: [ AnnotationParsers := self initialAnnotationParsers ]
]

{ #category : #'generated-accessing' }
LeParser class >> cacheId [
	^'2020-12-04T19:53:06.706247-06:00'
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
<url>
	: \< [^\[\]\(\)\<\>\s]+ \>
	;
<exclamationMark>
	: \!
	;
<labelUrl>
	: \[ [^\[\]]* \]\( [^\[\]\(\)\<\>]* \)
	;
<imageUrl>
	: <exclamationMark> \[ [^\[\]]* \]\( [^\[\]\(\)\<\>]* \)
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
	#(37 0 #reduceActionForPartsWithoutStars1: 1721345 false ) 
	#(39 1 #reduceActionFor_hash___numberSign__1: 1797121 false ) 
	#(58 1 #reduceActionForStar1: 3158017 false ) 
	#(29 1 #reduceActionForString1: 1364993 false ) 
	#(30 1 #reduceActionForLines1: 1463297 false ) 
	#(34 1 #reduceActionForLines1: 1557506 false ) 
	#(35 1 #reduceActionForLines1: 1600513 false ) 
	#(71 0 #reduceActionForSwitchToLinkText1: 4319233 true ) 
	#(60 0 #reduceActionForSwitchToAnnotation1: 3405825 true ) 
	#(36 1 #reduceActionForLines1: 1631233 false ) 
	#(43 0 #reduceActionForCodeBlockLanguage1: 2179073 true ) 
	#(34 1 #reduceActionFor_hash___numberSign__1: 1557505 false ) 
	#(38 1 #reduceActionForHeader2: 1786882 false ) 
	#(57 1 #reduceActionFor_hash___numberSign__1: 3110913 false ) 
	#(29 1 #reduceActionForString5: 1364997 false ) 
	#(67 2 #reduceActionForKeywordLink1: 3782657 false ) 
	#(33 1 #reduceActionForStar1: 1524737 false ) 
	#(29 2 #reduceActionForString2: 1364994 false ) 
	#(31 1 #reduceActionForLines1: 1500161 false ) 
	#(32 1 #reduceActionFor_hash___numberSign__1: 1508353 false ) 
	#(72 1 #reduceActionForStar1: 4372481 false ) 
	#(73 1 #liftFirstValue: 4448262 false ) 
	#(64 1 #reduceActionForExternalUrlLink1: 3642369 false ) 
	#(73 1 #liftFirstValue: 4448257 false ) 
	#(66 1 #reduceActionForExternalLabelUrlLink1: 3731457 false ) 
	#(65 1 #reduceActionForExternalImageLink1: 3683329 false ) 
	#(73 1 #liftFirstValue: 4448258 false ) 
	#(73 1 #liftFirstValue: 4448261 false ) 
	#(73 1 #liftFirstValue: 4448259 false ) 
	#(73 1 #liftFirstValue: 4448260 false ) 
	#(41 1 #reduceActionForCode1: 1971201 false ) 
	#(40 1 #reduceActionForStar1: 1879045 false ) 
	#(73 1 #liftFirstValue: 4448263 false ) 
	#(73 1 #liftFirstValue: 4448264 false ) 
	#(37 2 #reduceActionForPartsWithoutStars2: 1721346 false ) 
	#(40 1 #liftFirstValue: 1879044 false ) 
	#(42 0 #reduceActionForCodeBlockSource1: 2127873 true ) 
	#(40 1 #liftFirstValue: 1879041 false ) 
	#(44 1 #liftFirstValue: 2234369 false ) 
	#(40 1 #liftFirstValue: 1879042 false ) 
	#(40 1 #liftFirstValue: 1879043 false ) 
	#(45 1 #liftFirstValue: 2275334 false ) 
	#(45 1 #liftFirstValue: 2275331 false ) 
	#(63 1 #liftFirstValue: 3560450 false ) 
	#(63 1 #liftFirstValue: 3560451 false ) 
	#(63 1 #liftFirstValue: 3560449 false ) 
	#(45 1 #liftFirstValue: 2275333 false ) 
	#(45 1 #liftFirstValue: 2275332 false ) 
	#(45 1 #liftFirstValue: 2275330 false ) 
	#(45 1 #liftFirstValue: 2275329 false ) 
	#(72 1 #reduceActionForStar1: 4372482 false ) 
	#(39 2 #reduceActionForPartsWithoutStars2: 1797122 false ) 
	#(38 2 #reduceActionForHeader1: 1786881 false ) 
	#(36 2 #reduceActionForLineParts3: 1631235 false ) 
	#(57 2 #reduceActionForStars2: 3110914 false ) 
	#(29 2 #reduceActionForString3: 1364995 false ) 
	#(29 2 #reduceActionForString3: 1364998 false ) 
	#(30 3 #reduceActionForLines2: 1463298 false ) 
	#(32 2 #reduceActionForPartsWithoutStars2: 1508354 false ) 
	#(69 2 #reduceActionForEmptyDoubleBracketLink1: 3964929 false ) 
	#(69 2 #reduceActionForEmptyDoubleBracketLink1: 3964930 false ) 
	#(55 1 #liftFirstValue: 2909185 false ) 
	#(54 1 #reduceActionFor_hash___numberSign__1: 2843649 false ) 
	#(55 1 #liftFirstValue: 2909186 false ) 
	#(36 3 #reduceActionForLines2: 1631234 false ) 
	#(61 0 #reduceActionForSwitchToDefault1: 3463169 true ) 
	#(29 3 #reduceActionForString4: 1364996 false ) 
	#(68 3 #reduceActionForBlockLink1: 3854337 false ) 
	#(50 1 #liftFirstValue: 2651137 false ) 
	#(47 1 #reduceActionForLines1: 2525185 false ) 
	#(48 1 #reduceActionFor_hash___numberSign__1: 2549761 false ) 
	#(50 1 #liftFirstValue: 2651138 false ) 
	#(53 3 #reduceActionForItalic1: 2814977 false ) 
	#(54 2 #reduceActionForPartsWithoutStars2: 2843650 false ) 
	#(52 1 #reduceActionFor_hash___numberSign__1: 2755585 false ) 
	#(48 2 #reduceActionForPartsWithoutStars2: 2549762 false ) 
	#(41 4 #reduceActionForCode2: 1971202 false ) 
	#(62 0 #reduceActionForParseAnnotation1: 3514369 true ) 
	#(51 3 #reduceActionForItalic1: 2715649 false ) 
	#(52 2 #reduceActionForPartsWithoutStars2: 2755586 false ) 
	#(46 5 #reduceActionForBold1: 2407425 false ) 
	#(47 3 #reduceActionForInnerBoldStringParts2: 2525186 false ) 
	#(49 1 #reduceActionFor_hash___numberSign__1: 2592769 false ) 
	#(70 5 #reduceActionForDoubleBracketLink1: 4162561 false ) 
	#(56 5 #reduceActionForBold1: 2975745 false ) 
	#(49 2 #reduceActionForPartsWithoutStars2: 2592770 false ) 
	#(59 7 #reduceActionForDocumenterAnnotation1: 3192833 false )
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
	^ #('<annotationName>' '<whitespace>' '<text>' '<leftDoubleBracket>' '<hash>' '<rightDoubleBracket>' '<doubleRightParenthesis>' '<doubleLeftParenthesis>' '<doubleColon>' '<rightBracket>' '<url>' '<exclamationMark>' '<labelUrl>' '<imageUrl>' '<colon>' '<doubleLeftBrace>' '<doubleRightBrace>' '<leftBrace>' '<rightBrace>' '<eol>' '<star>' '<linkText>' '<inlineCode>' '<blockCode>' '<backquote>' '<leftParen>' '<rightParen>' 'B e g i n' 'String' 'Lines' 'EOLs' 'EOL ''part'' +' 'EOL' 'Line' 'NonHeaderLine' 'LineParts' 'PartsWithoutStars' 'Header' '<hash> ''numberSign''+' 'StringPart' 'Code' 'CodeBlockSource' 'CodeBlockLanguage' 'InnerStringPart' 'NonHashStringPart' 'Bold' 'InnerBoldStringParts' 'InnerBoldStringPart ''part'' +' 'InnerBoldStringPart ''part''+' 'InnerBoldStringPart' 'ItalicWithoutBold' 'InnerStringPart ''part'' +' 'Italic' 'InnerItalicStringPart ''part'' +' 'InnerItalicStringPart' 'BoldWithoutItalic' 'Stars' 'Star' 'DocumenterAnnotation' 'SwitchToAnnotation' 'SwitchToDefault' 'ParseAnnotation' 'ExternalLink' 'ExternalUrlLink' 'ExternalImageLink' 'ExternalLabelUrlLink' 'KeywordLink' 'BlockLink' 'EmptyDoubleBracketLink' 'DoubleBracketLink' 'SwitchToLinkText' 'Text' 'SpecialTextCharacters' 'E O F' 'error')
]

{ #category : #generated }
LeParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeStringNode #LeStringNode #OrderedCollection #OrderedCollection #OrderedCollection #LeTextNode #Object #OrderedCollection #OrderedCollection #OrderedCollection #LeHeaderNode #OrderedCollection #LeContentNode #LeContentNode #Object #Object #LeContentNode #LeContentNode #LeBoldNode #OrderedCollection #OrderedCollection #OrderedCollection #LeContentNode #LeItalicNode #OrderedCollection #LeItalicNode #OrderedCollection #LeContentNode #LeBoldNode #OrderedCollection #LeTextNode #LeCustomAnnotationNode nil nil #Object #LeExternalLinkNode #LeExternalUrlLinkNode #LeExternalImageLinkNode #LeExternalLabelUrlLinkNode #LeKeywordLinkNode #LeBlockLinkNode #LeEmptyDoubleBracketLinkNode #LeDoubleBracketLinkNode nil #LeTextNode #SmaCCToken #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeParser class >> transitionTable [
^#(
#[1 0 7 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 21 0 29 0 25 0 30 0 29 0 34 0 33 0 35 0 37 0 36 0 41 0 37 0 45 0 38 0 49 0 39 0 53 0 57 0 57 0 58 0 61 0 67 0 6 0 74] 
#[0 0 65 0 9] 
#[0 0 10 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 14 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 0 0 74] 
#[1 0 69 0 20 0 73 0 31 0 77 0 32 0 81 0 33 0 18 0 74] 
#[0 0 22 0 20 0 74] 
#[0 0 26 0 20 0 74] 
#[0 0 30 0 20 0 74] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 0 42 0 20 0 133 0 21 0 137 0 23 0 46 0 24 0 141 0 25 0 229 0 26 0 229 0 27 0 153 0 40 0 153 0 41 0 161 0 43 0 153 0 44 0 153 0 45 0 153 0 46 0 153 0 53 0 181 0 57 0 57 0 58 0 153 0 59 0 189 0 60 0 153 0 63 0 153 0 64 0 153 0 65 0 153 0 66 0 153 0 68 0 153 0 69 0 153 0 70 0 221 0 71 0 153 0 72 0 229 0 73 0 42 0 74] 
#[0 0 50 0 20 0 74] 
#[1 0 6 0 3 0 6 0 4 0 23 0 5 0 6 0 8 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 27 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 237 0 36 0 41 0 37 0 53 0 57 0 57 0 58 0 27 0 74] 
#[1 0 6 0 3 0 6 0 4 0 6 0 5 0 6 0 8 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 241 0 37 0 6 0 74] 
#[1 0 58 0 3 0 58 0 4 0 58 0 5 0 58 0 8 0 58 0 11 0 58 0 12 0 58 0 13 0 58 0 14 0 58 0 15 0 58 0 16 0 58 0 17 0 58 0 18 0 58 0 19 0 58 0 20 0 31 0 21 0 58 0 23 0 58 0 24 0 58 0 25 0 58 0 26 0 58 0 27 0 245 0 57 0 57 0 58 0 58 0 74] 
#[1 0 6 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 35 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 0 249 0 30 0 253 0 31 0 77 0 32 0 81 0 33 0 29 0 34 0 33 0 35 0 37 0 36 0 41 0 37 0 45 0 38 0 49 0 39 0 53 0 57 0 57 0 58 0 39 0 74] 
#[0 0 66 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 70 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 0 6 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 1 1 0 34 0 33 0 35 0 37 0 36 0 41 0 37 0 45 0 38 0 49 0 39 0 53 0 57 0 57 0 58 0 43 0 74] 
#[1 0 78 0 3 0 78 0 4 0 78 0 5 0 78 0 8 0 78 0 11 0 78 0 12 0 78 0 13 0 78 0 14 0 78 0 15 0 78 0 16 0 78 0 17 0 78 0 18 0 78 0 19 0 47 0 20 0 78 0 21 0 78 0 23 0 78 0 24 0 78 0 25 0 78 0 26 0 78 0 27 1 5 0 33 0 78 0 74] 
#[0 0 82 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 86 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 1 9 0 6 1 13 0 10] 
#[0 0 90 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 1 17 0 3] 
#[0 0 94 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 98 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 102 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 106 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 110 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 114 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 118 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 122 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 0 51 0 3 0 55 0 4 0 59 0 5 0 63 0 8 0 67 0 11 0 71 0 12 0 75 0 13 0 79 0 14 0 83 0 15 0 87 0 16 0 91 0 17 0 95 0 18 0 99 0 19 0 14 0 20 0 103 0 21 0 14 0 23 0 14 0 24 0 14 0 25 0 107 0 26 0 111 0 27 1 33 0 44 1 33 0 45 1 29 0 54 1 33 0 55 1 33 0 56 1 33 0 59 0 189 0 60 1 33 0 63 1 33 0 64 1 33 0 65 1 33 0 66 1 33 0 68 1 33 0 69 1 33 0 70 0 221 0 71 1 33 0 72 0 229 0 73 0 14 0 74] 
#[0 0 126 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 130 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 134 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 138 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 142 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 146 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 0 150 0 24 1 41 0 42] 
#[0 0 154 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 158 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 162 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 166 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 0 6 0 3 0 6 0 4 0 6 0 5 0 6 0 8 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 6 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 1 45 0 37 0 6 0 74] 
#[0 0 170 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 1 49 0 16] 
#[0 0 174 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 178 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 182 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 186 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 190 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 194 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 198 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 1 53 0 4] 
#[0 0 202 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 206 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 210 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 214 0 20 0 74] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 0 218 0 20 1 57 0 21 0 137 0 23 0 46 0 24 0 141 0 25 0 229 0 26 0 229 0 27 0 153 0 40 0 153 0 41 0 161 0 43 0 153 0 44 0 153 0 45 0 153 0 46 0 153 0 53 0 153 0 59 0 189 0 60 0 153 0 63 0 153 0 64 0 153 0 65 0 153 0 66 0 153 0 68 0 153 0 69 0 153 0 70 0 221 0 71 0 153 0 72 0 229 0 73 0 218 0 74] 
#[0 0 222 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 0 69 0 20 1 61 0 31 0 77 0 32 0 81 0 33 0 226 0 74] 
#[0 0 230 0 74] 
#[0 0 234 0 20 0 74] 
#[0 0 238 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 242 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 0 246 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 1 65 0 7] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 69 0 21 0 229 0 26 0 229 0 27 1 85 0 44 1 85 0 45 1 77 0 47 1 81 0 48 1 85 0 50 1 85 0 51 1 85 0 59 0 189 0 60 1 85 0 63 1 85 0 64 1 85 0 65 1 85 0 66 1 85 0 68 1 85 0 69 1 85 0 70 0 221 0 71 1 85 0 72 0 229 0 73] 
#[0 0 250 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 93 0 21 0 229 0 26 0 229 0 27 1 97 0 44 1 97 0 45 1 97 0 55 1 97 0 56 1 97 0 59 0 189 0 60 1 97 0 63 1 97 0 64 1 97 0 65 1 97 0 66 1 97 0 68 1 97 0 69 1 97 0 70 0 221 0 71 1 97 0 72 0 229 0 73] 
#[0 0 254 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 2 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 101 0 24] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 6 0 20 1 57 0 21 0 137 0 23 0 46 0 24 0 141 0 25 0 229 0 26 0 229 0 27 0 153 0 40 0 153 0 41 0 161 0 43 0 153 0 44 0 153 0 45 0 153 0 46 0 153 0 53 0 153 0 59 0 189 0 60 0 153 0 63 0 153 0 64 0 153 0 65 0 153 0 66 0 153 0 68 0 153 0 69 0 153 0 70 0 221 0 71 0 153 0 72 0 229 0 73 1 6 0 74] 
#[1 1 10 0 1 1 105 0 61] 
#[1 1 10 0 22 1 109 0 61] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 21 0 21 0 229 0 26 0 229 0 27 1 33 0 44 1 33 0 45 1 29 0 54 1 33 0 55 1 33 0 56 1 33 0 59 0 189 0 60 1 33 0 63 1 33 0 64 1 33 0 65 1 33 0 66 1 33 0 68 1 33 0 69 1 33 0 70 0 221 0 71 1 33 0 72 0 229 0 73] 
#[1 0 6 0 3 0 6 0 4 0 11 0 5 0 6 0 8 0 6 0 11 0 6 0 12 0 6 0 13 0 6 0 14 0 6 0 15 0 6 0 16 0 6 0 17 0 6 0 18 0 6 0 19 0 6 0 20 0 15 0 21 0 6 0 23 0 6 0 24 0 6 0 25 0 6 0 26 0 6 0 27 1 1 0 34 0 33 0 35 0 37 0 36 0 41 0 37 0 45 0 38 0 49 0 39 0 53 0 57 0 57 0 58 0 115 0 74] 
#[0 1 18 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 0 229 0 26 0 229 0 27 1 113 0 44 1 113 0 45 1 117 0 52 1 113 0 59 0 189 0 60 1 113 0 63 1 113 0 64 1 113 0 65 1 113 0 66 1 113 0 68 1 113 0 69 1 113 0 70 0 221 0 71 1 113 0 72 0 229 0 73] 
#[0 1 22 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 121 0 21] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 0 119 0 21 0 229 0 26 0 229 0 27 1 129 0 44 1 129 0 45 1 129 0 50 1 129 0 51 1 133 0 58 1 129 0 59 0 189 0 60 1 129 0 63 1 129 0 64 1 129 0 65 1 129 0 66 1 129 0 68 1 129 0 69 1 129 0 70 0 221 0 71 1 129 0 72 0 229 0 73] 
#[0 1 30 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 34 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[1 1 38 0 3 1 38 0 4 1 38 0 5 1 38 0 8 1 38 0 11 1 38 0 12 1 38 0 13 1 38 0 14 1 38 0 15 1 38 0 16 1 38 0 17 1 38 0 18 1 38 0 19 1 38 0 20 0 123 0 21 1 38 0 23 1 38 0 24 1 38 0 25 1 38 0 26 1 38 0 27 1 38 0 74] 
#[0 1 42 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 141 0 24] 
#[0 1 145 0 1] 
#[0 1 149 0 22] 
#[0 1 46 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 153 0 21 0 229 0 26 0 229 0 27 1 157 0 44 1 157 0 45 1 157 0 59 0 189 0 60 1 157 0 63 1 157 0 64 1 157 0 65 1 157 0 66 1 157 0 68 1 157 0 69 1 157 0 70 0 221 0 71 1 157 0 72 0 229 0 73] 
#[0 1 161 0 21] 
#[1 0 51 0 3 0 55 0 4 0 59 0 5 0 63 0 8 0 67 0 11 0 71 0 12 0 75 0 13 0 79 0 14 0 83 0 15 0 87 0 16 0 91 0 17 0 95 0 18 0 99 0 19 0 14 0 21 0 107 0 26 0 111 0 27 1 113 0 44 1 113 0 45 1 165 0 52 1 113 0 59 0 189 0 60 1 113 0 63 1 113 0 64 1 113 0 65 1 113 0 66 1 113 0 68 1 113 0 69 1 113 0 70 0 221 0 71 1 113 0 72 0 229 0 73] 
#[0 1 50 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 169 0 21 0 229 0 26 0 229 0 27 1 177 0 44 1 177 0 45 1 173 0 49 1 177 0 50 1 177 0 51 1 177 0 59 0 189 0 60 1 177 0 63 1 177 0 64 1 177 0 65 1 177 0 66 1 177 0 68 1 177 0 69 1 177 0 70 0 221 0 71 1 177 0 72 0 229 0 73] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 0 229 0 26 0 229 0 27 1 113 0 44 1 113 0 45 1 181 0 52 1 113 0 59 0 189 0 60 1 113 0 63 1 113 0 64 1 113 0 65 1 113 0 66 1 113 0 68 1 113 0 69 1 113 0 70 0 221 0 71 1 113 0 72 0 229 0 73] 
#[0 1 54 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 1 58 0 15 1 185 0 62] 
#[0 1 189 0 6] 
#[1 1 62 0 3 1 62 0 4 1 62 0 5 1 62 0 8 1 62 0 11 1 62 0 12 1 62 0 13 1 62 0 14 1 62 0 15 1 62 0 16 1 62 0 17 1 62 0 18 1 62 0 19 0 127 0 21 1 62 0 26 1 62 0 27] 
#[0 1 66 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 70 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 197 0 21 0 229 0 26 0 229 0 27 1 157 0 44 1 157 0 45 1 157 0 59 0 189 0 60 1 157 0 63 1 157 0 64 1 157 0 65 1 157 0 66 1 157 0 68 1 157 0 69 1 157 0 70 0 221 0 71 1 157 0 72 0 229 0 73] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 0 229 0 26 0 229 0 27 1 113 0 44 1 113 0 45 1 165 0 52 1 113 0 59 0 189 0 60 1 113 0 63 1 113 0 64 1 113 0 65 1 113 0 66 1 113 0 68 1 113 0 69 1 113 0 70 0 221 0 71 1 113 0 72 0 229 0 73] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 0 131 0 21 0 229 0 26 0 229 0 27 1 201 0 44 1 201 0 45 1 201 0 50 1 201 0 51 1 201 0 59 0 189 0 60 1 201 0 63 1 201 0 64 1 201 0 65 1 201 0 66 1 201 0 68 1 201 0 69 1 201 0 70 0 221 0 71 1 201 0 72 0 229 0 73] 
#[0 1 78 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[1 0 85 0 3 0 19 0 4 0 229 0 5 0 97 0 8 0 101 0 11 0 229 0 12 0 109 0 13 0 113 0 14 0 229 0 15 0 38 0 16 0 229 0 17 0 229 0 18 0 229 0 19 1 205 0 21 0 229 0 26 0 229 0 27 1 157 0 44 1 157 0 45 1 157 0 59 0 189 0 60 1 157 0 63 1 157 0 64 1 157 0 65 1 157 0 66 1 157 0 68 1 157 0 69 1 157 0 70 0 221 0 71 1 157 0 72 0 229 0 73] 
#[0 1 209 0 15] 
#[0 1 82 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74] 
#[0 1 86 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 62 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 90 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 21 0 26 0 27] 
#[0 1 193 0 21] 
#[0 1 213 0 17] 
#[0 1 94 0 3 0 4 0 5 0 8 0 11 0 12 0 13 0 14 0 15 0 16 0 17 0 18 0 19 0 20 0 21 0 23 0 24 0 25 0 26 0 27 0 74]
	).
]

{ #category : #parsing }
LeParser >> handleEmbeddedError: aSmaCCParserError [
	| errorNode |
	errorNode := SmaCCErrorNode new
		stackContents: aSmaCCParserError parser nodeStack copy;
		dismissedTokens: #();
		visitorTrait: TLeAnnotationParseNodeVisitor.
	(aSmaCCParserError parser currentToken value beginsWith: '}')
		ifTrue: [ self
				position: aSmaCCParserError parser currentToken startPosition - 1.
			errorNode
				errorToken:
					(SmaCCToken
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
	result := LeCustomAnnotationNode new.
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
				and:
					[ ('{}' includes: (ch := stream next)) not and: [ ch isLineBreak not ] ] ] ]
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
						ifNotEmpty:
							[ :str | tokens add: (SmaCCToken value: str start: start + 1 ids: #()) ].
					('|=' includes: ch)
						ifTrue: [ tokens
								add: (SmaCCToken value: (String with: ch) start: stream position ids: #()) ].
					ch = $}
						ifTrue: [ stream position: stream position - 1 ] ].
			self position: stream position.
			aNode isErrorNode
				ifTrue: [ aNode dismissedTokens: aNode dismissedTokens , tokens ]
				ifFalse: [ ^ SmaCCErrorNode new
						stackContents: {aNode};
						dismissedTokens: tokens;
						visitorTrait: TLeAnnotationParseNodeVisitor;
						errorToken: (SmaCCToken value: '' start: stream position + 1 ids: #()) ] ].
	^ aNode
]

{ #category : #testing }
LeParser >> tryAllTokens [
	^ true
]
