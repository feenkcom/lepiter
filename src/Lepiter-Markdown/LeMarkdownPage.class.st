"
A saved Markdown page with its companion files and exporter diagnostics. Options can retain a temporary directory for the lifetime of the inspected result.
"
Class {
	#name : #LeMarkdownPage,
	#superclass : #Object,
	#traits : 'TGtOptions',
	#classTraits : 'TGtOptions classTrait',
	#instVars : [
		'directory',
		'pageFile',
		'exporter'
	],
	#category : #'Lepiter-Markdown-Core'
}

{ #category : #accessing }
LeMarkdownPage >> directory [
	^ directory
]

{ #category : #accessing }
LeMarkdownPage >> directory: anObject [
	directory := anObject
]

{ #category : #accessing }
LeMarkdownPage >> exporter [
	^ exporter
]

{ #category : #accessing }
LeMarkdownPage >> exporter: anObject [
	exporter := anObject
]

{ #category : #views }
LeMarkdownPage >> gtDiagnosticsFor: aView [
	"Which source content could not be represented?"

	<gtView>
	exporter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Diagnostics';
		priority: 25;
		object: [ exporter ];
		view: #gtDiagnosticsFor:
]

{ #category : #views }
LeMarkdownPage >> gtMarkdownContentsFor: aView [
	"What exact Markdown source was written to disk?"

	<gtView>
	pageFile ifNil: [ ^ aView empty ].
	pageFile exists ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'Markdown contents';
		priority: 11;
		text: [ pageFile contents ]
]

{ #category : #views }
LeMarkdownPage >> gtMarkdownFor: aView [
	"How does the exported Markdown read, including local preview images?"

	<gtView>
	pageFile ifNil: [ ^ aView empty ].
	pageFile exists ifFalse: [ ^ aView empty ].
	^ aView textEditor
		title: 'Markdown';
		priority: 10;
		text: [ pageFile contents ];
		styler: [ LeLocalFileSnippetStyler new
				rootDirectory: pageFile parent;
				snippetViewModel: LeTextSnippet new asSnippetViewModel ]
]

{ #category : #views }
LeMarkdownPage >> gtOutputFilesFor: aView [
	"Which page and companion files were saved?"

	<gtView>
	directory ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Files';
		priority: 15;
		object: [ directory ];
		view: #gtTreeFor:
]

{ #category : #views }
LeMarkdownPage >> gtResourcesFor: aView [
	"Which resources were required or left optional?"

	<gtView>
	exporter ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Resources';
		priority: 20;
		object: [ exporter ];
		view: #gtResourcesFor:
]

{ #category : #accessing }
LeMarkdownPage >> log [
	^ exporter context log
]

{ #category : #accessing }
LeMarkdownPage >> pageFile [
	^ pageFile
]

{ #category : #accessing }
LeMarkdownPage >> pageFile: anObject [
	pageFile := anObject
]

{ #category : #accessing }
LeMarkdownPage >> resources [
	^ exporter context resources
]
