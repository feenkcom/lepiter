Class {
	#name : #BaselineOfLepiterGitHub,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterGitHub
}

{ #category : #accessing }
BaselineOfLepiterGitHub class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterGitHub >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				package: 'Lepiter-GitHub' with: [
					spec requires: #( 'LepiterEngineCore' ) ] ]
]
