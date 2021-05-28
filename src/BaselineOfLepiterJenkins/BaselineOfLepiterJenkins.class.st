Class {
	#name : #BaselineOfLepiterJenkins,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterJenkins
}

{ #category : #accessing }
BaselineOfLepiterJenkins class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterJenkins >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Snippet-Jenkins' with: [
					spec requires: #( 'LepiterEngineCore' ) ] ]
]
