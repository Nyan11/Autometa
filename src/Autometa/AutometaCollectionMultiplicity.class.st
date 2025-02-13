Class {
	#name : 'AutometaCollectionMultiplicity',
	#superclass : 'AutometaAbstractMultiplicity',
	#instVars : [
		'foundSize',
		'collectionClass'
	],
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'converting' }
AutometaCollectionMultiplicity >> asCodeString [

	^ '<1s> foundSize: <2s>; collectionClass: <3s>; yourself'
		  expandMacrosWith: super asCodeString
		  with: self foundSize printString
		  with: self collectionClass name
]

{ #category : 'accessing' }
AutometaCollectionMultiplicity >> collectionClass [

	^ collectionClass
]

{ #category : 'accessing' }
AutometaCollectionMultiplicity >> collectionClass: anObject [

	collectionClass := anObject
]

{ #category : 'accessing' }
AutometaCollectionMultiplicity >> foundSize [

	^ foundSize
]

{ #category : 'accessing' }
AutometaCollectionMultiplicity >> foundSize: anObject [

	foundSize := anObject
]
