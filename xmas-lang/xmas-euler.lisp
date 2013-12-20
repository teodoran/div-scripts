(load "~/Depot/private-scripts/xmas-lang/xmas-compiler.lisp")

-
  2   +
  3     $ -> #333 <x *3x>
  4       acc 0
  5       <x +x acc>
  6     $ =? -> #200 <x *5x>
  7         <x >999 x>
  8       acc 0 
  9       <x +x acc>
 10   $ =? -> #67 <x **3 5 x>
 11       <x >999 x>
 12     acc 0 
 13     <x +x acc>