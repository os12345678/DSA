open Lib.Tsort

(* test no nodes*)
let%expect_test _ =
  let graph = [] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| |}]

(* test one node*)
let%expect_test _ =
  let graph = [(1, [])] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| 1 |}]

(* test two nodes*)
let%expect_test _ =
  let graph = [(1, [2]); (2, [])] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| 1 -> 2 |}]

(* test for a cycle in the graph *)
let%expect_test _ =
  let graph = [(1, [2]); (2, [1])] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect.unreachable]
  [@@expect.uncaught_exn
    {|
  (* CR expect_test_collector: This test expectation appears to contain a backtrace.
     This is strongly discouraged as backtraces are fragile.
     Please change this test to not include a backtrace. *)

  ("Lib.Tsort.CycleFound(_)")
  Raised at Lib__Tsort.dfs.explore in file "src/tsort.ml", line 26, characters 28-51
  Called from Lib__Tsort.fold_left in file "src/tsort.ml", line 16, characters 50-60
  Called from Lib__Tsort.dfs.explore in file "src/tsort.ml", line 31, characters 27-79
  Called from Lib__Tsort.fold_left in file "src/tsort.ml", line 16, characters 50-60
  Called from Lib__Tsort.dfs.explore in file "src/tsort.ml", line 31, characters 27-79
  Called from Lib__Tsort.fold_left in file "src/tsort.ml", line 16, characters 50-60
  Called from Tests__Tsort_test.(fun) in file "tests/tsort_test.ml", line 24, characters 15-26
  Called from Expect_test_collector.Make.Instance_io.exec in file "collector/expect_test_collector.ml", line 262, characters 12-19 |}]

(* test for nodes greater than 2 *)
let%expect_test _ =
  let graph = [(1, [2]); (2, [3]); (3, [])] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| 1 -> 2 -> 3 |}]

(* test for nodes with more than 2 neighbours *)
let%expect_test _ =
  let graph = [(1, [2; 3; 4]); (2, [3; 5]); (3, [6; 7; 8])] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| 1 -> 4 -> 2 -> 5 -> 3 -> 8 -> 7 -> 6 |}]

(* test disjoint graph *)
let%expect_test _ =
  let graph = [(1, [2]); (2, [3]); (4, [5])] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| 4 -> 5 -> 1 -> 2 -> 3 |}]
