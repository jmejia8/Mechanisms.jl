if VERSION < v"0.7.0"
    if Pkg.installed("Plots") == nothing
        Pkg.add("Plots")
    end

    if Pkg.installed("DifferentialEquations") == nothing
        Pkg.add("DifferentialEquations")
    end
end

using DifferentialEquations
using Plots

gr(size=(500, 500),
   dpi = 19,
   legend=false)