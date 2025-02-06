Class {
	#name : 'DragonVisitor',
	#superclass : 'Object',
	#category : 'Dragon-Model',
	#package : 'Dragon',
	#tag : 'Model'
}

{ #category : 'visiting' }
DragonVisitor >> visitDescription: aDragonDescription [ 
	self explicitRequirement.
]

{ #category : 'visiting' }
DragonVisitor >> visitPropertyDescription: aDragonPropertyDescription [

	self explicitRequirement
]
