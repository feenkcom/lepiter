Class {
	#name : #LePasteSnippetCommandItem,
	#superclass : #Object,
	#classVars : [
		'Enabled'
	],
	#category : #'Lepiter-UI-Snippet'
}

{ #category : #private }
LePasteSnippetCommandItem class >> contextMenuItemSpecification [
	<leSnippetSpecification>
	^ LeContextMenuItemCommandSpecification new
		snippetClass: self;
		title: self description;
		commandGenerator: [ :referenceSnippet | self snippetCommandFromClipboard: referenceSnippet ]
]

{ #category : #'api - accessing menu' }
LePasteSnippetCommandItem class >> description [
	^ 'Paste from clipboard'
]

{ #category : #accessing }
LePasteSnippetCommandItem class >> enabled [
	^ Enabled ifNil: [ false ]
]

{ #category : #accessing }
LePasteSnippetCommandItem class >> enabled: anObject [
	Enabled := anObject
]

{ #category : #'api - accessing menu' }
LePasteSnippetCommandItem class >> snippetCommandFromClipboard: referenceSnippet [
	| snippet |

	snippet := LeJsonV4 uniqueInstance deserialize: Clipboard default clipboardText asString readStream.
	snippet uid: referenceSnippet database newUID.
	snippet allChildrenBreadthFirstDo: [ :child |
		child uid: referenceSnippet database newUID ].

	^ referenceSnippet commandBuilder insertChildSnippetTreeCommand
			forSnippet: snippet.
]
