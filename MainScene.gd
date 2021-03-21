extends Spatial


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var main_camera: Camera
var main_camera_mount: Spatial
var all_cameras = []

var portal_viewports = []

var speed = 1.5

var center_size = 0.43

var camera_captured = false
# Called when the node enters the scene tree for the first time.
func _ready():
    main_camera = $CameraMount/Camera
    main_camera_mount = $CameraMount
    all_cameras.append($North/Camera)
    all_cameras.append($East/Camera)
    all_cameras.append($South/Camera)
    all_cameras.append($West/Camera)
    
    portal_viewports.append($North)
    portal_viewports.append($South)
    portal_viewports.append($East)
    portal_viewports.append($West)
    
    get_tree().connect("screen_resized", self, "update_viewport_sizes")
    update_viewport_sizes()

func _input(event):
    if camera_captured and event is InputEventMouseMotion:
        var motion = event.relative
        main_camera_mount.rotate_y(motion.x * -0.02)
        main_camera.rotate_x(motion.y * -0.02)
        if main_camera.rotation.x > PI/2:
            main_camera.rotation.x = PI/2
        if main_camera.rotation.x < -PI/2:
            main_camera.rotation.x = -PI/2
    if !camera_captured and event is InputEventMouseButton and event.is_pressed():
        camera_captured = true
        Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
    elif event.is_action_pressed("ui_cancel"):
        camera_captured = false
        Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _process(delta):
    var motion = Vector3.ZERO
    if Input.is_action_pressed("move_back"):
        motion += main_camera_mount.transform.basis.z * speed
    if Input.is_action_pressed("move_forward"):
        motion += -main_camera_mount.transform.basis.z * speed
    if Input.is_action_pressed("move_left"):
        motion += -main_camera_mount.transform.basis.x * speed
    if Input.is_action_pressed("move_right"):
        motion += main_camera_mount.transform.basis.x * speed
#    if Input.is_action_pressed("move_up"):
#        main_camera_mount.translate(Vector3(0, 1, 0) * delta * speed)
#    if Input.is_action_pressed("move_down"):
#        main_camera_mount.translate(Vector3(0, -1, 0) * delta * speed)
    
    main_camera_mount.move_and_slide(motion, Vector3.UP)
    
    update_cells(main_camera_mount.translation)
    
    for cam in all_cameras:
        cam.global_transform = main_camera.global_transform


func update_viewport_sizes():
    var size = get_viewport().size
    for viewport in portal_viewports:
        viewport.size = size

enum Sides {
    NORTH,
    EAST,
    SOUTH,
    WEST
   }

enum Directions {
    NORTH,
    NORTH_NORTH_EAST,
    NORTH_EAST_EAST,
    EAST,
    SOUTH_EAST_EAST,
    SOUTH_SOUTH_EAST,
    SOUTH,
    SOUTH_SOUTH_WEST,
    SOUTH_WEST_WEST,
    WEST,
    NORTH_WEST_WEST,
    NORTH_NORTH_WEST
   }

var in_center = true
var last_side = Sides.SOUTH setget set_last_side
var last_direction = Sides.SOUTH
func set_last_side(side: int):
    last_side = side
    for portal in $Portals.get_children():
        portal.visible = true
    match side:
        Sides.NORTH:
            $Portals/North.visible = false
        Sides.SOUTH:
            $Portals/South.visible = false
        Sides.EAST:
            $Portals/East.visible = false
        Sides.WEST:
            $Portals/West.visible = false

func update_cells(position: Vector3):
    if abs(position.x) < center_size and abs(position.z) < center_size:
        in_center = true
        return
    elif in_center:
        in_center = false
        if get_side(position) == last_side:
            return
        else:
            swap_side(last_side)
            self.last_side = get_side(position)
            swap_side(last_side)
            return
    if get_direction(position) != last_direction:
        var last_dir = last_direction
        self.last_direction = get_direction(position)
        if last_dir == Directions.SOUTH:
            if last_direction == Directions.SOUTH_SOUTH_WEST:
                load_side(Sides.NORTH, Sides.WEST)
            if last_direction == Directions.SOUTH_SOUTH_EAST:
                load_side(Sides.NORTH, Sides.EAST)
        if last_dir == Directions.SOUTH_SOUTH_EAST:
            if last_direction == Directions.SOUTH:
                load_side(Sides.NORTH, Sides.SOUTH)
                load_side(Sides.EAST, Sides.SOUTH)
        if last_dir == Directions.SOUTH_EAST_EAST:
            if last_direction == Directions.EAST:
                load_side(Sides.WEST, Sides.EAST)
                load_side(Sides.SOUTH, Sides.EAST)
        if last_dir == Directions.EAST:
            if last_direction == Directions.SOUTH_EAST_EAST:
                load_side(Sides.WEST, Sides.SOUTH)
            if last_direction == Directions.NORTH_EAST_EAST:
                load_side(Sides.WEST, Sides.NORTH)
        if last_dir == Directions.NORTH_EAST_EAST:
            if last_direction == Directions.EAST:
                load_side(Sides.WEST, Sides.EAST)
                load_side(Sides.NORTH, Sides.EAST)
        if last_dir == Directions.NORTH_NORTH_EAST:
            if last_direction == Directions.NORTH:
                load_side(Sides.EAST, Sides.NORTH)
                load_side(Sides.SOUTH, Sides.NORTH)
        if last_dir == Directions.NORTH:
            if last_direction == Directions.NORTH_NORTH_EAST:
                load_side(Sides.SOUTH, Sides.EAST)
            if last_direction == Directions.NORTH_NORTH_WEST:
                load_side(Sides.SOUTH, Sides.WEST)
        if last_dir == Directions.NORTH_NORTH_WEST:
            if last_direction == Directions.NORTH:
                load_side(Sides.SOUTH, Sides.NORTH)
                load_side(Sides.WEST, Sides.NORTH)
        if last_dir == Directions.NORTH_WEST_WEST:
            if last_direction == Directions.WEST:
                load_side(Sides.EAST, Sides.WEST)
                load_side(Sides.NORTH, Sides.WEST)
        if last_dir == Directions.WEST:
            if last_direction == Directions.NORTH_WEST_WEST:
                load_side(Sides.EAST, Sides.NORTH)
            if last_direction == Directions.SOUTH_WEST_WEST:
                load_side(Sides.EAST, Sides.SOUTH)
        if last_dir == Directions.SOUTH_WEST_WEST:
            if last_direction == Directions.WEST:
                load_side(Sides.SOUTH, Sides.WEST)
                load_side(Sides.EAST, Sides.WEST)
        if last_dir == Directions.SOUTH_SOUTH_WEST:
            if last_direction == Directions.SOUTH:
                load_side(Sides.WEST, Sides.SOUTH)
                load_side(Sides.NORTH, Sides.SOUTH)
    if get_side(position) != last_side:
        self.last_side = get_side(position)

func load_side(side: int, from: int):
    pass

func swap_side(side: int):
    var old_current = $Current.get_child(0)
    if side == Sides.NORTH:
        var old_side = $North.get_child(1)
        $Current.remove_child(old_current)
        $North.remove_child(old_side)
        $North.add_child(old_current)
        $Current.add_child(old_side)
    elif side == Sides.EAST:
        var old_side = $East.get_child(1)
        $Current.remove_child(old_current)
        $East.remove_child(old_side)
        $East.add_child(old_current)
        $Current.add_child(old_side)
    elif side == Sides.SOUTH:
        var old_side = $South.get_child(1)
        $Current.remove_child(old_current)
        $South.remove_child(old_side)
        $South.add_child(old_current)
        $Current.add_child(old_side)
    elif side == Sides.WEST:
        var old_side = $West.get_child(1)
        $Current.remove_child(old_current)
        $West.remove_child(old_side)
        $West.add_child(old_current)
        $Current.add_child(old_side)
    else:
        printerr("Invalid side: ", side)

func get_side(position: Vector3):
    if abs(position.x) > abs(position.z):
        if position.x > 0:
            return Sides.EAST
        else:
            return Sides.WEST
    else:
        if position.z > 0:
            return Sides.SOUTH
        else:
            return Sides.NORTH


func get_direction(position: Vector3):
    var angle = rad2deg(atan2(position.x, -position.z))
    if angle > 145 || angle < -145:
        return Directions.SOUTH
    if angle < 145 && angle > 135:
        return Directions.SOUTH_SOUTH_EAST
    if angle < 135 && angle > 125:
        return Directions.SOUTH_EAST_EAST
    if angle < 125 && angle > 55:
        return Directions.EAST
    if angle < 55 && angle > 45:
        return Directions.NORTH_EAST_EAST
    if angle < 45 && angle > 35:
        return Directions.NORTH_NORTH_EAST
    if angle < 35 && angle > -35:
        return Directions.NORTH
    if angle < -35 && angle > -45:
        return Directions.NORTH_NORTH_WEST
    if angle < -45 && angle > -55:
        return Directions.NORTH_WEST_WEST
    if angle < -55 && angle > -125:
        return Directions.WEST
    if angle < -125 && angle > -135:
        return Directions.SOUTH_WEST_WEST
    if angle < -135 && angle > -145:
        return Directions.SOUTH_SOUTH_WEST
