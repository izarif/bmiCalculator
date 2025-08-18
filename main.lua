local loveframes
local maxFps

function calcBMI(height, weight)
  local bmi = weight / (height / 100) ^ 2

  return bmi
end

function getCategory(bmi)
  local category = ""

  if bmi <= 16.0 then
    category = "Underweight (Severe thinness)"
  elseif bmi <= 17.0 then
    category = "Underweight (Moderate thinness)"
  elseif bmi <= 18.5 then
    category = "Underweight (Mild thinness)"
  elseif bmi <= 25.0 then
    category = "Normal range"
  elseif bmi <= 30.0 then
    category = "Overweight (Pre-obese)"
  elseif bmi <= 35.0 then
    category = "Obese (Class I)"
  elseif bmi <= 40.0 then
    category = "Obese (Class II)"
  elseif bmi > 40.0 then
    category = "Obese (Class III)"
  end

  return category
end

function love.load()
  loveframes = require("loveframes")

  maxFps = 30

  loveframes.SetActiveSkin("Green")

  local frame = loveframes.Create("frame")
  frame:SetName("BMI Calculator")
  frame:SetSize(291, 170)
  frame:SetDraggable(false)
  frame:ShowCloseButton(false)

  local frameHeaderH = 25
  local padding = 5

  local heightText = loveframes.Create("text", frame)
  heightText:SetText("Height")

  local heightNumberBox = loveframes.Create("numberbox", frame)
  heightNumberBox:SetMinMax(1, 272)
  heightNumberBox:SetValue(1)

  local cmText = loveframes.Create("text", frame)
  cmText:SetText("cm")

  local weightText = loveframes.Create("text", frame)
  weightText:SetText("Weight")

  local weightNumberBox = loveframes.Create("numberbox", frame)
  weightNumberBox:SetMinMax(1, 727)
  weightNumberBox:SetValue(1)

  local kgText = loveframes.Create("text", frame)
  kgText:SetText("kg")

  local calcButton = loveframes.Create("button", frame)
  calcButton:SetText("Calculate")

  local bmiText = loveframes.Create("text", frame)
  bmiText:SetText("BMI")

  local bmiTextInput = loveframes.Create("textinput", frame)
  bmiTextInput:SetEditable(false)

  local kgm2Text = loveframes.Create("text", frame)
  kgm2Text:SetText("kg/m^2")

  local categoryText = loveframes.Create("text", frame)
  categoryText:SetText("Category")

  local categoryTextInput = loveframes.Create("textinput", frame)
  categoryTextInput:SetWidth(215)
  categoryTextInput:SetEditable(false)

  heightText:SetPos(
    padding,
    frameHeaderH
      + ((heightNumberBox:GetHeight() - heightText:GetHeight()) / 2)
      + padding
  )
  heightNumberBox:SetPos(
    heightText:GetWidth() + padding * 2,
    frameHeaderH + padding
  )
  cmText:SetPos(
    heightText:GetWidth() + heightNumberBox:GetWidth() + padding * 3,
    frameHeaderH
      + ((heightNumberBox:GetHeight() - cmText:GetHeight()) / 2)
      + padding
  )
  weightText:SetPos(
    padding,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + ((weightNumberBox:GetHeight() - weightText:GetHeight()) / 2)
      + padding * 2
  )
  weightNumberBox:SetPos(
    weightText:GetWidth() + padding * 2,
    frameHeaderH + heightNumberBox:GetHeight() + padding * 2
  )
  kgText:SetPos(
    weightText:GetWidth() + weightNumberBox:GetWidth() + padding * 3,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + ((weightNumberBox:GetHeight() - kgText:GetHeight()) / 2)
      + padding * 2
  )
  calcButton:SetPos(
    padding,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + weightNumberBox:GetHeight()
      + padding * 3
  )
  bmiText:SetPos(
    padding,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + weightNumberBox:GetHeight()
      + calcButton:GetHeight()
      + ((bmiTextInput:GetHeight() - bmiText:GetHeight()) / 2)
      + padding * 4
  )
  bmiTextInput:SetPos(
    bmiText:GetWidth() + padding * 2,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + weightNumberBox:GetHeight()
      + calcButton:GetHeight()
      + padding * 4
  )
  kgm2Text:SetPos(
    bmiText:GetWidth() + bmiTextInput:GetWidth() + padding * 3,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + weightNumberBox:GetHeight()
      + calcButton:GetHeight()
      + ((bmiTextInput:GetHeight() - kgm2Text:GetHeight()) / 2)
      + padding * 4
  )
  categoryText:SetPos(
    padding,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + weightNumberBox:GetHeight()
      + calcButton:GetHeight()
      + bmiTextInput:GetHeight()
      + ((categoryTextInput:GetHeight() - categoryText:GetHeight()) / 2)
      + padding * 5
  )
  categoryTextInput:SetPos(
    categoryText:GetWidth() + padding * 2,
    frameHeaderH
      + heightNumberBox:GetHeight()
      + weightNumberBox:GetHeight()
      + calcButton:GetHeight()
      + bmiTextInput:GetHeight()
      + padding * 5
  )

  calcButton.OnClick = function(obj, x, y)
    local height = heightNumberBox:GetValue()
    local weight = weightNumberBox:GetValue()
    local bmi = calcBMI(height, weight)
    local category = getCategory(bmi)

    bmiTextInput:SetText(bmi)
    categoryTextInput:SetText(category)
  end
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
