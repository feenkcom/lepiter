Extension { #name : #PySimpleStmtNode }

{ #category : #'*Lepiter-Python' }
PySimpleStmtNode >> isValueStatement [

	^ stmts allSatisfy: #isValueStatement
]
