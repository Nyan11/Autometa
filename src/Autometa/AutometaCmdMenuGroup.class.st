Class {
	#name : 'AutometaCmdMenuGroup',
	#superclass : 'CmdMenuGroup',
	#category : 'Autometa-Commands',
	#package : 'Autometa',
	#tag : 'Commands'
}

{ #category : 'accessing' }
AutometaCmdMenuGroup >> buildContextMenu: aMenu [

	aMenu addLine.
	super buildContextMenu: aMenu
]

{ #category : 'accessing' }
AutometaCmdMenuGroup >> description [

	^ 'Autometa contextual menu'
]

{ #category : 'accessing' }
AutometaCmdMenuGroup >> icon [

	^ AutometaIcon autometaIcon
]

{ #category : 'accessing' }
AutometaCmdMenuGroup >> name [

	^ 'Autometa'
]

{ #category : 'accessing' }
AutometaCmdMenuGroup >> order [
	"Idea to put molecule group to the end of menu"

	^ SmallInteger maxVal -1
]
