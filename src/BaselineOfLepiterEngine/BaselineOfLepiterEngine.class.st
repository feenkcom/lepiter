Class {
	#name : #BaselineOfLepiterEngine,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterEngine
}

{ #category : #accessing }
BaselineOfLepiterEngine class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baseline }
BaselineOfLepiterEngine >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'LepiterEngineExtensions' with: [
				spec repository: 'github://feenkcom/lepiter:main/src' ].
		spec package: 'Lepiter-Validator' with: [
				spec requires: #('LepiterEngineExtensions' ). ].
		spec package: 'Lepiter-Tool' with: [
				spec requires: #('LepiterEngineExtensions' ). ].
		spec package: 'Lepiter-Snippets' with: [ 
				spec requires: #('LepiterEngineExtensions') ].
		spec package: 'Lepiter-Setup' ].
]

{ #category : #converting }
BaselineOfLepiterEngine >> gtExamples [
	<gtExample>
	<return: #GtExplicitExampleGroup>
	^ ('Lepiter' gtPackageMatches & #gtExample gtReferences
		& (GtSearchMethodsInClassFilter forClass: BaselineOfLepiterEngine) not)
		gtExamples
]
