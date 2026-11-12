Class {
	#name : #LePharoRewriteResultExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Pharo-Rewrites-Examples'
}

{ #category : #examples }
LePharoRewriteResultExamples >> changesAndErrors [
	<gtExample>
	| result error method |
	method := self class >> #rewriteCascadeFailure:.
	result := self
			rewriteMethods: #(rewriteCascadeFailure: rewriteSuccess: rewriteSuccessAfter:).
	self assert: result errors size equals: 1.
	self assert: result changes gtAllChanges size equals: 2.
	self
		assert: (result changes gtAllChanges
				noneSatisfy: [ :each | each selector = #rewriteCascadeFailure: ]).
	self assert: result errors first key == method.
	error := result errors first value.
	self assert: error class equals: GtParseTreeRewriteError.
	self assert: error node methodNode == method ast.
	self assert: error originalSource equals: method sourceCode.
	self assert: error highlightedSourceText asString equals: method sourceCode.
	self assert: (result gtErrorsFor: GtPhlowView empty) class ~= GtPhlowEmptyView.
	^ result
]

{ #category : #examples }
LePharoRewriteResultExamples >> changesWithoutErrors [
	<gtExample>
	| result |
	result := self rewriteMethods: #(rewriteSuccess: rewriteSuccessAfter:).
	self assert: result class equals: LePharoRewriteResult.
	self assert: result errors isEmpty.
	self assert: result changes gtAllChanges size equals: 2.
	self
		assert: (result gtErrorsFor: GtPhlowView empty) class
		equals: GtPhlowEmptyView.
	^ result
]

{ #category : #examples }
LePharoRewriteResultExamples >> errorDetailsView [
	<gtExample>
	| error view element |
	error := GtParseTreeRewriterExamples new replacementCodeError.
	view := error gtDetailsFor: GtPhlowView empty.
	view asElementDo: [ :each | element := each ].
	self assert: element isNotNil.
	self assert: error originalError isNotNil.
	^ element
]

{ #category : #examples }
LePharoRewriteResultExamples >> errorSourceView [
	<gtExample>
	| error view element |
	error := self errorsWithoutChanges errors first value.
	view := error gtSourceFor: GtPhlowView empty.
	view asElementDo: [ :each | element := each ].
	self assert: element isNotNil.
	^ element
]

{ #category : #examples }
LePharoRewriteResultExamples >> errorsViewSelectsActualError [
	<gtExample>
	| result container list scripter selected view |
	result := self errorsWithoutChanges.
	view := result gtErrorsFor: GtPhlowView empty.
	self
		assert: (view columns collect: [ :each | each title ]) asArray
		equals: #('Method' 'Error').
	view asElementDo: [ :each | container := each ].
	scripter := BlScripter new element: container.
	list := (container query // GtPhlowColumnedListId) anyOne.
	list
		addEventHandlerOn: GtPhlowObjectToSelect
		do: [ :event | selected := event object ].
	list selectOne: 1.
	scripter pulseUntilReady.
	self assert: selected == result errors first value.
	^ scripter
]

{ #category : #examples }
LePharoRewriteResultExamples >> errorsWithoutChanges [
	<gtExample>
	| result |
	result := self rewriteMethods: #(rewriteCascadeFailure:).
	self assert: result errors size equals: 1.
	self assert: result changes gtAllChanges isEmpty.
	^ result
]

{ #category : #examples }
LePharoRewriteResultExamples >> matchingFailure [
	<gtExample>
	| snippet filter result |
	snippet := LePharoRewriteSnippet new
			search: '`{:node :dict | 1 / 0}';
			replace: '1';
			yourself.
	filter := GtSearchFixedMethodsFilter new
			methods: {self class >> #rewriteSuccess:};
			yourself.
	result := (snippet executeRewriteInFilter: filter) wait.
	self assert: result errors size equals: 1.
	self assert: result errors first value originalError class equals: ZeroDivide.
	self assert: result changes gtAllChanges isEmpty.
	^ result
]

{ #category : #examples }
LePharoRewriteResultExamples >> methodPatternRewrite [
	<gtExample>
	| snippet filter result |
	snippet := LePharoRewriteSnippet new
			isMethodPattern: true;
			search: 'rewriteSuccess: aStream ^ aStream print: self';
			replace: 'rewriteSuccess: aStream ^ self printOn: aStream';
			yourself.
	filter := GtSearchFixedMethodsFilter new
			methods: {self class >> #rewriteSuccess:};
			yourself.
	result := (snippet executeRewriteInFilter: filter) wait.
	self assert: result errors isEmpty.
	self assert: result changes gtAllChanges size equals: 1.
	^ result
]

{ #category : #fixtures }
LePharoRewriteResultExamples >> rewriteCascadeFailure: aStream [
	aStream
		cr;
		print: self
]

{ #category : #helpers }
LePharoRewriteResultExamples >> rewriteMethods: selectors [
	| snippet filter |
	snippet := LePharoRewriteSnippet new
			search: '``@receiver print: ``@object';
			replace: '``@object printOn: ``@receiver';
			yourself.
	filter := GtSearchFixedMethodsFilter new
			methods: (selectors collect: [ :selector | self class >> selector ]);
			yourself.
	^ (snippet executeRewriteInFilter: filter) wait
]

{ #category : #fixtures }
LePharoRewriteResultExamples >> rewriteSuccess: aStream [
	^ aStream print: self
]

{ #category : #fixtures }
LePharoRewriteResultExamples >> rewriteSuccessAfter: aStream [
	^ aStream print: self
]
