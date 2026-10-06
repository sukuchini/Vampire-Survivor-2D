extends CanvasLayer

@onready var score_label: Label = $MarginContainer/HBoxContainer/ScoreLabel
@onready var bombs_label: Label = $MarginContainer/HBoxContainer/BombsLabel

func set_score(points: int):
	score_label.text ="SCORE: %d" % points

func set_bombs(bombs: int):
	bombs_label.text = "BOMBS: %d" % bombs
