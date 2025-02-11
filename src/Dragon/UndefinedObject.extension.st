Extension { #name : 'UndefinedObject' }

{ #category : '*Dragon' }
UndefinedObject class >> isDragonFinal [

	^ true
]

{ #category : '*Dragon' }
UndefinedObject >> isDragonFinal [
	^ self class isDragonFinal
]
