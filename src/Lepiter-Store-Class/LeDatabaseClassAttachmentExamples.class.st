Class {
	#name : #LeDatabaseClassAttachmentExamples,
	#superclass : #LeDatabaseClassExamples,
	#category : #'Lepiter-Store-Class-Examples'
}

{ #category : #accessing }
LeDatabaseClassAttachmentExamples >> addAttachmentByContent [
	"Demonstrate attaching a file to a database by utf-8 content"

	<gtExample>
	<after: #stopMonitor>
	<return: #ByteString>
	| attachmentId userEmail now properties memFS |
	self monitorWithDuration: Duration zero.
	memFS := FileSystem memory root.

	userEmail := 'attached@email.com'.
	database properties savePersonalInformation: true.
	database userEmail: userEmail.
	now := DateAndTime now.

	self assert: monitor attachmentIds isEmpty.

	attachmentId := database
			addAttachmentWithContent: 'Hello, World'
			named: 'attachment.txt'.
	self
		assert: (monitor dbClass respondsTo: ('attachment_' , attachmentId) asSymbol).

	properties := database attachmentProperties: attachmentId.
	self assert: properties uploadedBy email equals: userEmail.	"It isn't actually possible to directly reference the original, since it is a memory file system.  Just check that the path is correct."
	self assert: properties originalReference basename equals: 'attachment.txt'.
	self assert: properties uploadDate - now < 1 hour.
	self
		assert: (database attachmentUtf8Stream: attachmentId do: [ :stream | stream contents ])
		equals: 'Hello, World'.
	self
		assert: (database attachmentBinaryStream: attachmentId do: [ :stream | stream contents ])
		equals: 'Hello, World' utf8Encoded.
	^ attachmentId
]

{ #category : #accessing }
LeDatabaseClassAttachmentExamples >> addAttachmentByCopy [
	"Demonstrate attaching a file to a database by copy"

	<gtExample>
	<after: #stopMonitor>
	<return: #ByteString>
	| attachmentId attachmentPath attachmentSource userEmail now properties memFS |
	self monitorWithDuration: Duration zero.
	memFS := FileSystem memory root.

	attachmentSource := memFS / 'attachment.txt'.
	attachmentSource writeStreamDo: [ :stream | stream << 'Hello, World' ].

	userEmail := 'attached@email.com'.
	database properties savePersonalInformation: true.
	database userEmail: userEmail.
	now := DateAndTime now.

	self assert: monitor attachmentIds isEmpty.

	attachmentPath := database addAttachmentByCopy: attachmentSource.
	self assert: (attachmentPath splitOn: '/') size equals: 3.
	self assert: (attachmentPath splitOn: '/') first equals: 'attachments'.
	self assert: (attachmentPath splitOn: '/') third equals: 'attachment.txt'.

	attachmentId := (attachmentPath splitOn: '/') second.
	self assert: attachmentSource exists.
	self
		assert: (monitor dbClass respondsTo: ('attachment_' , attachmentId) asSymbol).

	properties := database attachmentProperties: attachmentId.
	self assert: properties uploadedBy email equals: userEmail.	"It isn't actually possible to directly reference the original, since it is a memory file system.  Just check that the path is correct."
	self assert: properties originalReference path equals: attachmentSource path.
	self assert: properties uploadDate - now < 1 hour.
	self
		assert: (database attachmentUtf8Stream: attachmentId do: [ :stream | stream contents ])
		equals: 'Hello, World'.
	self
		assert: (database attachmentBinaryStream: attachmentId do: [ :stream | stream contents ])
		equals: 'Hello, World' utf8Encoded.
	^ attachmentId
]

{ #category : #accessing }
LeDatabaseClassAttachmentExamples >> addAttachmentByMove [
	"Demonstrate attaching a file to a database by copy"

	<gtExample>
	<after: #stopMonitor>
	<return: #LeDatabaseClassAttachmentExamples>
	| attachmentSource userEmail now memFS |
	self monitorWithDuration: Duration zero.
	memFS := FileSystem memory root.

	attachmentSource := memFS / 'attachment.txt'.
	attachmentSource writeStreamDo: [ :stream | stream << 'Hello, World' ].

	userEmail := 'attached@email.com'.
	database properties savePersonalInformation: true.
	database userEmail: userEmail.
	now := DateAndTime now.

	self assert: monitor attachmentIds isEmpty.

	self should: [ database addAttachmentByMove: attachmentSource ] raise: Error
]
