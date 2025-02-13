Extension { #name : 'UndefinedObject' }

{ #category : '*Autometa' }
UndefinedObject class >> isAutometaFinal [

	^ true
]

{ #category : '*Autometa' }
UndefinedObject >> isAutometaFinal [

	^ self class isAutometaFinal
]
