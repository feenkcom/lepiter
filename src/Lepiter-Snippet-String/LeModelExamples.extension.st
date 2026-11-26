Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Snippet-String' }
LeModelExamples >> stringSnippetWithTheSameParserSelectedAgain [
	"A string snippet read from disk has its format (the parser name) as a String:
	selecting the same parser again does not change the format"

	<gtExample>
	<return: #LeStringSnippet>
	| snippet announcements |
	snippet := LeStringSnippet new.
	snippet format: 'JSONParser'.
	announcements := OrderedCollection new.
	snippet announcer
		when: LeStringFormatChanged
		do: [ :anAnnouncement | announcements add: anAnnouncement ]
		for: self.
	snippet selectParserClass: JSONParser.
	self assert: announcements isEmpty.
	snippet selectParserClass: XMLParser.
	self assert: announcements size equals: 1.
	self assert: snippet format equals: #XMLParser.
	^ snippet
]
