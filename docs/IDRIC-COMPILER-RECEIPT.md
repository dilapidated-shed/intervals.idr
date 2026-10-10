# Pinned compiler revision for Idriç source acceptance

This workflow must use the maintained [Idriç compiler](https://github.com/isomorphisms/Idric), not the generic Idris 2 container used for the old compatibility suite.

**Compiler revision:** `94dfd99bd3e376507fedc8611053b7173b2519f0` on Idriç's default `Idriç` branch.

**Command:** `./edric bootstrap`, then that compiler's `idris2 --build intervals-idric.ipkg`, then run the fixture executable.

This is source-language and host-level proof/test acceptance. It is not direct ARM32, DEX, GPU, or other target backend acceptance. Pin updates require renewed verification.
