extends Node2D

func _ready():
	get_tree().connect("network_peer_connected", self, '_connected')

func _on_Server_creating_pressed():
	var server = NetworkedMultiplayerENet.new()
	server.create_server(7777, 2)
	get_tree().set_network_peer(server)
	print('created')

func _on_Server_loading_pressed():
	var client = NetworkedMultiplayerENet.new()
	client.create_client('127.0.0.1', 7777)
	get_tree().set_network_peer(client)
	print('loaded')

func _connected(client_id):
	Singleteon.user_id = client_id
	var game = preload('res://Scens/Сцена нищих тестов.tscn').instance()
	get_tree().get_root().add_child(game)
	print('connected')
	hide()
