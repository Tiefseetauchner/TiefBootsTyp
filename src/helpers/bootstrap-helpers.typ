#let concat-class-name(base, breakpoint) = {
  if breakpoint == none {
    base
  } else {
    base + "-" + breakpoint
  }
}

#let get-breakpointed-size-class-name(base, ..args) = {
  let result = ()

  if args.pos().len() > 0 {
    let first-pos-arg = str(args.pos().at(0))

    result += (base + "-" + first-pos-arg,)
  }

  for (breakpoint, value) in args.named() {
    result += (base + "-" + breakpoint + "-" + str(value),)
  }

  return result
}
