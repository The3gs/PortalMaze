extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var panels = []

export(Color) var color

# Called when the node enters the scene tree for the first time.
func _ready():
    for child in $Art.get_children():
        panels.append(child)
    
    var panel_material = SpatialMaterial.new()
    panel_material.albedo_color = color
    panel_material.flags_unshaded = true
    for panel in panels:
        panel.material_override = panel_material

func set_parameters(parameters):
    color = parameters
