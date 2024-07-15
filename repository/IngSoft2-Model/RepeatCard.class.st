"
repeat last board effect applied (excluding null effect)
"
Class {
	#name : 'RepeatCard',
	#superclass : 'InstantCard',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'event' }
RepeatCard >> activate: aCardHandler withTarget: aTarget [

	super activate: aCardHandler withTarget: aTarget.
	aCardHandler applyLastEffectOn: aTarget
]
