#--------------------------------------------------------------------
# Spacetime Discretization methods in Julia
# Soham 01-2018
#--------------------------------------------------------------------

function chebx{T<:Integer}(i::T, N::T)
	cospi((i-1)/N)
end

function chebd{T<:Integer}(i::T, j::T, N::T)
	if i==j==1
		return (2N^2 + 1)/6
	elseif i==j==N+1
		return -(2N^2 + 1)/6
	elseif i==j
		return -chebx(j, N)/(2(1-chebx(j, N)^2))
	else
		ci = (i == 1 || i == N+1) ? 2 : 1
		cj = (j == 1 || j == N+1) ? 2 : 1
		s  = (i + j) % 2 != 0 ? -1 : 1
		return (ci/cj)*(s/(chebx(i,N)-chebx(j,N)))
	end
end

function chebw{T<:Integer}(i::T, N::T)
	W = 0.0
	for j in 1:N+1
		w = (j == 1 ? 1 : (j-1)%2 == 0 ? 2/(1-(j-1)^2): 0)
		l = (i == 1 || i == N+1 ? (1/N)*cospi((i-1)*(j-1)/N) : (2/N)*cospi((i-1)*(j-1)/N))
		W +=  w*l
	end
	return W
end
