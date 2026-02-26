"
Examples for gtFileReference completion visitor.
"
Class {
	#name : #LeFileReferenceAnnotationCompletionVisitorExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-FileReference'
}

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferenceAtStart [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions position |
	aString := '{{gtFileReference:}}'.
	position := (aString indexOf: $:) + 1.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: actions size equals: 5.
	self assert: (actions collect: #text) asSet equals: (Set with: 'path=' with: 'label=' with: 'range=' with: 'expanded=' with: 'height=').

	^ aResult
]

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferenceAttributes [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy anAst anAnnotation position actions |
	aString := '{{gtFileReference:path=/tmp/readme.md|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LeFileReferenceAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: actions size equals: 4.
	self assert: (actions collect: #text) asSet equals: (Set with: 'label=' with: 'range=' with: 'expanded=' with: 'height=').

	^ aResult
]

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferenceLabelOnly [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions anAst anAnnotation position |
	aString := '{{gtFileReference:path=/tmp/readme.md|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LeFileReferenceAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: actions size equals: 4.
	self assert: (actions collect: #text) asSet equals: (Set with: 'label=' with: 'range=' with: 'expanded=' with: 'height=').

	^ aResult
]

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferenceNoSuggestions [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions anAst anAnnotation position |
	aString := '{{gtFileReference:path=/tmp/readme.md|label=Readme|range=1:2|expanded=true|height=200|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LeFileReferenceAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: actions isEmpty.

	^ aResult
]

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferencePathCompletion [
	<gtExample>
	<return: #GtCompletionResult>
	| base fileName dirName prefix aString position aResult aStrategy actions start displayTexts |
	fileName := 'alpha.txt'.
	dirName := 'gtFileReferenceCompletionExample'.
	base := FileSystem disk workingDirectory / dirName.
	[ 
		base ensureCreateDirectory.
		(base / fileName) writeStreamDo: [ :stream | stream nextPutAll: 'ok' ].

		prefix := dirName , '/a'.
		aString := '{{gtFileReference:path=' , prefix , '}}'.
		start := aString findString: prefix startingAt: 1.
		position := start + prefix size - 1.

		aStrategy := LeCompletionStrategy new.
		aResult := aStrategy completionResultFor: aString at: position requested: true.

		actions := OrderedCollection new.
		aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

		self assert: ((actions collect: #text) asSet includes: 'lpha.txt').

		displayTexts := actions collect: [ :each | each displayText asString ].
		self assert: (displayTexts asSet includes: dirName , '/' , fileName).
		^ aResult ]
		ensure: [
			(base / fileName) exists ifTrue: [ (base / fileName) delete ].
			base exists ifTrue: [ base delete ] ]
]

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferencePathCompletionFiltersWithFullPrefix [
	<gtExample>
	<return: #GtCompletionResult>
	| base fileNameA fileNameB dirName prefix aString position aResult aStrategy actions start displayTexts texts |
	fileNameA := 'alpha.txt'.
	fileNameB := 'alps.txt'.
	dirName := 'gtFileReferenceCompletionFilterExample'.
	base := FileSystem disk workingDirectory / dirName.
	[ 
		base ensureCreateDirectory.
		(base / fileNameA) writeStreamDo: [ :stream | stream nextPutAll: 'ok' ].
		(base / fileNameB) writeStreamDo: [ :stream | stream nextPutAll: 'ok' ].

		prefix := dirName , '/alps'.
		aString := '{{gtFileReference:path=' , prefix , '}}'.
		start := aString findString: prefix startingAt: 1.
		position := start + prefix size - 1.

		aStrategy := LeCompletionStrategy new.
		aResult := aStrategy completionResultFor: aString at: position requested: true.

		actions := OrderedCollection new.
		aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

		self assert: actions size equals: 1.
		texts := actions collect: #text.
		displayTexts := actions collect: [ :each | each displayText asString ].
		self assert: (texts asSet includes: '.txt').
		self assert: (displayTexts asSet includes: dirName , '/' , fileNameB).
		self assert: (displayTexts asSet includes: dirName , '/' , fileNameA) not.
		^ aResult ]
		ensure: [
			(base / fileNameA) exists ifTrue: [ (base / fileNameA) delete ].
			(base / fileNameB) exists ifTrue: [ (base / fileNameB) delete ].
			base exists ifTrue: [ base delete ] ]
]

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferencePathCompletionIncludesAttributePrefix [
	<gtExample>
	<return: #GtCompletionResult>
	| base fileName prefix aString position aResult aStrategy actions start texts displayTexts |
	fileName := 'label-gtfilecompletion.txt'.
	base := FileSystem disk workingDirectory.
	[ 
		(base / fileName) writeStreamDo: [ :stream | stream nextPutAll: 'ok' ].

		prefix := 'la'.
		aString := '{{gtFileReference:path=' , prefix , '}}'.
		start := aString findString: prefix startingAt: 1.
		position := start + prefix size - 1.

		aStrategy := LeCompletionStrategy new.
		aResult := aStrategy completionResultFor: aString at: position requested: true.

		actions := OrderedCollection new.
		aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

		texts := actions collect: #text.
		displayTexts := actions collect: [ :each | each displayText asString ].
		self assert: (texts asSet includes: 'bel=').
		self assert: (texts asSet includes: 'bel-gtfilecompletion.txt').
		self assert: (displayTexts asSet includes: 'label=').
		self assert: (displayTexts asSet includes: fileName).
		^ aResult ]
		ensure: [
			(base / fileName) exists ifTrue: [ (base / fileName) delete ] ]
]

{ #category : #examples }
LeFileReferenceAnnotationCompletionVisitorExamples >> completeFileReferencePathOnlySuggestion [
	<gtExample>
	<return: #GtCompletionResult>
	| aString aResult aStrategy actions anAst anAnnotation position |
	aString := '{{gtFileReference:label=Readme|}}'.
	anAst := LeParser parse: aString.
	anAnnotation := (anAst // LeFileReferenceAnnotationNode) anyOne.
	position := anAnnotation bars last stopPosition.
	
	aStrategy := LeCompletionStrategy new.
	aResult := aStrategy completionResultFor: aString at: position requested: true.

	actions := OrderedCollection new.
	aResult completionActionsWithIndexDo: [ :each :index | actions add: each ].

	self assert: actions size equals: 4.
	self assert: (actions collect: #text) asSet equals: (Set with: 'path=' with: 'range=' with: 'expanded=' with: 'height=').

	^ aResult
]
