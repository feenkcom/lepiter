Class {
	#name : #LePharoSnippetByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #'examples - rename variable' }
LePharoSnippetByScripterExamples >> applyNewNameWithScripter: aScripter [
	<gtExample>
	aScripter
		substep: 'Apply rename'
		do: [ :aStep | (aStep keyPress: BlKeyboardKey return) play ]
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> assertBindingsIn: aStep [
	aStep
		checkStep: [ :s | 
			s
				label: 'Check pharo snippet variable values';
				do: [ :aList :aData | 
					| allBindings aValue |
					allBindings := (aList query // LePharoSnippetElement
							// GtSourceCoderEditorElement) result
							collect: [ :eachCoder | eachCoder textualCoderViewModel compositeVariableBindings asDictionary ].
					aValue := aData at: #scriptExecutionResult.
					self assert: aValue value equals: {42}.
					self
						assert: (allBindings
								allSatisfy: [ :eachDictionary | (eachDictionary at: #a) value == aValue ]) ];
				onBreadthFirstChildOfClass: BrSimpleTree;
				onBreadthFirstChildOfClass: BrInfiniteTreeElement ].

	^ aStep
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> assertPharoSnippetElementContentIn: aStep [
	<gtExample>
	aStep
		checkStep: [ :s | 
			s
				label: 'Check pharo snippet element content';
				do: [ :aList | 
					| aPharoElementCollection |
					aPharoElementCollection := (aList query // LePharoSnippetElement) result.
					self
						assert: aPharoElementCollection isNotEmpty
						description: [ 'Page must have some Pharo snippet elements' ].
					aPharoElementCollection
						do: [ :eachPharoElement | 
							self
								assert: eachPharoElement editor text asString
								equals: eachPharoElement snippet code asString ] ];
				onBreadthFirstChildOfClass: BrSimpleTree;
				onBreadthFirstChildOfClass: BrInfiniteTreeElement ]
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> checkEveryPharoSnippetHasSameVariableValue [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self executeFirstPharoSnippet.

	self assertBindingsIn: aScripter.

	^ aScripter
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> clickOnPharoSnippetAt: anIndex step: aStep [
	<gtExample>
	aStep
		clickStep: [ :s | 
			s
				label: 'Click on a pharo snippet at ' , anIndex asString , ' position';
				onBreadthFirstChildOfClass: BrSimpleTree;
				onBreadthFirstChildOfClass: BrInfiniteTreeElement;
				onChildAt: anIndex;
				onBreadthFirstChildOfClass: LePharoSnippetElement;
				onBreadthFirstChildOfClass: BrTextElementWithCursors ].

	^ aStep
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> clickOnTheFirstPharoSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageContentElementWithPharoSnippetsSharingSameVariable.

	self clickOnPharoSnippetAt: 1 step: aScripter.

	^ aScripter
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> editEveryVisiblePharoSnippetIn: aStep appending: aString [
	<gtExample>
	aStep
		doStep: [ :s | 
			s
				label: 'Edit textual snippet element content';
				block: [ :aList | 
					| aPharoElementCollection |
					aPharoElementCollection := (aList query // LePharoSnippetElement) result.
					self
						assert: aPharoElementCollection isNotEmpty
						description: [ 'Page must have some Pharo snippet elements' ].
					aPharoElementCollection
						do: [ :eachPharoElement | 
							eachPharoElement editor text append: aString asRopedText.
							self
								assert: eachPharoElement editor text asString
								equals: eachPharoElement snippet code asString ] ];
				onBreadthFirstChildOfClass: BrSimpleTree;
				onBreadthFirstChildOfClass: BrInfiniteTreeElement ]
]

{ #category : #'examples - rename variable' }
LePharoSnippetByScripterExamples >> enterNewLocalVariableName [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self startRenameLocalVariable.

	self enterNewNameWithScripter: aScripter.
	self applyNewNameWithScripter: aScripter.

	self
		assert: aScripter model children items first text asString
		equals: 'b := Array with: 42'.
	self
		assert: (aScripter model children items allButFirst
				allSatisfy: [ :each | each text asString = 'b' ]).

	^ aScripter
]

{ #category : #'examples - rename variable' }
LePharoSnippetByScripterExamples >> enterNewNameWithScripter: aScripter [
	<gtExample>
	aScripter
		substep: 'Enter new name'
		do: [ :aStep | 
			(aStep keyPress: BlKeyboardKey delete) play.
			(aStep keyPress: BlKeyboardKey backspace) play.
			(aStep type: 'b') play ]
]

{ #category : #'examples - scripter' }
LePharoSnippetByScripterExamples >> evaluateWhenMaximized [
	<gtExample>
	<return: #BlScripter>
	| anElement aPager aScripter page examples aSnippetOne |
	examples := LeUIExamples new.
	page := examples database pageBuilder
			title: 'Shared variable a';
			add.
	aSnippetOne := page snippetBuilder
			pharo: 'a := 42';
			add.
	page snippetBuilder
		pharo: 'a odd';
		add.
	anElement := page asPhlowTool asElementDo: [ :e | e ].
	aPager := GtPager createWrappedOn: anElement.
	aPager maximized.
	aPager asElement.
	aScripter := self
			scripterWithModel: [ page ]
			element: [ :aPage | aPager asElement ].
	aScripter
		substeps: 'Execute and Inspect '
		do: [ :aSubStep | 
			self clickOnPharoSnippetAt: 1 step: aSubStep.
			aSubStep
				clickStep: [ :s | 
					s
						label: 'Execute pharo snippet';
						onBreadthFirstChildOfClass: BrSimpleTree;
						onBreadthFirstChildOfClass: BrInfiniteTreeElement;
						onChildAt: 1;
						onBreadthFirstChildOfClass: LePharoSnippetElement;
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						id: GtSourceCoderDoItAndGoActionId ] ].
	self executePharoSnippetAt: 2 step: aScripter.
	^ aScripter
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> executeAndAgainScrollDownPharoSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scrollUpPharoSnippets.
	aScripter
		substeps: 'Execute snippet again, scroll down and check variable bindigs'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			10
				timesRepeat: [ anIndex := anIndex + 1.
					aRootStep
						substeps: anIndex asString , '. Scroll and check variable bindigs'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll up pharo snippets';
								downBy: 25;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement;
								play.
							self assertBindingsIn: aStep ] ].
			aRootStep
				checkStep: [ :s | 
					s
						label: 'Check that the last block is displayed';
						do: [ :aList | 
							| aLastBlock aBlockIndex |
							aLastBlock := (aList children last query // LePharoSnippetElement) result
									first snippet.
							aBlockIndex := aLastBlock page children asArray
									identityIndexOf: aLastBlock.
							self assert: aBlockIndex equals: 51 ];
						onBreadthFirstChildOfClass: BrSimpleTree;
						onBreadthFirstChildOfClass: BrInfiniteTreeElement ] ].
	^ aScripter
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> executeFirstPharoSnippet [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageContentElementWithPharoSnippetsSharingSameVariable.

	self executePharoSnippetAt: 1 step: aScripter.

	^ aScripter
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> executePharoSnippetAt: anIndex step: aStep [
	<gtExample>
	aStep
		substeps: 'Execute and store pharo snippet result ' , anIndex asString , ' position'
		do: [ :aSubStep | 
			self clickOnPharoSnippetAt: anIndex step: aSubStep.

			aSubStep
				clickStep: [ :s | 
					s
						label: 'Execute pharo snippet';
						onBreadthFirstChildOfClass: BrSimpleTree;
						onBreadthFirstChildOfClass: BrInfiniteTreeElement;
						onChildAt: anIndex;
						onBreadthFirstChildOfClass: LePharoSnippetElement;
						onBreadthFirstChildOfClass: GtSourceCoderActionsElement;
						id: GtSourceCoderDoItActionId ].

			aSubStep
				doStep: [ :s | 
					s
						label: 'Store execution result';
						block: [ :anElement :aData | 
							| aNewValue |
							aNewValue := (anElement textualCoderViewModel compositeVariableBindings
									asDictionary at: #a) value.

							aData
								at: #scriptExecutionResult
								ifPresent: [ :anOldValue | (anOldValue == aNewValue) not ]
								ifAbsent: [  "ignore" ].

							aData at: #scriptExecutionResult put: aNewValue ];
						onBreadthFirstChildOfClass: BrSimpleTree;
						onBreadthFirstChildOfClass: BrInfiniteTreeElement;
						onChildAt: anIndex;
						onBreadthFirstChildOfClass: LePharoSnippetElement;
						onBreadthFirstChildOfClass: GtSourceCoderEditorElement ] ].

	^ aStep
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> moveDownPharoSnippetAt: anIndex step: aStep [
	<gtExample>
	
	self clickOnPharoSnippetAt: anIndex step: aStep.
	
	aStep shortcut
		combination: (LeSnippetElement keyboardShortcut: #MoveSnippetDown);
		label: 'Click on a pharo snippet at ', anIndex asString, ' position';
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement;
		onChildAt: anIndex;
		onBreadthFirstChildOfClass: LePharoSnippetElement;
		onBreadthFirstChildOfClass: BrTextElementWithCursors;
		play.

	^ aStep
]

{ #category : #'examples - page - pharo snippets' }
LePharoSnippetByScripterExamples >> pageContentElementWithEnumeradedPharoSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ LeUIExamples new titledPageWithPharoCodeHierarchy_numbers ]
			element: [ :aPage | LePageToolContentTreeElement new pageViewModel: aPage asContentUIModel ].
	^ aScripter
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> pageContentElementWithPharoSnippetsSharingSameVariable [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self
			scripterWithModel: [ LeUIExamples new titledPageWithPharoCodeHierarchy ]
			element: [ :aPage | LePageToolContentTreeElement new pageViewModel: aPage asContentUIModel ].
	^ aScripter
]

{ #category : #'examples - page - pharo snippets' }
LePharoSnippetByScripterExamples >> scrollDownEnumeradedPharoSnippets [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self pageContentElementWithEnumeradedPharoSnippets.
	aScripter
		substeps: 'Scroll down and check snippet element contents'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			8
				timesRepeat: [ 
					anIndex := anIndex + 1.
					
					self moveDownPharoSnippetAt: 1 step: aRootStep. 
					
					self editEveryVisiblePharoSnippetIn: aRootStep appending: ' scrollDown'.
					
					aRootStep
						substeps: anIndex asString , ' scroll and snippet element content'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll down pharo snippets';
								downBy: 35;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement;
								play.
							
							self assertPharoSnippetElementContentIn: aStep. ] ] ].
	^ aScripter
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> scrollDownPharoSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self executeFirstPharoSnippet.
	aScripter
		substeps: 'Scroll down and check variable bindigs'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			10
				timesRepeat: [ anIndex := anIndex + 1.
					aRootStep
						substeps: anIndex asString , '. Scroll and check variable bindigs'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll down pharo snippets';
								downBy: 25;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement;
								play.
							self assertBindingsIn: aStep ] ].
			aRootStep
				checkStep: [ :s | 
					s
						label: 'Check that the last block is displayed';
						do: [ :aList | 
							| aLastBlock aBlockIndex |
							aLastBlock := (aList children last query // LePharoSnippetElement) result
									first snippet.
							aBlockIndex := aLastBlock page children asArray
									identityIndexOf: aLastBlock.
							self assert: aBlockIndex equals: 51 ];
						onBreadthFirstChildOfClass: BrSimpleTree;
						onBreadthFirstChildOfClass: BrInfiniteTreeElement ] ].
	^ aScripter
]

{ #category : #'examples - page - pharo snippets' }
LePharoSnippetByScripterExamples >> scrollUpEnumeradedPharoSnippets [
	<gtExample>
	<noTest>
	| aScripter |
	aScripter := self scrollDownEnumeradedPharoSnippets.
	aScripter
		substeps: 'Scroll up and check snippet element contents'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			8
				timesRepeat: [ 
					anIndex := anIndex + 1.
					
					self editEveryVisiblePharoSnippetIn: aRootStep appending: ' scrollUp'.
					
					aRootStep
						substeps: anIndex asString , ' scroll and snippet element content'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll down pharo snippets';
								upBy: 35;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement;
								play.
							
							self assertPharoSnippetElementContentIn: aStep ] ] ].
	^ aScripter
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> scrollUpPharoSnippets [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self scrollDownPharoSnippets.
	aScripter
		substeps: 'Scroll up and check variable bindigs'
		do: [ :aRootStep | 
			| anIndex |
			anIndex := 0.
			10
				timesRepeat: [ anIndex := anIndex + 1.
					aRootStep
						substeps: anIndex asString , '. Scroll and check variable bindigs'
						do: [ :aStep | 
							aStep mouseWheel
								label: 'Scroll up pharo snippets';
								upBy: 25;
								onBreadthFirstChildOfClass: BrSimpleTree;
								onBreadthFirstChildOfClass: BrInfiniteTreeElement;
								play.
							self assertBindingsIn: aStep ] ].
			aRootStep
				checkStep: [ :s | 
					s
						label: 'Check that the first block is displayed';
						do: [ :aList | 
							| aLastBlock aBlockIndex |
							aLastBlock := (aList children first query // LePharoSnippetElement)
									result first snippet.
							aBlockIndex := aLastBlock page children asArray
									identityIndexOf: aLastBlock.
							self assert: aBlockIndex equals: 1 ];
						onBreadthFirstChildOfClass: BrSimpleTree;
						onBreadthFirstChildOfClass: BrInfiniteTreeElement ] ].
	^ aScripter
]

{ #category : #'examples - rename variable' }
LePharoSnippetByScripterExamples >> startRenameLocalVariable [
	<gtExample>
	<return: #BlScripter>
	| aScripter |
	aScripter := self pageContentElementWithPharoSnippetsSharingSameVariable.

	aScripter
		substeps: 'Initiate rename local variable'
		do: [ :aStep | 
			aStep
				clickStep: [ :s | 
					s
						label: 'Click on the coder editor to give it focus';
						id: GtSourceCoderEditorId ].

			aStep
				doStep: [ :s | 
					s
						label: 'Move cursor to variable';
						action: [ :aSourceEditor | aSourceEditor editor moveCursorTo: 0 ];
						id: GtSourceCoderEditorId ].

			aStep shortcut
				combination: BlKeyCombination primaryR;
				id: GtSourceCoderEditorId;
				play.

			aStep
				checkStep: [ :s | 
					s
						label: 'Check rename editor exists';
						exists;
						id: GtSourceCoderEditorId;
						onBreadthFirstChildOfClass: GtRenameEditor ] ].

	^ aScripter
]
