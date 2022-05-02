module ThemeSpec exposing
    ( ThemeSpec, ThemeSpecBackground, ThemeSpecColor, theme
    , lightTheme, darkTheme
    , sample
    , fontTitle, fontText, fontCode, borderRadius, borderRadiusLarge, focus, background, base, accent, success, warning, danger
    )

{-| ThemeSpec is a theme specification that can be used across a variety of projects to quickly theme them based on CSS variables. Themes are scoped and multiple can be used at the same time in an application. ThemeSpec is fully compatible with darkmode and any theme can have dark variants.

@docs ThemeSpec, ThemeSpecBackground, ThemeSpecColor, theme


# Default Themes

@docs lightTheme, darkTheme


# Theme Sample

@docs sample


# Theme Variables

@docs fontTitle, fontText, fontCode, borderRadius, borderRadiusLarge, focus, background, base, accent, success, warning, danger

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


{-| CSS Variables based on **background** colors.

  - background.base `var(--tmspc-background)`
  - background.dark `var(--tmspc-background-dark)`
  - background.darker `var(--tmspc-background-darker)`
  - background.shadow `var(--tmspc-background-shadow)`

-}
background : ThemeSpecBackground
background =
    { base = "var(--" ++ namespace ++ "-background)"
    , dark = "var(--" ++ namespace ++ "-background-dark)"
    , darker = "var(--" ++ namespace ++ "-background-darker)"
    , shadow = "var(--" ++ namespace ++ "-background-shadow)"
    }


{-| CSS Variables based on **base** colors.

  - base.base `var(--tmspc-base)`
  - base.dark `var(--tmspc-base-dark)`
  - base.darker `var(--tmspc-base-darker)`
  - base.shadow `var(--tmspc-base-shadow)`

-}
base : ThemeSpecColor
base =
    { base = "var(--" ++ namespace ++ "-base)"
    , light = "var(--" ++ namespace ++ "-base-light)"
    , lighter = "var(--" ++ namespace ++ "-base-lighter)"
    , shadow = "var(--" ++ namespace ++ "-base-shadow)"
    }


{-| CSS Variables based on **accent** colors.

  - accent.base `var(--tmspc-accent)`
  - accent.dark `var(--tmspc-accent-dark)`
  - accent.darker `var(--tmspc-accent-darker)`
  - accent.shadow `var(--tmspc-accent-shadow)`

-}
accent : ThemeSpecColor
accent =
    { base = "var(--" ++ namespace ++ "-accent)"
    , light = "var(--" ++ namespace ++ "-accent-light)"
    , lighter = "var(--" ++ namespace ++ "-accent-lighter)"
    , shadow = "var(--" ++ namespace ++ "-accent-shadow)"
    }


{-| CSS Variables based on **success** colors.

  - success.base `var(--tmspc-success)`
  - success.dark `var(--tmspc-success-dark)`
  - success.darker `var(--tmspc-success-darker)`
  - success.shadow `var(--tmspc-success-shadow)`

-}
success : ThemeSpecColor
success =
    { base = "var(--" ++ namespace ++ "-success)"
    , light = "var(--" ++ namespace ++ "-success-light)"
    , lighter = "var(--" ++ namespace ++ "-success-lighter)"
    , shadow = "var(--" ++ namespace ++ "-success-shadow)"
    }


{-| CSS Variables based on **warning** colors.

  - warning.base `var(--tmspc-warning)`
  - warning.dark `var(--tmspc-warning-dark)`
  - warning.darker `var(--tmspc-warning-darker)`
  - warning.shadow `var(--tmspc-warning-shadow)`

-}
warning : ThemeSpecColor
warning =
    { base = "var(--" ++ namespace ++ "-warning)"
    , light = "var(--" ++ namespace ++ "-warning-light)"
    , lighter = "var(--" ++ namespace ++ "-warning-lighter)"
    , shadow = "var(--" ++ namespace ++ "-warning-shadow)"
    }


{-| CSS Variables based on **danger** colors.

  - danger.base `var(--tmspc-danger)`
  - danger.dark `var(--tmspc-danger-dark)`
  - danger.darker `var(--tmspc-danger-darker)`
  - danger.shadow `var(--tmspc-danger-shadow)`

-}
danger : ThemeSpecColor
danger =
    { base = "var(--" ++ namespace ++ "-danger)"
    , light = "var(--" ++ namespace ++ "-danger-light)"
    , lighter = "var(--" ++ namespace ++ "-danger-lighter)"
    , shadow = "var(--" ++ namespace ++ "-danger-shadow)"
    }


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
            , theme : ThemeSpecColor
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
                    , HA.style "color" props.theme.lighter
                    , HA.style "width" "100%"
                    , HA.style "border" "none"
                    , HA.style "border-radius" borderRadius
                    , HA.style "background-color" props.theme.base
                    , HA.style "font-size" "18px"
                    , HA.style "font-family" fontText
                    , HA.style "margin" "8px 0 0"
                    , HA.style "padding" "12px 24px"
                    , HA.style "box-shadow" ("0 0 8px " ++ props.theme.shadow)
                    , HA.title ("" ++ colorName ++ " / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName ++ "-lighter") ] [ H.text props.label ]
                    , shapes colorName props.theme.light props.theme.lighter
                    ]
                , H.p
                    [ HA.style "padding-top" "12px"
                    , HA.style "margin" "12px 0"
                    , HA.style "padding" "16px 16px"
                    , HA.style "border-radius" borderRadius
                    , HA.style "border-left" ("8px solid " ++ props.theme.light)
                    , HA.style "background-color" props.theme.lighter
                    , HA.style "color" props.theme.base
                    , HA.style "font-size" "14px"
                    , HA.title (props.label ++ "-lighter / border-radius")
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
            , HA.style "border-radius" borderRadiusLarge
            , HA.style "background-color" background.base
            , HA.style "box-shadow" ("0 0 8px " ++ background.shadow)
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
                    [ HA.style "color" base.base
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
                    , HA.style "border-top" ("2px solid " ++ background.darker)
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
                    , HA.style "background-color" background.dark
                    , HA.style "color" base.base
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
                            , HA.style "background" background.darker
                            , HA.title "background-darker / focus (outline)"
                            ]
                            []
                        , H.div
                            [ HA.class (namespace ++ "-sampler-focus")
                            , HA.style "width" "20px"
                            , HA.style "height" "20px"
                            , HA.style "margin" "0 8px"
                            , HA.style "border-radius" "50%"
                            , HA.style "background" base.base
                            , HA.style "outline" ("3px solid " ++ focus)
                            , HA.style "outline-offset" "3px"
                            , HA.title "base / focus (outline)"
                            ]
                            []
                        ]
                    ]
                , H.p
                    [ HA.style "font-size" "14px"
                    , HA.style "color" base.light
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
