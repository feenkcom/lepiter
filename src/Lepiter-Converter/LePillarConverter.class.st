"
Convert the supplied Pillar formatted string to the equivalent Lepiter formatted string.

Limitations:

- The entire pillar string is considered to be a single lepiter text snippet.
- As there is no context to resolve file names, these URLs are left unchanged.

Subclasses provide the additional context to address both the limitations above.
"
Class {
	#name : #LePillarConverter,
	#superclass : #PRVisitor,
	#instVars : [
		'outStream',
		'source',
		'stack'
	],
	#category : #'Lepiter-Converter'
}

{ #category : #accessing }
LePillarConverter class >> convert: aString [
	^ self new
		source: aString;
		visit: (GtDocumenterParser new parse: aString);
		newSource
]

{ #category : #visiting }
LePillarConverter >> initialize [

	super initialize.
	outStream := String new writeStream.
	stack := Stack new.

]

{ #category : #accessing }
LePillarConverter >> newSource [
	^ outStream contents
]

{ #category : #accessing }
LePillarConverter >> source [
	^ source
]

{ #category : #accessing }
LePillarConverter >> source: aString [

	source := aString
]

{ #category : #'visiting-document' }
LePillarConverter >> visitAnnotatedParagraph: aPRAnnotatedParagraph [

	outStream
		<< '[[';
		<< aPRAnnotatedParagraph annotation asUppercase;
		<< ']] '.
	super visitAnnotatedParagraph: aPRAnnotatedParagraph.
	
]

{ #category : #'visiting-annotations' }
LePillarConverter >> visitAnnotation: anAnnotation [
	| annotation |

	annotation := source copyFrom: anAnnotation start + 2 to: anAnnotation stop - 2.
	annotation at: 1 put: annotation first asUppercase.
	outStream
		<< '{{gt';
		<< annotation;
		<< '}}'.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitBoldFormat: anObject [

	outStream nextPutAll: '**'.
	super visitBoldFormat: anObject.
	outStream nextPutAll: '**'.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitCodeblock: aCodeBlock [
	| position |

	position := aCodeBlock stop.
	[ (source at: position) isLineBreak ]
		whileTrue: [ position := position - 1 ].
	outStream 
		<< '```';
		<< (source copyFrom: aCodeBlock start + 3 to: position - 3);
		<< '```'; cr.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitExternalLink: anObject [

	anObject hasChildren ifTrue: 
		[ outStream << '['.
		super visitExternalLink: anObject.
		outStream 
			<< '](';
			<< (source copyFrom: anObject children last stop + 2 to: anObject stop - 1);
			<< ')' ]
	ifFalse: 
		[ outStream
			<< '<';
			<< (source copyFrom: anObject start + 1 to: anObject stop - 1);
			<< '>'  ].

]

{ #category : #'visiting-document' }
LePillarConverter >> visitFigure: aPRFigure [


	outStream << '!['.
	super visitFigure: aPRFigure.
	outStream 
		<< '](';
		<< (source copyFrom: aPRFigure children last stop + 2 to: aPRFigure stop - 1);
		<< ')'.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitHeader: aPRHeader [

	aPRHeader level timesRepeat: 
		[ outStream nextPut: $# ].
	outStream nextPut: Character space.
	super visitHeader: aPRHeader.
	outStream cr.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitItalicFormat: anObject [

	outStream nextPut: $*.
	super visitItalicFormat: anObject.
	outStream nextPut: $*.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitLineBreak: aPRLineBreak [

	outStream cr.
]

{ #category : #'visiting-document' }
LePillarConverter >> visitList: anObject [

	stack push: 1.
	super visitList: anObject.
	stack pop.
]

{ #category : #'visiting-document' }
LePillarConverter >> visitListItem: aPRListItem [
	| start number leader |

	start := aPRListItem start.
	leader := (source at: start) = $# ifTrue: 
		[ number := stack pop.
		stack push: number + 1.
		number asString, '. ' ]
	ifFalse: 
		[ '- ' ].
	outStream << leader.
	super visitListItem: aPRListItem.
	outStream cr.
]

{ #category : #'visiting-document' }
LePillarConverter >> visitMonospaceFormat: anObject [

	outStream nextPut: $`.
	super visitMonospaceFormat: anObject.
	outStream nextPut: $`.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitParagraph: anObject [

	super visitParagraph: anObject.
	outStream cr.

]

{ #category : #'visiting-document' }
LePillarConverter >> visitText: aPRText [

	outStream nextPutAll: aPRText text
]
