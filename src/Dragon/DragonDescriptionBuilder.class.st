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
	"We check for each class all instances and subinstances that could contains the value for each slot."
	allInstances := aClass withAllSubclasses flatCollect: #allInstances.
	aClass slots do: [ :slot |
		| allValues allValueTypes description matcherSetter matcherGetter possibleSetterSelectors possibleGetterSelectors |
		allValues := allInstances collect: [ :inst | slot read: inst ].
		allValueTypes := (allValues collect: #class) asSet.
		"We need to find all possible setters for each slot.
		We recover all method that are using this slot and select only the one with one argument."
		matcherSetter := RBParseTreeSearcher setterMethod: slot name.
		matcherGetter := RBParseTreeSearcher getterMethod: slot name.
		possibleSetterSelectors := OrderedCollection new.
		possibleGetterSelectors := OrderedCollection new.
		slot usingMethods do: [ :method |
			| parseTree |
			parseTree := method parseTree.
			method numArgs = 1 ifTrue: [
				matcherSetter executeTree: parseTree.
				matcherSetter answer ifNotNil: [
					possibleSetterSelectors add: method selector ] ].
			method numArgs = 0 ifTrue: [
				matcherGetter executeTree: parseTree.
				matcherGetter answer ifNotNil: [
					possibleGetterSelectors add: method selector ] ] ].
		description := DragonSlotDescription new
			               slot: slot name;
			               possibleSetterSelectors: possibleSetterSelectors;
			               possibleGetterSelectors: possibleGetterSelectors;
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
