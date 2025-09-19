Class {
	#name : #LeSmaCCRewriteSnippetExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-SmaCC-Rewrites-Examples'
}

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> executeReplaceInDirectory [
	<gtExample>
	<return: #LeSmaCCRewriteReplaceResult>
	| snippet context results fileResults |
	context := self snippetContext.
	snippet := self rewriteSnippet.
	snippet search: '`system`.println(`a{beList}`)'.
	snippet replace: '`system`.print(`a`)'.
	results := snippet
			executeReplaceIn: (context sharedBindings bindingOf: #directory) value.
	fileResults := results fileResultsStream toArray wait.
	self assert: fileResults size equals: 2.
	^ results
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> executeSearch [
	<gtExample>
	<return: #LeSmaCCRewriteSearchResult>
	| snippet context results fileResult nodes |
	context := self snippetContext.
	snippet := self rewriteSnippet.
	snippet search: '`system`.out'.
	results := snippet
			executeSearchInFiles: {(context sharedBindings bindingOf: #file) value} asAsyncStream.
	fileResult := results fileResultsStream toArray wait first.
	self
		assert: fileResult file
		equals: (context sharedBindings bindingOf: #file) value.
	nodes := fileResult nodes toArray wait.
	self assert: nodes size equals: 1.
	^ results
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> executeSearchAcrossDirectory [
	<gtExample>
	<return: #LeSmaCCRewriteSearchResult>
	| snippet context results fileResults |
	context := self snippetContext.
	snippet := self rewriteSnippet.
	snippet search: '`system`.println(`a{beList}`)'.
	results := snippet
			executeSearchIn: (context sharedBindings bindingOf: #directory) value.
	fileResults := results fileResultsStream toArray wait.
	self assert: fileResults size equals: 2.
	^ results
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> fileReferences [
	<gtExample>
	<return: #AsyncWithoutDuplicatesStream>
	| snippet context results refs |
	context := self snippetContext.
	snippet := self rewriteSnippet.
	results := snippet
			fileReferencesIn: (context sharedBindings bindingOf: #directory) value.
	refs := results toArray wait.
	self assert: refs size equals: 2.
	^ results
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> filterDescriptors [
	<gtExample>
	<return: #OrderedCollection>
	| snippet context descriptors |
	context := self snippetContext.
	snippet := self rewriteSnippet.
	descriptors := snippet filterDescriptorsUsing: context.
	self
		assert: (descriptors collect: #name) asSortedCollection asArray
		equals: #('directory' 'file' 'files').
	context selfObject: (context sharedBindings bindingOf: #file) value.
	descriptors := snippet filterDescriptorsUsing: context.
	self
		assert: (descriptors collect: #name) asSortedCollection asArray
		equals: #('directory' 'file' 'files' 'self').
	^ descriptors
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> javaFile [
	^ 'helloworld.java'
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> rewriteSnippet [
	<gtExample>
	<return: #LeSmaCCRewriteSnippet>
	| page snippet |
	page := LePage named: 'Test page'.
	page
		addSnippet: (LePharoSnippet new
				code: 'one := 1.
					noValue := nil.
					file := ' , self javaFile storeString
						, ' asFileReference.
					files := {file}.
					directory := ''.'' asFileReference';
				yourself).
	snippet := LeSmaCCRewriteSnippet new.
	snippet parser: #JavaParser.
	page addSnippet: snippet.
	^ snippet
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> snippetContext [
	<gtExample>
	<return: #LeSharedSnippetContext>
	| context directory |
	context := LeSharedSnippetContext new.
	context selfObject: 1.
	directory := self sourceDirectory.
	(context sharedBindings bindingOf: #one) value: 1.
	(context sharedBindings bindingOf: #noValue) value: nil.
	(context sharedBindings bindingOf: #file) value: directory / self javaFile.
	(context sharedBindings bindingOf: #files) value: {directory / self javaFile}.
	(context sharedBindings bindingOf: #directory) value: directory.
	^ context
]

{ #category : #accessing }
LeSmaCCRewriteSnippetExamples >> sourceDirectory [
	<gtExample>
	<return: #FileReference>
	| fileSystem dir |
	fileSystem := FileSystem memory.
	dir := fileSystem / 'src'.
	dir ensureCreateDirectory.
	dir / self javaFile
		writeStreamDo: [ :stream | 
			stream
				<< 'class HelloWorld {
    public static void main(String[] args) {
        System.out.println("Hello, World!"); 
    }
}' ].
	dir / 'goodbye.java'
		writeStreamDo: [ :stream | 
			stream
				<< 'class GoodbyeWorld {
    public static void main(String[] args) {
        System.err.println("Goodbye, World!"); 
    }
}' ].
	dir / 'README.txt' writeStreamDo: [ :stream | stream << 'Testing' ].
	^ dir
]
