module Mechanisms

export getOptimizationProblem, animateFourBarMechanism,getDynamicOptimizationProblem
export PTS_VERTICAL_LINE, PTS_ELLIPTIC, PTS_PAIR_1, PTS_PAIR_2

# include("externals.jl")
# include("fourBarControl.jl")
include("testPoints.jl")
include("fourBarMechanism.jl")

end # module
