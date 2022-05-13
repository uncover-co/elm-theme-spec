module ThemeSpec exposing
    ( lightTheme, darkTheme, theme, themeSpec, ThemeSpec, ThemeSpecData, ThemeSpecColor
    , sample
    , fontTitle, fontText, fontCode, background, baseline, primary, secondary, success, warning, danger, ThemeSpecColorVars
    )

{-| ThemeSpec is a theme specification that can be used across a variety of projects to quickly theme them based on CSS variables. Themes are scoped and multiple can be used at the same time in an application. ThemeSpec is fully compatible with darkmode and any theme can have dark variants.

@docs lightTheme, darkTheme, theme, themeSpec, ThemeSpec, ThemeSpecData, ThemeSpecColor


# Theme Sample

@docs sample


# Theme Variables

@docs fontTitle, fontText, fontCode, background, baseline, primary, secondary, success, warning, danger, ThemeSpecColorVars

-}

import Color exposing (Color)
import Html as H
import Html.Attributes as HA
import ThemeProvider exposing (Theme)



-- ThemeSpec
-- type alias ThemeSpec =
--     { fontTitle : String
--     , fontText : String
--     , fontCode : String
--     , background : Color
--     , details : Color
--     , base : Color
--     , primary : Color
--     , success : Color
--     , warning : Color
--     , danger : Color
--     }
-- Creating Theme


{-| Used for turning a `ThemeSpec` into a `Theme` used by [elm-theme-provider](https://package.elm-lang.org/packages/uncover-co/elm-theme-provider/latest/).
-}
toThemeProviderTheme : ThemeSpecData -> List ( String, String ) -> Theme
toThemeProviderTheme data extra =
    let
        colorChannels : Color -> String
        colorChannels color =
            let
                c : { red : Float, green : Float, blue : Float, alpha : Float }
                c =
                    Color.toRgba color
            in
            [ c.red, c.green, c.blue ]
                |> List.map (\c_ -> c_ * 255 |> ceiling |> String.fromInt)
                |> String.join " "

        colorVars : String -> Color -> List ( String, String )
        colorVars name color =
            [ ( name, Color.toCssString color )
            , ( name ++ "-ch", colorChannels color )
            ]

        colorSpec : String -> ThemeSpecColor -> List ( String, String )
        colorSpec name color =
            [ colorVars name color.base
            , colorVars (name ++ "-light") color.light
            , colorVars (name ++ "-contrast") color.contrast
            ]
                |> List.concat
    in
    [ [ ( "font-title", data.fonts.title )
      , ( "font-text", data.fonts.text )
      , ( "font-code", data.fonts.code )
      ]
    , colorSpec "background" data.colors.background
    , colorSpec "baseline" data.colors.baseline
    , colorSpec "primary" data.colors.primary
    , colorSpec "secondary" data.colors.secondary
    , colorSpec "success" data.colors.success
    , colorSpec "warning" data.colors.warning
    , colorSpec "danger" data.colors.danger
    , extra
    ]
        |> List.concat
        |> ThemeProvider.fromList namespace


{-| -}
type ThemeSpec
    = ThemeSpec
        { theme : ThemeProvider.Theme
        , data : ThemeSpecData
        }


{-| -}
type alias ThemeSpecData =
    { fonts :
        { title : String
        , text : String
        , code : String
        }
    , colors :
        { background : ThemeSpecColor
        , baseline : ThemeSpecColor
        , primary : ThemeSpecColor
        , secondary : ThemeSpecColor
        , success : ThemeSpecColor
        , warning : ThemeSpecColor
        , danger : ThemeSpecColor
        }
    }


{-| -}
type alias ThemeSpecColor =
    { base : Color
    , light : Color
    , contrast : Color
    }


{-| -}
themeSpec : ThemeSpecData -> List ( String, String ) -> ThemeSpec
themeSpec data extra =
    ThemeSpec
        { theme = toThemeProviderTheme data extra
        , data = data
        }


{-| -}
theme : ThemeSpec -> Theme
theme (ThemeSpec spec) =
    spec.theme



-- Default Themes


{-| -}
lightTheme : ThemeSpec
lightTheme =
    themeSpec
        { fonts =
            { title = "system-ui, sans-serif"
            , text = "system-ui, sans-serif"
            , code = "monospaced"
            }
        , colors =
            { background =
                { base = Color.rgb255 253 253 253
                , light = Color.rgb255 223 223 223
                , contrast = Color.rgb255 225 225 225
                }
            , baseline =
                { base = Color.rgb255 62 62 62
                , light = Color.rgb255 150 150 150
                , contrast = Color.rgb255 0 0 0
                }
            , primary =
                { base = Color.rgb255 0 141 235
                , light = Color.rgb255 95 185 244
                , contrast = Color.rgb255 255 255 255
                }
            , secondary =
                { base = Color.rgb255 91 111 125
                , light = Color.rgb255 141 160 174
                , contrast = Color.rgb255 255 255 255
                }
            , success =
                { base = Color.rgb255 68 183 1
                , light = Color.rgb255 115 209 60
                , contrast = Color.rgb255 255 255 255
                }
            , warning =
                { base = Color.rgb255 230 157 0
                , light = Color.rgb255 249 188 34
                , contrast = Color.rgb255 255 255 255
                }
            , danger =
                { base = Color.rgb255 220 49 50
                , light = Color.rgb255 248 102 103
                , contrast = Color.rgb255 255 255 255
                }
            }
        }
        []


{-| -}
darkTheme : ThemeSpec
darkTheme =
    themeSpec
        { fonts =
            { title = "system-ui, sans-serif"
            , text = "system-ui, sans-serif"
            , code = "monospaced"
            }
        , colors =
            { background =
                { base = Color.rgb255 37 40 48
                , light = Color.rgb255 56 60 70
                , contrast = Color.rgb255 22 24 29
                }
            , baseline =
                { base = Color.rgb255 227 227 227
                , light = Color.rgb255 110 114 120
                , contrast = Color.rgb255 255 255 255
                }
            , primary =
                { base = Color.rgb255 0 153 255
                , light = Color.rgb255 145 190 243
                , contrast = Color.rgb255 255 255 255
                }
            , secondary =
                { base = Color.rgb255 21 22 26
                , light = Color.rgb255 57 61 76
                , contrast = Color.rgb255 255 255 255
                }
            , success =
                { base = Color.rgb255 74 200 0
                , light = Color.rgb255 119 223 59
                , contrast = Color.rgb255 27 74 0
                }
            , warning =
                { base = Color.rgb255 251 179 0
                , light = Color.rgb255 255 215 114
                , contrast = Color.rgb255 91 65 0
                }
            , danger =
                { base = Color.rgb255 255 77 79
                , light = Color.rgb255 242 156 156
                , contrast = Color.rgb255 91 0 1
                }
            }
        }
        []



-- CSS Variables


namespace : String
namespace =
    "tmspc"


{-| `var(--tmspc-font-title)`
-}
fontTitle : String
fontTitle =
    "var(--" ++ namespace ++ "-font-title)"


{-| `var(--tmspc-font-text)`
-}
fontText : String
fontText =
    "var(--" ++ namespace ++ "-font-text)"


{-| `var(--tmspc-font-code)`
-}
fontCode : String
fontCode =
    "var(--" ++ namespace ++ "-font-code)"


{-| -}
type alias ThemeSpecColorVars =
    { base : String
    , baseChannels : String
    , light : String
    , lightChannels : String
    , contrast : String
    , contrastChannels : String
    }


toColorVars : String -> ThemeSpecColorVars
toColorVars name =
    { base = "var(--" ++ namespace ++ "-" ++ name ++ ")"
    , baseChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-ch)"
    , light = "var(--" ++ namespace ++ "-" ++ name ++ "-light)"
    , lightChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-light-ch)"
    , contrast = "var(--" ++ namespace ++ "-" ++ name ++ "-contrast)"
    , contrastChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-contrast-ch)"
    }


{-| -}
background : ThemeSpecColorVars
background =
    toColorVars "background"


{-| -}
baseline : ThemeSpecColorVars
baseline =
    toColorVars "baseline"


{-| -}
primary : ThemeSpecColorVars
primary =
    toColorVars "primary"


{-| -}
secondary : ThemeSpecColorVars
secondary =
    toColorVars "secondary"


{-| -}
success : ThemeSpecColorVars
success =
    toColorVars "success"


{-| -}
warning : ThemeSpecColorVars
warning =
    toColorVars "warning"


{-| -}
danger : ThemeSpecColorVars
danger =
    toColorVars "danger"


{-| Renders an element that showcases all the current theme's colors and settings.
-}
sample : H.Html msg
sample =
    let
        shapes : String -> String -> String -> H.Html msg
        shapes colorName first second =
            H.div
                [ HA.style "display" "flex"
                , HA.style "align-items" "center"
                ]
                [ H.div
                    [ HA.style "border-radius" "2px"
                    , HA.style "width" "20px"
                    , HA.style "height" "20px"
                    , HA.style "background-color" first
                    , HA.title ("" ++ colorName ++ "-light")
                    ]
                    []
                , H.div
                    [ HA.style "border-radius" "50%"
                    , HA.style "width" "20px"
                    , HA.style "height" "20px"
                    , HA.style "background-color" second
                    , HA.style "margin-left" "16px"
                    , HA.title ("" ++ colorName ++ "-lighter")
                    ]
                    []
                ]

        colorSample :
            { label : String
            , theme : ThemeSpecColorVars
            }
            -> H.Html msg
        colorSample props =
            let
                colorName =
                    String.toLower props.label
            in
            H.div
                [ HA.style "margin" "20px 0"
                ]
                [ H.button
                    [ HA.style "display" "flex"
                    , HA.style "align-items" "center"
                    , HA.style "justify-content" "space-between"
                    , HA.style "color" props.theme.contrast
                    , HA.style "width" "100%"
                    , HA.style "border" "none"
                    , HA.style "border-radius" "4px"
                    , HA.style "background-color" props.theme.base
                    , HA.style "font-size" "18px"
                    , HA.style "font-family" fontText
                    , HA.style "margin" "8px 0 0"
                    , HA.style "padding" "12px 24px"
                    , HA.style "box-shadow" ("0 0 8px rgb(" ++ props.theme.baseChannels ++ " / 0.3)")
                    , HA.title ("" ++ colorName ++ " / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName ++ "-contrast") ] [ H.text props.label ]
                    , shapes colorName props.theme.light props.theme.light
                    ]
                , H.p
                    [ HA.style "padding-top" "12px"
                    , HA.style "margin" "12px 0"
                    , HA.style "padding" "16px 16px"
                    , HA.style "border-radius" "4px"
                    , HA.style "border-left" ("8px solid " ++ props.theme.light)
                    , HA.style "background-color" ("rgb(" ++ props.theme.lightChannels ++ " / 0.1)")
                    , HA.style "color" baseline.base
                    , HA.style "font-size" "14px"
                    , HA.title (props.label ++ " with 0.08 opacity / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName) ]
                        [ H.text "Tinted backgrounds can be used to display information with semantic coloring." ]
                    ]
                ]

        separator : H.Html msg
        separator =
            H.div
                [ HA.style "display" "flex"
                , HA.style "justify-content" "center"
                , HA.style "margin" "20px 0"
                , HA.style "padding" "8px 12px"
                , HA.style "background" background.light
                , HA.style "border-radius" "4px"
                ]
                [ H.div
                    [ HA.style "border-radius" "50%"
                    , HA.style "background" baseline.light
                    , HA.style "width" "12px"
                    , HA.style "height" "12px"
                    ]
                    []
                ]
    in
    H.div
        [ HA.style "position" "relative"
        , HA.style "padding" "40px"
        , HA.style "background-color" background.contrast
        , HA.style "font-family" fontText
        , HA.style "font-size" "16px"
        , HA.title "background-light"
        ]
        [ H.div
            [ HA.style "position" "absolute"
            , HA.style "top" "0"
            , HA.style "left" "0"
            , HA.style "right" "0"
            , HA.style "bottom" "0"
            ]
            []
        , H.div
            [ HA.style "position" "relative"
            , HA.style "z-index" "1"
            , HA.style "padding" "40px"
            , HA.style "border-radius" "8px"
            , HA.style "background-color" background.base
            , HA.style "box-shadow" "0 0 8px rgba(0, 0, 0, 0.1)"
            , HA.style "font-family" fontText
            , HA.style "font-size" "16px"
            , HA.title "background-base"
            ]
            [ H.div
                [ HA.style "display" "flex"
                , HA.style "align-items" "baseline"
                ]
                [ H.h1
                    [ HA.style "font-family" fontTitle
                    , HA.style "font-size" "40px"
                    , HA.style "color" baseline.base
                    , HA.style "margin" "0px"
                    , HA.style "padding-bottom" "12px"
                    , HA.title "font-title / baseline-light"
                    ]
                    [ H.text "Theme Sampler" ]
                , H.div
                    [ HA.style "flex-grow" "1"
                    , HA.style "border-bottom" ("2px solid " ++ background.light)
                    ]
                    []
                ]
            , H.p
                [ HA.style "color" baseline.base
                , HA.style "margin" "0"
                , HA.title "font-text / baseline-base"
                ]
                [ H.text "This sampler is using "
                , H.span
                    [ HA.style "font-weight" "bold", HA.style "color" baseline.contrast ]
                    [ H.text "all available color and styles" ]
                , H.text " in your theme."
                , H.span
                    [ HA.style "color" baseline.light
                    , HA.title "font-text / baseline-base"
                    ]
                    [ H.text " You can hover over any element to figure out it's base styles."
                    ]
                ]
            , separator
            , colorSample
                { label = "Primary"
                , theme = primary
                }
            , colorSample
                { label = "Secondary"
                , theme = secondary
                }
            , colorSample
                { label = "Success"
                , theme = success
                }
            , colorSample
                { label = "Warning"
                , theme = warning
                }
            , colorSample
                { label = "Danger"
                , theme = danger
                }
            ]
        ]
