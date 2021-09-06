"
Glutin critical: [

	context := GlutinEventFetcher default eventLoop createHeadless.
	context makeCurrent.
	contextApi := context api.
	
	gl := contextApi = GlutinContextApi OpenGl
		ifTrue: [ GtGleamGL loadGl: [ :aSymbol | context getProcAddress: aSymbol ] ]
		ifFalse: [ contextApi = GlutinContextApi OpenGlEs
			ifTrue: [ GtGleamGL loadGles: [ :aSymbol | context getProcAddress: aSymbol ] ]
			ifFalse: [ self error: 'Unsupported API' ] ].

	texture := GtGleamTexture new
		gl: gl;
		id: gl gen_texture;
		target: gl GL_TEXTURE_2D;
		extent: 200@200;
		format: gl GL_RGBA;
		internalFormat: gl GL_RGBA;
		type: gl GL_UNSIGNED_BYTE.
		
	form := GtGleamHeadlessRenderer new
		gl: gl;
		texture: texture;
		render: [ :aGl :aTexture |
			aGl clear_color: Color blue.
			aGl clear: aGl GL_COLOR_BUFFER_BIT.
			aGl clear_depth: 0.
			aGl clear: aGl GL_DEPTH_BUFFER_BIT.
			
			
			
			aTexture asForm ] ]
"
Class {
	#name : 'LeOpenGLSnippetViewModel',
	#superclass : 'LePharoSnippetViewModel',
	#instVars : [
		'context',
		'gl'
	],
	#category : 'Lepiter-Snippet-OpenGL-Snippet'
}

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> codeHeight [
	^ self snippetModel codeHeight
]

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> doItAllRequestedBy: aRequesterObject [
	"Revaluate the content of the coder and return the result"
	<return: #Object>

	^ self coderViewModel doItAllRequestedBy: aRequesterObject
]

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> elementHeight [
	^ self snippetModel elementHeight
]

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> hideCode [
	| wasFocused |

	wasFocused := self focused.
	self coderViewModel focused: false.
	self snippetModel codeVisible: false.
	self focused: wasFocused
]

{ #category : 'initialization' }
LeOpenGLSnippetViewModel >> initialize [
	super initialize.
]

{ #category : 'private - notifying' }
LeOpenGLSnippetViewModel >> notifyCodeVisibilityChanged [
	self announce: (LeElementSnippetViewModelCodeVisibilityChanged new)
]

{ #category : 'private - notifying' }
LeOpenGLSnippetViewModel >> notifyHeightChanged [
	self announce: (LeElementSnippetViewModelHeightChanged new)
]

{ #category : 'private - event handling' }
LeOpenGLSnippetViewModel >> onCodeHeightChanged [
	self notifyHeightChanged
]

{ #category : 'private - event handling' }
LeOpenGLSnippetViewModel >> onCodeVisibilityChanged [
	self notifyCodeVisibilityChanged
]

{ #category : 'private - event handling' }
LeOpenGLSnippetViewModel >> onElementHeightChanged [
	self notifyHeightChanged
]

{ #category : 'api - snippet model' }
LeOpenGLSnippetViewModel >> onSnippetModelChanged [
	super onSnippetModelChanged.
	
	Glutin critical: [
		| anApi |
	
		context := GlutinEventFetcher default eventLoop createHeadless.
		context makeCurrent.
		anApi := context api.
		
		gl := anApi = GlutinContextApi OpenGl
			ifTrue: [ GtGleamGL loadGl: [ :aSymbol | context getProcAddress: aSymbol ] ]
			ifFalse: [ anApi = GlutinContextApi OpenGlEs
				ifTrue: [ GtGleamGL loadGles: [ :aSymbol | context getProcAddress: aSymbol ] ]
				ifFalse: [ self error: 'Unsupported API' ] ] ]
]

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> resizeElementHeightTo: aNewHeight [
	| aDelta newCodeHeight |
	
	"is positive when increasing element height"
	aDelta := aNewHeight - self elementHeight.
	
	"should decrease code height first"
	newCodeHeight := (self codeHeight - aDelta) max: 0.
	
	self snippetModel elementHeight: self elementHeight + (self codeHeight - newCodeHeight).
	self snippetModel codeHeight: newCodeHeight
]

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> setElementHeightTo: aNewHeight [
	self snippetModel elementHeight: aNewHeight
]

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> shouldShowCode [
	^ self snippetModel codeVisible
]

{ #category : 'api - snippet' }
LeOpenGLSnippetViewModel >> showCode [
	self snippetModel codeVisible: true
]

{ #category : 'accessing' }
LeOpenGLSnippetViewModel >> snippetElementClass [
	^ LeElementSnippetElement
]

{ #category : 'accessing' }
LeOpenGLSnippetViewModel >> snippetView [
	<return: #LeSnippetView>
	
	^ super snippetView needsContentDecorationBar: false
]

{ #category : 'api - snippet model' }
LeOpenGLSnippetViewModel >> subscribeToSnippetModel [
	super subscribeToSnippetModel.
	
	self snippetModel weak when: LeElementSnippetElementHeightChanged
		send: #onElementHeightChanged
		to: self.

	self snippetModel weak when: LeElementSnippetCodeHeightChanged
		send: #onCodeHeightChanged
		to: self.
		
	self snippetModel weak when: LeElementSnippetCodeVisibilityChanged
		send: #onCodeVisibilityChanged
		to: self
]

{ #category : 'api - snippet model' }
LeOpenGLSnippetViewModel >> unsubscribeFromSnippetModel [
	super unsubscribeFromSnippetModel.

	self snippetModel unsubscribe: self
]
