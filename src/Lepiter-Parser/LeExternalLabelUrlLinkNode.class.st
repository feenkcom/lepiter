Class {
	#name : #LeExternalLabelUrlLinkNode,
	#superclass : #LeExternalLinkNode,
	#category : #'Lepiter-Parser'
}

{ #category : #generated }
LeExternalLabelUrlLinkNode >> acceptVisitor: aContentVisitor [
	^ aContentVisitor visitExternalLabelUrlLink: self
]

{ #category : #accessing }
LeExternalLabelUrlLinkNode >> displayLabel [
	"Answer the string that should be used to display the receiver.
	If a label is present, use that, otherwise the URL"

	^ self label ifEmpty: [ self url ]
]

{ #category : #actions }
LeExternalLabelUrlLinkNode >> gtCopyUrlToClipboardActionFor: anAction [
	<gtAction>
	| urlUtility |
	self attributes
		at: #urlUtility
		ifPresent: [ :present | urlUtility := present ]
		ifAbsent: [ ^ anAction noAction ].
	urlUtility isFile ifTrue: [ ^ anAction noAction ].
	^ anAction button
		priority: 1;
		id: #'menu--copy-url';
		label: 'Copy URL to Clipboard';
		target: LeExternalLinkNodeActionTarget;
		action: [ :aButton | GtClipboard clipboardText: urlUtility asString ]
]

{ #category : #actions }
LeExternalLabelUrlLinkNode >> gtInspectUrlStringActionFor: anAction [
	<gtAction>
	| urlUtility |
	self attributes
		at: #urlUtility
		ifPresent: [ :present | urlUtility := present ]
		ifAbsent: [ ^ anAction noAction ].
	urlUtility isFile ifTrue: [ ^ anAction noAction ].
	^ anAction button
		priority: 2;
		id: #'menu--inspect-string';
		label: 'Inspect URL String';
		target: LeExternalLinkNodeActionTarget;
		action: [ :aButton | aButton phlow spawnObject: urlUtility asString ]
]

{ #category : #accessing }
LeExternalLabelUrlLinkNode >> label [ 
	| linkString endOfLabel |

	linkString := self link source.
	endOfLabel := linkString indexOf: $].
	self assert: endOfLabel > 0.
	^ linkString copyFrom: 2 to: endOfLabel - 1.
]

{ #category : #accessing }
LeExternalLabelUrlLinkNode >> url [
	"Answer the destination, excluding Markdown delimiters."

	| linkString endOfLabel destination |
	linkString := self link source.
	endOfLabel := linkString indexOfSubCollection: ']('.
	self assert: endOfLabel > 0.
	destination := linkString copyFrom: endOfLabel + 2 to: linkString size - 1.
	((destination beginsWith: '<') and: [ destination endsWith: '>' ])
		ifTrue: [ destination := destination copyFrom: 2 to: destination size - 1 ].
	^ destination
]
