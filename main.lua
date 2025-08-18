local loveframes = nil
local maxFps = nil

local iz = nil

local frameW = nil
local frameH = nil
local frameHeaderH = nil
local padding = nil

local font = nil
local cfg = nil
local langCode = nil

local langFrame = nil
local mainFrame = nil

function calcBmi(height, weight)
  local bmi = weight / (height / 100) ^ 2

  return bmi
end

function getCategory(bmi)
  local category = ""

  if bmi <= 16.0 then
    category = "categoryVal1"
  elseif bmi <= 17.0 then
    category = "categoryVal2"
  elseif bmi <= 18.5 then
    category = "categoryVal3"
  elseif bmi <= 25.0 then
    category = "categoryVal4"
  elseif bmi <= 30.0 then
    category = "categoryVal5"
  elseif bmi <= 35.0 then
    category = "categoryVal6"
  elseif bmi <= 40.0 then
    category = "categoryVal7"
  elseif bmi > 40.0 then
    category = "categoryVal8"
  end

  return category
end

function createMainFrame()
  local frame = {}
  frame.obj = loveframes.Create("frame")
  frame.obj:SetName("bmiCalculator")
  frame.obj:SetSize(frameW, frameH)
  frame.obj:SetDraggable(false)
  frame.obj:ShowCloseButton(false)

  frame.heightText = loveframes.Create("text", frame.obj)
  frame.heightText:SetFont(font)
  frame.heightText:SetText(iz.translateStr("height"))

  frame.heightNumberBox = loveframes.Create("numberbox", frame.obj)
  frame.heightNumberBox:SetFont(font)
  frame.heightNumberBox:AutoSize()
  frame.heightNumberBox:SetMin(1)
  frame.heightNumberBox:SetMax(272)
  frame.heightNumberBox:SetValue(1)

  frame.cmText = loveframes.Create("text", frame.obj)
  frame.cmText:SetFont(font)
  frame.cmText:SetText(iz.translateStr("cm"))

  frame.weightText = loveframes.Create("text", frame.obj)
  frame.weightText:SetFont(font)
  frame.weightText:SetText(iz.translateStr("weight"))

  frame.weightNumberBox = loveframes.Create("numberbox", frame.obj)
  frame.weightNumberBox:SetFont(font)
  frame.weightNumberBox:AutoSize()
  frame.weightNumberBox:SetMin(1)
  frame.weightNumberBox:SetMax(727)
  frame.weightNumberBox:SetValue(1)

  frame.kgText = loveframes.Create("text", frame.obj)
  frame.kgText:SetFont(font)
  frame.kgText:SetText(iz.translateStr("kg"))

  frame.calcButton = loveframes.Create("button", frame.obj)
  frame.calcButton:SetFont(font)
  frame.calcButton:SetText(iz.translateStr("calculate"))
  frame.calcButton:AutoSize()

  frame.bmiText = loveframes.Create("text", frame.obj)
  frame.bmiText:SetFont(font)
  frame.bmiText:SetText(iz.translateStr("bmi"))

  frame.bmiTextInput = loveframes.Create("textinput", frame.obj)
  frame.bmiTextInput:SetFont(font)
  frame.bmiTextInput:AutoSize()
  frame.bmiTextInput:SetEditable(false)

  frame.kgm2Text = loveframes.Create("text", frame.obj)
  frame.kgm2Text:SetFont(font)
  frame.kgm2Text:SetText(iz.translateStr("kgm2"))

  frame.categoryText = loveframes.Create("text", frame.obj)
  frame.categoryText:SetFont(font)
  frame.categoryText:SetText(iz.translateStr("category"))

  frame.categoryTextInput = loveframes.Create("textinput", frame.obj)
  frame.categoryTextInput:SetFont(font)
  frame.categoryTextInput:AutoSize()
  frame.categoryTextInput:SetWidth(215)
  frame.categoryTextInput:SetEditable(false)

  frame.heightText:SetPos(
    padding,
    frameHeaderH
      + ((frame.heightNumberBox:GetHeight() - frame.heightText:GetHeight()) / 2)
      + padding
  )
  frame.heightNumberBox:SetPos(
    frame.heightText:GetWidth() + padding * 2,
    frameHeaderH + padding
  )
  frame.cmText:SetPos(
    frame.heightText:GetWidth() + frame.heightNumberBox:GetWidth() + padding * 3,
    frameHeaderH
      + ((frame.heightNumberBox:GetHeight() - frame.cmText:GetHeight()) / 2)
      + padding
  )
  frame.weightText:SetPos(
    padding,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + ((frame.weightNumberBox:GetHeight() - frame.weightText:GetHeight()) / 2)
      + padding * 2
  )
  frame.weightNumberBox:SetPos(
    frame.weightText:GetWidth() + padding * 2,
    frameHeaderH + frame.heightNumberBox:GetHeight() + padding * 2
  )
  frame.kgText:SetPos(
    frame.weightText:GetWidth() + frame.weightNumberBox:GetWidth() + padding * 3,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + ((frame.weightNumberBox:GetHeight() - frame.kgText:GetHeight()) / 2)
      + padding * 2
  )
  frame.calcButton:SetPos(
    padding,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + frame.weightNumberBox:GetHeight()
      + padding * 3
  )
  frame.bmiText:SetPos(
    padding,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + frame.weightNumberBox:GetHeight()
      + frame.calcButton:GetHeight()
      + ((frame.bmiTextInput:GetHeight() - frame.bmiText:GetHeight()) / 2)
      + padding * 4
  )
  frame.bmiTextInput:SetPos(
    frame.bmiText:GetWidth() + padding * 2,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + frame.weightNumberBox:GetHeight()
      + frame.calcButton:GetHeight()
      + padding * 4
  )
  frame.kgm2Text:SetPos(
    frame.bmiText:GetWidth() + frame.bmiTextInput:GetWidth() + padding * 3,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + frame.weightNumberBox:GetHeight()
      + frame.calcButton:GetHeight()
      + ((frame.bmiTextInput:GetHeight() - frame.kgm2Text:GetHeight()) / 2)
      + padding * 4
  )
  frame.categoryText:SetPos(
    padding,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + frame.weightNumberBox:GetHeight()
      + frame.calcButton:GetHeight()
      + frame.bmiTextInput:GetHeight()
      + ((frame.categoryTextInput:GetHeight() - frame.categoryText:GetHeight()) / 2)
      + padding * 5
  )
  frame.categoryTextInput:SetPos(
    frame.categoryText:GetWidth() + padding * 2,
    frameHeaderH
      + frame.heightNumberBox:GetHeight()
      + frame.weightNumberBox:GetHeight()
      + frame.calcButton:GetHeight()
      + frame.bmiTextInput:GetHeight()
      + padding * 5
  )

  frame.calcButton.OnClick = function(obj, x, y)
    local height = frame.heightNumberBox:GetValue()
    local weight = frame.weightNumberBox:GetValue()
    local bmi = calcBmi(height, weight)
    local category = getCategory(bmi)

    frame.bmiTextInput:SetText(bmi)
    frame.categoryTextInput:SetText(iz.translateStr(category))
  end

  return frame
end

function createLangFrame()
  local frame = {}
  frame.obj = loveframes.Create("frame")
  frame.obj:SetName("Language")
  frame.obj:SetSize(frameW, frameH)
  frame.obj:SetDraggable(false)
  frame.obj:ShowCloseButton(false)

  frame.selectText = loveframes.Create("text", frame.obj)
  frame.selectText:SetFont(font)
  frame.selectText:SetText("Select language")

  frame.multiChoice = loveframes.Create("multichoice", frame.obj)

  for _, lang in ipairs(cfg["langs"]) do
    frame.multiChoice:AddChoice(lang["name"])
  end

  frame.multiChoice:SetChoice("English")

  frame.okButton = loveframes.Create("button", frame.obj)
  frame.okButton:SetFont(font)
  frame.okButton:SetText("Ok")
  frame.okButton:AutoSize()

  frame.selectText:SetPos(padding, frameHeaderH + padding)
  frame.multiChoice:SetPos(
    padding,
    frameHeaderH + frame.selectText:GetHeight() + padding * 2
  )
  frame.okButton:SetPos(
    padding,
    frameHeaderH
      + frame.selectText:GetHeight()
      + frame.multiChoice:GetHeight()
      + padding * 3
  )

  frame.okButton.OnClick = function(obj, x, y)
    local selectedLangIdx = frame.multiChoice:GetChoiceIndex()
    langCode = cfg["langs"][selectedLangIdx]["code"]
    iz.langTable = iz.readLangTable(langCode)

    mainFrame = createMainFrame()

    langFrame.obj:SetVisible(false)
    mainFrame.obj:SetVisible(true)
  end

  return frame
end

function love.load()
  loveframes = require("izFrames")
  iz = require("iz")

  maxFps = 30

  loveframes.SetActiveSkin("green")

  frameW = 320
  frameH = 200
  frameHeaderH = 25
  padding = 5
  font = love.graphics.newFont("resources/dejaVuSansRegular.ttf", 16)
  cfg = iz.readCfg()

  langFrame = createLangFrame()
end

function love.update(dt)
  if dt < 1 / maxFps then
    love.timer.sleep(1 / maxFps - dt)
  end

  loveframes.update(dt)
end

function love.draw()
  loveframes.draw()
end

function love.mousepressed(x, y, button)
  loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  loveframes.mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
  loveframes.wheelmoved(x, y)
end

function love.keypressed(key, isrepeat)
  loveframes.keypressed(key, isrepeat)
end

function love.keyreleased(key)
  loveframes.keyreleased(key)
end

function love.TextInput(text)
  loveframes.TextInput(text)
end
