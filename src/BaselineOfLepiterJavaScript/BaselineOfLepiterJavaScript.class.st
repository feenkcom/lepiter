Class {
	#name : #BaselineOfLepiterJavaScript,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterJavaScript
}

{ #category : #accessing }
BaselineOfLepiterJavaScript class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baselines }
BaselineOfLepiterJavaScript >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				baseline: 'LepiterEngineCore' with: [ 
					spec repository: 'github://feenkcom/lepiter:main/src' ].
			spec
				baseline: 'Gt4JSLink' with: [ 
					spec repository: 'github://feenkcom/gtoolkit-remote-javascript:main/src' ].
			spec
				baseline: 'Gt4ChromeDevTools' with: [ 
					spec repository: 'github://feenkcom/gtoolkit-chrome:main/src' ].
			spec
				package: 'Lepiter-JavaScript' with: [
					spec requires: #( 'LepiterEngineCore' 'Gt4JSLink' ) ] ]
]
