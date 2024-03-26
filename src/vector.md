---
title: Simple 2D/3D Vector Implemenation for Lua
date: 23/03/2024
author: Abhishek Mishra
license: MIT, see LICENSE file for details.
---

# Introduction

Lua has a minimal standard library and does not have a Vector type.

This is a literate program that describes a 2D/3D Vector implemenation in the
Lua Programming language. Note that we are not talking about an arraylist/vector
datastructure which can have a large number of elements. These are vectors with
three components x, y and z. Such vectors are a staple of graphics programming.
See for example Vec2/Vec3/Vec4 in GLSL. I write a lot of graphics programs in
Lua, especially in Love2D and need vectors in most of them.

The three component vector with z = 0 can be used as a two-dimensional vector
and meets most of my programming needs.

The design of this program borrows heavily from the [Sample Vector implemtation
in Love2d Docs][1], as well as the [Vector API in p5.js][2]. As a reault, the
implementation is straighforward and provides the most common operations on
Vector. The implementation prioritises simplicity.

The Vector implementation provides just one public export, the `Vector` class.
This class is written using the [middleclass][3] library.

[1]: https://love2d.org/wiki/Vectors
[2]: https://p5js.org/reference/#/p5.Vector
[3]: https://github.com/kikito/middleclass

The next section describes the implementation, then we provide a few sample
usages of the `Vector` API. The final sections list any future plans, current
limitations, known issues etc.

# Program

The program implements just one class named `Vector` in the file `vector.lua`.
The implemenation tries to provide a public API similar to the [p5js Vector
implementation][2]. Since Lua has operator overloading via certain special
methods, we use this mechanism to provide arithmetic operations for vectors.

## Header

The header is self-explanatory and provides some minimal info about the file in
standard documentation format. All the class and method documentation in the
program also uses the same format.

```lua { code_file="vector.lua" }
--- vector.lua - A simple vector class. Similar to the Vector implementation in
-- the p5.js library.
--
-- see: https://p5js.org/reference/#/p5.Vector
-- see: https://love2d.org/wiki/Vectors
--
-- date: 23/03/2024
-- author: Abhishek Mishra
-- license: MIT, see LICENSE for more details.
```

## Class Definition

The `Vector` class is implemented using the excellent [`kikito/middleclass`
library][3]. The constructor accepts three values `x`, `y`, and `z`, the three
components of the new vector. If any of these values are not provided the
default is `0`.

Using this mechanism one can use the class as a 2D vector by initializing only
the `x` and `y` components and forgetting that the `z` component even exists.

Theoretically, one can also use the class for a scalar by making `y` and `z` 0.
However this would not be very useful.

The `set` method can be used to set 1, 2 or all 3 of the values of the values
together.

The `x`, `y` and `z` values can also be changed individually by directly setting
the values by assignment.

```lua { code_file="vector.lua" }
local class = require('middleclass')

--- Vector class
local Vector = class('Vector')

--- constructor
--@param x the x component of the vector
--@param y the y component of the vector
--@param z the z component of the vector
function Vector:initialize(x, y, z)
    self:set(x or 0, y or 0, z or 0)
end

--- set the x, y, z components of the vector
--@param x the x component of the vector
--@param y the y component of the vector
--@param z the z component of the vector
function Vector:set(x, y, z)
    self.x = x
    self.y = y
    self.z = z
end
```

**Example**

```lua
-- a 2d vector
v2d = Vector(1, 2)

-- set both x and y
v2d:set(5, 6)

-- a 3d vector
v3d = Vector(2, 3, 4)

-- set x, y, and z together
v3d:set(5, 6, 7)

-- set a single component
v3d.x = 8
```


## Print the Vector

We override the `__tostring` metamethod to provide a readable respresentation
for the Vector when printing to a console or for other debugging use-cases.

```lua { code_file="vector.lua" }

--- tostring operator overloading
function Vector:__tostring()
    return 'Vector(' .. self.x .. ', ' .. self.y .. ', ' .. self.z .. ')'
end
```

**Example**

We can create a vector and print it to the console.

```lua
v = Vector(1, 2)

print(v)
-- Vector(1, 2)
```

## Clone/Copy the Vector

Cloning/copying a vector is a common alternate way of constructing a new vector
instance useful in many contexts. The `copy` method simply returns a new
instance with the same components.

```lua { code_file="vector.lua" }

--- copy the vector
function Vector:copy()
    return Vector(self.x, self.y, self.z)
end
```

**Example**

In the following example we create a vector `v`, and a copy `w`. Then we change
the value of `w.x` and `v` remains unchanged.

```lua
v = Vector(1, 2)
w = v:copy()
w.x = 4
print(v .. ', ' .. w)
-- Vector(1, 2, 0), Vector(4, 2, 0)
```

## Arithmetic Operations



```lua { code_file="vector.lua" }

--- add a vector to this vector using the lua operator overloading
--@param v the vector to add
function Vector:__add(v)
    return Vector(self.x + v.x, self.y + v.y, self.z + v.z)
end

--- subtract a vector from this vector using the lua operator overloading
--@param v the vector to subtract
function Vector:__sub(v)
    return Vector(self.x - v.x, self.y - v.y, self.z - v.z)
end

--- multiply this vector by a scalar using the lua operator overloading
--@param s the scalar to multiply
function Vector:__mul(s)
    return Vector(self.x * s, self.y * s, self.z * s)
end

--- divide this vector by a scalar using the lua operator overloading
--@param s the scalar to divide
function Vector:__div(s)
    return Vector(self.x / s, self.y / s, self.z / s)
end
```

## Magnitude and Heading

```lua { code_file="vector.lua" }

--- get the magnitude of the vector
function Vector:mag()
    return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
end

-- set the magnitude of the vector
--@param m the magnitude to set
function Vector:setMag(m)
    self:normalize()
    -- multiply by the magnitude
    self:set(self.x * m, self.y * m, self.z * m)
end

--- get the magnitude of the vector squared
function Vector:magSq()
    return self.x * self.x + self.y * self.y + self.z * self.z
end

--- get the heading of the vector
function Vector:heading()
    return math.atan(self.y, self.x)
end

--- limit the magnitude of the vector, returns a new vector without modifying
-- the original
--@param max the maximum magnitude
--@return the limited vector (a new vector)
function Vector:limit(max)
    local limited = self:copy()
    if limited:magSq() > max * max then
        limited:normalize()
        limited = limited * max
    end
    return limited
end
```

## Products (Dot & Cross)

```lua { code_file="vector.lua" }

--- dot product of this vector with another vector
--@param v the other vector
function Vector:dot(v)
    return self.x * v.x + self.y * v.y + self.z * v.z
end

--- cross product of this vector with another vector
--@param v the other vector
function Vector:cross(v)
    return Vector(
        self.y * v.z - self.z * v.y,
        self.z * v.x - self.x * v.z,
        self.x * v.y - self.y * v.x
    )
end
```

## Miscellaneous Vector Functions

```lua { code_file="vector.lua" }

--- distance between this vector and another vector
--@param v the other vector
function Vector:dist(v)
    return (self - v):mag()
end

--- normalize the vector
function Vector:normalize()
    local m = self:mag()
    if m > 0 then
        self:set(self.x / m, self.y / m, self.z / m)
    end
end
```

## Comparison Operations

```lua { code_file="vector.lua" }

--- equals operator overloading
--@param v the other vector
function Vector:__eq(v)
    return self.x == v.x and self.y == v.y and self.z == v.z
end

--- vector not equals operator overloading
--@param v the other vector
function Vector:__ne(v)
    return not (self == v)
end

--- vector unary minus operator overloading
function Vector:__unm()
    return Vector(-self.x, -self.y, -self.z)
end

--- vector unary plus operator overloading
function Vector:__uplus()
    return self:copy()
end

--- vector less than operator overloading
--@param v the other vector
function Vector:__lt(v)
    return self:magSq() < v:magSq()
end

--- vector less than or equal to operator overloading
--@param v the other vector
function Vector:__le(v)
    return self:magSq() <= v:magSq()
end

--- vector greater than operator overloading
--@param v the other vector
function Vector:__gt(v)
    return self:magSq() > v:magSq()
end

--- vector greater than or equal to operator overloading
--@param v the other vector
function Vector:__ge(v)
    return self:magSq() >= v:magSq()
end
```

## Create a Random Vector

```lua { code_file="vector.lua" }

--- create a random 2D vector
--@return a random 2D vector
function Vector.random2D()
    local angle = math.random() * math.pi * 2
    return Vector(math.cos(angle), math.sin(angle))
end

--- create a random 3D vector
--@return a random 3D vector
function Vector.random3D()
    local angle = math.random() * math.pi * 2
    local vz = math.random() * 2 - 1
    local vx = math.sqrt(1 - vz * vz) * math.cos(angle)
    local vy = math.sqrt(1 - vz * vz) * math.sin(angle)
    return Vector(vx, vy, vz)
end
```

## Module Return

```lua { code_file="vector.lua" }

return Vector
```

# Future Plans

* Provide a constructor that accepts values in a table.

```lua
local v = Vector { 1, 2, 0 }
```


# Limitations & Known Issues

