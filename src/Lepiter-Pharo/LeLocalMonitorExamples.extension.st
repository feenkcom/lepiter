Extension { #name : #LeLocalMonitorExamples }

{ #category : #'*Lepiter-Pharo' }
LeLocalMonitorExamples >> createDatabase [
	"Reset the receiver and create a sample database"

	| page1 page2 page3 page4 |
	database := LeDatabase new.
	page1 := database pageBuilder
		title: 'Page 1';
		add.
	page1 snippetBuilder
		string: 'Page 1 Paragraph 1';
		add.
	page2 := database pageBuilder
		title: 'Page 2';
		add.
	page2 snippetBuilder
		string: 'Page 2 Paragraph 1';
		add.
	page2 snippetBuilder
		string: 'Page 2 link to [[Page 1]]';
		add.
	page3 := database pageBuilder
		title: 'Page 3';
		add.
	page3 snippetBuilder
		string: 'Page 3 Paragraph 1';
		add.
	page4 := database pageBuilder
		title: 'Page 4';
		add.
	page4 snippetBuilder
		string: 'Pharo snippet follows';
		add.
	page4 addSnippet: (LePharoSnippet new code: '42 inspect').
	^ database
]

{ #category : #'*Lepiter-Pharo' }
LeLocalMonitorExamples >> snippetTypes [
	"Create a database and one page with all block types"

	<gtExample>
	<return: #LeDatabase>
	| page1 |
	self reset.
	database := LeDatabase new.
	page1 := database pageBuilder
			title: 'Page 1';
			add.
	page1 snippetBuilder
		string: 'Text Block';
		add.
	page1 addSnippet: (LePharoSnippet new code: '42 inspect').
	self assert: page1 childrenCount equals: 2.
	self assert: page1 children first string equals: 'Text Block'.
	self assert: page1 children second code equals: '42 inspect'.
	^ database
]
