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