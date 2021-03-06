# OpenDSSDirect

[OpenDSS](http://smartgrid.epri.com/SimulationTool.aspx) is an open-source
distribution system simulator. This Julia package implements a "direct" library
interface to OpenDSS. See [this
documentation](http://svn.code.sf.net/p/electricdss/code/trunk/Distrib/Doc/OpenDSS_Direct_DLL.pdf)
for detailed information on the direct library interface to OpenDSS. The direct
library interface can be faster than the more traditional COM interface.

## Installation

For now, this package is registered, so you can use the following to install:

```julia
Pkg.add("OpenDSSDirect")
```

To install the latest development version, use the following from within Julia:

```julia
Pkg.checkout("OpenDSSDirect")
```

This package includes OpenDSS as a library. You do not have to install OpenDSS
separately. In particular, it includes the OpenDSSDirect dynamically linked
library that implements the direct-access API.

Note that this should work on 32- and 64-bit Windows systems and 64-bit Linux
and Mac systems. The Windows dynamic-linked libraries are taken from the official
libraries ccompiled by Delphi. The Linux library is based on the LazDSS branch.
The Linux library was compiled on an older version of Linux (Centos 6.4). It 
should run on most newer versions of Linux. If it does not, you can try compiling
the library on your system. Including DLL binaries is not the
best practice, but this works well enough for now. Installing and compiling
Lazarus and LazDSS is not easy to do as part of package installation.

For compiling libraries, please see [OpenDSSDirect.make](https://github.com/Muxelmann/OpenDSSDirect.make).

## Features

[Julia](http://julialang.org/) is a fast, flexible numerical language with
Matlab-like syntax. Like Python or Matlab, scripting OpenDSS can be used for
Monte-Carlo batch runs, parameter sweeps, post processing and plotting of
results, and more.

Julia has several key features for advanced operations with OpenDSS:

* **Parallel operations** -- Julia supports several ways to process data in
  parallel. This includes parallel operations on multiple CPU cores and
  parallel operations on processes in a cluster. See
  [examples/8760_pmap.jl](https://github.com/tshort/OpenDSSDirect.jl/blob/master/examples/8760_pmap.jl)
  for an example of an annual simulation split among local CPU cores.

* **Optimization** -- Julia has strong support for optimization.

* **Custom solutions and custom models** -- Because Julia compiles to codes
  that run as quickly as C programs, it is possible to implement custom
  solutions, and these custom solutions can contain custom models implemented
  in Julia. The basic idea is to run a custom solution as described in
  [OpenDSS Solution Interface.pdf](http://svn.code.sf.net/p/electricdss/code/trunk/Distrib/Doc/OpenDSS%20Solution%20Interface.pdf).
  Custom control or power control elements can be implemented between each
  model iteration. See
  [examples/low-level-solver.jl](https://github.com/tshort/OpenDSSDirect.jl/blob/master/examples/low-level-solver.jl)
  for an example with a custom solver, including a case with an alternate sparse
  matrix solver.

## Example

The `dss` function is the main function for passing commands to OpenDSS. 
After that, a number of modules are available to access different data structures
in OpenDSS. Here is an example summing the kW and kvar from loads using the 
`Loads` module:

```julia
using OpenDSSDirect.DSS
filename = Pkg.dir("OpenDSSDirect", "examples", "8500-Node", "Master.dss")
dss("""
    clear
    compile $filename
    solve
""")

loadnumber = Loads.First()
kWsum = 0.0
kvarsum = 0.0
while loadnumber > 0
    kWsum += Loads.kW()
    kvarsum += Loads.kvar()
    loadnumber = Loads.Next()
end
```


## Contents

```@contents
Pages = [
    "api.md",
    "flags.md",
    "dssmode.md",
    "lowlevel.md",
    "docindex.md"
]
Depth = 1
```
