exception CycleFound of int list

val graph : (int * int list) list
val dfs : (int * int list) list -> int list -> int -> int list
val tsort : (int * int list) list -> int list
val sorted : int list
val print_sorted : int list -> unit
