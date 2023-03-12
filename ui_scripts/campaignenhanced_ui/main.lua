function frontend()
    require("colors")
    print("INIT FRONT END")

    LUI.LevelSelect.IsAllLevelCompleted = function()
        return false
    end
    
    Engine.CanResumeGame = function()
        return false
    end
    
    local localize = Engine.Localize
    Engine.Localize = function(...)
        local args = {...}
        if (args[1] == "@MENU_SP_FOR_THE_RECORD") then
            return ""
        end
    
        if (args[1] == "@MENU_SP_CAMPAIGN") then
            return localize("@MENU_CE_TITLE")
        end
    
        return localize(unpack(args))
    end

    LUI.addmenubutton("main_campaign", {
        index = 5,
        text = "@MENU_CE_STATS_TITLE",
        description = Engine.Localize("@MENU_CE_STATS_DESC"),
        callback = function()
            --LUI.FlowManager.RequestAddMenu(nil, firstmenu)
            LUI.FlowManager.RequestAddMenu(nil, "stats_menu")
        end
    })

    LUI.MenuBuilder.registerType("stats_menu", function(a1)
        local menu = LUI.MenuTemplate.new(a1, {
            menu_title = Engine.Localize("@XBOXLIVE_VIEW_PROFILE"),
            exclusiveController = 0,
            menu_width = 400,
            menu_top_indent = LUI.MenuTemplate.spMenuOffset,
            showTopRightSmallBar = true
        })

        local stats = cestats.getstats()

        f6_local12 = LUI.MenuBuilder.BuildRegisteredType( "h1_box_deco", {
            decoTopOffset = 75,
            decoBottomOffset = -50,
            decoRightOffset = 0,
            decoLeftOffset = 420,
            rightAnchor = true
        } )

        -- Linea in alto a sinistra
        local f6_local13 = CoD.CreateState( 100, 100, 650, 100, CoD.AnchorTypes.TopLeft )
        f6_local13.color = aar_score_gold
        f6_local12:addElement( LUI.UILine.new( f6_local13 ) )

        local f7_local13 = CoD.CreateState(150, 24, 50, 50,  CoD.AnchorTypes.TopLeftRight )
        f7_local13.font = CoD.TextSettings.SP_HudAmmoStatusText.Font
        f7_local13.alignment = LUI.AdjustAlignmentForLanguage( LUI.Alignment.Left )
        f7_local13.color = text_rarity3
        f7_local13.lineSpacingRatio = 0
        f7_local13.top = 100
        
        local f7_local14 = LUI.UIText.new( f7_local13 )
        --f7_local14:setText( game:getdvar("name") )
        f7_local14 = LUI.UIText.new( {
            font = CoD.TextSettings.SP_HudAmmoStatusText.Font,
            textStyle = CoD.TextStyle.ShadowedMore,
            alignment = LUI.AdjustAlignmentForLanguage( LUI.Alignment.Left ),
            top = -220,
            left = -150,
            width = 0,
            height = 30,
            color = text_rarity3,
            alpha = 1
        } )
        f7_local14:setText( "" )
        f7_local14:setTextStyle( CoD.TextStyle.ShadowedMore )

        f6_local12:addElement( f7_local14 )

        menu:addElement( f6_local12 )
        menu:AddBackButton(function(a1)
            Engine.PlaySound(CoD.SFX.MenuBack)
            LUI.FlowManager.RequestLeaveMenu(a1)
        end)

        return menu
    end)
end

function ingame()
end

if (Engine.InFrontend()) then
    frontend()
else
    ingame()
end