Class {
	#name : #LeExportSlides,
	#superclass : #Object,
	#traits : 'TGtSlideShow',
	#classTraits : 'TGtSlideShow classTrait',
	#category : #'Lepiter-Snippet-Element-Examples'
}

{ #category : #accessing }
LeExportSlides >> graphicalStackFirstExampleSlideFor: aSlide [
	<gtSlide>
	^ GtTour new graphicalStackFirstExampleSlideFor: aSlide
]

{ #category : #accessing }
LeExportSlides >> multipleViewsForOneObjectExampleSlideFor: aSlide [
	<gtSlide>
	^ GtTour new multipleViewsForOneObjectExampleSlideFor: aSlide
]
