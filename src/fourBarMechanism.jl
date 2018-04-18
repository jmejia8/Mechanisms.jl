function grashof(p)
    g = zeros(4)
    g[1] = p[1]+p[2]-p[3]-p[4]
    g[2] = p[2]-p[3]
    g[3] = p[3]-p[4]
    g[4] = p[4]-p[1]

    for i = 1:4
        g[i] <= 0.0 && (g[i] = 0.0)
    end

    return g
end

function sequence(θ2)
    n = length(θ2)
    offset = θ2[1]

    nvector = zeros(n)
    nvector[1]=0

    if π <= offset <= 2π 
        for i=2:n
            if  π <= θ2[i] <= 2π
               nvector[i] = θ2[i] - offset 
            else
               nvector[i] = θ2[i] + offset
            end
        end
    else
        for i=2:n
            nvector[i] = θ2[i]-offset
        end
    end
              
    g = zeros(n)

    for i = 1:n-1
        gi = nvector[i] - nvector[i+1]

        gi >= 0 && ( g[i] = gi )
    end

    nvector[n] >= 2π && ( g[n] = 2π )
        
    return g
end

function fourBarKinetics(p::Vector{Float64}, θ2_values::Vector{Float64})
    # p = [r1, r2, r3, r4, rcx, rcy θ0, x0, y0]
    # θ2_values = [θ21, ..., θ2n]
    θ1 = 0.0

    C = zeros( length(θ2_values),2 )

    i = 1
    for θ2 = θ2_values
        A1 = 2p[3] * (p[2] * cos(θ2) - p[1]*cos(θ1))
        B1 = 2p[3] * (p[2] * sin(θ2) - p[1]*sin(θ1))
        C1 = p[1]^2+p[2]^2+p[3]^2-p[4]^2- 2p[1]*p[2]*cos(θ2-θ1)
        
        Dis = B1^2+A1^2-C1^2

        if Dis < 0
            continue
        end

        θ3 = 2atan((-B1+sqrt(Dis))/(C1-A1))
        
        Cxr = p[2]*cos(θ2)+p[5]*cos(θ3)-p[6]*sin(θ3)
        Cyr = p[2]*sin(θ2)+p[5]*sin(θ3)+p[6]*cos(θ3)
        
        C[i,1] = Cxr*cos(p[7])-Cyr*sin(p[7])+p[8]
        C[i,2] = Cxr*sin(p[7])+Cyr*cos(p[7])+p[9]

        i += 1
    end

    # coupler
    return C
end

function quadraticError(X::Matrix{Float64}, Y::Matrix{Float64})
    # length(X) == length(Y)

    return sum( (X - Y) .^ 2 )
end

function objectiveFunction(p, precisionPts)
    # coupler values
    C = fourBarKinetics(p[1:9], p[10:end])

    # error
    return quadraticError(C, precisionPts)
end

function contraints(p)
    if length(p) < 10
        return grashof(p)
    end
    return [grashof(p); sequence(p[10:end])]
end

# no synchronized strategy
function getOptimizationProblem(precisionPts::Matrix{Float64})
    return 9 + size(precisionPts,1), # search space dimension
           p -> objectiveFunction(p, precisionPts),
           p -> contraints(p)
end

# not synchronized strategy pair points
function getOptimizationProblem(precisionPts::Matrix{Float64}, precisionPts2::Matrix{Float64})
    return 9 + size(precisionPts,1), # search space dimension
           p -> objectiveFunction(p, precisionPts) + objectiveFunction(p, precisionPts2),
           p -> 2contraints(p)
end

# synchronized strategy
function getOptimizationProblem(precisionPts::Matrix{Float64}, X0::Vector{Float64}, θ2::Vector{Float64})
    # X0 = [θ0, x0, y0]
    return 6, # search space dimension
           p -> objectiveFunction([p; X0; θ2], precisionPts),
           p -> contraints(p)
end