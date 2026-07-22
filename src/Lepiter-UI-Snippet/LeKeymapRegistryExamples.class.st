"
I contain examples for {{gtClass:LeKeymapRegistry}} verifying that all Lepiter-specific keyboard shortcuts are properly registered with their default key combinations.
"
Class {
	#name : #LeKeymapRegistryExamples,
	#superclass : #Object,
	#category : #'Lepiter-UI-Snippet-Examples'
}

{ #category : #examples }
LeKeymapRegistryExamples >> deleteNextCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default deleteNextShortcutId.
	self assert: combination isSingleKey.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> deletePreviousCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default deletePreviousShortcutId.
	self assert: combination isSingleKey.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> indentSnippetCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default indentSnippetShortcutId.
	self assert: combination isCompulsory.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> lepiterKeymapRegistry [
	<gtExample>
	<return: #LeKeymapRegistry>
	| registry |
	
	registry := LeKeymapRegistry new.
	self assert: registry numberOfKeymaps >= 9.
	
	^ registry
]

{ #category : #examples }
LeKeymapRegistryExamples >> moveSnippetDownCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default moveSnippetDownShortcutId.
	self assert: combination isCompulsory.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> moveSnippetUpCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default moveSnippetUpShortcutId.
	self assert: combination isCompulsory.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> renameSnippetCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default renameSnippetShortcutId.
	self assert: combination isCompulsory.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> secondaryNewLineCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default secondaryNewLineShortcutId.
	self assert: combination isCompulsory.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> splitSnippetCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default splitSnippetShortcutId.
	self assert: combination isCompulsory.
	^ combination
]

{ #category : #examples }
LeKeymapRegistryExamples >> unindentSnippetCombination [
	<gtExample>
	<return: #BlKeyCombination>
	| registry combination |
	registry := self lepiterKeymapRegistry.
	combination := registry combinationFor: LeShortcutIds default unindentSnippetShortcutId.
	self assert: combination isCompulsory.
	^ combination
]
