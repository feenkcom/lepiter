"
Domain object representing a file reference annotation with resolved file reference and optional range interval.
"
Class {
	#name : #LeFileReference,
	#superclass : #Object,
	#instVars : [
		'fileReference',
		'range'
	],
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #'instance creation' }
LeFileReference class >> for: aFileReference range: anInterval [
	^ self new
		fileReference: aFileReference;
		range: anInterval;
		yourself
]

{ #category : #'instance creation' }
LeFileReference class >> fromAnnotation: anAnnotation inPage: aPage [
	| pathString fileReference rangeStart rangeEnd interval |
	pathString := anAnnotation pathString ifNil: [ ^ nil ].
	fileReference := pathString asFileReference.
	fileReference isAbsolute ifFalse: [
		(aPage notNil and: [ aPage pageFileReference notNil ]) ifTrue: [
			fileReference := aPage pageFileReference parent resolveReference: fileReference ] ].
	rangeStart := anAnnotation rangeStart.
	rangeEnd := anAnnotation rangeEnd.
	interval := (rangeStart notNil and: [ rangeEnd notNil ])
		ifTrue: [ rangeStart to: rangeEnd ]
		ifFalse: [ nil ].
	^ self for: fileReference range: interval
]

{ #category : #private }
LeFileReference >> applyRange: anInterval toEditor: anEditor [
	| lines start end |
	lines := (self fileReference contents) lines.
	start := anInterval first max: 1.
	end := anInterval last min: lines size.
	start > end ifTrue: [ ^ self ].

	"This is a conservative approach: show only the range text."
	anEditor text: (String streamContents: [ :s |
		(lines copyFrom: start to: end)
			do: [ :line | s nextPutAll: line; lf ] ]).
]

{ #category : #accessing }
LeFileReference >> fileReference [
	^ fileReference
]

{ #category : #accessing }
LeFileReference >> fileReference: aFileReference [
	fileReference := aFileReference
]

{ #category : #'gt-views' }
LeFileReference >> gtLiveDirectoryFor: aView [
	^ aView list
		title: 'Contents';
		items: [ (self fileReference children
			asSortedCollection: [ :a :b | a basename <= b basename ]) asArray ];
		itemText: [ :each | each basename ]
]

{ #category : #'gt-views' }
LeFileReference >> gtLiveFileFor: aView [
	| editor |
	editor := aView textEditor
		title: self fileReference basename;
		text: [ self fileReference contents ];
		yourself.

	self range ifNotNil: [ :interval |
		self applyRange: interval toEditor: editor ].

	^ editor
]

{ #category : #'gt-views' }
LeFileReference >> gtLiveFor: aView [
	<gtView>
	^ self fileReference isDirectory
		ifTrue: [ self gtLiveDirectoryFor: aView ]
		ifFalse: [ self gtLiveFileFor: aView ]
]

{ #category : #accessing }
LeFileReference >> range [
	^ range
]

{ #category : #accessing }
LeFileReference >> range: anInterval [
	range := anInterval
]
