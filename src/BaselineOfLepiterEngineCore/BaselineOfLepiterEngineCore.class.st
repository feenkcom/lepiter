Class {
	#name : #BaselineOfLepiterEngineCore,
	#superclass : #BaselineOf,
	#category : #BaselineOfLepiterEngineCore
}

{ #category : #baseline }
BaselineOfLepiterEngineCore >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'Brick'
					with: [ spec repository: 'github://feenkcom/Brick:main/src' ];
				baseline: 'GToolkitFileUtility'
					with: [ spec repository: 'github://feenkcom/gtoolkit-utility:main/src' ];
				baseline: 'GToolkitInspector'
					with: [ spec repository: 'github://feenkcom/gtoolkit-inspector:main/src' ];
				baseline: 'GToolkitCoder'
					with: [ spec repository: 'github://feenkcom/gtoolkit-coder:main/src' ];
				baseline: 'GToolkit4Pharo'
					with: [ spec repository: 'github://feenkcom/gt4pharo:main/src' ];
				baseline: 'GToolkit4Json'
					with: [ spec repository: 'github://feenkcom/gt4json:main/src' ];
				baseline: 'GToolkitReleaser'
					with: [ spec repository: 'github://feenkcom/gtoolkit-releaser:main/src' ];
				baseline: 'LepiterXDoc'
					with: [ spec repository: 'github://feenkcom/lepiter:main/src' ];
				baseline: 'SmaCCRuntime'
					with: [ spec repository: 'github://j-brant/SmaCC' ];
				baseline: 'JSONParser' with: [ spec repository: 'github://j-brant/SmaCC' ];
				baseline: 'Beacon'
					with: [ spec repository: 'github://feenkcom/pharo-beacon/repository' ];
				baseline: 'JSONWebToken'
					with: [ spec repository: 'github://feenkcom/JSONWebToken/source' ];
				baseline: 'ZincHTTPComponentsRest'
					with: [ spec repository: 'github://feenkcom/zinc/repository' ].

			spec
				package: 'Lepiter-Parser' with: [ spec requires: #('SmaCCRuntime') ];
				package: 'Lepiter-History'
					with: [ spec requires: #('Brick' 'GToolkitFileUtility') ];
				package: 'Lepiter-Core'
					with: [ spec
							requires: #('Lepiter-Parser' 'JSONParser' 'Lepiter-History' 'Brick' 'GToolkitCoder' 'GToolkit4Pharo') ];
				package: 'Lepiter-Utilities' with: [ spec requires: #('Lepiter-Core') ];
				package: 'Lepiter-Store'
					with: [ spec requires: #('Lepiter-Core' 'Lepiter-Utilities' 'GToolkit4Json') ];
				package: 'Lepiter-Store-Class' with: [ spec requires: #('Lepiter-Store') ];
				package: 'Lepiter-Translator-Roam'
					with: [ spec requires: #('Lepiter-Store') ];
				package: 'Lepiter-Translator-JupyterNotebook'
					with: [ spec requires: #('Lepiter-Core') ];
				package: 'Lepiter-UI-Core'
					with: [ spec requires: #('Lepiter-Core' 'GToolkitInspector' 'Brick') ];
				package: 'Lepiter-UI-Snippet'
					with: [ spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-Parser') ];
				package: 'Lepiter-UI-Page'
					with: [ spec requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet') ];
				package: 'Lepiter-UI-IncomingReferences'
					with: [ spec
							requires: #('Lepiter-Core' 'Lepiter-UI-Core' 'Lepiter-UI-Page' 'Lepiter-UI-Snippet') ];
				package: 'Lepiter-UI-Utilities';
				package: 'Lepiter-UI'
					with: [ spec
							requires: #('Lepiter-Core' 'Lepiter-Parser' 'Lepiter-UI-Core' 'Lepiter-UI-Snippet' 'Lepiter-UI-Page' 'Lepiter-UI-IncomingReferences' 'Lepiter-UI-Utilities' 'Lepiter-Utilities' 'Lepiter-Store' 'Lepiter-Translator-Roam') ];
				package: 'Lepiter-Extensions'
					with: [ spec
							requires: #('LepiterXDoc' 'Brick' 'Lepiter-Core' 'Lepiter-Store' 'Lepiter-UI' 'Lepiter-UI-Page') ];
				package: 'Lepiter-Snippet-Text'
					with: [ spec requires: #('Lepiter-Core' 'Lepiter-UI') ];
				package: 'Lepiter-ToC'
					with: [ spec requires: #('Lepiter-Core' 'Lepiter-UI') ];
				package: 'Lepiter-Export'
					with: [ spec
							requires: #('Brick' 'Lepiter-Core' 'LepiterXDoc' 'SmaCCRuntime' 'Lepiter-UI-Snippet' 'Lepiter-Store' 'Lepiter-Snippet-Text') ];
				package: 'Lepiter-HTML'
					with: [ spec
							requires: #('Lepiter-Core' 'Lepiter-Parser' 'Lepiter-Export' 'LepiterXDoc' 'GToolkitReleaser') ];
				package: 'Lepiter-Playground'
					with: [ spec requires: #('Lepiter-Core' 'Lepiter-Store' 'Lepiter-UI') ];
				package: 'Lepiter-Core-Examples'
					with: [ spec
							requires: #('Lepiter-Snippet-Text' 'Lepiter-Store-Class' 'Lepiter-Utilities') ];
				package: 'Lepiter-BasicServer'
					with: [ spec requires: #(Beacon JSONWebToken ZincHTTPComponentsRest) ]
					";
				package: 'LepiterLatex'
					with: [ spec requires: #('Lepiter-Core') ] "
					]
]
