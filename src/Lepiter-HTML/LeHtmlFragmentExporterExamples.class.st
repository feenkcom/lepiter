"
Demonstrate the operation of {{gtClass:name=LeHtmlFragmentExporterVisitor}}.

Since there is no page or database present at this level, links to other pages, etc. can't be resolved and page related tags such as body, metadata, etc. are not included.  See {{gtClass:name=LeHtmlPageExporterVisitor}}.

"
Class {
	#name : #LeHtmlFragmentExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlFragmentExporterExamples >> basicMarkdown [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '*italic* **bold** `mono`'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	self assert: html trimBoth
		equals: '<div class="text_snippet"><i>italic</i> <b>bold</b> <code>mono</code></div>'.
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> classAnnotation [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtClass:LeHtmlFragmentExporterExamples}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	self assert: html trimBoth
		equals: '<div class="text_snippet"><span class="class_annotation">LeHtmlFragmentExporterExamples<span class="class_definition">Object subclass: #LeHtmlFragmentExporterExamples
	instanceVariableNames: ''''
	classVariableNames: ''''
	package: ''Lepiter-HTML-Examples''<br></span></span>
</div>'.
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> codeBlock [
	"Confirm that a code block is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '```\answer:=42.\```' withCRs.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	self assert: html trimBoth
		equals: '<div class="text_snippet"><div class="code_block"><pre><code class="hljs smalltalk">\answer:=42.\</code></pre></div>\</div>' withCRs.
	^ html
]

{ #category : #examples }
LeHtmlFragmentExporterExamples >> methodAnnotation [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtMethod:LeHtmlFragmentExporterExamples>>#basicMarkdown}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	self assert: (html includesSubstring: 'method_annotation').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples&gt;&gt;#basicMarkdown').
	self assert: (html includesSubstring: 'method_definition').
	^ html
]

{ #category : #accessing }
LeHtmlFragmentExporterExamples >> pharoSnippet [
	<gtExample>
	| markdown html |
	markdown := LePharoSnippet code: 'answer := 41.'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
	^ html

]

{ #category : #accessing }
LeHtmlFragmentExporterExamples >> tweetSnippet [
	<gtExample>
	| markdown html |
	markdown := LeTweetReferenceSnippet new
		url:'https://twitter.com/testing_jk/status/1359470619839070211';
		tweet: LeTweetRefSnippetExamples new validTweet.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlFragmentExporterVisitor new stream: stream) ].
		
	'<blockquote class="twitter-tweet"><p lang="es" dir="ltr">Cosmos <a href="https://t.co/qrF9Wfhrop">pic.twitter.com/qrF9Wfhrop</a></p>&mdash; JKTesting (@testing_jk) <a href="https://twitter.com/testing_jk/status/1359470619839070211?ref_src=twsrc%5Etfw">February 10, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>'.
	'<blockquote class="twitter-tweet"><p lang="es" dir="ltr">Eloquent. <a href="https://t.co/ndI6Y7B9qi">https://t.co/ndI6Y7B9qi</a></p>&mdash; Tudor Girba (@girba) <a href="https://twitter.com/girba/status/1405805371617329160?ref_src=twsrc%5Etfw">June 18, 2021</a></blockquote> <script async src="https://platform.twitter.com/widgets.js" charset="utf-8"></script>'.
	^ html

]
