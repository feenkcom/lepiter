Class {
	#name : #LeYoutubeUrlExamples,
	#superclass : #Object,
	#category : #'Lepiter-Snippet-Youtube-Examples'
}

{ #category : #accessing }
LeYoutubeUrlExamples >> invalidUrl1 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| aYoutubeUrl |
	aYoutubeUrl := LeYoutubeUrl new string: 'Tudor Gîrba'.
	self assert: aYoutubeUrl isValidYoutubeUrl not.
	^ aYoutubeUrl
]

{ #category : #accessing }
LeYoutubeUrlExamples >> video01 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| anUrlString anUrl aYoutubeUrl |
	anUrlString := 'https://youtu.be/WfAbOlmULjk?t=21'.
	anUrl := anUrlString asZnUrl.

	aYoutubeUrl := LeYoutubeUrl new string: anUrlString.

	self assert: aYoutubeUrl url equals: anUrl.
	self assert: aYoutubeUrl isValidYoutubeUrl.
	self assert: aYoutubeUrl videoId equals: 'WfAbOlmULjk'.
	self assert: aYoutubeUrl startAt equals: '21'.
	self assert: aYoutubeUrl embedVideoIdAndStart equals: 'WfAbOlmULjk?start=21'.

	^ aYoutubeUrl
]

{ #category : #accessing }
LeYoutubeUrlExamples >> video02 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| anUrlString anUrl aYoutubeUrl |
	anUrlString := 'youtu.be/WfAbOlmULjk?t=12'.
	anUrl := anUrlString asZnUrl.

	aYoutubeUrl := LeYoutubeUrl new string: anUrlString.

	self
		assert: aYoutubeUrl url
		equals: 'https://youtu.be/WfAbOlmULjk?t=12' asZnUrl.
	self assert: aYoutubeUrl isValidYoutubeUrl.
	self assert: aYoutubeUrl videoId equals: 'WfAbOlmULjk'.
	self assert: aYoutubeUrl startAt equals: '12'.
	self assert: aYoutubeUrl embedVideoIdAndStart equals: 'WfAbOlmULjk?start=12'.

	^ aYoutubeUrl
]

{ #category : #accessing }
LeYoutubeUrlExamples >> video03 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| anUrlString anUrl aYoutubeUrl |
	anUrlString := 'YOUTU.be/WfAbOlmULjk?t=144'.
	anUrl := anUrlString asZnUrl.

	aYoutubeUrl := LeYoutubeUrl new string: anUrlString.

	self
		assert: aYoutubeUrl url
		equals: 'https://youtu.be/WfAbOlmULjk?t=144' asZnUrl.
	self assert: aYoutubeUrl isValidYoutubeUrl.
	self assert: aYoutubeUrl videoId equals: 'WfAbOlmULjk'.
	self assert: aYoutubeUrl startAt equals: '144'.
	self assert: aYoutubeUrl embedVideoIdAndStart equals: 'WfAbOlmULjk?start=144'.

	^ aYoutubeUrl
]

{ #category : #accessing }
LeYoutubeUrlExamples >> video04 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| anUrlString anUrl aYoutubeUrl |
	anUrlString := 'YOUTU.be?t=144'.
	anUrl := anUrlString asZnUrl.

	aYoutubeUrl := LeYoutubeUrl new string: anUrlString.

	self assert: aYoutubeUrl url equals: 'https://youtu.be?t=144' asZnUrl.
	self assert: aYoutubeUrl isValidYoutubeUrl not.
	self assert: aYoutubeUrl videoId equals: nil.
	self assert: aYoutubeUrl startAt equals: 144 asString.
	self assert: aYoutubeUrl embedVideoIdAndStart equals: ''.

	^ aYoutubeUrl
]

{ #category : #accessing }
LeYoutubeUrlExamples >> video05 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| anUrlString anUrl aYoutubeUrl |
	anUrlString := 'anything but url'.
	anUrl := anUrlString asZnUrl.

	aYoutubeUrl := LeYoutubeUrl new string: anUrlString.

	self assert: aYoutubeUrl url equals: '/anything%20but%20url' asZnUrl.
	self assert: aYoutubeUrl isValidYoutubeUrl not.
	self assert: aYoutubeUrl videoId equals: 'anything but url'.
	self assert: aYoutubeUrl startAt equals: 0 asString.
	self
		assert: aYoutubeUrl embedVideoIdAndStart
		equals: 'anything but url?start=0'.

	^ aYoutubeUrl
]

{ #category : #accessing }
LeYoutubeUrlExamples >> video06 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| anUrlString anUrl aYoutubeUrl |
	anUrlString := 'https://anything but url'.
	anUrl := anUrlString asZnUrl.

	aYoutubeUrl := LeYoutubeUrl new string: anUrlString.

	self assert: aYoutubeUrl url equals: 'https://anything%20but%20url/' asZnUrl.
	self assert: aYoutubeUrl isValidYoutubeUrl not.
	self assert: aYoutubeUrl videoId equals: nil.
	self assert: aYoutubeUrl startAt equals: 0 asString.
	self assert: aYoutubeUrl embedVideoIdAndStart equals: ''.

	^ aYoutubeUrl
]

{ #category : #accessing }
LeYoutubeUrlExamples >> video07 [
	<gtExample>
	<return: #LeYoutubeUrl>
	| anUrlString anUrl aYoutubeUrl |
	anUrlString := 'YOUTU.be/WfAbOlmULjk?t=144s'.
	anUrl := anUrlString asZnUrl.

	aYoutubeUrl := LeYoutubeUrl new string: anUrlString.

	self
		assert: aYoutubeUrl url
		equals: 'https://youtu.be/WfAbOlmULjk?t=144s' asZnUrl.
	self assert: aYoutubeUrl isValidYoutubeUrl.
	self assert: aYoutubeUrl videoId equals: 'WfAbOlmULjk'.
	self assert: aYoutubeUrl startAt equals: '144s'.
	self assert: aYoutubeUrl embedVideoIdAndStart equals: 'WfAbOlmULjk?start=144s'.

	^ aYoutubeUrl
]
