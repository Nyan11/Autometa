Extension { #name : 'Number' }

{ #category : '*Dragon' }
Number class >> isDragonFinal [

	^ true
]

{ #category : '*Dragon' }
Number >> isDragonFinal [
	^ self class isDragonFinal
]
