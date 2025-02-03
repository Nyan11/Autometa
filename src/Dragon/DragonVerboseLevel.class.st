Class {
	#name : 'DragonVerboseLevel',
	#superclass : 'DragonNoVerboseLevel',
	#instVars : [
		'count',
		'size'
	],
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
DragonVerboseLevel >> endBuilding [

	Transcript crShow: 'Done.'
]

{ #category : 'as yet unclassified' }
DragonVerboseLevel >> startBuilding: aCollection [

	size := aCollection size.
	count := 1.
	Transcript crShow: 'Total number of classes: ' , size printString
]

{ #category : 'as yet unclassified' }
DragonVerboseLevel >> startClass: aClass [

	Transcript crShow:
		count printString , ' / ' , size printString , ' - ' , aClass name.
	count := count + 1
]
