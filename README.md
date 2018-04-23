# Mechanisms

 Kinetics of important Mechanisms, prepared to constrained optimization.


[![Build Status](https://travis-ci.org/jmejia8/Mechanisms.jl.svg?branch=master)](https://travis-ci.org/jmejia8/Mechanisms.jl)

# Example

```julia
using Mechanisms
p =  [25.806923155616076,7.206840543271378,25.433307805225706,
      25.581872903631492,43.76124192997665,17.31237766430696,
      4.328061708805246,-18.454401816641795,56.391854888638704,
      1.7725777135059568,2.406537344482028,2.905924030160018,
      3.3833860876551376,3.8836626455580485,4.520954645032934]

D, f, g = getOptimizationProblem(PTS_VERTICAL_LINE)


@printf("Error: %e\n", f(p))
println("Constraints: ", g( p ))
```
<!-- [![Coverage Status](https://coveralls.io/repos/jmejia8/Mechanisms.jl/badge.svg?branch=master&service=github)](https://coveralls.io/github/jmejia8/Mechanisms.jl?branch=master)

[![codecov.io](http://codecov.io/github/jmejia8/Mechanisms.jl/coverage.svg?branch=master)](http://codecov.io/github/jmejia8/Mechanisms.jl?branch=master)
 -->