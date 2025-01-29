Class {
	#name : 'DragonErrorSlot',
	#superclass : 'Error',
	#instVars : [
		'objectClass',
		'slotName'
	],
	#category : 'Dragon',
	#package : 'Dragon'
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
