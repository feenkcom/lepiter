Trait {
	#name : #TLeHtmlPiece,
	#category : #'Lepiter-HTML-Piece - Model'
}

{ #category : #converting }
TLeHtmlPiece >> asLeHtmlFormatPiece [
	^ self
]

{ #category : #'gt - extensions' }
TLeHtmlPiece >> gtOutputFor: aView [
	<gtView>
	^ aView textEditor
		title: 'Output';
		priority: 20;
		aptitude: BrGlamorousCodeEditorAptitude;
		text: [ String streamContents: [ :aStream | 
			self writeWithContext: (LeHtmlContext new stream: aStream) ] ]
]

{ #category : #'api - writing' }
TLeHtmlPiece >> writeWithContext: aContext [
	self explicitRequirement
]
