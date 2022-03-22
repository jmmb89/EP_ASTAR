-- Main 

--arquivo com as funcoes e variaveis criadas p/ o A*
require "astar"

math.randomseed(os.time())

function print_info()
	print("\nLegenda:\n")
	for i=1, 4 do
		print(tiles[i], "=", simbols[i])
	end
	print("inicio", "=", "S")
	print("fim", "=", "E")
	print("caminho", "=", "O\n")
end

function print_map()
	for i=1, map_l do
		map_path[i] = {}
		for j=1, map_w do
			map_path[i][j] = nil
		end
	end

	for i=1, map_l do
		for j=1, map_w do
			if i == 1 and j == 1 then 
				io.write(" S")
				map_path[i][j] = "S"
			elseif i == map_l and j == map_w then
				io.write(" E")
				map_path[i][j] = "E"
			else
				io.write(" ", simbols[map[i][j]])
				map_path[i][j] = simbols[map[i][j]]
			end
		end
		print("")
	end
end
	
function init()
	print("## Programa A* - Senac - BCC ##\n")

	while map_w <= 2 and map_l <= 2 do
		print("\nInsira a largura do mapa:")
		new_w = io.read()
		new_w = tonumber(new_w)
		print("\nInsira o comprimento do mapa:")
		new_l = io.read()
		new_l = tonumber(new_l)

		if new_w ~= nil and new_l ~= nil then 
			if new_w <= 2 or new_l <= 2 then
				print("Tamanho invalido! (minimo = 2)")
			else
				map_l = new_l
				map_w = new_w
			end
		else
			print("Insira um numero!")
		end
	end

	for i=1, map_l do
		map[i] = {}
		for j=1, map_w do
			if not (i == map_l and i == map_w) then
				map[i][j] = math.random(1, 4)
			else
				map[i][j] = 1
			end
		end
	end
	print_info()
	print_map()
	a_star(1, 1, map_l, map_w)
end

init()
