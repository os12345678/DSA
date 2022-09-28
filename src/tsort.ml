exception CycleFound of int list

(* Finding a topological ordering of a graph using depth-first search. *)

(* The algorithm is based on the following idea: - We start with an empty list of nodes. -
   We visit each node in the graph, and add it to the list of nodes if it has not been
   visited yet. - We visit a node by visiting all its successors, and then adding the node
   itself to the list of nodes. - If we encounter a node that has already been visited, we
   have found a cycle in the graph. *)

let graph = [(1, [2]); (2, [3]); (3, [4; 7; 6])]

(** [dfs]

    @param [graph] the graph to be traversed
    @param [visited] the list of nodes that have already been visited
    @param [start_node] the node to start the traversal from [explore]
    @param [path] the topological path found so far
    @param [visited] the list of nodes that have already been visited
    @param [node] the node to be explored
    @return
      a topological ordering of the graph, or raises [CycleFound] if a cycle is found *)

(** call dfs on [start_node]*)
let dfs graph visited start_node =
  let rec explore path visited node =
    if List.mem node path then raise (CycleFound path)
    else if List.mem node visited then visited
    else
      let new_path = node :: path in
      let edges = try List.assoc node graph with Not_found -> [] in
      let visited = List.fold_left (explore new_path) visited edges in
      node :: visited in
  explore [] visited start_node

(** @param [graph] the graph to be traversed
    @return a topologically sorted list *)
let tsort graph =
  let nodes = List.map fst graph in
  List.fold_left (dfs graph) [] nodes

let sorted = tsort graph

let rec print_sorted = function
  | []      -> ()
  | [x]     -> print_int x
  | x :: xs -> print_int x ; print_string " -> " ; print_sorted xs

(* let _ = print_sorted sorted *)
