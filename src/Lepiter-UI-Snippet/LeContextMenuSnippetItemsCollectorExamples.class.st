Class {
	#name : #LeContextMenuSnippetItemsCollectorExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Spotter'
}

{ #category : #'examples - builder' }
LeContextMenuSnippetItemsCollectorExamples >> basicBuilder [
	<gtExample>
	<return: #LeContextMenuSnippetItemsCollector>
	| aBuilder |
	aBuilder := LeContextMenuSnippetItemsCollector new.
	^ aBuilder
]

{ #category : #'examples - builder' }
LeContextMenuSnippetItemsCollectorExamples >> realBuilder [
	<gtExample>
	<return: #LeContextMenuSnippetItemsCollector>
	| aBuilder aCollection |
	aBuilder := self basicBuilder.

	aCollection := aBuilder collectMenuItems.
	self assert: aCollection isNotNil.
	self assert: aCollection isNotEmpty.

	aCollection
		do: [ :eachMenuItem | 
			self assert: eachMenuItem snippetClass isInstanceSide.
			self assert: eachMenuItem title isString.
			self assert: eachMenuItem title isNotEmpty.
			self assert: eachMenuItem priority isNumber ].

	^ aBuilder
]
