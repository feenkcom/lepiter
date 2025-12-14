Class {
	#name : #LeExternalUrlLinkNode,
	#superclass : #LeExternalLinkNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeExternalUrlLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitExternalUrlLink: self
]

{ #category : #actions }
LeExternalUrlLinkNode >> gtCopyUrlToClipboardActionFor: anAction [
	<gtAction>
	| urlUtility |
	self attributes
		at: #urlUtility
		ifPresent: [ :present | urlUtility := present ]
		ifAbsent: [ ^ anAction noAction ].
	urlUtility isFile ifTrue: [ ^ anAction noAction ].
	^ anAction button
		priority: 1;
		label: 'Copy URL to Clipboard';
		target: LeExternalLinkNodeActionTarget;
		action: [  "id: #'menu--maximize-pane';":aButton | GtClipboard clipboardText: urlUtility asString ]
]

{ #category : #actions }
LeExternalUrlLinkNode >> gtInspectUrlStringActionFor: anAction [
	<gtAction>
	| urlUtility |
	self attributes
		at: #urlUtility
		ifPresent: [ :present | urlUtility := present ]
		ifAbsent: [ ^ anAction noAction ].
	urlUtility isFile ifTrue: [ ^ anAction noAction ].
	^ anAction button
		priority: 2;
		label: 'Inspect URL String';
		target: LeExternalLinkNodeActionTarget;
		action: [ :aButton | aButton phlow spawnObject: urlUtility asString ]
]

{ #category : #accessing }
LeExternalUrlLinkNode >> url [ 
	| linkString |

	linkString := self link source.
	^ linkString copyFrom: 2 to: linkString size - 1
]
