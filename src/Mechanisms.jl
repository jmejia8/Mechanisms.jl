module Mechanisms

export getOptimizationProblem
export PTS_VERTICAL_LINE, PTS_ELLIPTIC, PTS_PAIR_1, PTS_PAIR_2

include("testPoints.jl")
include("fourBarMechanism.jl")

end # module
