Class {
	#name : #LePlainTextCoderSnippetElementWithRustTextEditorStencil,
	#superclass : #LePlainTextSnippetElementStencil,
	#category : #'Lepiter-Snippet-Text-Support'
}

{ #category : #'api - instantiation' }
LePlainTextCoderSnippetElementWithRustTextEditorStencil >> create [
	<return: #BlElement>
	^ self basicElement
		initializeEditorElement: (GtTextEditorElement new
				defaultFontName: 'Source Code Pro';
				defaultFontSize: 14;
				defaultForeground: Color black;
				in: [ :anEditor | anEditor privateEditorHandle enableInMemoryCommandsRecorder ];
				yourself)
]
