Extension { #name : #XdUUIDGenerator }

{ #category : #'*Lepiter-HTML-Old' }
XdUUIDGenerator >> nextIdFromPage: aLePage [
	"Return next unique id that can be used to identify objects.
	The {{gtClass:LePage}} instance can be used to generate the id."

	<return: #String>
	^ aLePage uid asString36
]
