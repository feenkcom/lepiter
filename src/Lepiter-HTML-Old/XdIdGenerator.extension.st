Extension { #name : #XdIdGenerator }

{ #category : #'*Lepiter-HTML-Old' }
XdIdGenerator >> nextIdFromPage: aLePage [
	"Return next unique id that can be used to identify objects.
	The {{gtClass:LePage}} instance can be used to generate the id."

	<return: #String>
	^ self nextId
]
