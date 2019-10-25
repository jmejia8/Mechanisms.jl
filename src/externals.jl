if VERSION < v"0.7.0"
    if Pkg.installed("DifferentialEquations") == nothing
        Pkg.add("DifferentialEquations")
    end
end

using DifferentialEquations
