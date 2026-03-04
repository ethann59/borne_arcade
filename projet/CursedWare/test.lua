local busted = require("busted")

local function test_init()
    assert.not_nil(busted.run("local Vector2 = require('src/classes/Vector2')"))
    assert.not_nil(busted.run("local Color = require('src/classes/Color')"))
    assert.not_nil(busted.run("local Square = require('src/classes/Rect')"))
    assert.not_nil(busted.run("local Image = require('src/classes/Image')"))
    assert.not_nil(busted.run("local Quad = require('src/classes/Quad')"))
    assert.not_nil(busted.run("local Spritesheet = require('src/classes/Spritesheet')"))
    assert.not_nil(busted.run("local TextLabel = require('src/classes/TextLabel')"))
    assert.not_nil(busted.run("local ShakingText = require('src/classes/advanced/ShakingText')"))
    assert.not_nil(busted.run("local Renderer = require('src/libs/Rendering/Renderer')"))
    assert.not_nil(busted.run("local LogManager = require('src/libs/Debug/LogManager')"))
    assert.not_nil(busted.run("local TweenService = require('src/libs/Tween')"))
    assert.not_nil(busted.run("local DelayService = require('src/libs/Delay')"))
end

local function test_car_movement()
    local Car = require("src/car")
    local Character = Car:new()
    Character.Position = Vector2(0, 0)
    Character.Rotation = 0
    Character.Velocity = Vector2(0, 0)
    Character.Speed = 1

    Character:UpdateCar(0.01)
    assert.not_nil(Character.Position)
    assert.not_nil(Character.Velocity)
    assert.not_nil(Character.Rotation)
end

local function test_car_rotation()
    local Car = require("src/car")
    local Character = Car:new()
    Character.Position = Vector2(0, 0)
    Character.Rotation = 0
    Character.Velocity = Vector2(0, 0)
    Character.Speed = 1

    Character:UpdateCar(0.01)
    assert.not_nil(Character.Position)
    assert.not_nil(Character.Velocity)
    assert.not_nil(Character.Rotation)
end

local function test_car_bounds()
    local Car = require("src/car")
    local Character = Car:new()
    Character.Position = Vector2(0, 0)
    Character.Rotation = 0
    Character.Velocity = Vector2(0, 0)
    Character.Speed = 1
    Character.BoundPos = Vector2(0, 0)
    Character.BoundSize = Vector2(100, 100)

    Character:UpdateCar(0.01)
    assert.close_to(Character.Position.Y, 0, 0.1)
    assert.close_to(Character.Position.X, 0, 0.1)
end

local function test_car_flags()
    local Car = require("src/car")
    local Character = Car:new()
    Character.Position = Vector2(0, 0)
    Character.Rotation = 0
    Character.Velocity = Vector2(0, 0)
    Character.Speed = 1
    Character.BoundPos = Vector2(0, 0)
    Character.BoundSize = Vector2(100, 100)
    Character.Stages = Stages
    Character.MaxDifficulty = MaxDifficulty

    Character:UpdateCar(0.01)
    assert.close_to(Character.Position.Y, 0, 0.1)
    assert.close_to(Character.Position.X, 0, 0.1)
end

local function test_init_dependencies()
    test_init()
end

busted.run("test_init()")
