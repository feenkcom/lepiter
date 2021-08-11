Class {
	#name : #BaselineOfLepiterEngineCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterEngineCore
}

{ #category : #accessing }
BaselineOfLepiterEngineCore class >> gtDependencyAnalysisPreloadedBaselines [
	^ super gtDependencyAnalysisPreloadedBaselines
		copyWith: BaselineOfGToolkit
]

{ #category : #baseline }
BaselineOfLepiterEngineCore >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:v0.8.490/src' ].
		spec 
			package: 'Lepiter-Parser';
			package: 'Lepiter-Core' with: [
				spec requires: #('Lepiter-Parser' ). ];
			package: 'Lepiter-Utilities' with: [
				spec requires: #('Lepiter-Core' ). ];
			package: 'Lepiter-Store' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Utilities' ). ];
			package: 'Lepiter-Translator-Roam' with: [
				spec requires: #('Lepiter-Store' ). ];
			package: 'Lepiter-Translator-JupyterNotebook' with: [
				spec requires: #('Lepiter-Core' ). ];
			package: 'Lepiter-UI-Core' with: [
				spec requires: #('Lepiter-Core' 'GToolkitInspector' ). ];
			package: 'Lepiter-UI-Snippet' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-Parser' ). ];
			package: 'Lepiter-UI-Page' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet' ). ];
			package: 'Lepiter-UI-IncomingReferences' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Page' 'Lepiter-UI-Snippet' ). ];
			package: 'Lepiter-UI-Utilities';
			package: 'Lepiter-UI' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Parser' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet' 'Lepiter-UI-Page' 'Lepiter-UI-IncomingReferences' 'Lepiter-UI-Utilities' 'Lepiter-Utilities' 'Lepiter-Store' 'Lepiter-Translator-Roam' ). ];
			package: 'Lepiter-Snippet-Text' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI' ). ];
			package: 'Lepiter-HTML' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Parser' ). ];
			package: 'Lepiter-Playground' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Store' 'Lepiter-UI' ). ];
			package: 'Lepiter-Core-Examples' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Snippet-Text' ). ]. ].

]
