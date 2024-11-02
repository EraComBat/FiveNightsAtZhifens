extends TileMapLayer

var astar := AStarGrid2D.new()
# Called when the node enters the scene tree for the first time.
func _ready():
	astar.region = get_used_rect()
	astar.cell_size = get_tile_set().tile_size
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_MANHATTAN
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_NEVER
	astar.update()
	print(astar.region)
	pass # Replace with function body.
