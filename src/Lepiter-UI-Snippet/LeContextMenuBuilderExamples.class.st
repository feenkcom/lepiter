Class {
	#name : 'LeContextMenuBuilderExamples',
	#superclass : 'Object',
	#category : 'Lepiter-UI-Snippet-Spotter'
}

{ #category : 'examples - builder' }
LeContextMenuBuilderExamples >> basicBuilder [
	<gtExample>
	| aBuilder |
	aBuilder := LeContextMenuBuilder new.
	^ aBuilder
]

{ #category : 'examples - builder' }
LeContextMenuBuilderExamples >> realBuilder [
	<gtExample>
	| aBuilder aCollection |
	aBuilder := LeContextMenuBuilder new.
	aCollection := aBuilder build.
	self assert: aCollection isNotNil.
	self assert: aCollection isNotEmpty.
	
	aCollection do: [ :eachMenuItem | 
		self assert: eachMenuItem snippetClass isInstanceSide.
		self assert: eachMenuItem title isString.
		self assert: eachMenuItem title isNotEmpty.
		self assert: eachMenuItem priority isNumber.	
	].
	
	^ aBuilder
]
