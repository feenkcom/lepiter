"
Visit all .pillar files in the rootDirectory and below and convert them to lepiter pages in leDatabase.

Typical usage:

```
LePillarFileConverterVisitor new
	rootDirectory: '/path/to/pillar/documentation' asFileReference;
	leDatabase: aLeDatabase;
	preorder.
```

"
Class {
	#name : #LePillarFileConverterVisitor,
	#superclass : #FileSystemVisitor,
	#instVars : [
		'rootDirectory',
		'leDatabase',
		'out'
	],
	#category : #'Lepiter-Converter'
}

{ #category : #accessing }
LePillarFileConverterVisitor >> leDatabase [
	^ leDatabase
]

{ #category : #accessing }
LePillarFileConverterVisitor >> leDatabase: anObject [
	leDatabase := anObject
]

{ #category : #actions }
LePillarFileConverterVisitor >> preorder [
	| guide |

	guide := PreorderGuide for: self.
	guide selectChildren: [ :parentEntry | 
		"Don't follow symlinks or git internal directories"
		parentEntry isSymlink not and:
			[ parentEntry basename ~= '.git' ] ].
	^ self visit: rootDirectory with: guide.
]

{ #category : #accessing }
LePillarFileConverterVisitor >> rootDirectory [
	^ rootDirectory
]

{ #category : #accessing }
LePillarFileConverterVisitor >> rootDirectory: anObject [
	rootDirectory := anObject
]

{ #category : #visiting }
LePillarFileConverterVisitor >> visit: aReference with: aGuide [
	out := (Array new: 10) writeStream.
	aGuide show: aReference.
	^ out contents
]

{ #category : #visiting }
LePillarFileConverterVisitor >> visitFile: aReference [

	aReference extension = #pillar ifFalse: [ ^ self ].

	LePillarFileConverter 
		convert: aReference reference
		in: leDatabase.
]
