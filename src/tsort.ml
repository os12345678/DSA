exception CycleFound of int list
exception Not_found

let graph = [(1, [2; 3]); (2, [5; 4]); (3, [6]); (4, [6]); (5, [4; 6])]

let rec is_in neighbour visited =
  match visited with
  | []      -> false
  | x :: xs -> if x = neighbour then true else is_in neighbour xs

let rec assoc x = function
  | []          -> raise Not_found
  | (a, b) :: l -> if compare a x = 0 then b else assoc x l

let rec fold_left f accu l =
  match l with [] -> accu | a :: l -> fold_left f (f accu a) l

let rec map f = function
  | []     -> []
  | a :: l ->
      let r = f a in
      r :: map f l

let dfs graph visited start_node =
  let rec explore path visited node =
    if is_in node path then raise (CycleFound path)
    else if is_in node visited then visited
    else
      let update_path = node :: path in
      let update_edges = try assoc node graph with Not_found -> [] in
      let update_visited = fold_left (explore update_path) visited update_edges in
      node :: update_visited in
  explore [] visited start_node

let tsort graph =
  let nodes = map fst graph in
  fold_left (dfs graph) [] nodes

let sorted = tsort graph

let rec print_sorted = function
  | []      -> ()
  | [x]     -> print_int x
  | x :: xs -> print_int x ; print_string " -> " ; print_sorted xs

let () = print_sorted sorted
