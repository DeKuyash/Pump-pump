


local function callMenu()

    -----------------------------------------------------
    ----------------------Менюшка------------------------
    -----------------------------------------------------

    local basicMenu = vgui.Create('DFrame')
    basicMenu:SetTitle('Телосложение')
    basicMenu:SetSize(900, 700)
    basicMenu:Center()			
    basicMenu:MakePopup()
    basicMenu:SetDraggable(false)
    basicMenu.Paint = function(self, w, h)
        draw.RoundedBox(2, 0, 0, w, h, Color(0, 161, 255, 240))
        draw.RoundedBox(2, 0, 0, w, h*0.035, Color(0, 90, 145, 240))
    end

    -----------------------------------------------------

    local characterBackground = vgui.Create('DPanel', basicMenu)
    characterBackground:SetSize(300, 600)
    characterBackground:Center()
    characterBackground:SetPos(300, 60)

    characterBackground.Paint = function(self, w, h)
        draw.RoundedBox(4, 0, 0, w, h, Color(0, 90, 145, 240))
    end

    -----------------------------------------------------

    local character = vgui.Create('DModelPanel', characterBackground)
    character:SetSize(450, 900)
    character:SetModel(LocalPlayer():GetModel())
    character:Center()
    character:SetCamPos(Vector(-12, 50, 50))

    character:SetDirectionalLight(BOX_TOP, Color(255, 255, 255))
    character:SetDirectionalLight(BOX_FRONT, Color(255, 255, 255))
    character:SetDirectionalLight(BOX_LEFT, Color(255, 255, 255))
    character:SetDirectionalLight(BOX_RIGHT, Color(255, 255, 255))

    local ent = character:GetEntity()

    character:GetEntity():SetAngles(Angle(0, 100, 0))

    function character:LayoutEntity(ent) return end

    local isDragging = false 
    local lastMouseX = 0

    character.OnMousePressed = function(self, mCode)
        if mCode == MOUSE_LEFT then

            isDragging = true 
            lastMouseX = gui.MouseX()
            self:MouseCapture(true)

        end
    end

    character.OnMouseReleased = function(self, mCode)
        if mCode == MOUSE_LEFT then

            isDragging = false 
            self:MouseCapture(false)

        end
    end

    character.Think = function(self)
        if isDragging then

            local mouseX = gui.MouseX()
            local deltaMouseX = mouseX - lastMouseX
            lastMouseX = mouseX

            local angle = self:GetEntity():GetAngles()
            angle.y = angle.y + deltaMouseX * 1
            self:GetEntity():SetAngles(angle)

        end
    end

    -----------------------------------------------------
    ---------------------Кнопки зума---------------------
    -----------------------------------------------------

    local fov = 60

    local zoomButton = vgui.Create('DButton', basicMenu)

    zoomButton:SetPos(570, 590)
    zoomButton:SetSize(20, 20)
    zoomButton:SetText('+')

    zoomButton.DoClick = function()
        fov = fov - 10
        
        if fov < 50 then fov = 50 end

        character:SetFOV(fov)

    end

    -----------------------------------------------------

    local UnzoomButton = vgui.Create('DButton', basicMenu)

    UnzoomButton:SetPos(570, 620)
    UnzoomButton:SetSize(20, 20)
    UnzoomButton:SetText('—')

    UnzoomButton.DoClick = function()
        fov = fov + 10
        
        if fov > 100 then fov = 100 end

        character:SetFOV(fov)

    end

    -----------------------------------------------------
    -----------------------Ползунки----------------------
    -----------------------------------------------------


    -- Талия

    local waistSlider = vgui.Create('DNumSlider', basicMenu)
    waistSlider:SetPos(20, 100)				
    waistSlider:SetSize(275, 10)			
    waistSlider:SetText('Талия')
    waistSlider:SetMin(-0.5)				 
    waistSlider:SetMax(0.5)	
    waistSlider:SetDecimals(2)	
    waistSlider:SetValue(0.00)
    waistSlider:SetDark(true)

    waistSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(1, Vector(0.8, 0.8, 0.8) * (value+1))

    end   


    -- Грудь

    local breastSlider = vgui.Create('DNumSlider', basicMenu)
    breastSlider:SetPos(20, 250)				
    breastSlider:SetSize(275, 20)			
    breastSlider:SetText('Грудь')
    breastSlider:SetMin(-0.5)				 
    breastSlider:SetMax(0.5)	
    breastSlider:SetDecimals(2)	
    breastSlider:SetValue(0.00)
    breastSlider:SetDark(true)

    breastSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(3, Vector(1, 0.8, 0.8) * (value+1))

        local y = (ent:GetManipulateBoneScale(3)).y
        ent:ManipulateBoneScale(3, Vector(1, y, 1))

    end     


    -- Шея

    local neckSlider = vgui.Create('DNumSlider', basicMenu)
    neckSlider:SetPos(20, 400)				
    neckSlider:SetSize(275, 10)			
    neckSlider:SetText('Шея')
    neckSlider:SetMin(-0.5)				 
    neckSlider:SetMax(0.5)	
    neckSlider:SetDecimals(2)	
    neckSlider:SetValue(0.00)
    neckSlider:SetDark(true)

    neckSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(5, Vector(1, 1, 1) * (value+1))

    end  


    -- Трицепс

    local tricepsSlider = vgui.Create('DNumSlider', basicMenu)
    tricepsSlider:SetPos(20, 550)				
    tricepsSlider:SetSize(275, 20)			
    tricepsSlider:SetText('Трицепс')
    tricepsSlider:SetMin(-0.5)				 
    tricepsSlider:SetMax(0.5)	
    tricepsSlider:SetDecimals(2)	
    tricepsSlider:SetValue(0.00)
    tricepsSlider:SetDark(true)

    tricepsSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(9, Vector(1, 1, 1) * (value+1))

        local right_y = (ent:GetManipulateBoneScale(9)).y
        local right_z = (ent:GetManipulateBoneScale(9)).z
        ent:ManipulateBoneScale(9, Vector(1, right_y, right_z))

        ---

        ent:ManipulateBoneScale(14, Vector(1, 1, 1) * (value+1))

        local left_y = (ent:GetManipulateBoneScale(14)).y
        local left_z = (ent:GetManipulateBoneScale(14)).z
        ent:ManipulateBoneScale(14, Vector(1, left_y, left_z))

    end  


    -- Плечи

    local shouldersSlider = vgui.Create('DNumSlider', basicMenu)
    shouldersSlider:SetPos(620, 100)				
    shouldersSlider:SetSize(275, 10)			
    shouldersSlider:SetText('Плечи')
    shouldersSlider:SetMin(-0.5)				 
    shouldersSlider:SetMax(0.5)	
    shouldersSlider:SetDecimals(2)	
    shouldersSlider:SetValue(0.00)
    shouldersSlider:SetDark(true)

    shouldersSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(8, Vector(1, 1, 1) * (value+1))
        ent:ManipulateBoneScale(13, Vector(1, 1, 1) * (value+1))

    end  


    -- Предплечья

    local forearmsSlider = vgui.Create('DNumSlider', basicMenu)
    forearmsSlider:SetPos(620, 250)				
    forearmsSlider:SetSize(275, 20)			
    forearmsSlider:SetText('Предплечья')
    forearmsSlider:SetMin(-0.5)				 
    forearmsSlider:SetMax(0.5)	
    forearmsSlider:SetDecimals(2)	
    forearmsSlider:SetValue(0.00)
    forearmsSlider:SetDark(true)

    forearmsSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(10, Vector(1, 1, 0.8) * (value+1))
        ent:ManipulateBoneScale(15, Vector(1, 1, 0.8) * (value+1))

    end  


    -- Бедра

    local hipsSlider = vgui.Create('DNumSlider', basicMenu)
    hipsSlider:SetPos(620, 400)				
    hipsSlider:SetSize(275, 20)			
    hipsSlider:SetText('Бедра')
    hipsSlider:SetMin(-0.5)				 
    hipsSlider:SetMax(0.5)	
    hipsSlider:SetDecimals(2)	
    hipsSlider:SetValue(0.00)
    hipsSlider:SetDark(true)

    hipsSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(18, Vector(1, 1, 1) * (value+1))
        ent:ManipulateBoneScale(22, Vector(1, 1, 1) * (value+1))

    end  

    -- Икры

    local caviarSlider = vgui.Create('DNumSlider', basicMenu)
    caviarSlider:SetPos(620, 550)				
    caviarSlider:SetSize(275, 20)			
    caviarSlider:SetText('Икры')
    caviarSlider:SetMin(-0.5)				 
    caviarSlider:SetMax(0.5)	
    caviarSlider:SetDecimals(2)	
    caviarSlider:SetValue(0.00)
    caviarSlider:SetDark(true)

    caviarSlider.OnValueChanged = function(panel, value)
        ent:ManipulateBoneScale(19, Vector(1, 1, 1) * (value+1))
        ent:ManipulateBoneScale(23, Vector(1, 1, 1) * (value+1))

    end


    -----------------------------------------------------
    -----------------------Кнопочки----------------------
    -----------------------------------------------------


    local acceptButton = vgui.Create('DButton', basicMenu)

    acceptButton:SetPos(820, 640)
    acceptButton:SetSize(60, 20)
    acceptButton:SetText('ACCEPT')


    acceptButton.DoClick = function()

        local boneScaleTable = {
            [1] = ent:GetManipulateBoneScale(1),
            [3] = ent:GetManipulateBoneScale(3),
            [5] = ent:GetManipulateBoneScale(5),
            [9] = ent:GetManipulateBoneScale(9),
            [14] = ent:GetManipulateBoneScale(14),
            [8] = ent:GetManipulateBoneScale(8),
            [13] = ent:GetManipulateBoneScale(13),
            [10] = ent:GetManipulateBoneScale(10),
            [15] = ent:GetManipulateBoneScale(15),
            [18] = ent:GetManipulateBoneScale(18),
            [22] = ent:GetManipulateBoneScale(22),
            [19] = ent:GetManipulateBoneScale(19),
            [23] = ent:GetManipulateBoneScale(23)
        }

        net.Start('acceptProcess')
            net.WriteInt(LocalPlayer():EntIndex(), 8)
            net.WriteTable(boneScaleTable)
        net.SendToServer()

    end


    local resetButton = vgui.Create('DButton', basicMenu)

    resetButton:SetPos(750, 640)
    resetButton:SetSize(60, 20)
    resetButton:SetText('RESET')

    resetButton.DoClick = function()

        waistSlider:SetValue(0)
        breastSlider:SetValue(0)
        neckSlider:SetValue(0)
        tricepsSlider:SetValue(0)
        shouldersSlider:SetValue(0)
        forearmsSlider:SetValue(0)
        hipsSlider:SetValue(0)
        caviarSlider:SetValue(0)

    end
end


hook.Add('KeyPress', 'callMenuKeyPress', function(ply, key)
    if key == IN_SCORE then
        callMenu()

    end
end)