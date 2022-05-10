module ThemeSpec exposing
    ( lightTheme, darkTheme, theme, themeSpec, ThemeSpec, ThemeSpecData, ThemeSpecBackground, ThemeSpecColor
    , sample
    , fontTitle, fontText, fontCode, background, details, base, accent, success, warning, danger, ThemeSpecBackgroundVariableSet, ThemeSpecColorVariableSet
    )

{-| ThemeSpec is a theme specification that can be used across a variety of projects to quickly theme them based on CSS variables. Themes are scoped and multiple can be used at the same time in an application. ThemeSpec is fully compatible with darkmode and any theme can have dark variants.

@docs lightTheme, darkTheme, theme, themeSpec, ThemeSpec, ThemeSpecData, ThemeSpecBackground, ThemeSpecColor


# Theme Sample

@docs sample


# Theme Variables

@docs fontTitle, fontText, fontCode, background, details, base, accent, success, warning, danger, ThemeSpecBackgroundVariableSet, ThemeSpecColorVariableSet

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
--     , accent : Color
--     , success : Color
--     , warning : Color
--     , danger : Color
--     }
-- Creating Theme


{-| Used for turning a `ThemeSpec` into a `Theme` used by [elm-theme-provider](https://package.elm-lang.org/packages/uncover-co/elm-theme-provider/latest/).
-}
toThemeProviderTheme : ThemeSpecData -> Theme
toThemeProviderTheme data =
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

        backgroundSpec : String -> ThemeSpecBackground -> List ( String, String )
        backgroundSpec name color =
            [ colorVars name color.default
            , colorVars (name ++ "-dark") color.dark
            , colorVars (name ++ "-darker") color.darker
            , colorVars (name ++ "-shadow") color.darker
            ]
                |> List.concat

        colorSpec : String -> ThemeSpecColor -> List ( String, String )
        colorSpec name color =
            [ colorVars name color.default
            , colorVars (name ++ "-light") color.light
            , colorVars (name ++ "-lighter") color.lighter
            , colorVars (name ++ "-inverse") color.inverse
            ]
                |> List.concat
    in
    [ [ ( "font-title", data.fonts.title )
      , ( "font-text", data.fonts.text )
      , ( "font-code", data.fonts.code )
      ]
    , backgroundSpec "background" data.colors.background
    , backgroundSpec "details" data.colors.details
    , colorSpec "base" data.colors.base
    , colorSpec "accent" data.colors.accent
    , colorSpec "success" data.colors.success
    , colorSpec "warning" data.colors.warning
    , colorSpec "danger" data.colors.danger
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
        { background : ThemeSpecBackground
        , details : ThemeSpecBackground
        , base : ThemeSpecColor
        , accent : ThemeSpecColor
        , success : ThemeSpecColor
        , warning : ThemeSpecColor
        , danger : ThemeSpecColor
        }
    }


{-| -}
type alias ThemeSpecBackground =
    { default : Color
    , dark : Color
    , darker : Color
    , shadow : Color
    }


{-| -}
type alias ThemeSpecColor =
    { default : Color
    , light : Color
    , lighter : Color
    , inverse : Color
    }


{-| -}
themeSpec : ThemeSpecData -> ThemeSpec
themeSpec data =
    ThemeSpec
        { theme = toThemeProviderTheme data
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
                { default = Color.rgb255 253 253 253
                , dark = Color.rgb255 242 242 242
                , darker = Color.rgb255 229 229 229
                , shadow = Color.rgb255 30 30 30
                }
            , details =
                { default = Color.rgb255 165 165 165
                , dark = Color.rgb255 209 209 209
                , darker = Color.rgb255 237 237 237
                , shadow = Color.rgb255 30 30 30
                }
            , base =
                { default = Color.rgb255 62 62 62
                , light = Color.rgb255 86 86 86
                , lighter = Color.rgb255 130 130 130
                , inverse = Color.rgb255 242 242 242
                }
            , accent =
                { default = Color.rgb255 0 141 235
                , light = Color.rgb255 42 158 235
                , lighter = Color.rgb255 77 184 255
                , inverse = Color.rgb255 241 247 253
                }
            , success =
                { default = Color.rgb255 68 183 1
                , light = Color.rgb255 85 200 17
                , lighter = Color.rgb255 99 221 27
                , inverse = Color.rgb255 243 250 240
                }
            , warning =
                { default = Color.rgb255 230 157 0
                , light = Color.rgb255 244 175 0
                , lighter = Color.rgb255 252 187 21
                , inverse = Color.rgb255 248 246 242
                }
            , danger =
                { default = Color.rgb255 220 49 50
                , light = Color.rgb255 241 74 76
                , lighter = Color.rgb255 252 88 90
                , inverse = Color.rgb255 252 243 244
                }
            }
        }


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
                { default = Color.rgb255 37 40 48
                , dark = Color.rgb255 31 34 42
                , darker = Color.rgb255 29 31 37
                , shadow = Color.rgb255 0 0 0
                }
            , details =
                { default = Color.rgb255 67 70 78
                , dark = Color.rgb255 51 53 62
                , darker = Color.rgb255 46 54 64
                , shadow = Color.rgb255 0 0 0
                }
            , base =
                { default = Color.rgb255 224 228 245
                , light = Color.rgb255 152 156 168
                , lighter = Color.rgb255 109 114 130
                , inverse = Color.rgb255 32 35 42
                }
            , accent =
                { default = Color.rgb255 0 153 255
                , light = Color.rgb255 1 127 211
                , lighter = Color.rgb255 31 47 66
                , inverse = Color.rgb255 241 247 253
                }
            , success =
                { default = Color.rgb255 74 200 0
                , light = Color.rgb255 62 167 2
                , lighter = Color.rgb255 37 56 50
                , inverse = Color.rgb255 243 250 240
                }
            , warning =
                { default = Color.rgb255 251 179 0
                , light = Color.rgb255 210 149 0
                , lighter = Color.rgb255 56 51 36
                , inverse = Color.rgb255 248 246 242
                }
            , danger =
                { default = Color.rgb255 255 77 79
                , light = Color.rgb255 224 45 47
                , lighter = Color.rgb255 50 36 38
                , inverse = Color.rgb255 252 243 244
                }
            }
        }



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
type alias ThemeSpecBackgroundVariableSet =
    { default : String
    , defaultChannels : String
    , dark : String
    , darkChannels : String
    , darker : String
    , darkerChannels : String
    , shadow : String
    , shadowChannels : String
    }


toBackgroundVars : String -> ThemeSpecBackgroundVariableSet
toBackgroundVars name =
    { default = "var(--" ++ namespace ++ "-" ++ name ++ ")"
    , defaultChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-ch)"
    , dark = "var(--" ++ namespace ++ "-" ++ name ++ "-dark)"
    , darkChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-dark-ch)"
    , darker = "var(--" ++ namespace ++ "-" ++ name ++ "-darker)"
    , darkerChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-darker-ch)"
    , shadow = "var(--" ++ namespace ++ "-" ++ name ++ "-shadow)"
    , shadowChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-shadow-ch)"
    }


{-| -}
background : ThemeSpecBackgroundVariableSet
background =
    toBackgroundVars "background"


{-| -}
details : ThemeSpecBackgroundVariableSet
details =
    toBackgroundVars "details"


{-| -}
type alias ThemeSpecColorVariableSet =
    { default : String
    , defaultChannels : String
    , light : String
    , lightChannels : String
    , lighter : String
    , lighterChannels : String
    , inverse : String
    , inverseChannels : String
    }


toColorVars : String -> ThemeSpecColorVariableSet
toColorVars name =
    { default = "var(--" ++ namespace ++ "-" ++ name ++ ")"
    , defaultChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-ch)"
    , light = "var(--" ++ namespace ++ "-" ++ name ++ "-light)"
    , lightChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-light-ch)"
    , lighter = "var(--" ++ namespace ++ "-" ++ name ++ "-lighter)"
    , lighterChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-lighter-ch)"
    , inverse = "var(--" ++ namespace ++ "-" ++ name ++ "-inverse)"
    , inverseChannels = "var(--" ++ namespace ++ "-" ++ name ++ "-inverse-ch)"
    }


{-| -}
base : ThemeSpecColorVariableSet
base =
    toColorVars "base"


{-| -}
accent : ThemeSpecColorVariableSet
accent =
    toColorVars "accent"


{-| -}
success : ThemeSpecColorVariableSet
success =
    toColorVars "success"


{-| -}
warning : ThemeSpecColorVariableSet
warning =
    toColorVars "warning"


{-| -}
danger : ThemeSpecColorVariableSet
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
            , theme : ThemeSpecColorVariableSet
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
                    , HA.style "color" props.theme.inverse
                    , HA.style "width" "100%"
                    , HA.style "border" "none"
                    , HA.style "border-radius" "4px"
                    , HA.style "background-color" props.theme.default
                    , HA.style "font-size" "18px"
                    , HA.style "font-family" fontText
                    , HA.style "margin" "8px 0 0"
                    , HA.style "padding" "12px 24px"
                    , HA.style "box-shadow" ("0 0 8px rgb(" ++ props.theme.defaultChannels ++ " / 0.5)")
                    , HA.title ("" ++ colorName ++ " / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName ++ "-inverse") ] [ H.text props.label ]
                    , shapes colorName props.theme.light props.theme.lighter
                    ]
                , H.p
                    [ HA.style "padding-top" "12px"
                    , HA.style "margin" "12px 0"
                    , HA.style "padding" "16px 16px"
                    , HA.style "border-radius" "4px"
                    , HA.style "border-left" ("8px solid " ++ props.theme.light)
                    , HA.style "background-color" ("rgb(" ++ props.theme.defaultChannels ++ " / 0.08)")
                    , HA.style "color" props.theme.default
                    , HA.style "font-size" "14px"
                    , HA.title (props.label ++ " with 0.08 opacity / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName) ]
                        [ H.text "Tinted backgrounds can be used to display information with semantic coloring." ]
                    ]
                ]
    in
    H.div
        [ HA.style "padding" "40px"
        , HA.style "background-color" background.darker
        , HA.style "font-family" fontText
        , HA.style "font-size" "16px"
        , HA.title "background-darker"
        ]
        [ H.div
            [ HA.style "padding" "40px"
            , HA.style "border-radius" "8px"
            , HA.style "background-color" background.default
            , HA.style "box-shadow" ("0 0 8px rgb(" ++ background.shadowChannels ++ " / 0.2)")
            , HA.style "font-family" fontText
            , HA.style "font-size" "16px"
            , HA.title "background / background-shadow / border-radius-large"
            ]
            [ H.div []
                [ H.h1
                    [ HA.style "font-family" fontTitle
                    , HA.style "font-size" "40px"
                    , HA.style "color" base.light
                    , HA.style "margin" "0px"
                    , HA.style "padding-bottom" "12px"
                    , HA.title "font-title / base-light"
                    ]
                    [ H.text "Theme Sampler" ]
                , H.p
                    [ HA.style "color" base.default
                    , HA.style "margin" "0 0 16px"
                    , HA.title "font-text / base"
                    ]
                    [ H.text "This sampler is using "
                    , H.span [ HA.style "font-weight" "bold" ] [ H.text "all available color and styles" ]
                    , H.text " in your theme. You can hover over any element to figure out it's base styles."
                    ]
                , H.hr
                    [ HA.style "margin" "20px 0"
                    , HA.style "border" "none"
                    , HA.style "border-top" ("2px solid " ++ details.darker)
                    , HA.title "background-darker"
                    ]
                    []
                , H.div
                    [ HA.style "display" "flex"
                    , HA.style "align-items" "center"
                    , HA.style "justify-content" "space-between"
                    , HA.style "margin" "0"
                    , HA.style "padding" "16px 16px 16px 24px"
                    , HA.style "border-radius" "4px"
                    , HA.style "background-color" background.dark
                    , HA.style "color" base.light
                    , HA.style "font-size" "14px"
                    , HA.title "base-lighter / border-radius"
                    ]
                    [ H.p
                        [ HA.style "margin" "0"
                        , HA.title "font-text / base"
                        ]
                        [ H.text "\"Focus\" is used for accessibility features" ]
                    , H.div
                        [ HA.style "display" "flex"
                        ]
                        [ H.node "style"
                            []
                            [ H.text
                                ("."
                                    ++ namespace
                                    ++ "-sampler-focus { cursor: pointer; outline-offset: 3px; outline: 0 solid  "
                                    ++ accent.default
                                    ++ "; transition: outline-width 0.1s; }"
                                    ++ " ."
                                    ++ namespace
                                    ++ "-sampler-focus:hover { outline-width: 3px; }"
                                )
                            ]
                        , H.div
                            [ HA.class (namespace ++ "-sampler-focus")
                            , HA.style "width" "20px"
                            , HA.style "height" "20px"
                            , HA.style "margin" "0 8px"
                            , HA.style "border-radius" "4px"
                            , HA.style "background" details.dark
                            , HA.title "background-darker / focus (outline)"
                            ]
                            []
                        , H.div
                            [ HA.class (namespace ++ "-sampler-focus")
                            , HA.style "width" "20px"
                            , HA.style "height" "20px"
                            , HA.style "margin" "0 8px"
                            , HA.style "border-radius" "50%"
                            , HA.style "background" details.default
                            , HA.style "outline" ("3px solid " ++ accent.default)
                            , HA.style "outline-offset" "3px"
                            , HA.title "base / focus (outline)"
                            ]
                            []
                        ]
                    ]
                , H.p
                    [ HA.style "font-size" "14px"
                    , HA.style "color" base.lighter
                    , HA.style "margin" "16px 0 40px"
                    , HA.title "base-lighter"
                    ]
                    [ H.text "You should also consider using a contrast checker like "
                    , H.a
                        [ HA.style "color" "inherit"
                        , HA.target "_blank"
                        , HA.href "https://webaim.org/resources/contrastchecker/"
                        ]
                        [ H.text "this one" ]
                    , H.text " to make sure everything is working correctly."
                    ]
                ]
            , H.div []
                [ colorSample
                    { label = "Base"
                    , theme = base
                    }
                , colorSample
                    { label = "Accent"
                    , theme = accent
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
        ]
