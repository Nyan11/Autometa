Class {
	#name : 'DragonErrorSlot',
	#superclass : 'DragonError',
	#instVars : [
		'objectClass',
		'slotName'
	],
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'accessing' }
DragonErrorSlot >> objectClass [

	^ objectClass
]

{ #category : 'accessing' }
DragonErrorSlot >> objectClass: anObject [

	objectClass := anObject
]

{ #category : 'accessing' }
DragonErrorSlot >> slotName [

	^ slotName
]

{ #category : 'accessing' }
DragonErrorSlot >> slotName: anObject [

	slotName := anObject
]
