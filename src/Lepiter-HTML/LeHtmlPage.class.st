Class {
	#name : #LeHtmlPage,
	#superclass : #Object,
	#traits : 'TGtOptions',
	#classTraits : 'TGtOptions classTrait',
	#instVars : [
		'directory',
		'pageFile',
		'resources',
		'log'
	],
	#category : #'Lepiter-HTML-! Core'
}

{ #category : #accessing }
LeHtmlPage >> directory [
	^ directory
]

{ #category : #accessing }
LeHtmlPage >> directory: anObject [
	directory := anObject
]

{ #category : #'gt - extensions' }
LeHtmlPage >> gtActionWebBrowseFor: anAction [
	<gtAction>
	self directory exists ifFalse: [ ^ anAction noAction ].

	^ anAction button
		priority: 5;
		icon: BrGlamorousIcons go;
		tooltip: 'Open in OS';
		action: [ WebBrowser openOn: self directory fullName ]
]

{ #category : #'gt - extensions' }
LeHtmlPage >> gtOpenInWebBrowserFor: anAction [
	<gtAction>
	pageFile ifNil: [ ^ anAction noAction ].
	pageFile exists ifFalse: [ ^ anAction noAction ].

	^ anAction button
		label: 'Web browser';
		priority: 1;
		action: [ :aButton | WebBrowser openOn: pageFile fullName ]
]

{ #category : #'gt - extensions' }
LeHtmlPage >> gtOutputFilesFor: aView [
	<gtView>
	directory ifNil: [ ^ aView empty ].

	^ aView forward
		title: 'Files';
		priority: 15;
		object: [ self directory ];
		view: #gtTreeFor:
]

{ #category : #accessing }
LeHtmlPage >> log [
	^ log
]

{ #category : #accessing }
LeHtmlPage >> log: anObject [
	log := anObject
]

{ #category : #accessing }
LeHtmlPage >> pageFile [
	^ pageFile
]

{ #category : #accessing }
LeHtmlPage >> pageFile: anObject [
	pageFile := anObject
]

{ #category : #accessing }
LeHtmlPage >> resources [
	^ resources
]

{ #category : #accessing }
LeHtmlPage >> resources: anObject [
	resources := anObject
]
