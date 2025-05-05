"
Tests reloading all pages from the Glamorous Toolkit book using {{gtClass:LePageStructureAsseambler}}.
"
Class {
	#name : #LeGtBookDatabaseExplicitReloadExamples,
	#superclass : #Object,
	#category : #'Lepiter-Core-Examples-Database'
}

{ #category : #setup }
LeGtBookDatabaseExplicitReloadExamples >> copyGlamorousToolkitBookInMemory [
	| memoryStorage gtBookLocation localStore |

	memoryStorage := FileSystem memory / 'storage'.
	memoryStorage ensureCreateDirectory.
	
	gtBookLocation := GtResourcesUtility default resourceAtPath: Path * 'feenkcom' / 'gtoolkit' / 'lepiter'.
	gtBookLocation copyAllTo: memoryStorage.
	
	localStore := LeLocalStoreLoad current.
	localStore localRoot: memoryStorage.
	^ localStore loadAndMonitorFrom: memoryStorage saveDelay: Duration zero
]

{ #category : #examples }
LeGtBookDatabaseExplicitReloadExamples >> reloadAllPagesFromDisk [
	<gtExample>
	<return: #LePageStructureAssemblersGroup>
	| existinDatabase replacementDatabase asseamblers |
	existinDatabase := self copyGlamorousToolkitBookInMemory.
	existinDatabase stopMonitoring.

	asseamblers := LePageStructureAssemblersGroup new.
	replacementDatabase := self copyGlamorousToolkitBookInMemory.
	(replacementDatabase pages
		reject: [ :aPage | 
			aPage allChildrenDepthFirst
				anySatisfy: [ :aSnippet | aSnippet isUnknownSnippet ] ])
		do: [ :aReplacementPage | 
			| existingPage initialJsonContent newJsonContent asseambler |
			existingPage := existinDatabase pageWithID: aReplacementPage uid.
			initialJsonContent := LeJsonV4 uniqueInstance serializePretty: existingPage.

			asseambler := existingPage rebuildFromContent: aReplacementPage.
			asseamblers add: asseambler.

			newJsonContent := LeJsonV4 uniqueInstance serializePretty: existingPage.

			self assert: newJsonContent equals: initialJsonContent ].

	self assert: asseamblers size > 0.

	^ asseamblers
]
