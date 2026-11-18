"
Lepiter styling for standalone Markdown files. Resolves relative images against an explicit directory without creating a synthetic database or monitor.
"
Class {
	#name : #LeLocalFileSnippetStyler,
	#superclass : #LeSnippetStyler,
	#instVars : [
		'rootDirectory'
	],
	#category : #'Lepiter-UI-Snippet-Text styler'
}

{ #category : #accessing }
LeLocalFileSnippetStyler >> imageRootDirectory [
	^ rootDirectory ifNil: [ super imageRootDirectory ]
]

{ #category : #accessing }
LeLocalFileSnippetStyler >> rootDirectory: aDirectory [
	rootDirectory := aDirectory
]
