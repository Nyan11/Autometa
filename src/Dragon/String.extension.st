Extension { #name : 'String' }

{ #category : '*Dragon' }
String >> asDragonType [

	^ String
]

{ #category : '*Dragon' }
String class >> isDragonFinal [

	^ true
]

{ #category : '*Dragon' }
String >> isDragonFinal [
	^ self class isDragonFinal
]
