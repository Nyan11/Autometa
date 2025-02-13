Class {
	#name : 'AutometaErrorSlot',
	#superclass : 'AutometaError',
	#instVars : [
		'objectClass',
		'slotName'
	],
	#category : 'Autometa-Builders',
	#package : 'Autometa',
	#tag : 'Builders'
}

{ #category : 'accessing' }
AutometaErrorSlot >> objectClass [

	^ objectClass
]

{ #category : 'accessing' }
AutometaErrorSlot >> objectClass: anObject [

	objectClass := anObject
]

{ #category : 'accessing' }
AutometaErrorSlot >> slotName [

	^ slotName
]

{ #category : 'accessing' }
AutometaErrorSlot >> slotName: anObject [

	slotName := anObject
]
