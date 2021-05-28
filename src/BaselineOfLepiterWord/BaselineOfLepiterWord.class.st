Class {
	#name : #BaselineOfLepiterWord,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterWord
}

{ #category : #accessing }
BaselineOfLepiterWord class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterWord >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Snippet-Words' with: [
					spec requires: #( 'LepiterEngineCore' ) ] ]
]
