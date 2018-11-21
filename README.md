# [Literals](https://github.com/eschnett/Literals.jl)

A Julia library to experiment with representing literal values (i.e.
integer and floating-point constants in the source code) in the same
way as irrational numbers such as `pi`.

The goal is that in expressions such as `0.1 * x`, the term `0.1` is
only evaluated once the type of `x` is known, so that the same type
can be used. In other words, the expression `big(pi)` produces a very
accurate value of `pi`, and we want to achieve the same for
`big(0.1)`.

[![Build Status (Travis)](https://travis-ci.org/eschnett/Literals.jl.svg?branch=master)](https://travis-ci.org/eschnett/Literals.jl)
[![Build status (Appveyor)](https://ci.appveyor.com/api/projects/status/aancab20uolykwwu/branch/master?svg=true)](https://ci.appveyor.com/project/eschnett/fixedpoint-jl/branch/master)
[![Coverage Status (Coveralls)](https://coveralls.io/repos/github/eschnett/Literals.jl/badge.svg?branch=master)](https://coveralls.io/github/eschnett/Literals.jl?branch=master)
