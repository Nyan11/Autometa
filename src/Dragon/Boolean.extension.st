Extension { #name : 'Boolean' }

{ #category : '*Dragon' }
Boolean >> asDragonType [

	^ Boolean
]

{ #category : '*Dragon' }
Boolean class >> isDragonFinal [

	^ true
]

{ #category : '*Dragon' }
Boolean >> isDragonFinal [
	^ self class isDragonFinal
]
