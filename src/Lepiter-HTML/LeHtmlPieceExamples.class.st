Class {
	#name : #LeHtmlPieceExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Piece - Examples'
}

{ #category : #examples }
LeHtmlPieceExamples >> doubleBracketFormatOutput [
	^ '<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="author" content="feenk.com">
		<title>Template | Feenk</title>
		<style>body { margin: 1em }</style>
	</head>
	<body>
	<h1>Hello World</h1>
	</body>
</html>'
]

{ #category : #examples }
LeHtmlPieceExamples >> doubleBracketFormatTemplate [
	^ '<!DOCTYPE html>
<html lang="{{lang}}">
	<head>
		<meta charset="{{charset}}">
		<meta name="author" content="{{author}}">
		<title>{{title}}</title>
		<style>body { margin: 1em }</style>
	</head>
	<body>
	{{content}}
	</body>
</html>'
]

{ #category : #examples }
LeHtmlPieceExamples >> formatDoubleBracketPiece [
	<gtExample>
	<return: #LeHtmlDoubleBracketFormatPiece>
	| piece output |
	piece := LeHtmlDoubleBracketFormatPiece new
			at: #lang put: 'en';
			at: #charset put: 'UTF-8';
			at: #author put: 'feenk.com';
			at: #title put: 'Template | Feenk';
			at: #content put: self helloWorldPiece;
			template: self doubleBracketFormatTemplate.

	self assert: piece template equals: self doubleBracketFormatTemplate.
	self assert: piece arguments size equals: 5.

	output := String
			streamContents: [ :aStream | piece writeWithContext: (LeHtmlContext new stream: aStream) ].

	self assert: output equals: self doubleBracketFormatOutput.

	^ piece
]

{ #category : #examples }
LeHtmlPieceExamples >> formatOutput [
	^ '<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="author" content="feenk.com">
		<title>Template | Feenk</title>
	</head>
	<body>
	<h1>Hello World</h1>
	</body>
</html>'
]

{ #category : #examples }
LeHtmlPieceExamples >> formatPiece [
	<gtExample>
	<return: #LeHtmlFormatPiece>
	| piece output |
	piece := LeHtmlFormatPiece new
			at: #lang put: 'en';
			at: #charset put: 'UTF-8';
			at: #author put: 'feenk.com';
			at: #title put: 'Template | Feenk';
			at: #content put: self helloWorldPiece;
			template: self formatTemplate.

	self assert: piece template equals: self formatTemplate.
	self assert: piece arguments size equals: 5.

	output := String
			streamContents: [ :aStream | piece writeWithContext: (LeHtmlContext new stream: aStream) ].

	self assert: output equals: self formatOutput.

	^ piece
]

{ #category : #examples }
LeHtmlPieceExamples >> formatPieceWithCurlyBrackets [
	<gtExample>
	<return: #LeHtmlDoubleBracketFormatPiece>
	| piece output |
	piece := LeHtmlDoubleBracketFormatPiece new
			at: #'test}test' put: 'test';
			template: 'hello, {{test}test}}!'.

	output := String
			streamContents: [ :aStream | piece writeWithContext: (LeHtmlContext new stream: aStream) ].

	self assert: output equals: 'hello, test!'.

	^ piece
]

{ #category : #examples }
LeHtmlPieceExamples >> formatTemplate [
	^ '<!DOCTYPE html>
<html lang="{lang}">
	<head>
		<meta charset="{charset}">
		<meta name="author" content="{author}">
		<title>{title}</title>
	</head>
	<body>
	{content}
	</body>
</html>'
]

{ #category : #examples }
LeHtmlPieceExamples >> helloWorldPiece [
	<gtExample>
	<return: #LeHtmlHelloWorldPiece>
	^ LeHtmlHelloWorldPiece new
]
