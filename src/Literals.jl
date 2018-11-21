module Literals

# Basic idea: Numeric literals are integers (if they have no decimal
# dot) or rationals (if they do have a decimal dot).
#
# Literal values can be combined with the usual arithmetic operations
# (+, -, *, /, etc.). Integer literals are converted to rational
# literals when necessary, i.e. when they are combined with a rational
# literal, or when they are divided.
#
# When a literal value is combined (via an arithmetic operation) with
# a non-literal value, then it is converted to the type of the other
# operand. (Question: Should the resulting type depend on the
# magnitude of the literal?)
#
# When a rational literal encounters an integer, it is converted to a
# floating point number. This is because Julia prefers floating point
# numbers over rational numbers.
#
# Question: All literal processing should happen at compile time. Can
# we enforce this somehow?



struct Literal{T} <: Number
    value::T
end

export IntLiteral
const IntLiteral = Literal{BigInt}

export RationalLiteral
const RationalLiteral = Literal{Rational{BigInt}}

export literal
literal(x::Integer) = IntLiteral(x)
literal(x::Rational) = RationalLiteral(x)

# rational(x::IntLiteral) = RationalLiteral(x.value)
# rational(x::RationalLiteral) = x
rational(x::Integer) = Rational{BigInt}(x)
rational(x::Rational) = x



(::Type{N})(x::IntLiteral) where {N <: Number} = N(x.value)
(::Type{I})(x::RationalLiteral) where {I <: Integer} = float(I)(x.value)
(::Type{F})(x::RationalLiteral) where {F <: AbstractFloat} = F(x.value)

Base.promote_rule(::Type{IntLiteral}, ::Type{RationalLiteral}) = RationalLiteral
Base.promote_rule(::Type{IntLiteral}, ::Type{N}) where {N <: Number} = N
Base.promote_rule(::Type{RationalLiteral},
                  ::Type{I}) where {I <: Integer} = float(I)
Base.promote_rule(::Type{RationalLiteral},
                  ::Type{F}) where {F <: AbstractFloat} = F



function Base.zero(::Type{L}) where {L <: Literal}
    L(0)
end

function Base.one(::Type{L}) where {L <: Literal}
    L(1)
end



function Base. +(x::Literal, ys::Literal...)
    literal(+(x.value, map(y->y.value, ys)...))
end

function Base. -(x::Literal)
    literal(- x.value)
end
function Base. -(x::Literal, y::Literal)
    literal(x.value - y.value)
end

function Base.abs(x::Literal)
    literal(abs(x.value))
end
function Base.sign(x::Literal)
    # We could convert to IntLiteral here
    literal(sign(x.value))
end
function Base.signbit(x::Literal)
    signbit(x.value)
end



function Base. *(x::Literal, ys::Literal...)
    literal(*(x.value, map(y->y.value, ys)...))
end

function Base.inv(x::Literal)
    literal(inv(rational(x.value)))
end
function Base. /(x::Literal, y::Literal)
    literal(rational(x.value) / rational(y.value))
end
function Base. \(x::Literal, y::Literal)
    y / x
end

function Base. ^(x::Literal, y::IntLiteral)
    if y >= 0
        literal(x.value ^ y.value)
    else
        literal(rational(x.value) ^ y.value)
    end
end



function Base.isequal(x::Literal, y::Literal)
    x.value == y.value
end

function Base.isless(x::Literal, y::Literal)
    x.value < y.value
end

function Base. ==(x::Literal, y::Literal)
    x.value == y.value
end

function Base. !=(x::Literal, y::Literal)
    x.value != y.value
end

function Base. <(x::Literal, y::Literal)
    x.value < y.value
end

function Base. <=(x::Literal, y::Literal)
    x.value <= y.value
end

function Base. >(x::Literal, y::Literal)
    x.value > y.value
end

function Base. >=(x::Literal, y::Literal)
    x.value >= y.value
end

end
