Class {
	#name : #LeSmaCCRewriteReplaceFileResult,
	#superclass : #Object,
	#instVars : [
		'file',
		'originalSource',
		'newSource',
		'parserClass'
	],
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Model'
}

{ #category : #views }
LeSmaCCRewriteReplaceFileResult >> asElement [
	| change styler |
	change := GtDiffBuilder
			computeDifferencesFrom: self originalSource
			to: self newSource
			using: (GtSmaCCDiffSplitter new scannerClass: self parserClass scannerClass).
	styler := self parserClass gtStyler.
	^ (GtDiffElementWithLabelStencil new
		fromLabelText: 'Original';
		toLabelText: 'New';
		change: change;
		styler: styler) create
]

{ #category : #views }
LeSmaCCRewriteReplaceFileResult >> asElementWithExpander [
	^ BrExpander new hMatchParent vFitContentLimited
		aptitude: GtCoderExpanderAptitude new;
		margin: (BlInsets all: 5);
		header: [ BrLabel new
				aptitude: BrGlamorousLabelAptitude;
				text: self file gtDisplayString ];
		content: [ BrVerticalPane new
				vFitContentLimited;
				hMatchParent;
				addChild: (BrLabel new
						aptitude: BrGlamorousLabelAptitude;
						text: self file gtDisplayString);
				addChild: (self asElement padding: (BlInsets top: 5)) ]
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> file [
	^ file
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> file: aFileReference [
	file := aFileReference
]

{ #category : #views }
LeSmaCCRewriteReplaceFileResult >> gtDiffFor: aView [
	<gtView>
	^ aView explicit
		title: 'Diff';
		stencil: [ self asElement ]
]

{ #category : #testing }
LeSmaCCRewriteReplaceFileResult >> hasChanges [
	^ newSource notNil and: [ newSource ~= originalSource ]
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> newSource [
	^ newSource ifNil: [ self originalSource ]
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> newSource: aString [
	newSource := aString
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> originalSource [
	^ originalSource
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> originalSource: aString [
	originalSource := aString
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> parserClass [
	^ parserClass
]

{ #category : #accessing }
LeSmaCCRewriteReplaceFileResult >> parserClass: aSmaCCParserClass [
	parserClass := aSmaCCParserClass
]
