Class {
	#name : #LeRoamJsonDatabaseMergeExamples,
	#superclass : #Object,
	#category : #'Lepiter-Translator-Roam-Example'
}

{ #category : #examples }
LeRoamJsonDatabaseMergeExamples >> roamMetadataMerge [
	"Merge a sample database in to an empty database and confirm that the metadata is maintained correctly."

	<gtExample>
	<return: #LeDatabase>
	| database json mergeDb mergeP1 mergeP2 dbP1 dbP2 |
	json := (self class >> #sampleRoamExport) comments second
			copyReplaceAll: '""'
			with: '"'.
	mergeDb := LeRoamJsonTranslator new databaseFromStream: json readStream.
	database := LeDatabase new.
	database userEmail: 'import@user.com'.
	LeDatabaseMerge merge: mergeDb into: database.
	self assert: database pageCount equals: 2.	"The original DB is damaged as part of the merge, recreate it"
	mergeDb := LeRoamJsonTranslator new databaseFromStream: json readStream.
	mergeP1 := mergeDb pageNamed: 'Page 1'.
	mergeP2 := mergeDb pageNamed: 'Page 2'.

	dbP1 := database pageNamed: 'Page 1'.
	dbP2 := database pageNamed: 'Page 2'.

	self assert: dbP1 createTime equals: mergeP1 createTime.
	self assert: dbP1 editTime equals: mergeP1 editTime.
	self assert: dbP1 createEmail equals: mergeP1 createEmail.
	self assert: dbP1 editEmail equals: mergeP1 editEmail.

	self assert: dbP2 createTime equals: mergeP2 createTime.
	self assert: dbP2 editTime equals: mergeP2 editTime.
	self assert: dbP2 createEmail equals: mergeP2 createEmail.
	self assert: dbP2 editEmail equals: mergeP2 editEmail.

	^ mergeDb
]

{ #category : #private }
LeRoamJsonDatabaseMergeExamples >> sampleRoamExport [
	"The comment below is retrieved as the Roam JSON file"
	"[{""create-time"":1583400473000,""create-email"":""user@email.com"",""edit-time"":1593093861000,""edit-email"":""user@email.com"",""uid"":""9JXk99ud"",""children"":[{""create-time"":1583400473000,""create-email"":""user@email.com"",""edit-time"":1593093861000,""edit-email"":""user@email.com"",""uid"":""vk+ew4bd"",""string"":""[https://www.stephenwolfram.com/publications/what-ultimately-possible-physics/](https://www.stephenwolfram.com/publications/what-ultimately-possible-physics/)zotero://select/items/1_KR6KVTEW:""},{""create-time"":1583400473000,""create-email"":""user@email.com"",""edit-time"":1593093861000,""edit-email"":""user@email.com"",""uid"":""plGMaGzP"",""string"":""Author: [[Page 2]]""},{""create-time"":1583400473000,""create-email"":""user@email.com"",""edit-time"":1593093861000,""edit-email"":""user@email.com"",""uid"":""gqUN4Oor"",""string"":""Discusses the possibility of finding computational models for our universe.""}],""title"":""Page 1""},
{""create-time"":1583400473000,""create-email"":""user@email.com"",""edit-time"":1593093861000,""edit-email"":""user@email.com"",""uid"":""Dj5aH1uN"",""children"":[],""title"":""Page 2""}]"

]
