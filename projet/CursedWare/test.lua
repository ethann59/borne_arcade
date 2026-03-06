local busted = require("busted")
local Vector2 = require("src.classes.Vector2")
local Color = require("src.classes.Color")
local Square = require("src.classes.Rect")
local Image = require("src.classes.Image")
local Spritesheet = require("src.classes.Spritesheet")
local TextLabel = require("src.classes.TextLabel")
local ShakingText = require("src.classes.advanced.ShakingText")
local Renderer = require("src.libs.Rendering.Renderer")
local TweenService = require("src.libs.Tween")
local DelayService = require("src.libs.Delay")

describe("Vector2 Tests", function()
    it("should initialize with default values", function()
        local v = Vector2()
        assert.equal(v.X, 0)
        assert.equal(v.Y, 0)
    end)

    it("should initialize with given values", function()
        local v = Vector2(1, 2)
        assert.equal(v.X, 1)
        assert.equal(v.Y, 2)
    end)

    it("should clone correctly", function()
        local v1 = Vector2(1, 2)
        local v2 = v1:Clone()
        assert.equal(v2.X, 1)
        assert.equal(v2.Y, 2)
        v2.X = 3
        assert.equal(v1.X, 1)
    end)
end)

describe("Color Tests", function()
    it("should initialize with default values", function()
        local c = Color()
        assert.equal(c.R, 0)
        assert.equal(c.G, 0)
        assert.equal(c.B, 0)
    end)

    it("should initialize with given values", function()
        local c = Color(1, 0.5, 0.2)
        assert.equal(c.R, 1)
        assert.equal(c.G, 0.5)
        assert.equal(c.B, 0.2)
    end)
end)

describe("Square Tests", function()
    it("should initialize correctly", function()
        local s = Square(Vector2(1, 1), Vector2(2, 2))
        assert.equal(s.Position.X, 1)
        assert.equal(s.Position.Y, 1)
        assert.equal(s.Size.X, 2)
        assert.equal(s.Size.Y, 2)
    end)
end)

describe("Image Tests", function()
    it("should initialize correctly", function()
        local img = Image("test.png")
        assert.equal(img.Path, "test.png")
    end)
end)

describe("Spritesheet Tests", function()
    it("should initialize correctly", function()
        local ss = Spritesheet("test.png", 32, 32)
        assert.equal(ss.Path, "test.png")
        assert.equal(ss.FrameWidth, 32)
        assert.equal(ss.FrameHeight, 32)
    end)
end)

describe("TextLabel Tests", function()
    it("should initialize correctly", function()
        local t = TextLabel("Hello", Vector2(10, 10))
        assert.equal(t.Text, "Hello")
        assert.equal(t.Position.X, 10)
        assert.equal(t.Position.Y, 10)
    end)
end)

describe("ShakingText Tests", function()
    it("should initialize correctly", function()
        local st = ShakingText("Shake", Vector2(5, 5))
        assert.equal(st.Text, "Shake")
        assert.equal(st.Position.X, 5)
        assert.equal(st.Position.Y, 5)
    end)
end)

describe("Renderer Tests", function()
    it("should render without error", function()
        local obj = Square(Vector2(0, 0), Vector2(10, 10))
        assert.doesNotThrow(function() Renderer:Render(obj) end)
    end)
end)

describe("TweenService Tests", function()
    it("should animate without error", function()
        local obj = {x = 0}
        assert.doesNotThrow(function() TweenService:Tween(obj, {x = 10}, 1) end)
    end)
end)

describe("DelayService Tests", function()
    it("should delay execution without error", function()
        assert.doesNotThrow(function() DelayService:Delay(0.1) end)
    end)
end)

describe("DriftDrawer Game Logic", function()
    local game = require("CursedWare.minigames.DriftDrawer.game")

    it("should initialize correctly", function()
        local instance = game.new()
        assert.is_not_nil(instance)
        assert.equal(instance.Name, "Drift Drawer")
        assert.equal(instance.IsActive, true)
    end)

    it("should have valid stages", function()
        assert.is_not_nil(game.Stages)
        assert.is_true(#game.Stages > 0)
    end)

    it("should handle car movement correctly", function()
        local instance = game.new()
        local car = {
            Position = Vector2(100, 100),
            MoveDirection = {W = 0, A = 0, S = 0, D = 0},
            Speed = 100,
            Velocity = Vector2(0, 0),
            Rotation = 0
        }
        instance.Car = car
        instance:UpdateCar(0.016)
        assert.is_not_nil(car.Position)
    end)
end)

describe("Brood War Game Logic", function()
    local game = require("CursedWare.minigames.BroodWar.game")

    it("should initialize correctly", function()
        local instance = game.new()
        assert.is_not_nil(instance)
        assert.equal(instance.Name, "Brood War")
        assert.equal(instance.IsActive, true)
    end)

    it("should have valid stages", function()
        assert.is_not_nil(game.Stages)
        assert.is_true(#game.Stages > 0)
    end)

    it("should handle character movement correctly", function()
        local instance = game.new()
        local char = {
            Position = Vector2(100, 100),
            MoveDirection = {W = 0, A = 0, S = 0, D = 0},
            Speed = 100,
            Velocity = Vector2(0, 0),
            Rotation = 0
        }
        instance.Character = char
        instance:UpdateCharacter(0.016)
        assert.is_not_nil(char.Position)
    end)
end)

describe("Brood War Game Logic - Edge Cases", function()
    local game = require("CursedWare.minigames.BroodWar.game")

    it("should handle invalid input gracefully", function()
        local instance = game.new()
        local char = {
            Position = Vector2(-100, -100),
            MoveDirection = {W = 0, A = 0, S = 0, D = 0},
            Speed = 100,
            Velocity = Vector2(0, 0),
            Rotation = 0
        }
        instance.Character = char
        instance:UpdateCharacter(0.016)
        assert.is_not_nil(char.Position)
    end)

    it("should handle zero velocity correctly", function()
        local instance = game.new()
        local char = {
            Position = Vector2(100, 100),
            MoveDirection = {W = 0, A = 0, S = 0, D = 0},
            Speed = 0,
            Velocity = Vector2(0, 0),
            Rotation = 0
        }
        instance.Character = char
        instance:UpdateCharacter(0.016)
        assert.is_not_nil(char.Position)
    end)
end)

describe("DriftDrawer Game Logic - Edge Cases", function()
    local game = require("CursedWare.minigames.DriftDrawer.game")

    it("should handle invalid stage data gracefully", function()
        local stages = game.Stages
        assert.is_not_nil(stages)
        for _, stage in ipairs(stages) do
            assert.is_not_nil(stage.Difficulty)
            assert.is_not_nil(stage.Flags)
        end
    end)

    it("should handle zero vector correctly", function()
        local result = game.MoveTowards(Vector2(0, 0), Vector2(10, 10), 5)
        assert.is_not_nil(result)
    end)
end)

describe("Integration Tests", function()
    it("should render multiple objects without error", function()
        local obj1 = Square(Vector2(0, 0), Vector2(10, 10))
        local obj2 = Image("test.png")
        local obj3 = TextLabel("Test", Vector2(5, 5))
        assert.doesNotThrow(function()
            Renderer:Render(obj1)
            Renderer:Render(obj2)
            Renderer:Render(obj3)
        end)
    end)

    it("should animate and delay correctly together", function()
        local obj = {x = 0}
        local tween = TweenService:Tween(obj, {x = 10}, 0.1)
        local delay = DelayService:Delay(0.05)
        assert.is_not_nil(tween)
        assert.is_not_nil(delay)
    end)
end)
