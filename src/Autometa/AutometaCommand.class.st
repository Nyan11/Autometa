Class {
	#name : 'AutometaCommand',
	#superclass : 'CmdCommand',
	#instVars : [
		'selectedClasses'
	],
	#category : 'Autometa-Commands',
	#package : 'Autometa',
	#tag : 'Commands'
}

{ #category : 'testing' }
AutometaCommand class >> canBeExecutedInContext: aToolContext [

	(super canBeExecutedInContext: aToolContext) ifFalse: [ ^ false ].
	aToolContext selectedItems ifEmpty: [ ^ false ].
	^ true
]

{ #category : 'testing' }
AutometaCommand class >> isAbstract [

	^ self = AutometaCommand
]

{ #category : 'execution' }
AutometaCommand >> prepareFullExecutionInContext: aToolContext [

	super prepareFullExecutionInContext: aToolContext.
	selectedClasses := aToolContext selectedItems collect: [ :p |
		                   p browserItem actualObject ]
]

{ #category : 'execution' }
AutometaCommand >> selectedClasses [

	^ selectedClasses
]
