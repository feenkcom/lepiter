Class {
	#name : #LeDatabasePropertyExamples,
	#superclass : #LeLocalExamples,
	#category : #'Lepiter-Store-Local-Examples'
}

{ #category : #examples }
LeDatabasePropertyExamples >> databaseWithPersonalInfo [
	"Check the personal information saved to disk when savePersonalInformation is true"

	<gtExample>
	<return: #LeDatabasePropertyExamples>
	| testAttachment pathString properties dbProperties |
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.
	testAttachment := memStore parent / 'test.attachment'.
	testAttachment ensureCreateFile.
	database := LeLocalStoreLoad current loadAndMonitorFrom: memStore.
	database monitor savePersonalInformation: true.
	pathString := database addAttachmentByCopy: testAttachment.

	properties := STONJSON
			fromString: ((memStore / pathString) parent / LeAttachment basename) contents.
	dbProperties := STONJSON
			fromString: (memStore / database properties propertiesBasename) contents.

	self assert: (dbProperties at: #savePersonalInformation) equals: true.
	self assert: (properties includesKey: #originalReference).
	self
		assert: ((properties at: #originalReference) at: #filename)
		equals: '/test.attachment'
]

{ #category : #examples }
LeDatabasePropertyExamples >> databaseWithoutPersonalInfo [
	"Confirm that attachment properties don't include personal information when saved to disk"

	<gtExample>
	<return: #LeDatabasePropertyExamples>
	| testAttachment pathString properties |
	memStore := FileSystem memory root / 'db'.
	memStore ensureCreateDirectory.
	testAttachment := memStore parent / 'test.attachment'.
	testAttachment ensureCreateFile.
	database := LeLocalStoreLoad current loadAndMonitorFrom: memStore.
	pathString := database addAttachmentByCopy: testAttachment.

	properties := STONJSON
			fromString: ((memStore / pathString) parent / LeAttachment basename) contents.
	self deny: (properties includesKey: #originalReference)
]
