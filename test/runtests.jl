using Literals
using Test

@test literal(1) isa IntLiteral
@test literal(1//2) isa RationalLiteral



@test isequal(literal(1) + literal(2), literal(1 + 2))
@test isequal(literal(1) + literal(2//3), literal(1 + 2//3))
@test isequal(literal(1//2) + literal(2), literal(1//2 + 2))
@test isequal(literal(1//2) + literal(2//3), literal(1//2 + 2//3))

@test isequal(literal(1) + 2, 1 + 2)
@test isequal(1 + literal(2), 1 + 2)
@test isequal(literal(1) + 2.0, 1 + 2.0)
@test isequal(1.0 + literal(2), 1.0 + 2)

@test isequal(literal(1//2) + 2, float(1//2) + 2)
@test isequal(1 + literal(2//3), 1 + float(2//3))
@test isequal(literal(1//2) + 2.0, float(1//2) + 2.0)
@test isequal(1.0 + literal(2//3), 1.0 + float(2//3))



@test isequal(- literal(1), literal(-1))
@test isequal(- literal(1//2), literal(-1//2))



@test isequal(literal(1) - literal(2), literal(1 - 2))
@test isequal(literal(1) - literal(2//3), literal(1 - 2//3))
@test isequal(literal(1//2) - literal(2), literal(1//2 - 2))
@test isequal(literal(1//2) - literal(2//3), literal(1//2 - 2//3))

@test isequal(literal(1) - 2, 1 - 2)
@test isequal(1 - literal(2), 1 - 2)
@test isequal(literal(1) - 2.0, 1 - 2.0)
@test isequal(1.0 - literal(2), 1.0 - 2)

@test isequal(literal(1//2) - 2, float(1//2) - 2)
@test isequal(1 - literal(2//3), 1 - float(2//3))
@test isequal(literal(1//2) - 2.0, float(1//2) - 2.0)
@test isequal(1.0 - literal(2//3), 1.0 - float(2//3))



@test isequal(literal(1) * literal(2), literal(1 * 2))
@test isequal(literal(1) * literal(2//3), literal(1 * 2//3))
@test isequal(literal(1//2) * literal(2), literal(1//2 * 2))
@test isequal(literal(1//2) * literal(2//3), literal(1//2 * 2//3))

@test isequal(literal(1) * 2, 1 * 2)
@test isequal(1 * literal(2), 1 * 2)
@test isequal(literal(1) * 2.0, 1 * 2.0)
@test isequal(1.0 * literal(2), 1.0 * 2)

@test isequal(literal(1//2) * 2, float(1//2) * 2)
@test isequal(1 * literal(2//3), 1 * float(2//3))
@test isequal(literal(1//2) * 2.0, float(1//2) * 2.0)
@test isequal(1.0 * literal(2//3), 1.0 * float(2//3))



@test isequal(inv(literal(1)), literal(inv(1//1)))
@test isequal(inv(literal(1//2)), literal(inv(1//2)))



@test isequal(literal(1) / literal(2), literal(1//2))
@test isequal(literal(1) / literal(2//3), literal(1 / 2//3))
@test isequal(literal(1//2) / literal(2), literal(1//2 / 2))
@test isequal(literal(1//2) / literal(2//3), literal(1//2 / 2//3))

@test isequal(literal(1) / 2, float(1) / float(2))
@test isequal(1 / literal(2), float(1) / float(2))
@test isequal(literal(1) / 2.0, float(1) / 2.0)
@test isequal(1.0 / literal(2), 1.0 / float(2))

@test isequal(literal(1//2) / 2, float(1//2) / 2)
@test isequal(1 / literal(2//3), 1 / float(2//3))
@test isequal(literal(1//2) / 2.0, float(1//2) / 2.0)
@test isequal(1.0 / literal(2//3), 1.0 / float(2//3))
