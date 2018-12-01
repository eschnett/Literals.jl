using Literals
using Test



# Create literal values

@test literal(false) isa LitInt{false}
@test literal(true) isa LitInt{true}

@test literal(0) isa LitInt{0}
@test literal(2) isa LitInt{2}
@test literal(-3) isa LitInt{-3}
@test literal(Int8(4)) isa LitInt{4}
@test literal(Int16(4)) isa LitInt{4}
@test literal(Int32(4)) isa LitInt{4}
@test literal(Int64(4)) isa LitInt{4}
@test literal(Int128(4)) isa LitInt{4}
@test literal(typemax(Int)) isa LitInt
@test literal(typemax(Int128)) isa Int128
@test literal(1+big(typemax(Int128))) isa BigInt

@test literal(Unsigned(0)) isa LitInt{UInt(0)}
@test literal(Unsigned(2)) isa LitInt{UInt(2)}
@test literal(UInt8(4)) isa LitInt{UInt(4)}
@test literal(UInt16(4)) isa LitInt{UInt(4)}
@test literal(UInt32(4)) isa LitInt{UInt(4)}
@test literal(UInt64(4)) isa LitInt{UInt(4)}
@test literal(UInt128(4)) isa LitInt{UInt(4)}
@test literal(typemax(UInt)) isa LitInt
@test literal(typemax(UInt128)) isa UInt128
@test literal(1+big(typemax(UInt128))) isa BigInt

@test literal(2//1) isa LitRat{2, 1}
@test literal(1//2) isa LitRat{1, 2}
@test literal(Int8(1)//Int8(2)) isa LitRat{1, 2}
@test literal(Int16(1)//Int16(2)) isa LitRat{1, 2}
@test literal(Int32(1)//Int32(2)) isa LitRat{1, 2}
@test literal(Int64(1)//Int64(2)) isa LitRat{1, 2}
@test literal(Int128(1)//Int128(2)) isa LitRat{1, 2}

@test literal(1.0) isa LitRat{1, 1}
@test literal(1.5) isa LitRat{3, 2}
@test literal(1.5f0) isa Float32
@test literal(Float16(1.5)) isa Float16
@test literal(big(1.5)) isa BigFloat

@test literal(π) isa LitSym{:π}
@test literal(pi) isa LitSym{:π}
@test literal(ℯ) isa LitSym{:ℯ}
@test literal(:π) isa LitSym{:π}
@test literal(:pi) isa LitSym{:π}
@test literal(:ℯ) isa LitSym{:ℯ}



# Evaluate literal values

@test Bool(literal(false)) === false
@test Bool(literal(true)) === true

@test Int(literal(2)) === 2
@test Integer(literal(2)) === 2
@test Integer(literal(2000)) === 2000
@test Integer(literal(200000)) === 200000
@test Integer(literal(20000000000)) === 20000000000
@test Integer(literal(20000000000000000000)) === 20000000000000000000
@test Integer(literal(0x2)) === 0x2
@test Integer(literal(0x200)) === 0x200
@test Integer(literal(0x20000)) === 0x20000
@test Integer(literal(0x200000000)) === 0x200000000
@test Integer(literal(0x20000000000000000)) === 0x20000000000000000
@test isequal(Rational(literal(2)), 2//1)
@test isequal(Rational(literal(2//3)), 2//3)

@test isequal(Float64(literal(1.0)), 1.0)
@test isequal(Float64(literal(1.5)), 1.5)
@test isequal(AbstractFloat(literal(1.0)), 1.0)
@test isequal(AbstractFloat(literal(1.5)), 1.5)

@test isequal(AbstractFloat(literal(:π)), Float64(π))



# Operations between literal values

# Unary operations
@test + literal(2) === literal(2)
@test + literal(2//3) === literal(2//3)
@test + literal(:π) === literal(:π)

@test - literal(2) === literal(-2)
@test - literal(2//3) === literal(-2//3)
@test isequal(- literal(:π), - Float64(π))

@test abs(literal(2)) === literal(2)
@test abs(literal(-2)) === literal(2)
@test abs(literal(2//3)) === literal(2//3)
@test abs(literal(-2//3)) === literal(2//3)
@test isequal(abs(literal(:π)), abs(Float64(π)))

@test inv(literal(2)) === literal(1//2)
@test inv(literal(2//3)) === literal(3//2)
@test isequal(inv(literal(:π)), inv(Float64(π)))

@test max(literal(2)) === literal(2)
@test max(literal(2//3)) === literal(2//3)
@test max(literal(:π)) === literal(:π)

@test min(literal(2)) === literal(2)
@test min(literal(2//3)) === literal(2//3)
@test min(literal(:π)) === literal(:π)

@test sign(literal(2)) === literal(1)
@test sign(literal(0)) === literal(0)
@test sign(literal(-2)) === literal(-1)
@test sign(literal(2//3)) === literal(1//1)
@test sign(literal(0//3)) === literal(0//1)
@test sign(literal(-2//3)) === literal(-1//1)
@test isequal(sign(literal(:π)), 1.0)

@test signbit(literal(2)) === literal(false)
@test signbit(literal(0)) === literal(false)
@test signbit(literal(-2)) === literal(true)
@test signbit(literal(2//3)) === literal(false)
@test signbit(literal(0//3)) === literal(false)
@test signbit(literal(-2//3)) === literal(true)
@test signbit(literal(:π)) === false

# Binary operations
@test literal(2) + literal(3) === literal(5)
@test literal(2) + literal(3//4) === literal(11//4)
@test literal(2//3) + literal(3//4) === literal(17//12)
@test literal(1//3) + literal(2//3) === literal(1//1)
@test isequal(literal(2) + literal(:π), 2 + Float64(π))

@test literal(2) - literal(3) === literal(-1)
@test literal(2) - literal(3//4) === literal(5//4)
@test literal(2//3) - literal(3//4) === literal(-1//12)
@test literal(4//3) - literal(1//3) === literal(1//1)
@test isequal(literal(2) - literal(:π), 2 - Float64(π))

@test literal(2) * literal(3) === literal(6)
@test literal(2) * literal(3//4) === literal(3//2)
@test literal(2//3) * literal(3//4) === literal(1//2)
@test literal(1//3) * literal(3//1) === literal(1//1)
@test isequal(literal(2) * literal(:π), 2 * Float64(π))

@test literal(2) / literal(3) === literal(2//3)
@test literal(2) / literal(3//4) === literal(8//3)
@test literal(2//3) / literal(3//4) === literal(8//9)
@test literal(1//3) / literal(1//3) === literal(1//1)
@test isequal(literal(2) / literal(:π), 2 / Float64(π))

@test literal(2) \ literal(3) === literal(3//2)
@test literal(2) \ literal(3//4) === literal(3//8)
@test literal(2//3) \ literal(3//4) === literal(9//8)
@test literal(1//3) \ literal(1//3) === literal(1//1)
@test isequal(literal(2) \ literal(:π), 2 \ Float64(π))

@test literal(2) // literal(3) === literal(2//3)
@test literal(2) // literal(3//4) === literal(8//3)
@test literal(2//3) // literal(3//4) === literal(8//9)
@test literal(1//3) // literal(1//3) === literal(1//1)

@test (literal(2) == literal(2)) === literal(true)
@test (literal(2) == literal(3)) === literal(false)
@test (literal(:π) == literal(:π)) === true
@test (literal(:π) == literal(:ℯ)) === false

@test (literal(2) != literal(2)) === literal(false)
@test (literal(2) != literal(3)) === literal(true)
@test (literal(:π) != literal(:π)) === false
@test (literal(:π) != literal(:ℯ)) === true

@test (literal(2) < literal(2)) === literal(false)
@test (literal(2) < literal(3)) === literal(true)
@test (literal(:π) < literal(:π)) === false
@test (literal(:π) < literal(:ℯ)) === false

@test (literal(2) > literal(2)) === literal(false)
@test (literal(2) > literal(3)) === literal(false)
@test (literal(:π) > literal(:π)) === false
@test (literal(:π) > literal(:ℯ)) === true

@test (literal(2) <= literal(2)) === literal(true)
@test (literal(2) <= literal(3)) === literal(true)
@test (literal(:π) <= literal(:π)) === true
@test (literal(:π) <= literal(:ℯ)) === false

@test (literal(2) >= literal(2)) === literal(true)
@test (literal(2) >= literal(3)) === literal(false)
@test (literal(:π) >= literal(:π)) === true
@test (literal(:π) >= literal(:ℯ)) === true

@test cmp(literal(2), literal(2)) === literal(0)
@test cmp(literal(2), literal(3)) === literal(-1)
@test cmp(literal(3), literal(2)) === literal(1)
@test cmp(literal(:π), literal(:π)) === 0
@test cmp(literal(:π), literal(:ℯ)) === 1

@test copysign(literal(2), literal(-3)) === literal(-2)
@test copysign(literal(2), literal(3)) === literal(2)
@test copysign(literal(-2), literal(-3)) === literal(-2)
@test copysign(literal(-2), literal(3)) === literal(2)
# Note: Julia's copysign is not type-stable, but ours is.
# @test isequal(copysign(literal(:π), literal(:ℯ)), copysign(π, ℯ))

@test flipsign(literal(2), literal(-3)) === literal(-2)
@test flipsign(literal(2), literal(3)) === literal(2)
@test flipsign(literal(-2), literal(-3)) === literal(2)
@test flipsign(literal(-2), literal(3)) === literal(-2)
# Note: Julia's flipsign is not type-stable, but ours is.
# @test isequal(flipsign(literal(:π), literal(:ℯ)), flipsign(π, ℯ))
