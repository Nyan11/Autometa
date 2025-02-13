Class {
	#name : 'BaselineOfAutometa',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfAutometa',
	#package : 'BaselineOfAutometa'
}

{ #category : 'baselines' }
BaselineOfAutometa >> baseline: spec [

	<baseline>
	spec for: #common do: [
		spec package: 'Autometa'.
		spec package: 'Autometa-Tests' ]
]
