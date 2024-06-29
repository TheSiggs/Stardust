class_name LabelConsciousnessCore
extends Label
## Displays the CC Label

## Connect signals
func _ready() -> void:
	update_text()
	HandlerConsciousnessCore.ref.consciousness_core_created.connect(update_text)
	HandlerConsciousnessCore.ref.consciousness_core_consumed.connect(update_text)

## Updates stardust text
func update_text(_qty : int = -1) -> void:
	text = "Consciousness Cores : %s" % HandlerConsciousnessCore.ref.get_consciousness_core()
