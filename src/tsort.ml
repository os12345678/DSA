exception CycleFound of int list
exception Not_found

let graph = [(1, [2; 3]); (2, [5; 4]); (3, [6]); (4, [6]); (5, [4; 6])]

(** The following four functions are reimplementations of ocaml base functions *)
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

(** 
The [dfs] function starts a new dfs exploration from every node in the graph and ignores any 
previously visited nodes. It the sorted nodes into the [visited] list for each call of [dfs]. 
@param [graph] the graph to explore
@param [visited] the list of nodes already visited
@param [start_node] the node to start the exploration from
@param [path] the path of nodes visited so far
@param [node] the current node being explored from the [path]
@exception [CycleFound] if a cycle is found
@exception [Not_found] graph representation is invalid
*)
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

(** The [tsort] function builds a topological sort of the graph by calling [dfs] on every
    node in the graph. The function starts by calling the first node in the graph,
    recursively folding sorted nodes produced by [dfs] into a list of [nodes]*)
let tsort graph =
  let nodes = map fst graph in
  fold_left (dfs graph) [] nodes

let sorted = tsort graph

let rec print_sorted = function
  | []      -> ()
  | [x]     -> print_int x
  | x :: xs -> print_int x ; print_string " -> " ; print_sorted xs

let () = print_sorted sorted
