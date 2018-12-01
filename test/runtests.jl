using Literals
using Test



# Create literal values

@test literal(false) isa LitInt{false}
@test literal(true) isa LitInt{true}

@test literal(0) isa LitInt{Int128(0)}
@test literal(2) isa LitInt{Int128(2)}
@test literal(-3) isa LitInt{Int128(-3)}
@test literal(Int8(4)) isa LitInt{Int128(4)}
@test literal(Int16(4)) isa LitInt{Int128(4)}
@test literal(Int32(4)) isa LitInt{Int128(4)}
@test literal(Int64(4)) isa LitInt{Int128(4)}
@test literal(Int128(4)) isa LitInt{Int128(4)}

@test literal(Unsigned(0)) isa LitInt{UInt128(0)}
@test literal(Unsigned(2)) isa LitInt{UInt128(2)}
@test literal(UInt8(4)) isa LitInt{UInt128(4)}
@test literal(UInt16(4)) isa LitInt{UInt128(4)}
@test literal(UInt32(4)) isa LitInt{UInt128(4)}
@test literal(UInt64(4)) isa LitInt{UInt128(4)}
@test literal(UInt128(4)) isa LitInt{UInt128(4)}

@test literal(2//1) isa LitRat{Int128(2), Int128(1)}
@test literal(1//2) isa LitRat{Int128(1), Int128(2)}
@test literal(Int8(1)//Int8(2)) isa LitRat{Int128(1), Int128(2)}
@test literal(Int16(1)//Int16(2)) isa LitRat{Int128(1), Int128(2)}
@test literal(Int32(1)//Int32(2)) isa LitRat{Int128(1), Int128(2)}
@test literal(Int64(1)//Int64(2)) isa LitRat{Int128(1), Int128(2)}
@test literal(Int128(1)//Int128(2)) isa LitRat{Int128(1), Int128(2)}

@test literal(1.0) isa LitRat{Int128(1), Int128(1)}
@test literal(1.5) isa LitRat{Int128(3), Int128(2)}
@test literal(1.5f0) isa LitRat{Int128(3), Int128(2)}
@test literal(Float16(1.5)) isa LitRat{Int128(3), Int128(2)}

@test literal(π) isa LitFun{:π, Tuple{}}
@test literal(pi) isa LitFun{:π, Tuple{}}
@test literal(ℯ) isa LitFun{:ℯ, Tuple{}}
@test literal(:π) isa LitFun{:π, Tuple{}}
@test literal(:pi) isa LitFun{:π, Tuple{}}
@test literal(:ℯ) isa LitFun{:ℯ, Tuple{}}

@test LitFun(:+, literal(2)) isa LitFun{:+, Tuple{LitInt{Int128(2)}}}
@test LitFun(:inv, literal(2)) isa LitFun{:inv, Tuple{LitInt{Int128(2)}}}

@test (LitFun(:+, literal(2), literal(3)) isa
       LitFun{:+, Tuple{LitInt{Int128(2)}, LitInt{Int128(3)}}})
@test (LitFun(:*, literal(2), literal(3)) isa
       LitFun{:*, Tuple{LitInt{Int128(2)}, LitInt{Int128(3)}}})

@test LitExpr(:π) isa LitExpr
@test LitExpr(:ℯ) isa LitExpr

@test LitExpr(:+, literal(2)) isa LitExpr
@test LitExpr(:inv, literal(2)) isa LitExpr

@test LitExpr(:+, literal(2), literal(3)) isa LitExpr
@test LitExpr(:*, literal(2), literal(3)) isa LitExpr



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

@test Integer(LitFun(:+, literal(2))) === 2
@test Rational(LitFun(:inv, literal(2))) === 1//2

@test Integer(LitFun(:+, literal(2), literal(3))) === 5
@test Integer(LitFun(:*, literal(2), literal(3))) === 6

@test isequal(AbstractFloat(LitExpr(:π)), Float64(π))

@test Integer(LitExpr(:+, literal(2))) === 2
@test Rational(LitExpr(:inv, literal(2))) === 1//2

@test Integer(LitExpr(:+, literal(2), literal(3))) === 5
@test Integer(LitExpr(:*, literal(2), literal(3))) === 6



# Operations between literal values

# Unary operations
@test + literal(2) === literal(2)
@test + literal(2//3) === literal(2//3)
@test + literal(:π) === literal(:π)

@test - literal(2) === literal(-2)
@test - literal(2//3) === literal(-2//3)
@test - literal(:π) === literal(:-, literal(:π))
@test - (- literal(:π)) === literal(:π)

@test abs(literal(2)) === literal(2)
@test abs(literal(-2)) === literal(2)
@test abs(literal(2//3)) === literal(2//3)
@test abs(literal(-2//3)) === literal(2//3)
@test abs(literal(:π)) === literal(:abs, literal(:π))
@test abs(abs(literal(:π))) === abs(literal(:π))
@test abs(-literal(:π)) === abs(literal(:π))

@test inv(literal(2)) === literal(1//2)
@test inv(literal(2//3)) === literal(3//2)
@test inv(literal(:π)) === literal(:inv, literal(:π))
@test inv(inv(literal(:π))) === literal(:π)

@test max(literal(2)) === literal(2)
@test max(literal(2//3)) === literal(2//3)
@test max(literal(:π)) === literal(:π)

@test min(literal(2)) === literal(2)
@test min(literal(2//3)) === literal(2//3)
@test min(literal(:π)) === literal(:π)

@test sign(literal(2)) === literal(1)
@test sign(literal(-2)) === literal(-1)
@test sign(literal(2//3)) === literal(1//1)
@test sign(literal(-2//3)) === literal(-1//1)
@test sign(literal(:π)) === literal(:sign, literal(:π))
@test sign(sign(literal(:π))) === sign(literal(:π))

@test signbit(literal(2)) === literal(false)
@test signbit(literal(-2)) === literal(true)
@test signbit(literal(2//3)) === literal(false)
@test signbit(literal(-2//3)) === literal(true)
@test signbit(literal(:π)) === literal(:signbit, literal(:π))
@test signbit(signbit(literal(:π))) === literal(false)

# Binary operations
@test literal(2) + literal(3) === literal(5)
@test literal(2//3) + literal(3//4) === literal(17//12)
@test literal(1//3) + literal(2//3) === literal(1//1)
@test literal(2) + literal(:π) === literal(:+, literal(2), literal(:π))

@test literal(2) - literal(3) === literal(-1)
@test literal(2//3) - literal(3//4) === literal(-1//12)
@test literal(4//3) - literal(1//3) === literal(1//1)
@test literal(2) - literal(:π) === literal(:-, literal(2), literal(:π))

@test literal(2) * literal(3) === literal(6)
@test literal(2//3) * literal(3//4) === literal(1//2)
@test literal(1//3) * literal(3//1) === literal(1//1)
@test literal(2) * literal(:π) === literal(:*, literal(2), literal(:π))

@test literal(2) / literal(3) === literal(2//3)
@test literal(2//3) / literal(3//4) === literal(8//9)
@test literal(1//3) / literal(1//3) === literal(1//1)
@test literal(2) / literal(:π) === literal(:/, literal(2), literal(:π))

@test literal(2) // literal(3) === literal(2//3)
@test literal(2//3) // literal(3//4) === literal(8//9)
@test literal(1//3) // literal(1//3) === literal(1//1)
@test literal(2) // literal(:π) === literal(://, literal(2), literal(:π))

@test literal(2) \ literal(3) === literal(3//2)
@test literal(2//3) \ literal(3//4) === literal(9//8)
@test literal(1//3) \ literal(1//3) === literal(1//1)
@test literal(2) \ literal(:π) === literal(:\, literal(2), literal(:π))

@test (literal(2) == literal(2)) === literal(true)
@test (literal(2) == literal(3)) === literal(false)
@test (literal(:π) == literal(:π)) === literal(true)
@test (literal(:π) == literal(:ℯ)) === literal(:(==), literal(:π), literal(:ℯ))

@test (literal(2) != literal(2)) === literal(false)
@test (literal(2) != literal(3)) === literal(true)
@test (literal(:π) != literal(:π)) === literal(false)
@test (literal(:π) != literal(:ℯ)) === literal(:(!=), literal(:π), literal(:ℯ))

@test (literal(2) < literal(2)) === literal(false)
@test (literal(2) < literal(3)) === literal(true)
@test (literal(3) < literal(2)) === literal(false)
@test (literal(:π) < literal(:π)) === literal(false)
@test (literal(:π) < literal(:ℯ)) === literal(:(<), literal(:π), literal(:ℯ))

@test (literal(2) > literal(2)) === literal(false)
@test (literal(2) > literal(3)) === literal(false)
@test (literal(3) > literal(2)) === literal(true)
@test (literal(:π) > literal(:π)) === literal(false)
@test (literal(:π) > literal(:ℯ)) === literal(:(>), literal(:π), literal(:ℯ))

@test (literal(2) <= literal(2)) === literal(true)
@test (literal(2) <= literal(3)) === literal(true)
@test (literal(3) <= literal(2)) === literal(false)
@test (literal(:π) <= literal(:π)) === literal(true)
@test (literal(:π) <= literal(:ℯ)) === literal(:(<=), literal(:π), literal(:ℯ))

@test (literal(2) >= literal(2)) === literal(true)
@test (literal(2) >= literal(3)) === literal(false)
@test (literal(3) >= literal(2)) === literal(true)
@test (literal(:π) >= literal(:π)) === literal(true)
@test (literal(:π) >= literal(:ℯ)) === literal(:(>=), literal(:π), literal(:ℯ))

@test cmp(literal(2), literal(2)) === literal(0)
@test cmp(literal(2), literal(3)) === literal(-1)
@test cmp(literal(3), literal(2)) === literal(1)
@test cmp(literal(:π), literal(:π)) === literal(0)
@test cmp(literal(:π), literal(:ℯ)) === literal(:cmp, literal(:π), literal(:ℯ))

@test copysign(literal(2), literal(-3)) === literal(-2)
@test copysign(literal(2), literal(3)) === literal(2)
@test copysign(literal(-2), literal(-3)) === literal(-2)
@test copysign(literal(-2), literal(3)) === literal(2)
@test (copysign(literal(:π), literal(:ℯ)) ===
       literal(:copysign, literal(:π), literal(:ℯ)))

@test flipsign(literal(2), literal(-3)) === literal(-2)
@test flipsign(literal(2), literal(3)) === literal(2)
@test flipsign(literal(-2), literal(-3)) === literal(2)
@test flipsign(literal(-2), literal(3)) === literal(-2)
@test (flipsign(literal(:π), literal(:ℯ)) ===
       literal(:flipsign, literal(:π), literal(:ℯ)))
