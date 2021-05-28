Extension { #name : #LeSnippet }

{ #category : #'*Lepiter-Translator-Roam' }
LeSnippet >> roamJsonStringContent [
	"Return the string content that will be exported in plain JSON.
	This is used for Roam JSON exports"
	^ self acceptVisitor: LeRoamJSONExportVisitor new
]
