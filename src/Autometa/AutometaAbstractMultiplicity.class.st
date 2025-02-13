Class {
	#name : 'AutometaAbstractMultiplicity',
	#superclass : 'Object',
	#category : 'Autometa-Model',
	#package : 'Autometa',
	#tag : 'Model'
}

{ #category : 'converting' }
AutometaAbstractMultiplicity >> asCodeString [

	^ '<1s> new' expandMacrosWith: self class name
]
