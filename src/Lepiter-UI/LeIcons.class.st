Class {
	#name : #LeIcons,
	#superclass : #Object,
	#category : 'Lepiter-UI-Basic - UI'
}

{ #category : #accessing }
LeIcons class >> lepiterDatabase [
	<script: 'self lepiterDatabase inspect'>

	^ [
		BlElement new
			size: 16@16;
			addChildren: { 
				BlElement new
					size: 16@16;
					outskirts: BlOutskirts centered;
					geometry: (BlSvgPath new
						svg: 'M 1 13.6 L 1 2.4 C 1 1.6272 4.136 1 8 1 C 11.864 1 15 1.6272 15 2.4 L 15 13.6 C 15 14.3728 11.864 15 8 15 C 4.136 15 1 14.3728 1 13.6 M 1 2.4 C 1 3.1728 4.136 3.8 8 3.8 C 11.864 3.8 15 3.1728 15 2.4'
						viewbox: (0@0 extent: 16@16));
					border: (BlBorder builder paint: Color black; width: 1; "capRound; "build).
					(BlTextElement new text: 'ĭ' asRopedText glamorousRegularFont bold; padding: (BlInsets top: 5.5 bottom: 2.5)) asScalableElement size: 16@16
			} ] asStencil
]

{ #category : #accessing }
LeIcons class >> lepiterIcon [
	<script: 'self lepiterIcon inspect'>

	^ [ (BlTextElement new text: 'ĭ' asRopedText glamorousRegularFont bold; padding: (BlInsets all: 1)) asScalableElement size: 16@16 ] asStencil
]

{ #category : #accessing }
LeIcons class >> lepiterPage [
	<script: 'self lepiterPage inspect'>

	^ [
		BlElement new
			size: 16@16;
			addChildren: { 
				BlElement new
					size: 16@16;
					outskirts: BlOutskirts centered;
					geometry: (BlSvgPath new
						svg: 'M 15 5.1426 C 15 3.81638 14.8222 3.6523 13.52342 2.3398 L 13.5097 2.32622 C 12.20406 1 12.19048 1 10.85054 1 C 9.06638 1 1 1 1 1 L 1 15 L 15 15 L 15 5.1426 Z M 15 5.07428 C 15 3.81638 14.98628 3.81638 12.19048 3.81638 L 12.19048 3.81638 C 12.19048 1.01372 12.19048 1 10.93258 1'
						viewbox: (0@0 extent: 16@16));
					border: (BlBorder builder paint: Color black; width: 1; "capRound;" build).
					(BlTextElement new text: 'ĭ' asRopedText glamorousRegularFont bold; padding: (BlInsets all: 4)) asScalableElement size: 16@16
			} ] asStencil
]
