Class {
	#name : #BaselineOfLepiterPharo,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterPharo
}

{ #category : #accessing }
BaselineOfLepiterPharo class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterPharo >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-Pharo' with: [
					spec requires: #( 'LepiterEngineCore') ] ]
]
