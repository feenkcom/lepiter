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
		spec 
			baseline: 'GToolkitInspector' with: [
				spec repository: 'github://feenkcom/gtoolkit-inspector:main/src' ];
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick:main/src' ];
			baseline: 'GToolkit4Json' with: [
				spec repository: 'github://feenkcom/gt4json:main/src' ];
			baseline: 'LepiterXDoc' with: [
				spec repository: 'github://feenkcom/lepiter:main/src' ].
				
		spec 
			package: 'Lepiter-Parser';
			package: 'Lepiter-History';
			package: 'Lepiter-Core' with: [
				spec requires: #('Lepiter-Parser' ). ];
			package: 'Lepiter-Utilities' with: [
				spec requires: #('Lepiter-Core' ). ];
			package: 'Lepiter-Store' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Utilities' 'GToolkit4Json' ). ];
			package: 'Lepiter-Translator-Roam' with: [
				spec requires: #('Lepiter-Store' ). ];
			package: 'Lepiter-Translator-JupyterNotebook' with: [
				spec requires: #('Lepiter-Core' ). ];
			package: 'Lepiter-UI-Core' with: [
				spec requires: #('Lepiter-Core' 'GToolkitInspector' 'Brick' ). ];
			package: 'Lepiter-UI-Snippet' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-Parser' ). ];
			package: 'Lepiter-UI-Page' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet' ). ];
			package: 'Lepiter-UI-IncomingReferences' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Page' 'Lepiter-UI-Snippet' ). ];
			package: 'Lepiter-UI-Utilities';
			package: 'Lepiter-UI' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Parser' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet' 'Lepiter-UI-Page' 'Lepiter-UI-IncomingReferences' 'Lepiter-UI-Utilities' 'Lepiter-Utilities' 'Lepiter-Store' 'Lepiter-Translator-Roam' ). ];
			package: 'Lepiter-Extensions' with: [
				spec requires: #( 'LepiterXDoc' ) ];
			package: 'Lepiter-Snippet-Text' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-UI' ). ];
			package: 'Lepiter-HTML' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Parser' 'LepiterXDoc' ). ];
			package: 'Lepiter-Playground' with: [
				spec requires: #('Lepiter-Core' 'Lepiter-Store' 'Lepiter-UI' ). ];
			package: 'Lepiter-Core-Examples' with: [
				spec requires: #('Lepiter-Snippet-Text' ). ]. ].

]
