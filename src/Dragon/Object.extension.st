Extension { #name : 'Object' }

{ #category : '*Dragon' }
Object >> dragonDescription [

	^ self class dragonInstanceDescription
]

{ #category : '*Dragon' }
Object class >> dragonInstanceDescription [

	| description |
	description := DragonDescription new objectClass: self.
	description slotDescriptions:
		((Pragma allNamed: #dragonDescription from: self to: Object)
			 collect: [ :pragma | pragma method valueWithReceiver: nil ]).
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
