"
Markdown export state. Shares the format-neutral resource pipeline with HTML, not its rendering context.
"
Class {
	#name : #LeMarkdownContext,
	#superclass : #LeExportContext,
	#instVars : [
		'page',
		'pageLinks'
	],
	#category : #'Lepiter-Markdown-Core'
}

{ #category : #accessing }
LeMarkdownContext >> page [
	^ page
]

{ #category : #accessing }
LeMarkdownContext >> page: anObject [
	page := anObject
]

{ #category : #accessing }
LeMarkdownContext >> pageLinks [
	^ pageLinks
		ifNil: [ pageLinks := LeExportPageLinksBuilder new
					pages: {page};
					mainPage: page;
					sequencer: self sequencer;
					fileExtension: 'md';
					build;
					links ]
]

{ #category : #accessing }
LeMarkdownContext >> pageLinks: anObject [
	pageLinks := anObject
]
