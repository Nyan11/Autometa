Class {
	#name : 'AutometaVerboseLevel',
	#superclass : 'AutometaNoVerboseLevel',
	#instVars : [
		'count',
		'size'
	],
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'as yet unclassified' }
AutometaVerboseLevel >> endBuilding [

	Transcript crShow: 'Done.'
]

{ #category : 'as yet unclassified' }
AutometaVerboseLevel >> endClass: aClass [
]

{ #category : 'as yet unclassified' }
AutometaVerboseLevel >> startBuilding: aCollection [

	size := aCollection size.
	count := 1.
	Transcript crShow: 'Total number of classes: ' , size printString
]

{ #category : 'as yet unclassified' }
AutometaVerboseLevel >> startClass: aClass [

	Transcript crShow:
		count printString , ' / ' , size printString , ' - ' , aClass name.
	count := count + 1
]
