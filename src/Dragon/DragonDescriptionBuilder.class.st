Class {
	#name : 'DragonDescriptionBuilder',
	#superclass : 'Object',
	#instVars : [
		'classToGenerate'
	],
	#category : 'Dragon',
	#package : 'Dragon'
}

{ #category : 'building' }
DragonDescriptionBuilder >> build [

	(self classToGenerate withAllSuperclasses difference: { Object . ProtoObject }) do: [ :cls |
		self buildFor: cls ]
]

{ #category : 'building' }
DragonDescriptionBuilder >> buildFor: aClass [

	| allInstances |
	allInstances := aClass withAllSubclasses flatCollect: #allInstances.
	aClass slots do: [ :slot |
		| allValues allValueTypes description |
		allValues := allInstances collect: [ :inst | slot read: inst ].
		allValueTypes := (allValues collect: #class) asSet.
		description := DragonSlotDescription new
			               slot: slot name;
			               knownTypeValues: allValueTypes;
			               yourself.
		description installDragonDescriptionOn: aClass ]
]

{ #category : 'accessing' }
DragonDescriptionBuilder >> classToGenerate [
	^ classToGenerate
]

{ #category : 'as yet unclassified' }
DragonDescriptionBuilder >> classToGenerate: aClass [

	classToGenerate := aClass 
]
