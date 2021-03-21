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
    for panel in panels:
        panel.material_override = panel_material


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
