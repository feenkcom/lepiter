Extension { #name : #LeModelExamples }

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> changeSnippetsPageTitle [
	^ 'Change snippets'
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> createClassChange [
^ 'OmEntry {
	#tags : {
		#author : ''GlamorousAuthor'',
		#time : DateAndTime [ ''2024-04-01T12:32:40.324219-03:00'' ],
		#prior : OmReference [ ''7'' ],
		#self : OmReference [ ''8'' ]
	},
	#content : EpClassAddition {
		#class : RGClassDefinition {
			#annotations : IdentityDictionary {
				#traitCompositionSource : ''{}'',
				#definitionSource : ''Object subclass: #LeOnDemandDummyClass\r\tinstanceVariableNames: \''\''\r\tclassVariableNames: \''\''\r\tpackage: \''LepiterOnDemandDummies\'''',
				#superclassName : ''Object''
			},
			#name : #LeOnDemandDummyClass,
			#methods : IdentityDictionary { },
			#protocols : Set [ ],
			#instanceVariables : OrderedCollection [ ],
			#metaClass : RGMetaclassDefinition {
				#annotations : IdentityDictionary {
					#traitCompositionSource : ''{}'',
					#definitionSource : ''LeOnDemandDummyClass class\r\tinstanceVariableNames: \''\''''
				},
				#name : #''LeOnDemandDummyClass class'',
				#methods : IdentityDictionary { },
				#protocols : Set [ ],
				#instanceVariables : OrderedCollection [ ],
				#baseClass : @7
			},
			#comment : RGCommentDefinition {
				#annotations : IdentityDictionary {
					#className : #LeOnDemandDummyClass,
					#isMetaSide : false
				},
				#parent : @7,
				#content : ''''
			},
			#classVariables : OrderedCollection [ ],
			#category : #LepiterOnDemandDummies,
			#package : #LepiterOnDemandDummies,
			#sharedPools : OrderedCollection [ ]
		}
	}
}
'
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> createMethodChange [
	^ 'OmEntry {
	#tags : {
		#author : ''GlamorousAuthor'',
		#time : DateAndTime [ ''2024-04-01T12:43:15.069521-03:00'' ],
		#prior : OmReference [ ''19'' ],
		#self : OmReference [ ''20'' ]
	},
	#content : EpMethodAddition {
		#method : RGMethodDefinition {
			#annotations : IdentityDictionary {
				#className : #LeOnDemandDummyClass,
				#isMetaSide : false
			},
			#name : #example,
			#protocol : #accessing,
			#sourceCode : ''example\r\t<gtExample>\r\tself assert: (self isKindOf: LeOnDemandDummyClass).\r\tself assert: self printString isNotEmpty.\r\r\t^ self'',
			#stamp : '''',
			#package : #LepiterOnDemandDummies
		}
	}
}'
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> databaseWithPageHavingChangeAndDependentSnippets [
	<gtExample>
	| temporaryDatabase database page createClassPath createClassSnippet createMethodPath createMethodSnippet exampleSnippet |
	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	page := database pageBuilder
			title: self changeSnippetsPageTitle;
			add.

	createClassPath := database
			addAttachmentWithContent: self createClassChange
			named: 'createClass.ombu'.
	createClassSnippet := LeChangesSnippet new
			fileName: createClassPath;
			previewHeight: 220.
	page addSnippet: createClassSnippet.
	page snippetBuilder
		string: '{{gtClass:LeOnDemandDummyClass}}';
		add.

	createMethodPath := database
			addAttachmentWithContent: self createMethodChange
			named: 'createMethod.ombu'.
	createMethodSnippet := LeChangesSnippet new
			fileName: createMethodPath;
			previewHeight: 220.
	page addSnippet: createMethodSnippet.
	page snippetBuilder
		string: '{{gtMethod:LeOnDemandDummyClass >> #example}}';
		add.

	exampleSnippet := LeExampleSnippet empty
			exampleBehaviorName: #LeOnDemandDummyClass;
			exampleSelector: #example;
			codeExpanded: false;
			noCode: true;
			previewExpanded: true;
			previewHeight: 250.
	page addSnippet: exampleSnippet.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> databaseWithStringAndPharoSnippets [
	<gtExample>

	| temporaryDatabase database page pharoSnippet stringSnippet |

	temporaryDatabase := LeTemporaryDatabase new.
	database := temporaryDatabase database.

	page := database pageBuilder
			title: self stringAndPharoPageTitle;
			add.

	stringSnippet := LeStringSnippet new
			contentString: self stringJSONContents;
			bindingName: self stringBindingName;
			format: JSONParser name.
	page addSnippet: stringSnippet.

	pharoSnippet := LePharoSnippet empty code: self stringBindingName.
	page addSnippet: pharoSnippet.

	^ temporaryDatabase
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> pageHavingChangeAndDependentSnippets [

	<gtExample>
	| temporaryDatabase database page |
	temporaryDatabase := self databaseWithPageHavingChangeAndDependentSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self changeSnippetsPageTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> pageHavingStringAndPharoSnippets [
	<gtExample>
	
	| temporaryDatabase database page |
	
	temporaryDatabase := self databaseWithStringAndPharoSnippets.
	database := temporaryDatabase database.

	page := database pageNamed: self stringAndPharoPageTitle.

	^ LePageExampleHolder new
		page: page;
		temporaryDatabase: temporaryDatabase
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> stringAndPharoPageTitle [
	^ 'String and Pharo snippets'
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> stringBindingName [
	^ 'jsonQuery'
]

{ #category : #'*Lepiter-Snippets' }
LeModelExamples >> stringJSONContents [
	^ '{
  "name": "Elizabeth",
  "children": [
    {
      "name": "Charles",
      "children": [
        {
          "name": "William",
          "children": [
            { "name": "George" },
            { "name": "Charlotte" }
          ]
        },
        {
          "name": "Harry",
          "children": [
          	{ "name": "Archie" },
          	{ "name": "Lilibet" }
          ]
        }
      ]
    }
  ]
}'
]
