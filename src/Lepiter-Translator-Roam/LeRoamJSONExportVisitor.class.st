Class {
	#name : #LeRoamJSONExportVisitor,
	#superclass : #LeContentNodeVisitor,
	#category : #'Lepiter-Translator-Roam-Core'
}

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitElementSnippet: aSnippet [
	^ String streamContents: [ :stream |
		stream 
			<< '```smalltalk'; cr;
			<< aSnippet code; cr;
			<< '```' ]
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitGitHubIssueSnippet: aSnippet [
	^ aSnippet contentAsString
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitGitHubSnippet: aSnippet [
	^ aSnippet contentAsString
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitJavaScriptSnippet: aSnippet [
	"Code snippets are converted to fenced code blocks with smalltalk language."

	^ String streamContents: [ :stream |
		stream 
			<< '```javascript'; cr;
			<< aSnippet code; cr;
			<< '```' ]
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitPharoSnippet: aSnippet [
	"Code snippets are converted to fenced code blocks with smalltalk language."
	
	^ String streamContents: [ :stream |
		stream 
			<< '```smalltalk'; cr;
			<< aSnippet code; cr;
			<< '```' ]
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitPictureSnippet: aSnippet [
	^ aSnippet urlString 
		ifEmpty: [ '' ]
		ifNotEmpty: [ '![](', aSnippet urlString, ')' ]
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitPythonSnippet: aSnippet [
	^ String streamContents: [ :stream |
		stream 
			<< '```python'; cr;
			<< aSnippet code; cr;
			<< '```' ]
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitSnippet: aSnippet [
	^ ''
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitSparqlSnippet: aSnippet [
	^ String streamContents: [ :stream |
		stream 
			<< '```sparql'; cr;
			<< aSnippet code; cr;
			<< '```' ] 
]

{ #category : #accessing }
LeRoamJSONExportVisitor >> visitTextSnippet: aSnippet [
	^ aSnippet string
]
