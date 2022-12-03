extends Control

var font 

func _ready():
    font = DynamicFont.new()
    font.font_data = load("res://Font/Chalktastic-x1nR.ttf")
    update()

