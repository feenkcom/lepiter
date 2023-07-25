"
Some old [](https://lepiter.io) post image links use `![](file://attachments/uuid/file.png)` instead of `![](file:///attachments/uuid/file.png)` that use *three shashes*. 

If two slases are used, e.g., `file://host/path`, it implies that `attachemnts` part is a hostname, which is incorrect. This object fixes it to `file:///attachements/...`. See more details about File URI sheme at [Wikipedia](https://en.wikipedia.org/wiki/File_URI_scheme#How_many_slashes).

We can remove this object once we know that we do not have such links in lepiter databases. See [feenkcom/gtoolkit#3365](https://github.com/feenkcom/gtoolkit/issues/3365). 

"
Class {
	#name : #LeUrlStringUtilityTwoSlashesFixer,
	#superclass : #Object,
	#instVars : [
		'urlString',
		'fixedUrlString'
	],
	#category : #'Lepiter-Core-Utility'
}

{ #category : #'api - fixing' }
LeUrlStringUtilityTwoSlashesFixer >> fix [
	fixedUrlString := self urlString.
	(fixedUrlString beginsWith: self twoSlashTemplate)
		ifTrue: [ fixedUrlString := fixedUrlString
					copyReplaceAll: self twoSlashTemplate
					with: 'file:///attachments/' ]
]

{ #category : #accessing }
LeUrlStringUtilityTwoSlashesFixer >> fixedUrlString [
	^ fixedUrlString
]

{ #category : #private }
LeUrlStringUtilityTwoSlashesFixer >> twoSlashTemplate [
	^ 'file://attachments/'
]

{ #category : #accessing }
LeUrlStringUtilityTwoSlashesFixer >> urlString [
	^ urlString
]

{ #category : #accessing }
LeUrlStringUtilityTwoSlashesFixer >> urlString: anObject [
	urlString := anObject
]
