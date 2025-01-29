Extension { #name : 'Object' }

{ #category : '*Dragon' }
Object >> dragonDescription [

	| description |
	description := DragonDescription new objectClass: self class.
	description slotDescriptions: ((Pragma allNamed: #dragonDescription from: self class to: Object) collect: [ :pragma | pragma method valueWithReceiver: self ]).
	^ description
]

{ #category : '*Dragon' }
Object >> generateDragonDescription [

	^ DragonDescriptionBuilder new classToGenerate: self class; build.
	
]

{ #category : '*Dragon' }
Object >> verifyDragonDescription [

	^ self dragonDescription verifyInstance: self.

	
]
