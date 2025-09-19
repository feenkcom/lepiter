Class {
	#name : #GtSearchCompiledMethodItemType,
	#superclass : #GtSearchCodeEntityItemType,
	#category : #'Lepiter-Core-Filters'
}

{ #category : #'as yet unclassified' }
GtSearchCompiledMethodItemType >> bindElement: aCoderElement toEntity: aCodeEntity fromFilter: aFilter [
	| viewModel |
	viewModel := self
			createViewModelForEntity: aCodeEntity
			fromFilter: aFilter .
	aCoderElement textualCoderViewModel: viewModel.
	^ aCoderElement
]

{ #category : #'as yet unclassified' }
GtSearchCompiledMethodItemType >> createElement [
	^ GtExpandableMethodCoderElement new
		padding: (BlInsets right: 5)
]

{ #category : #'as yet unclassified' }
GtSearchCompiledMethodItemType >> createViewModelForEntity: aCodeEntity fromFilter: aFilter [
	| coderModel |
	coderModel := GtPharoMethodCoder forMethod: aCodeEntity.
	^ coderModel asCoderViewModel
		expanded: false;
		shouldHaveHeader: true;
		highlighter: aFilter highlighter.
]
