-- A*

map_l = 0 -- X 
map_w = 0 -- Y

score = {terra = 1, agua = 3, areia = 6, block = 99} 
tiles = {"terra", "agua", "areia", "block"}
simbols = {"*", "@", "#", "X"}

map = {}
path = {}
map_path = {}
open = {}
close = {}
path_found = false
debug = false 

function table_has_key(tab, key)
	return tab[key] ~= nil
end

function get_distance(x, y, pos)
	--distancia euclidiana (nao eh exata, mas melhor do que com manhatan)
	dist = math.sqrt(math.pow((x - pos.x), 2) + math.pow((y - pos.y), 2))
	dist = math.floor(dist*10)
	return dist
end

--total score
function get_score(x, y, start_pos, end_pos)
	g = get_distance(x, y, start_pos)
	h = get_distance(x, y, end_pos)
	t = map[x][y]
  return g + h + t 
end

function get_best_guess()
	best_score = 99999
	tile_name = nil 
	tile = {x = nil, y = nil}
	for k, v in pairs(open) do
		if open[k].fc < best_score then
			best_score = open[k].fc
			tile_name = k
			tile.x = open[k].x
			tile.y = open[k].y
		elseif open[k].fc == best_score then
			if open[k].hc < open[tile_name].hc then
				tile_name = k
				tile.x = open[k].x
				tile.y = open[k].y
			end
		end
	end
	return tile_name, tile
end

function is_on_list(x, y, name)	
	if table_has_key(open, name) or table_has_key(close, name) then
		return true
	end
	return false
end

--para eliminar as bordas do mapa, obstaculos, casas fechadas e exploradas e casa inicial
function is_valid(x, y, name)
	if x < 1 or y < 1 or x > map_l or y > map_w or is_on_list(x, y, name) or (x == 1 and y == 1) then
		return false
	elseif x > 0 and y > 0 then
		if map[x][y] == 4 then
			return false
		end
	end
	return true
end

function get_valid_neighbors(x, y, start_pos, end_pos)
	neighbors = {}
	dif = {
		{x = -1, y = -1},
		{x = 0, y = -1},
		{x = 1, y = -1},
		{x = -1, y = 0},
		{x = 1, y = 0},
		{x = -1, y = 1},
		{x = 0, y = 1},
		{x = 1, y = 1}
	}

	last_pos = {x = x, y = y}
	if debug then print(string.format("LAST POS: x=%s y=%s", last_pos.x, last_pos.y)) end
	
	for i=1, 8 do
		tx = x + dif[i].x
		ty = y + dif[i].y
		name = "tile" .. tostring(tx) .. "-" .. tostring(ty)
		if is_valid(tx, ty, name) then
			f_c = get_score(tx, ty, start_pos, end_pos) --custo total
			h_c = get_distance(tx, ty, end_pos) --distancia da posicao atual ate o fim
			g_c = get_distance(tx, ty, start_pos) --distancia da posicao atual ate o comeco
			neighbors[name] = {x = tx, y = ty, fc = f_c, hc = h_c, gc = g_c, came_from = last_pos}
		end
	end
	return neighbors
end

function open_len()
	c = 0
	for k, v in pairs(open) do
		if k ~= nil then
			c = c + 1
		end
	end
	return c
end

function print_map_path()
	print()
	for i=1, map_l do
		for j=1, map_w do
			io.write(" ", map_path[i][j])
		end
		print()
	end
end

function draw_path(n_tile)
	lx = map_l
	ly = map_w

	while lx > 1 and ly > 1 do
		--tile_from = {x = path[n_tile].came_from.x, y = path[n_tile].came_from.y}
		lx = path[n_tile].came_from.x
		ly = path[n_tile].came_from.y
		map_path[lx][ly] = "O"
		n_tile = "tile" .. tostring(lx) .. "-" .. tostring(ly)
	end
	print_map_path()
end

function a_star(sx, sy, ex, ey)
	start_p = {x = sx, y = sy}
	end_p = {x = ex, y = ey}
	neighbors = get_valid_neighbors(sx, sy, start_p, end_p)
	n_tile = nil

	--inicializa a lista
	for k, v in pairs(neighbors) do
		open[k] = neighbors[k]
		path[k] = neighbors[k]
	end

	while open_len() > 0 and not path_found do
	--while open_len() > 1 and not path_found do
		n_tile, n_pos = get_best_guess()
		if debug then
			print(string.format("Next_tile = %s", n_tile))
			print("#####################")
		end
		--se o tile a visitar eh o fim, terminar.
		if open[n_tile].x == ex and open[n_tile].y == ey then
			path_found = true
			print("\nPATH FOUND!\n")
			draw_path(n_tile)

		else
			--visita o proximo tile
			neighbors = get_valid_neighbors(open[n_tile].x, open[n_tile].y, start_p, end_p)
			for k, v in pairs(neighbors) do
				open[k] = neighbors[k]
				path[k] = neighbors[k]
			end
			--adiciona o tile em closed e remove do open
			for k, v in pairs(open) do
				if k ~= nil then
					if open[k].x == n_pos.x and open[k].y == n_pos.y then
						close[k] = open[k]
						open[k] = nil
						break
					end
				end
			end
		end
	end
	if debug then print("OPEN LEN = ", open_len()) end
	if not path_found then print("\nNO PATH FOUND\n") end
end
