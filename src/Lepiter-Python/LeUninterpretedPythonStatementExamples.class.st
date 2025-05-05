Class {
	#name : #LeUninterpretedPythonStatementExamples,
	#superclass : #Object,
	#category : #'Lepiter-Python-Examples'
}

{ #category : #examples }
LeUninterpretedPythonStatementExamples >> multiplePythonStatements [
	"Check converting a string containing multiple python statements"

	<gtExample>
	<return: #LeUninterpretedPythonStatementExamples>
	| statements |
	statements := LeUninterpretedPythonStatement
			statementsFrom: 'import os\os.getcwd()' withCRs.
	self assert: statements size equals: 2.
	self assert: statements first string equals: 'import os'.
	self assert: statements last string equals: 'os.getcwd()'
]

{ #category : #examples }
LeUninterpretedPythonStatementExamples >> multiplePythonStatementsWithContinuation [
	"Check converting a string containing multiple python statements"

	<gtExample>
	<return: #LeUninterpretedPythonStatementExamples>
	| statements |
	statements := LeUninterpretedPythonStatement
			statementsFrom: ('import {1}\  os\os.getcwd()' withCRs format: {'\'}).
	self assert: statements size equals: 2.
	self assert: statements first string equals: 'import   os'.
	self assert: statements last string equals: 'os.getcwd()'
]

{ #category : #examples }
LeUninterpretedPythonStatementExamples >> multiplePythonStatementsWithContinuationAndEmptyLine [
	"Check converting a string containing multiple python statements and empty lines"

	<gtExample>
	<return: #LeUninterpretedPythonStatementExamples>
	| statements |
	statements := LeUninterpretedPythonStatement
			statementsFrom: ('import {1}\  os\\os.getcwd()' withCRs format: {'\'}).
	self assert: statements size equals: 3.
	self assert: statements first string equals: 'import   os'.
	self assert: statements last string equals: 'os.getcwd()'
]
