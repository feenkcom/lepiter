Class {
	#name : #LePharoRewriteSnippetExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Lepiter-Snippet-Pharo-Rewrites'
}

{ #category : #'examples - rewrites' }
LePharoRewriteSnippetExamples >> cancelExecuteRewrites [
	<gtExample>
	| scripter |
	scripter := self
			scripterWithModel: [ | page |
				page := LeModelExamples new pageOneFromDatabaseWithOnlyOnePage page.
				page
					addFirstSnippet: (LePharoRewriteSnippet new
							search: '`{:node :dict | false}';
							replace: 'should not be used';
							yourself).
				page ]
			element: [ :page | 
				GtPager
					createWrappedOn: (page asLepiterPagePhlowTool asElementDo: [ :anElement | anElement ]) ].
	scripter click
		// #replaceButton;
		playNoPulse.
	scripter
		clickStep: [ :s | 
			s
				label: 'Canceling';
				// #toolArea;
				// BrAsyncWidget;
				// BrButton ].
	scripter
		checkStep: [ :s | 
			s
				label: 'Has canceled';
				// #toolArea;
				// BrAsyncWidget;
				// #label;
				value: [ :each | each text asString ] equals: 'AsyncFutureCancelled' ].
	^ scripter
]

{ #category : #'examples - rewrites' }
LePharoRewriteSnippetExamples >> executeRewrites [
	<gtExample>
	| scripter |
	scripter := self scripterOnInitialExample.
	scripter clickStep: [ :s | s // #replaceButton ].
	scripter isNil ifTrue: [ self assert: false ].	"Here as something to be rewritten."
	scripter
		checkStep: [ :s | 
			s
				// GtChangesElement;
				do: [ :each | 
					| found selector className |
					found := false.
					selector := thisContext method selector.
					className := thisContext method methodClass name.
					self
						assert: (each changes gtAllChanges
								anySatisfy: [ :change | change selector = selector and: [ change changeClassName = className ] ]) ] ].
	^ scripter
]

{ #category : #'examples - search' }
LePharoRewriteSnippetExamples >> executeSearch [
	<gtExample>
	| scripter |
	scripter := self scripterOnInitialExample.
	scripter clickStep: [ :s | s // #searchButton ].
	scripter isNil ifTrue: [ self assert: false ].	"Here for something to be found."
	scripter
		doStep: [ :s | 
			s
				// GtPharoStreamingMethodsCoderElement;
				block: [ :each | each streamingCodersViewModel scrollToCompiledMethod: thisContext method method ] ].
	scripter
		checkStep: [ :s | 
			s
				exists;
				// GtExpandableMethodCoderElement;
				@ [ :each | each coderViewModel compiledMethod == thisContext method method ] ].
	^ scripter
]

{ #category : #examples }
LePharoRewriteSnippetExamples >> scripterOnInitialExample [
	<gtExample>
	| scripter |
	scripter := self
			scripterWithModel: [ | page |
				page := LeModelExamples new pageOneFromDatabaseWithOnlyOnePage page.
				page
					addFirstSnippet: (LePharoRewriteSnippet new
							search: '``@a isNil ifTrue: ``@b';
							replace: '``@a ifNil: ``@b';
							yourself).
				page ]
			element: [ :page | 
				GtPager
					createWrappedOn: (page asLepiterPagePhlowTool asElementDo: [ :anElement | anElement ]) ].
	scripter
		checkStep: [ :s | 
			s
				label: 'All methods selected';
				value: [ :each | each text asString ] equals: 'All Methods';
				// GtFilterTagLabelId ].
	^ scripter
]
