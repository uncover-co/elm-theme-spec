module ThemeSpec exposing
    ( Theme
    , ThemeColor
    , background
    , backgroundContrast
    , backgroundFaded
    , backgroundShadow
    , baseTheme
    , borderRadius
    , borderRadiusLarge
    , color
    , colorContrast
    , colorFaded
    , colorShadow
    , danger
    , dangerContrast
    , dangerFaded
    , dangerShadow
    , focus
    , focusContrast
    , focusFaded
    , focusShadow
    , fontCode
    , fontText
    , fontTitle
    , globalProvider
    , highlight
    , highlightContrast
    , highlightFaded
    , highlightShadow
    , provider
    , sample
    , success
    , successContrast
    , successFaded
    , successShadow
    , warning
    , warningContrast
    , warningFaded
    , warningShadow
    )

import Html as H
import Html.Attributes as HA



-- Scope


namespace : String
namespace =
    "tmspc"



-- Base


type alias ThemeColor =
    { base : String
    , faded : String
    , contrast : String
    , shadow : String
    }


type alias Theme =
    { -- font
      fontTitle : String
    , fontText : String
    , fontCode : String
    , -- border radius
      borderRadius : Int
    , borderRadiusLarge : Int
    , -- colors
      focus : ThemeColor
    , background : ThemeColor
    , color : ThemeColor
    , highlight : ThemeColor
    , success : ThemeColor
    , warning : ThemeColor
    , danger : ThemeColor
    }


baseTheme : Theme
baseTheme =
    { -- fonts
      fontTitle = "serif"
    , fontText = "system-ui, sans-serif"
    , fontCode = "monospaced"

    -- border radius
    , borderRadius = 4
    , borderRadiusLarge = 8
    , -- colors
      focus =
        { base = "#59e7d2"
        , faded = "#59e7d2"
        , contrast = "#59e7d2"
        , shadow = "#59e7d2"
        }
    , background =
        { base = "#fff"
        , faded = "#eee"
        , contrast = "#333"
        , shadow = "#eaeaea"
        }
    , color =
        { base = "#333"
        , faded = "#aaa"
        , contrast = "#fff"
        , shadow = "#ccc"
        }
    , highlight =
        { base = "#09f"
        , faded = "#9cf"
        , contrast = "#fff"
        , shadow = "#9cf"
        }
    , success =
        { base = "#56bd1a"
        , faded = "#8ed466"
        , contrast = "#fff"
        , shadow = "#8ed466"
        }
    , warning =
        { base = "#fa0"
        , faded = "#faf3e0"
        , contrast = "#fff"
        , shadow = "#d2b672"
        }
    , danger =
        { base = "#ff4d4f"
        , faded = "#f4bd4f"
        , contrast = "#fff"
        , shadow = "#f4bd4f"
        }
    }


toString : Theme -> String
toString theme =
    let
        colorVars : ( String, Theme -> ThemeColor ) -> List ( String, String )
        colorVars ( label, getter ) =
            let
                themeColor =
                    getter theme
            in
            [ ( label ++ "-base", .base themeColor )
            , ( label ++ "-faded", .faded themeColor )
            , ( label ++ "-contrast", .contrast themeColor )
            , ( label ++ "-shadow", .shadow themeColor )
            ]
    in
    [ [ -- Fonts
        ( "font-title", theme.fontTitle )
      , ( "font-text", theme.fontText )
      , ( "font-code", theme.fontCode )

      -- Border Radius
      , ( "border-radius", String.fromInt theme.borderRadius ++ "px" )
      , ( "border-radius-large", String.fromInt theme.borderRadiusLarge ++ "px" )
      ]
    , -- Colors
      [ ( "background", .background )
      , ( "color", .color )
      , ( "focus", .focus )
      , ( "success", .success )
      , ( "warning", .warning )
      , ( "danger", .danger )
      ]
        |> List.concatMap colorVars
    ]
        |> List.concat
        |> List.map (\( k, v ) -> "--" ++ namespace ++ "-" ++ k ++ ":" ++ v)
        |> String.join ";"



-- Applying


globalProvider : Theme -> H.Html msg
globalProvider theme =
    H.node "style"
        []
        [ H.text <|
            "body { "
                ++ toString theme
                ++ " }"
        ]


provider : Theme -> H.Attribute msg
provider theme =
    HA.attribute "style" (toString theme)



-- Accessors


fontTitle : String
fontTitle =
    "var(--" ++ namespace ++ "-font-title)"


fontText : String
fontText =
    "var(--" ++ namespace ++ "-font-text)"


fontCode : String
fontCode =
    "var(--" ++ namespace ++ "-font-code)"


borderRadius : String
borderRadius =
    "var(--" ++ namespace ++ "-border-radius)"


borderRadiusLarge : String
borderRadiusLarge =
    "var(--" ++ namespace ++ "-border-radius-large)"


background : String
background =
    "var(--" ++ namespace ++ "-background)"


backgroundFaded : String
backgroundFaded =
    "var(--" ++ namespace ++ "-background)"


backgroundContrast : String
backgroundContrast =
    "var(--" ++ namespace ++ "-background)"


backgroundShadow : String
backgroundShadow =
    "var(--" ++ namespace ++ "-background)"


color : String
color =
    "var(--" ++ namespace ++ "-color)"


colorFaded : String
colorFaded =
    "var(--" ++ namespace ++ "-color)"


colorContrast : String
colorContrast =
    "var(--" ++ namespace ++ "-color)"


colorShadow : String
colorShadow =
    "var(--" ++ namespace ++ "-color)"


focus : String
focus =
    "var(--" ++ namespace ++ "-focus)"


focusFaded : String
focusFaded =
    "var(--" ++ namespace ++ "-focus)"


focusContrast : String
focusContrast =
    "var(--" ++ namespace ++ "-focus)"


focusShadow : String
focusShadow =
    "var(--" ++ namespace ++ "-focus)"


highlight : String
highlight =
    "var(--" ++ namespace ++ "-highlight)"


highlightFaded : String
highlightFaded =
    "var(--" ++ namespace ++ "-highlight)"


highlightContrast : String
highlightContrast =
    "var(--" ++ namespace ++ "-highlight)"


highlightShadow : String
highlightShadow =
    "var(--" ++ namespace ++ "-highlight)"


success : String
success =
    "var(--" ++ namespace ++ "-success)"


successFaded : String
successFaded =
    "var(--" ++ namespace ++ "-success)"


successContrast : String
successContrast =
    "var(--" ++ namespace ++ "-success)"


successShadow : String
successShadow =
    "var(--" ++ namespace ++ "-success)"


warning : String
warning =
    "var(--" ++ namespace ++ "-warning)"


warningFaded : String
warningFaded =
    "var(--" ++ namespace ++ "-warning)"


warningContrast : String
warningContrast =
    "var(--" ++ namespace ++ "-warning)"


warningShadow : String
warningShadow =
    "var(--" ++ namespace ++ "-warning)"


danger : String
danger =
    "var(--" ++ namespace ++ "-danger)"


dangerFaded : String
dangerFaded =
    "var(--" ++ namespace ++ "-danger)"


dangerContrast : String
dangerContrast =
    "var(--" ++ namespace ++ "-danger)"


dangerShadow : String
dangerShadow =
    "var(--" ++ namespace ++ "-danger)"



-- Theme Sample


sample : Theme -> H.Html msg
sample theme =
    H.div
        [ provider theme ]
        []
