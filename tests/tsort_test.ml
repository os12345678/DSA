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
  Raised at Lib__Tsort.dfs.explore in file "src/tsort.ml", line 27, characters 28-51
  Called from Lib__Tsort.fold_left in file "src/tsort.ml", line 17, characters 50-60
  Called from Lib__Tsort.dfs.explore in file "src/tsort.ml", line 32, characters 27-79
  Called from Lib__Tsort.fold_left in file "src/tsort.ml", line 17, characters 50-60
  Called from Lib__Tsort.dfs.explore in file "src/tsort.ml", line 32, characters 27-79
  Called from Lib__Tsort.fold_left in file "src/tsort.ml", line 17, characters 50-60
  Called from Tests__Tsort_test.(fun) in file "tests/tsort_test.ml", line 24, characters 15-26
  Called from Expect_test_collector.Make.Instance_io.exec in file "collector/expect_test_collector.ml", line 262, characters 12-19 |}]

(* test for nodes greater than 2 *)
let%expect_test _ =
  let graph = [(1, [2]); (2, [3]); (3, [])] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| 1 -> 2 -> 3 |}]

(* test for nodes greater than 30 with nodes having more than 2 neighbours*)
let%expect_test _ =
  let graph =
    [ ( 1
      , [ 2; 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23
        ; 24; 25; 26; 27; 28; 29; 30 ] )
    ; ( 2
      , [ 3; 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24
        ; 25; 26; 27; 28; 29; 30 ] )
    ; ( 3
      , [ 4; 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25
        ; 26; 27; 28; 29; 30 ] )
    ; ( 4
      , [ 5; 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26
        ; 27; 28; 29; 30 ] )
    ; ( 5
      , [ 6; 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26
        ; 27; 28; 29; 30 ] )
    ; ( 6
      , [ 7; 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27
        ; 28; 29; 30 ] )
    ; ( 7
      , [ 8; 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28
        ; 29; 30 ] )
    ; ( 8
      , [ 9; 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29
        ; 30 ] )
    ; ( 9
      , [ 10; 11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29
        ; 30 ] )
    ; ( 10
      , [11; 12; 13; 14; 15; 16; 17; 18; 19; 20; 21; 22; 23; 24; 25; 26; 27; 28; 29; 30]
      ) ] in
  let sorted = tsort graph in
  print_sorted sorted ; [%expect {| 1 -> 2 -> 3 -> 4 -> 5 -> 6 -> 7 -> 8 -> 9 -> 10 -> 30 -> 29 -> 28 -> 27 -> 26 -> 25 -> 24 -> 23 -> 22 -> 21 -> 20 -> 19 -> 18 -> 17 -> 16 -> 15 -> 14 -> 13 -> 12 -> 11 |}]

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
