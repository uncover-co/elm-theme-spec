module ThemeSpec exposing
    ( ThemeSpec, ThemeSpecBackground, ThemeSpecColor, theme
    , lightTheme, darkTheme
    , sample
    , fontTitle, fontText, fontCode, borderRadius, borderRadiusLarge, focus, background, backgroundDark, backgroundDarker, backgroundShadow, base, baseLight, baseLighter, baseShadow, danger, dangerLight, dangerLighter, dangerShadow, accent, accentLight, accentLighter, accentShadow, success, successLight, successLighter, successShadow, warning, warningLight, warningLighter, warningShadow
    )

{-| ThemeSpec is a theme specification that can be used across a variety of projects to quickly theme them based on CSS variables. Themes are scoped and multiple can be used at the same time in an application. ThemeSpec is fully compatible with darkmode and any theme can have dark variants.

@docs ThemeSpec, ThemeSpecBackground, ThemeSpecColor, theme


# Default Themes

@docs lightTheme, darkTheme


# Theme Sample

@docs sample


# Theme Variables

@docs fontTitle, fontText, fontCode, borderRadius, borderRadiusLarge, focus, background, backgroundDark, backgroundDarker, backgroundShadow, base, baseLight, baseLighter, baseShadow, danger, dangerLight, dangerLighter, dangerShadow, accent, accentLight, accentLighter, accentShadow, success, successLight, successLighter, successShadow, warning, warningLight, warningLighter, warningShadow

-}

import Html as H
import Html.Attributes as HA
import ThemeProvider exposing (Theme)



-- ThemeSpec


{-| -}
type alias ThemeSpecBackground =
    { base : String
    , dark : String
    , darker : String
    , shadow : String
    }


{-| -}
type alias ThemeSpecColor =
    { base : String
    , light : String
    , lighter : String
    , shadow : String
    }


{-| -}
type alias ThemeSpec =
    { -- font
      fontTitle : String
    , fontText : String
    , fontCode : String

    -- border radius
    , borderRadius : String
    , borderRadiusLarge : String

    -- a11y
    , focus : String

    -- background
    , background : ThemeSpecBackground

    -- foreground
    , base : ThemeSpecColor
    , accent : ThemeSpecColor
    , success : ThemeSpecColor
    , warning : ThemeSpecColor
    , danger : ThemeSpecColor
    }



-- Creating Theme


{-| Used for turning a `ThemeSpec` into a `Theme` used by [elm-theme-provider](https://package.elm-lang.org/packages/uncover-co/elm-theme-provider/latest/).
-}
theme : ThemeSpec -> Theme
theme themeSpec =
    let
        colorVars : ( String, ThemeSpec -> ThemeSpecColor ) -> List ( String, String )
        colorVars ( label, getter ) =
            let
                themeColor =
                    getter themeSpec
            in
            [ ( label, .base themeColor )
            , ( label ++ "-light", .light themeColor )
            , ( label ++ "-lighter", .lighter themeColor )
            , ( label ++ "-shadow", .shadow themeColor )
            ]

        backgroundVars : ( String, ThemeSpec -> ThemeSpecBackground ) -> List ( String, String )
        backgroundVars ( label, getter ) =
            let
                themeBackground =
                    getter themeSpec
            in
            [ ( label, .base themeBackground )
            , ( label ++ "-dark", .dark themeBackground )
            , ( label ++ "-darker", .darker themeBackground )
            , ( label ++ "-shadow", .shadow themeBackground )
            ]
    in
    [ [ -- Fonts
        ( "font-title", themeSpec.fontTitle )
      , ( "font-text", themeSpec.fontText )
      , ( "font-code", themeSpec.fontCode )

      -- Border Radius
      , ( "border-radius", themeSpec.borderRadius )
      , ( "border-radius-large", themeSpec.borderRadiusLarge )

      -- Colors - Simple
      , ( "focus", themeSpec.focus )
      ]

    -- Colors - BackgroundColor
    , [ ( "background", .background )
      ]
        |> List.concatMap backgroundVars
    , -- Colors – ThemeColor
      [ ( "base", .base )
      , ( "accent", .accent )
      , ( "success", .success )
      , ( "warning", .warning )
      , ( "danger", .danger )
      ]
        |> List.concatMap colorVars
    ]
        |> List.concat
        |> ThemeProvider.fromList namespace



-- Default Themes


{-| -}
lightTheme : Theme
lightTheme =
    theme
        { fontTitle = "system-ui, sans-serif"
        , fontText = "system-ui, sans-serif"
        , fontCode = "monospaced"
        , borderRadius = "4px"
        , borderRadiusLarge = "8px"
        , focus = "#59e7d2"
        , background =
            { base = "#fdfdfd"
            , dark = "#f5f5f5"
            , darker = "#eaeaea"
            , shadow = "#dfdfdf"
            }
        , base =
            { base = "#3e3e3e"
            , light = "#595959"
            , lighter = "#e7e7e7"
            , shadow = "#aaa"
            }
        , accent =
            { base = "#008deb"
            , light = "#4db8ff"
            , lighter = "#e8f3ff"
            , shadow = "#9cf"
            }
        , success =
            { base = "#40ad00"
            , light = "#63dd1b"
            , lighter = "#eef7e9"
            , shadow = "#8ed466"
            }
        , warning =
            { base = "#e69d00"
            , light = "#ffc533"
            , lighter = "#f9f5ea"
            , shadow = "#f5c95b"
            }
        , danger =
            { base = "#dc3132"
            , light = "#fc585a"
            , lighter = "#ffeff0"
            , shadow = "#f98a8b"
            }
        }


{-| -}
darkTheme : Theme
darkTheme =
    theme
        { fontTitle = "system-ui, sans-serif"
        , fontText = "system-ui, sans-serif"
        , fontCode = "monospaced"
        , borderRadius = "4px"
        , borderRadiusLarge = "8px"
        , focus = "#59e7d2"
        , background =
            { base = "#20232a"
            , dark = "#1a1c23"
            , darker = "#16181d"
            , shadow = "#111111"
            }
        , base =
            { base = "#e0e4f5"
            , light = "#6d7282"
            , lighter = "#30323b"
            , shadow = "#646566"
            }
        , accent =
            { base = "#09f"
            , light = "#017fd3"
            , lighter = "#203246"
            , shadow = "#2e69a4"
            }
        , success =
            { base = "#4ac800"
            , light = "#3ea702"
            , lighter = "#253832"
            , shadow = "#37651c"
            }
        , warning =
            { base = "#fbb300"
            , light = "#d29500"
            , lighter = "#3d3727"
            , shadow = "#7f6831"
            }
        , danger =
            { base = "#ff4d4f"
            , light = "#e02d2f"
            , lighter = "#41282a"
            , shadow = "#893a3b"
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


{-| `var(--tmspc-border-radius)`

Usually used for the border radius of small elements. (e.g. buttons)

-}
borderRadius : String
borderRadius =
    "var(--" ++ namespace ++ "-border-radius)"


{-| `var(--tmspc-border-radius-large)`

Usually used for the border radius of large elements. (e.g. cards)

-}
borderRadiusLarge : String
borderRadiusLarge =
    "var(--" ++ namespace ++ "-border-radius-large)"



-- Focus


{-| `var(--tmspc-focus)`

Usually used for accessibility purposes.

-}
focus : String
focus =
    "var(--" ++ namespace ++ "-focus)"



-- Background


{-| `var(--tmspc-background)`
-}
background : String
background =
    "var(--" ++ namespace ++ "-background)"


{-| `var(--tmspc-background-dark)`
-}
backgroundDark : String
backgroundDark =
    "var(--" ++ namespace ++ "-background-dark)"


{-| `var(--tmspc-background-darker)`
-}
backgroundDarker : String
backgroundDarker =
    "var(--" ++ namespace ++ "-background-darker)"


{-| `var(--tmspc-background-shadow)`
-}
backgroundShadow : String
backgroundShadow =
    "var(--" ++ namespace ++ "-background-shadow)"



-- Base


{-| `var(--tmspc-base)`
-}
base : String
base =
    "var(--" ++ namespace ++ "-base)"


{-| `var(--tmspc-base-light)`
-}
baseLight : String
baseLight =
    "var(--" ++ namespace ++ "-base-light)"


{-| `var(--tmspc-base-lighter)`
-}
baseLighter : String
baseLighter =
    "var(--" ++ namespace ++ "-base-lighter)"


{-| `var(--tmspc-base-shadow)`
-}
baseShadow : String
baseShadow =
    "var(--" ++ namespace ++ "-base-shadow)"



-- Accent


{-| `var(--tmspc-accent)`
-}
accent : String
accent =
    "var(--" ++ namespace ++ "-accent)"


{-| `var(--tmspc-accent-light)`
-}
accentLight : String
accentLight =
    "var(--" ++ namespace ++ "-accent-light)"


{-| `var(--tmspc-accent-lighter)`
-}
accentLighter : String
accentLighter =
    "var(--" ++ namespace ++ "-accent-lighter)"


{-| `var(--tmspc-accent-shadow)`
-}
accentShadow : String
accentShadow =
    "var(--" ++ namespace ++ "-accent-shadow)"



-- Success


{-| `var(--tmspc-success)`
-}
success : String
success =
    "var(--" ++ namespace ++ "-success)"


{-| `var(--tmspc-success-light)`
-}
successLight : String
successLight =
    "var(--" ++ namespace ++ "-success-light)"


{-| `var(--tmspc-success-lighter)`
-}
successLighter : String
successLighter =
    "var(--" ++ namespace ++ "-success-lighter)"


{-| `var(--tmspc-success-shadow)`
-}
successShadow : String
successShadow =
    "var(--" ++ namespace ++ "-success-shadow)"



-- Warning


{-| `var(--tmspc-warning)`
-}
warning : String
warning =
    "var(--" ++ namespace ++ "-warning)"


{-| `var(--tmspc-warning-light)`
-}
warningLight : String
warningLight =
    "var(--" ++ namespace ++ "-warning-light)"


{-| `var(--tmspc-warning-lighter)`
-}
warningLighter : String
warningLighter =
    "var(--" ++ namespace ++ "-warning-lighter)"


{-| `var(--tmspc-warning-shadow)`
-}
warningShadow : String
warningShadow =
    "var(--" ++ namespace ++ "-warning-shadow)"



-- Danger


{-| `var(--tmspc-danger)`
-}
danger : String
danger =
    "var(--" ++ namespace ++ "-danger)"


{-| `var(--tmspc-danger-light)`
-}
dangerLight : String
dangerLight =
    "var(--" ++ namespace ++ "-danger-light)"


{-| `var(--tmspc-danger-lighter)`
-}
dangerLighter : String
dangerLighter =
    "var(--" ++ namespace ++ "-danger-lighter)"


{-| `var(--tmspc-danger-shadow)`
-}
dangerShadow : String
dangerShadow =
    "var(--" ++ namespace ++ "-danger-shadow)"


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
            , lighterLabel : String
            , base : String
            , light : String
            , lighter : String
            , shadow : String
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
                    , HA.style "color" props.lighter
                    , HA.style "width" "100%"
                    , HA.style "border" "none"
                    , HA.style "border-radius" borderRadius
                    , HA.style "background-color" props.base
                    , HA.style "font-size" "18px"
                    , HA.style "font-family" fontText
                    , HA.style "margin" "8px 0 0"
                    , HA.style "padding" "12px 24px"
                    , HA.style "box-shadow" ("0 0 8px " ++ props.shadow)
                    , HA.title ("" ++ colorName ++ " / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName ++ "-lighter") ] [ H.text props.label ]
                    , shapes colorName props.light props.lighter
                    ]
                , H.p
                    [ HA.style "padding-top" "12px"
                    , HA.style "margin" "12px 0"
                    , HA.style "padding" "16px 16px"
                    , HA.style "border-radius" borderRadius
                    , HA.style "border-left" ("8px solid " ++ props.light)
                    , HA.style "background-color" props.lighter
                    , HA.style "color" props.base
                    , HA.style "font-size" "14px"
                    , HA.title (props.lighterLabel ++ " / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName) ]
                        [ H.text "Tinted backgrounds can be used to display information with semantic coloring." ]
                    ]
                ]
    in
    H.div
        [ HA.style "padding" "40px"
        , HA.style "background-color" backgroundDarker
        , HA.style "font-family" fontText
        , HA.style "font-size" "16px"
        , HA.title "background-darker"
        ]
        [ H.div
            [ HA.style "padding" "40px"
            , HA.style "border-radius" borderRadiusLarge
            , HA.style "background-color" background
            , HA.style "box-shadow" ("0 0 8px " ++ backgroundShadow)
            , HA.style "font-family" fontText
            , HA.style "font-size" "16px"
            , HA.title "background / background-shadow / border-radius-large"
            ]
            [ H.div []
                [ H.h1
                    [ HA.style "font-family" fontTitle
                    , HA.style "font-size" "40px"
                    , HA.style "color" baseLight
                    , HA.style "margin" "0px"
                    , HA.style "padding-bottom" "12px"
                    , HA.title "font-title / base-light"
                    ]
                    [ H.text "Theme Sampler" ]
                , H.p
                    [ HA.style "color" base
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
                    , HA.style "border-top" ("2px solid " ++ backgroundDarker)
                    , HA.title "background-darker"
                    ]
                    []
                , H.div
                    [ HA.style "display" "flex"
                    , HA.style "align-items" "center"
                    , HA.style "justify-content" "space-between"
                    , HA.style "margin" "0"
                    , HA.style "padding" "16px 16px 16px 24px"
                    , HA.style "border-radius" borderRadius
                    , HA.style "background-color" backgroundDark
                    , HA.style "color" base
                    , HA.style "font-size" "14px"
                    , HA.title "background-dark / border-radius"
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
                                    ++ focus
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
                            , HA.style "background" backgroundDarker
                            , HA.title "background-darker / focus (outline)"
                            ]
                            []
                        , H.div
                            [ HA.class (namespace ++ "-sampler-focus")
                            , HA.style "width" "20px"
                            , HA.style "height" "20px"
                            , HA.style "margin" "0 8px"
                            , HA.style "border-radius" "50%"
                            , HA.style "background" base
                            , HA.style "outline" ("3px solid " ++ focus)
                            , HA.style "outline-offset" "3px"
                            , HA.title "base / focus (outline)"
                            ]
                            []
                        ]
                    ]
                , H.p
                    [ HA.style "font-size" "14px"
                    , HA.style "color" baseLight
                    , HA.style "margin" "16px 0 40px"
                    , HA.title "base-light"
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
                    , lighterLabel = "background-darker"
                    , base = base
                    , light = baseLight
                    , lighter = baseLighter
                    , shadow = baseShadow
                    }
                , colorSample
                    { label = "Accent"
                    , lighterLabel = "accenter-lighter"
                    , base = accent
                    , light = accentLight
                    , lighter = accentLighter
                    , shadow = accentShadow
                    }
                , colorSample
                    { label = "Success"
                    , lighterLabel = "success-lighter"
                    , base = success
                    , light = successLight
                    , lighter = successLighter
                    , shadow = successShadow
                    }
                , colorSample
                    { label = "Warning"
                    , lighterLabel = "warning-lighter"
                    , base = warning
                    , light = warningLight
                    , lighter = warningLighter
                    , shadow = warningShadow
                    }
                , colorSample
                    { label = "Danger"
                    , lighterLabel = "danger-lighter"
                    , base = danger
                    , light = dangerLight
                    , lighter = dangerLighter
                    , shadow = dangerShadow
                    }
                ]
            ]
        ]
