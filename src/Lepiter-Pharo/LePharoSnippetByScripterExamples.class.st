Class {
	#name : #LePharoSnippetByScripterExamples,
	#superclass : #Object,
	#traits : 'TBlDevScripterExamples',
	#classTraits : 'TBlDevScripterExamples classTrait',
	#category : #'Lepiter-Pharo-Examples'
}

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> assertBindingsIn: aStep [
	
	aStep check
		label: 'Check pharo snippet variable values';
		do: [ :aList :aData | 
			| allBindings aValue |
			allBindings := (aList query // LePharoSnippetElement // GtSourceCoderEditorElement) result collect: [ :eachCoder | 
				eachCoder textualCoderViewModel compositeVariableBindings asDictionary ].
			aValue := aData at: #scriptExecutionResult. 
			self assert: aValue value equals: { 42 }.
			self assert: (allBindings allSatisfy: [ :eachDictionary |
				(eachDictionary at: #a) value == aValue ]).
		];
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement;
		play.

	^ aStep
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> assertPharoSnippetElementContentIn: aStep [
	<gtExample>
	aStep check
		label: 'Check pharo snippet element content';
		do: [ :aList | 
			| aPharoElementCollection |
			aPharoElementCollection := (aList query // LePharoSnippetElement) result.
			self assert: aPharoElementCollection isNotEmpty description: [ 'Page must have some Pharo snippet elements' ].
			aPharoElementCollection do: [ :eachPharoElement |
				self assert: eachPharoElement editor text asString equals: eachPharoElement snippet code asString ] ];
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> checkEveryPharoSnippetHasSameVariableValue [
	<gtExample>
	| aScripter |
	aScripter := self executeFirstPharoSnippet.
	
	self assertBindingsIn: aScripter.

	^ aScripter
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> clickOnPharoSnippetAt: anIndex step: aStep [
	<gtExample>
	
	aStep click
		label: 'Click on a pharo snippet at ', anIndex asString, ' position';
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement;
		onChildAt: anIndex;
		onBreadthFirstChildOfClass: LePharoSnippetElement;
		onBreadthFirstChildOfClass: BrTextElementWithCursors;
		play.

	^ aStep
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> clickOnTheFirstPharoSnippet [
	<gtExample>
	| aScripter |
	aScripter := self pageContentElementWithPharoSnippetsSharingSameVariable.
	
	self clickOnPharoSnippetAt: 1 step: aScripter.

	^ aScripter
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> editEveryVisiblePharoSnippetIn: aStep appending: aString [
	<gtExample>
	aStep do
		label: 'Edit textual snippet element content';
		block: [ :aList | 
			| aPharoElementCollection |
			aPharoElementCollection := (aList query // LePharoSnippetElement) result.
			self assert: aPharoElementCollection isNotEmpty description: [ 'Page must have some Pharo snippet elements' ].
			aPharoElementCollection do: [ :eachPharoElement |
				eachPharoElement editor text append: aString asRopedText. 
				self assert: eachPharoElement editor text asString equals: eachPharoElement snippet code asString ] ];
		onBreadthFirstChildOfClass: BrSimpleTree;
		onBreadthFirstChildOfClass: BrInfiniteTreeElement
]

{ #category : #'examples - rename variable' }
LePharoSnippetByScripterExamples >> enterNewLocalVariableName [

	<gtExample>
	| aScripter |
	aScripter := self startRenameLocalVariable.

	aScripter 
		substep: 'Enter new name' 
		do: [ :aStep | 
			(aStep keyClick: BlKeyboardKey delete) play.
			(aStep keyClick: BlKeyboardKey backspace) play.
			(aStep type: 'b') play ].

	aScripter
		substep: 'Apply rename'
		do: [ :aStep | (aStep keyClick: BlKeyboardKey return) play ].

	aScripter syncContinue.
	
	self assert: aScripter model children items first text asString equals: 'b := Array with: 42'.
	self assert: (aScripter model children items allButFirst allSatisfy: [:each | each text asString = 'b']).
	
	^ aScripter
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> executeAndAgainScrollDownPharoSnippets [
	<gtExample>
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
								onBreadthFirstChildOfClass: BrInfiniteTreeElement.
							aStep wait forEmptySpaceTaskQueueTimeout: 1 seconds.
							self assertBindingsIn: aStep ] ].
			aRootStep check
				label: 'Check that the last block is displayed';
				do: [ :aList | 
					| aLastBlock aBlockIndex |
					aLastBlock := (aList children last query
						// LePharoSnippetElement) result first snippet.
					aBlockIndex := aLastBlock page children asArray
						identityIndexOf: aLastBlock.
					self assert: aBlockIndex equals: 51 ];
				onBreadthFirstChildOfClass: BrSimpleTree;
				onBreadthFirstChildOfClass: BrInfiniteTreeElement ].
	^ aScripter syncContinue
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> executeFirstPharoSnippet [
	<gtExample>
	| aScripter |
	aScripter := self pageContentElementWithPharoSnippetsSharingSameVariable.
	
	self executePharoSnippetAt: 1 step: aScripter.
	
	^ aScripter
]

{ #category : #'examples - support' }
LePharoSnippetByScripterExamples >> executePharoSnippetAt: anIndex step: aStep [ 
	<gtExample>
	
	aStep substeps: 'Execute and store pharo snippet result ', anIndex asString, ' position' do: [ :aSubStep |
		
		self clickOnPharoSnippetAt: anIndex step: aSubStep.
	
		aSubStep click
			label: 'Execute pharo snippet';
			onBreadthFirstChildOfClass: BrSimpleTree;
			onBreadthFirstChildOfClass: BrInfiniteTreeElement;
			onChildAt: anIndex;
			onBreadthFirstChildOfClass: LePharoSnippetElement;
			onBreadthFirstChildOfClass: GtCoderActionsElement;
			id: GtSourceCoderDoItActionId;
			play.
			
		aSubStep do
			label: 'Store execution result';
			block: [ :anElement :aData | 
				| aNewValue |
				aNewValue := (anElement textualCoderViewModel compositeVariableBindings asDictionary at: #a) value.
				
				aData 
					at: #scriptExecutionResult 
					ifPresent: [ :anOldValue | (anOldValue == aNewValue) not ]
					ifAbsent: [ "ignore" ].
				
				aData 
					at: #scriptExecutionResult 
					put: aNewValue ];
			onBreadthFirstChildOfClass: BrSimpleTree;
			onBreadthFirstChildOfClass: BrInfiniteTreeElement;
			onChildAt: anIndex;
			onBreadthFirstChildOfClass: LePharoSnippetElement;
			onBreadthFirstChildOfClass: GtSourceCoderEditorElement;
			play ].

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
		onBreadthFirstChildOfClass: BrTextElementWithCursors.

	^ aStep
]

{ #category : #'examples - page - pharo snippets' }
LePharoSnippetByScripterExamples >> pageContentElementWithEnumeradedPharoSnippets [
	<gtExample>
	| aScripter |
	aScripter := self 
		scripterWithModel: [ LeUIExamples new titledPageWithPharoCodeHierarchy_numbers ]
		element: [ :aPage | LePageToolContentTreeElement new pageViewModel: (LePageViewModel new pageModel: aPage) ].
	^ aScripter syncContinue
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> pageContentElementWithPharoSnippetsSharingSameVariable [
	<gtExample>
	| aScripter |
	aScripter := self 
		scripterWithModel: [ LeUIExamples new titledPageWithPharoCodeHierarchy ]
		element: [ :aPage | LePageToolContentTreeElement new pageViewModel: (LePageViewModel new pageModel: aPage) ].
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
								onBreadthFirstChildOfClass: BrInfiniteTreeElement.
							aStep wait forEmptySpaceTaskQueueTimeout: 1 seconds.
							
							self assertPharoSnippetElementContentIn: aStep. ] ] ].
	^ aScripter syncContinue
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> scrollDownPharoSnippets [
	<gtExample>
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
								onBreadthFirstChildOfClass: BrInfiniteTreeElement.
							aStep wait forEmptySpaceTaskQueueTimeout: 1 seconds.
							self assertBindingsIn: aStep ] ].
			aRootStep check
				label: 'Check that the last block is displayed';
				do: [ :aList | 
					| aLastBlock aBlockIndex |
					aLastBlock := (aList children last query
						// LePharoSnippetElement) result first snippet.
					aBlockIndex := aLastBlock page children asArray
						identityIndexOf: aLastBlock.
					self assert: aBlockIndex equals: 51 ];
				onBreadthFirstChildOfClass: BrSimpleTree;
				onBreadthFirstChildOfClass: BrInfiniteTreeElement ].
	^ aScripter syncContinue
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
								onBreadthFirstChildOfClass: BrInfiniteTreeElement.
							aStep wait forEmptySpaceTaskQueueTimeout: 1 seconds.
							
							self assertPharoSnippetElementContentIn: aStep ] ] ].
	^ aScripter syncContinue
]

{ #category : #'examples - page' }
LePharoSnippetByScripterExamples >> scrollUpPharoSnippets [
	<gtExample>
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
								onBreadthFirstChildOfClass: BrInfiniteTreeElement.
							aStep wait forEmptySpaceTaskQueueTimeout: 1 seconds.
							self assertBindingsIn: aStep ] ].
			aRootStep check
				label: 'Check that the first block is displayed';
				do: [ :aList | 
					| aLastBlock aBlockIndex |
					aLastBlock := (aList children first query
						// LePharoSnippetElement) result first snippet.
					aBlockIndex := aLastBlock page children asArray
						identityIndexOf: aLastBlock.
					self assert: aBlockIndex equals: 1 ];
				onBreadthFirstChildOfClass: BrSimpleTree;
				onBreadthFirstChildOfClass: BrInfiniteTreeElement ].
	^ aScripter syncContinue
]

{ #category : #'examples - rename variable' }
LePharoSnippetByScripterExamples >> startRenameLocalVariable [

	<gtExample>
	| aScripter |
	aScripter := self pageContentElementWithPharoSnippetsSharingSameVariable.
	
	aScripter click
		label: 'Click on the coder editor to give it focus';
		id: #snippetContent;
		play.

	aScripter do
		label: 'Move cursor to variable';
		action: [ :aSourceEditor | aSourceEditor editor moveCursorTo: 0 ];
		id: #snippetContent;
		play.
		
	aScripter shortcut
		combination: BlKeyCombination primaryR;
		id: #snippetContent;
		play.

	aScripter check
		label: 'Check rename editor exists';
		exists;
		id: #snippetContent;
		onBreadthFirstChildOfClass: GtRenameEditor;
		play.
		
	^ aScripter syncContinue
]
