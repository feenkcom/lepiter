Class {
	#name : #LeStoreLocationExamples,
	#superclass : #Object,
	#traits : 'TAssertable',
	#classTraits : 'TAssertable classTrait',
	#category : #'Lepiter-Store-Examples'
}

{ #category : #examples }
LeStoreLocationExamples >> classClassEuqality [
	"Check comparison of two class Urls"

	<gtExample>
	<return: #LeStoreLocationExamples>
	self
		assert: ('class:///Package/Class' lepiterDbUrlEquals: 'class:///Package/Class').
	self
		deny: ('class:///Package/Class' lepiterDbUrlEquals: 'class:///Package/Class2')
]

{ #category : #examples }
LeStoreLocationExamples >> fileClassEquality [
	"Check comparison of different schemes"

	<gtExample>
	<return: #LeStoreLocationExamples>
	self
		deny: ('file:///{home}/a/b/c' lepiterDbUrlEquals: 'class:///Package/Class').
	self
		deny: ('class:///Package/Class' lepiterDbUrlEquals: 'file:///{home}/a/b/c')
]

{ #category : #examples }
LeStoreLocationExamples >> fileFileEquality [
	"Check comparison of two file locations"

	<gtExample>
	<return: #LeStoreLocationExamples>
	self
		assert: ('file:///{home}/a/b/c' lepiterDbUrlEquals: 'file:///{home}/a/b/c').
	self
		assert: (FileLocator home / 'a/b/c' lepiterDbUrlEquals: 'file:///{home}/a/b/c').
	self
		assert: ('file:///{home}/a/b/c' lepiterDbUrlEquals: FileLocator home / 'a/b/c').
	self
		assert: ('file:///{home}/a/b/c' asZnUrl lepiterDbUrlEquals: 'file:///{home}/a/b/c').
	self
		assert: ('file:///{home}/a/b/c' lepiterDbUrlEquals: 'file:///{home}/a/b/c' asZnUrl).
	self
		assert: (FileLocator home / 'a/b/c' lepiterDbUrlEquals: FileLocator home / 'a/b/c').

	self deny: ('file:///{home}/a/b/c' lepiterDbUrlEquals: 'file:///{home}/a/b/d').
	self
		deny: (FileLocator home / 'a/b/c' lepiterDbUrlEquals: 'file:///{home}/a/b/d').
	self
		deny: ('file:///{home}/a/b/c' lepiterDbUrlEquals: FileLocator home / 'a/b/d').
	self
		deny: ('file:///{home}/a/b/c' asZnUrl lepiterDbUrlEquals: 'file:///{home}/a/b/d').
	self
		deny: ('file:///{home}/a/b/c' lepiterDbUrlEquals: 'file:///{home}/a/b/d' asZnUrl).
	self
		deny: (FileLocator home / 'a/b/c' lepiterDbUrlEquals: FileLocator home / 'a/b/d')
]
