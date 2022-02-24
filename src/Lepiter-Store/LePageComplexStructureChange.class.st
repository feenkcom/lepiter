"
At the moment I indicate that there is a change in structure.
"
Class {
	#name : #LePageComplexStructureChange,
	#superclass : #LePageStructureChange,
	#category : #'Lepiter-Store-Reload'
}

{ #category : #testing }
LePageComplexStructureChange class >> needsPageRebuild [
	^ true
]
