Class {
	#name : #BaselineOfLepiterYoutube,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterYoutube
}

{ #category : #accessing }
BaselineOfLepiterYoutube class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baseline }
BaselineOfLepiterYoutube >> baseline: spec [
	<baseline> 
	spec
		for: #common do: [
			spec
				package: 'Lepiter-Snippet-Youtube'
		]
]
