Changes since Idris 2 v0.2.0
----------------------------

Language changes:

* `Bits8`, `Bits16`, `Bits32` and `Bits64` primitive types added, with:
   + `Num`, `Eq`, `Ord` and `Show` implementations.
   + Casts from `Integer`, for literals
   + Casts to `Int` (except `Bits64` which might not fit), `Integer` and `String`
   + Passed to C FFI as `unsigned`
   + Primitives added in `Data.Buffer`
* Elaborator reflection and quoting terms
   + Requires extension `%language ElabReflection`
   + API defined in `Language.Reflection`, including functions for getting types
     of global names, constructors of data types, and adding new top level
     declarations
   + Implemented `%macro` function flag, to remove the syntactic noise of
     invoking elaborator scripts. This means the function must always
     be fully applied, and is run under `%runElab`
* Add `import X as Y`
   + This imports the module `X`, adding aliases for the definitions in
     namespace `Y`, so they can be referred to as `Y`.
* `do` notation can now be qualified with a namespace
   + `MyDo.do` opens a `do` block where the `>>=` operator used is `MyDo.(>>=)`

Library changes:

* `IO` operations in the `prelude` and `base` libraries now use the
  `HasIO` interface, rather than using `IO` directly.
* Experimental `Data.Linear.Array` added to `contrib`, supporting mutable
  linear arrays with constant time read/write, convertible to immutable arrays
  with constant time read.
   + Anything in `Data.Linear` in `contrib`, just like the rest of `contrib`,
     should be considered experimental with the API able to change at any time!
     Further experiments in `Data.Linear` are welcome :).
* Experimental `Control.Linear.LIO` added to `contrib`, supporting computations
  which track the multiplicities of their return values, which allows linear
  resources to be tracked.
* Added `Control.Monad.ST`, for update in-place via `STRef` (which is like
  `IORef`, but can escape from `IO`). Also added `Data.Ref` which provides an
  interface to both `IORef` and `STRef`.
* Added `Control.ANSI` in `contrib`, for usage of ANSI escape codes for text
  styling and cursor/screen control in terminals.

Command-line options changes:

* Removed `--ide-mode-socket-with` option.  `--ide-mode-socket` now accepts an
  optional `host:port` argument.
* Added options to override source directory, build directory and output
  directory: `--source-dir`, `--build-dir`, `--output-dir`.
  + These options are also available as fields in the package description:
    `sourcedir`, `builddir`, `outputdir`.

Compiler changes:

* It is now possible to create new backends with minimal overhead. `Idris.Driver`
exposes the function `mainWithCodegens` that takes a list of codegens. The
feature in documented [here](https://idris2.readthedocs.io/en/latest/backends/custom.html).
* New code generators `node` and `js`.

REPL changes:

* Implemented `:module` command, to load a module during a REPL session.
* Implemented `:doc`, which displays documentation for a name.
* Implemented `:browse`, which lists the names exported by a namespace.

Changes since Idris 2 v0.1.0
----------------------------

The implementation is now self-hosted. To initialise the build, either use
the [bootstrapping version of Idris2](https://github.com/edwinb/Idris2-boot)
or build from the generated Scheme, using `make bootstrap`.

Language changes:

* `total`, `covering` and `partial` flags on functions now have an effect.
* `%default <totality status>` has been implemented. By default, functions must
  be at least `covering`
  + That is, `%default covering` is the default status.
* Fields of records can be accessed (and updated) using the dot syntax,
  such as `r.field1.field2` or `record { field1.field2 = 42 }`.
  For details, see https://idris2.readthedocs.io/en/latest/reference/records.html
* New function flag `%tcinline` which means that the function should be
  inlined for the purposes of totality checking (but otherwise not inlined).
  This can be used as a hint for totality checking, to make the checker look
  inside functions that it otherwise might not.
* %transform directive, for declaring transformation rules on runtime
  expressions. Transformation rules are automatically added for top level
  implementations of interfaces.
* A %spec flag on functions which allows arguments to be marked for partial
  evaluation, following the rules from "Scrapping Your Inefficient Engine"
  (ICFP 2010, Brady & Hammond)
* To improve error messages, one can use `with NS.name <term>`
  or `with [NS.name1, NS.name2, ...] <term>` to disable disambiguation
  for the given names in `<term>`. Example: `with MyNS.(>>=) do ...`.

Library additions:

* Additional file management operations in `base`
* New module in `base` for time (`System.Clock`)
* New modules in `contrib` for JSON (`Language.JSON.*`); random numbers
  (`System.Random`)

Compiler updates:

* Data types with a single constructor, with a single unerased arguments,
  are translated to just that argument, to save repeated packing and unpacking.
  (c.f. `newtype` in Haskell)
  + A data type can opt out of this behaviour by specifying `noNewtype` in its
    options list. `noNewtype` allows code generators to apply special handling
    to the generated constructor/deconstructor, for a newtype-like data type,
    that would otherwise be optimised away.
* 0-multiplicity constructor arguments are now properly erased, not just
  given a placeholder null value.

Other improvements:

* Various performance improvements in the typechecker:
  + Noting which metavariables are blocking unification constraints, so that
    they only get retried if those metavariables make progress.
  + Evaluating `fromInteger` at compile time.
* Extend Idris2's literate mode to support reading Markdown and OrgMode files.
  For more details see: https://idris2.readthedocs.io/en/latest/reference/literate.html

Changes since Idris 1
---------------------

Everything :). For full details, see:
https://idris2.readthedocs.io/en/latest/updates/updates.html
