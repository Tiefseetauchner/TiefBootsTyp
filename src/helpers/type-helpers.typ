#let default(val, default) = if val == none { default } else { val }

#let spread-or-single(arg) = if type(arg) == array { arg } else if arg == none { () } else { (arg,) }
