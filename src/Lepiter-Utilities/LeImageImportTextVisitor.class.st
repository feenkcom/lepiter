"
LeImageImportTextVisitor is used by {{gtClass:name=LeImageImportVisitor}} to visit an individual text snippet, download any images that are referenced, i.e. links of the form `![label](url)`, and add them as attachments to the database.

See {{gtClass:name=LeImageImportVisitor}} for more information.

"
Class {
	#name : #LeImageImportTextVisitor,
	#superclass : #Object,
	#traits : 'TLeContentNodeVisitor',
	#classTraits : 'TLeContentNodeVisitor classTrait',
	#instVars : [
		'importer',
		'snippet'
	],
	#category : 'Lepiter-Utilities-ImageImport'
}

{ #category : #accessing }
LeImageImportTextVisitor >> importer [
	^ importer
]

{ #category : #accessing }
LeImageImportTextVisitor >> importer: anObject [
	importer := anObject
]

{ #category : #accessing }
LeImageImportTextVisitor >> snippet [
	<return: #LeTextSnippet>

	^ snippet
]

{ #category : #accessing }
LeImageImportTextVisitor >> snippet: aLeTextSnippet [
	snippet := aLeTextSnippet 
]

{ #category : #generated }
LeImageImportTextVisitor >> visitExternalImageLink: anExternalImageLink [
	"Attempt to download the supplied link and add it as an attachment to the snippet's database."
	| urlString pathString oldString newString |

	urlString := anExternalImageLink url.
	pathString := importer attachURL: urlString.
	pathString ifNil: [ ^ self visitExternalLink: anExternalImageLink ].
	oldString := snippet string.
	newString := String streamContents: [ :stream |
		stream 
			<< (oldString copyFrom: 1 to: anExternalImageLink startPosition);
			<< '[';
			<< anExternalImageLink label;
			<< '](';
			<< pathString;
			<< (oldString copyFrom: anExternalImageLink stopPosition to: oldString size) ].
	snippet updateString: newString.
	^ self visitExternalLink: anExternalImageLink
]
