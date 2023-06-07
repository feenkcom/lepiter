Extension { #name : #LeHtmlVisitor }

{ #category : #'*Lepiter-Snippet-Example' }
LeHtmlVisitor >> visitExampleSnippet: aLeExampleSnippet [

	| snippetResources |
	
	snippetResources := self resourcesFor: aLeExampleSnippet.
	
	context html
		tag: #div
		do: [
		
			aLeExampleSnippet noCode ifFalse: [ 
				snippetResources
					ifEmpty: [ "ignore" ]
					ifOne: [ :aResource | 
						self writeExampleSourceCode: aLeExampleSnippet. ]
					ifMore: [ :aCollection |
						self writeExampleSourceCode: aLeExampleSnippet. ] ].
	
			snippetResources 
				ifEmpty: [ "ignore" ]
				ifOne: [ :aResource |
					| aFileName |
					aFileName := aResource pathName.
					LeHtmlFigureImageWriter new
						html: context html;
						imageSrc: aFileName;
						caption: nil;
						write ]
				ifMore: [ :aCollection |
					LeHtmlCarouselWriter new
						html: context html;
						sequencer: context sequencer;
						resources: aCollection;
						write ].

		self visitContent: aLeExampleSnippet ].
		
	^ aLeExampleSnippet
]

{ #category : #'*Lepiter-Snippet-Example' }
LeHtmlVisitor >> writeExampleSourceCode: aLeExampleSnippet [

	context html 
		tag: #div
		attributes: #('class' 'snippet textual-snippet code-snippet pharo-snippet documentWidth')
		do: [ 
			context html 
				tag: #pre
				attributes: #('class' 'no_bottom_margin') 
				do: [
					context html
						escape: aLeExampleSnippet referencedExample sourceCode asString
				]
		].
]
