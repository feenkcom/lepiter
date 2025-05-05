Class {
	#name : #LeExampleSnippetViewModelExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Example-Examples'
}

{ #category : #'examples - support' }
LeExampleSnippetViewModelExamples class >> classSideExample [

	<gtExample>
	^ 42
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> classSideExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: self class classSide name;
		exampleSelector: #classSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> classSideExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self classSideExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNotNil.
	self assert: anExample exists.

	^ aViewModel
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> compileErrorClassSideBehaviorExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: '3#3IncorrectClassName class';
		exampleSelector: #classSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> compileErrorClassSideBehaviorExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self compileErrorClassSideBehaviorExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNil.

	^ aViewModel
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> compileErrorClassSideMethodExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: self class classSide name;
		exampleSelector: #'classSide-@-Example'
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> compileErrorClassSideMethodExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self compileErrorClassSideMethodExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNil.

	^ aViewModel
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> expressionInsteadOfBehaviorNameExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: '(3+3 notExistingMethod) class';
		exampleSelector: #classSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> expressionInsteadOfBehaviorNameExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self expressionInsteadOfBehaviorNameExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNil.

	^ aViewModel
]

{ #category : #'examples - support' }
LeExampleSnippetViewModelExamples >> instanceSideExample [
	<gtExample>
	<return: #SmallInteger>
	^ 42
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> instanceSideExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: self class name;
		exampleSelector: #instanceSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> instanceSideExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self instanceSideExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNotNil.
	self assert: anExample exists.

	^ aViewModel
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> notExistingClassSideBehaviorExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: 'NotExistingBehaviorOf' , self class classSide name;
		exampleSelector: #classSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> notExistingClassSideBehaviorExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self notExistingClassSideBehaviorExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNil.

	^ aViewModel
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> notExistingClassSideMethodExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: self class classSide name;
		exampleSelector: #notExistingClassSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> notExistingClassSideMethodExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self notExistingClassSideMethodExampleSnippet.

	aViewModel := aSnippet asSnippetViewModel.

	aViewModel gtExampleDo: [ :theExample | anExample := theExample ].

	self assert: anExample isNil.

	^ aViewModel
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> notExistingInstanceSideBehaviorExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: 'NotExistingBehaviorOf' , self class name;
		exampleSelector: #instanceSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> notExistingInstanceSideBehaviorExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self notExistingInstanceSideBehaviorExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNil.

	^ aViewModel
]

{ #category : #'examples - snippet' }
LeExampleSnippetViewModelExamples >> notExistingInstanceSideMethodExampleSnippet [
	<gtExample>
	<return: #LeExampleSnippet>
	^ LeExampleSnippet new
		exampleBehaviorName: self class name;
		exampleSelector: #notExistingInstanceSideExample
]

{ #category : #'examples - snippet view model' }
LeExampleSnippetViewModelExamples >> notExistingInstanceSideMethodExampleSnippetViewModel [
	<gtExample>
	<return: #LeExampleSnippetViewModel>
	| aSnippet aViewModel anExample |
	aSnippet := self notExistingInstanceSideMethodExampleSnippet.
	aViewModel := aSnippet asSnippetViewModel.

	anExample := self obtainGtExampleFromViewModel: aViewModel.

	self assert: anExample isNil.

	^ aViewModel
]

{ #category : #'examples - support' }
LeExampleSnippetViewModelExamples >> obtainGtExampleFromViewModel: aViewModel [

	| anExample |
	[ aViewModel gtExampleDo: [ :theExample | anExample := theExample ] ]
		on: OCSemanticWarning, SyntaxErrorNotification
		do: [ :aNotification | 
			AssertionFailure signal:
				'Compiler notification must not happen: ' , aNotification asString ].

	^ anExample
]
