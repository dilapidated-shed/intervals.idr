# intervals.idr

An independent home for exact intervals and uncertainty semantics that can be carried into Idriç and consumed by [Econometrician-in-a-Box](https://github.com/bl4ckb4ll/econometrician).

The central distinction is between **a set of possible values** and **a claim about why or how well a value is known**. An interval alone has no confidence level, distribution, sampling model, physical provenance, or Gaussian interpretation.

The initial executable target is an Idris 2-compatible exact-rational interval core. Modern Idriç semantic contracts will be developed alongside it without claiming that the current compiler has already accepted or executed them. This repository remains independent of the Idriç compiler; checked source and downstream integration must be verified separately.

See [issue #1](https://github.com/dilapidated-shed/intervals.idr/issues/1), [Idriç issue #30](https://github.com/isomorphisms/Idric/issues/30), and [Econometrician](https://github.com/bl4ckb4ll/econometrician). The first implementation is on a feature branch; the empty initial repository did not contain executable code.
