Class {
	#name : #LeHtmlBookFragmentExporterExamples,
	#superclass : #Object,
	#category : #'Lepiter-HTML-Examples'
}

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> basicMarkdown [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |
	markdown := LeTextSnippet string: '*italic* **bold** `mono`'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new stream: stream) ].
	self assert: html trimBoth
		equals: '<div class="snippet textual-snippet text-snippet">
  <p>
<i>italic</i> <b>bold</b> <code>mono</code>
  </p>
</div>'.
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> classAnnotation [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtClass:LeHtmlFragmentExporterExamples}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new stream: stream) ].
	self assert: (html includesSubstring: '<code class="class_annotation">').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples').
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> codeBlock [
	"Confirm that a code block is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '```\answer:=42.\```' withCRs.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new stream: stream) ].
		
	self assert: html trimBoth
		equals: '<div class="snippet textual-snippet text-snippet">
  <p>
    <div class="code_block">
      <pre>
        <code class="smalltalk">
answer:=42.
        </code>
      </pre>
    </div>
  </p>
</div>'.
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> elementSnippet [
	<gtExample>
	| snippet html aResources |

	snippet := LeElementSnippet 
		code: BrExamplesShowroom name, ' new ', #glamorousBreadcrumb asString.
	html := String streamContents: [ :stream |
		snippet acceptVisitor: (LeHtmlBookFragmentExporterVisitor new 
			externalPicturesWriter: (aResources := LeResourcesExporter new);
			stream: stream) ].
			
	self 
		assert: html isNotEmpty 
		description: [ 'HTML output must be non-empty'].
	
	self assert: (html includesSubstring: '<figure class="snippet picture-snippet').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>').
	
	self assert: aResources asArray size equals: 1.
	
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> exampleSnippet [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeExampleSnippet new 
		exampleBehaviorName: 'LeHtmlFragmentExporterExamples';
		exampleSelector: 'pictureSnippet'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: ((LeHtmlBookFragmentExporterVisitor new 
		externalPicturesWriter: LeResourcesExporter new)
		stream: stream) ].
	self assert: (html includesSubstring:'<div>
  <div class="snippet textual-snippet code-snippet pharo-snippet documentWidth">
    <pre class="no_bottom_margin">
pictureSnippet
	<gtExample>').
	self assert: (html includesSubstring:'  <div class="height-one-em">
  </div>').
	self assert: (html includesSubstring:'<figure class="documentWidth">
    <img src="gt-figures/1000.png">
    </img>
  </figure>
</div>').
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> methodAnnotation [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtMethod:LeHtmlFragmentExporterExamples>>#basicMarkdown}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new stream: stream) ].
	self assert: (html includesSubstring: 'method_annotation expandable_annotation_label').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples&gt;&gt;#basicMarkdown').
	self assert: (html includesSubstring: 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body hidden_annotation').
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> methodAnnotation_withInexistentClassAndNameParameter [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtMethod:name=LeHtmlInexistentClass>>#inexistentMethod}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new stream: stream) ].

	self 
		assert: (html includesSubstring: 'name=LeHtmlInexistentClass>>#inexistentMethod') not 
		description: [ 'The `name=` part must not be included' ].
	self assert: (html includesSubstring: 'method_annotation expandable_annotation_label').
	self assert: (html includesSubstring: 'LeHtmlInexistentClass&gt;&gt;#inexistentMethod').
	self assert: (html includesSubstring: 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body hidden_annotation').
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> methodAnnotation_withNameParameter [
	"Confirm that basic markup is converted"
	<gtExample>
	| markdown html |

	markdown := LeTextSnippet string: '{{gtMethod:name=LeHtmlFragmentExporterExamples>>#basicMarkdown}}'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new stream: stream) ].

	self 
		assert: (html includesSubstring: 'name=LeHtmlFragmentExporterExamples') not 
		description: [ 'The `name=` part must not be included' ].
	self assert: (html includesSubstring: 'method_annotation expandable_annotation_label').
	self assert: (html includesSubstring: 'LeHtmlFragmentExporterExamples&gt;&gt;#basicMarkdown').
	self assert: (html includesSubstring: 'textual-snippet code-snippet pharo-method-snippet expandable_annotation_body hidden_annotation').
	^ html
]

{ #category : #accessing }
LeHtmlBookFragmentExporterExamples >> pharoSnippet [
	<gtExample>
	| markdown html |
	markdown := LePharoSnippet code: 'answer := 41.'.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new stream: stream) ].
	self assert: html trimBoth
		equals: '<div class="snippet textual-snippet code-snippet pharo-snippet">
  <pre class="no_bottom_margin">
answer := 41.
  </pre>
</div>'.
	^ html

]

{ #category : #accessing }
LeHtmlBookFragmentExporterExamples >> pictureFile [
	^ (GtResourcesUtility resourceAtPath: Path 
		* 'feenkcom'
		/ 'gtoolkit-demos' 
		/ 'data' 
		/ 'faceapi' 
		/ '1280px-Einstein-with-habicht-and-solovine.jpg') asUrl asString
]

{ #category : #accessing }
LeHtmlBookFragmentExporterExamples >> pictureSnippet [
	<gtExample>
	| markdown html aResources |
	markdown := LePictureSnippet new urlString: self pictureFile.
	html := String streamContents: [ :stream |
		markdown acceptVisitor: (LeHtmlBookFragmentExporterVisitor new 
			externalPicturesWriter: (aResources := LeResourcesExporter new);
			stream: stream) ].
	
	self assert: (html beginsWith: '<figure class="snippet picture-snippet paragraphWidth"').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.jpg"/>').
	
	self assert: aResources asArray size equals: 1.
	
	^ html
]

{ #category : #examples }
LeHtmlBookFragmentExporterExamples >> wardleySnippet [
	<gtExample>
	| wardleyMap snippet html aResources |

	wardleyMap := GtWardleyMapJsonExporterImporterExamples  new importWardleyMapWithPipelineInnerNodesFromDictionary.
	snippet := LeWardleyMapSnippet new wardleyMap: wardleyMap.
	html := String streamContents: [ :stream |
		snippet acceptVisitor: (LeHtmlBookFragmentExporterVisitor new 
			externalPicturesWriter: (aResources := LeResourcesExporter new);
			stream: stream) ].
	
	self 
		assert: html isNotEmpty 
		description: [ 'HTML output must be non-empty'].
	
	self assert: (html includesSubstring: '<figure class="snippet picture-snippet').
	self assert: (html includesSubstring: '<img class="picture-snippet-image" src="gt-figures/1000.png"/>').
	
	self assert: aResources asArray size equals: 1.
	
	^ html
]
