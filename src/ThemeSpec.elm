module ThemeSpec exposing
    ( Theme, ThemeColor
    , lightTheme, darkTheme
    , globalProvider, provider
    , globalProviderWithDarkMode, providerWithDarkMode, DarkModeStrategy(..)
    , sample
    , fontTitle, fontText, fontCode, borderRadius, borderRadiusLarge, focus, background, backgroundContrast, backgroundDark, backgroundLight, backgroundShadow, backgroundTint, color, colorContrast, colorDark, colorLight, colorShadow, colorTint, danger, dangerContrast, dangerDark, dangerLight, dangerShadow, dangerTint, highlight, highlightContrast, highlightDark, highlightLight, highlightShadow, highlightTint, success, successContrast, successDark, successLight, successShadow, successTint, warning, warningContrast, warningDark, warningLight, warningShadow, warningTint
    , toString
    )

{-| ThemeSpec is a theme specification that can be used across a variety of projects to quickly theme them based on CSS vars. Themes are scoped and multiple can be used at the same time in an application. ThemeSpec is fully compatible with darkmode and any theme can have dark variants.


# Theme

@docs Theme, ThemeColor


# Default Themes

@docs lightTheme, darkTheme


# Setup

@docs globalProvider, provider


# Dark Mode

@docs globalProviderWithDarkMode, providerWithDarkMode, DarkModeStrategy


# Theme Sample

@docs sample


# Theme Variables

@docs fontTitle, fontText, fontCode, borderRadius, borderRadiusLarge, focus, background, backgroundContrast, backgroundDark, backgroundLight, backgroundShadow, backgroundTint, color, colorContrast, colorDark, colorLight, colorShadow, colorTint, danger, dangerContrast, dangerDark, dangerLight, dangerShadow, dangerTint, highlight, highlightContrast, highlightDark, highlightLight, highlightShadow, highlightTint, success, successContrast, successDark, successLight, successShadow, successTint, warning, warningContrast, warningDark, warningLight, warningShadow, warningTint


# Low-level

@docs toString

-}

import Html as H
import Html.Attributes as HA
import ThemeSpec.CSSVariables as CSS
import ThemeSpec.Hash
import ThemeSpec.Sample
import ThemeSpec.Theme



-- Base


{-| -}
type alias ThemeColor =
    { base : String
    , light : String
    , dark : String
    , tint : String
    , contrast : String
    , shadow : String
    }


{-| -}
type alias Theme =
    { fontTitle : String
    , fontText : String
    , fontCode : String
    , borderRadius : Int
    , borderRadiusLarge : Int
    , focus : String
    , background : ThemeColor
    , color : ThemeColor
    , highlight : ThemeColor
    , success : ThemeColor
    , warning : ThemeColor
    , danger : ThemeColor
    }


{-| -}
lightTheme : Theme
lightTheme =
    { fontTitle = "system-ui, sans-serif"
    , fontText = "system-ui, sans-serif"
    , fontCode = "monospaced"
    , borderRadius = 4
    , borderRadiusLarge = 8
    , focus = "#59e7d2"
    , background =
        { base = "#fdfdfd"
        , dark = "#dadada"
        , light = "#eaeaea"
        , tint = "#f5f5f5"
        , contrast = "#f5f5f5"
        , shadow = "#dfdfdf"
        }
    , color =
        { base = "#666"
        , dark = "#111"
        , light = "#888"
        , tint = "#f5f5f5"
        , contrast = "#fff"
        , shadow = "#aaa"
        }
    , highlight =
        { base = "#09f"
        , dark = "#017fd3"
        , light = "#4db8ff"
        , tint = "#e8f3ff"
        , contrast = "#fff"
        , shadow = "#9cf"
        }
    , success =
        { base = "#4ac800"
        , dark = "#3ea702"
        , light = "#63dd1b"
        , tint = "#eef7e9"
        , contrast = "#fff"
        , shadow = "#8ed466"
        }
    , warning =
        { base = "#fbb300"
        , dark = "#d29500"
        , light = "#ffd469"
        , tint = "#fbf7eb"
        , contrast = "#fff"
        , shadow = "#f5c95b"
        }
    , danger =
        { base = "#ff4d4f"
        , dark = "#e02d2f"
        , light = "#ff9596"
        , tint = "#fef5f6"
        , contrast = "#fff"
        , shadow = "#f98a8b"
        }
    }


{-| -}
darkTheme : Theme
darkTheme =
    { fontTitle = "system-ui, sans-serif"
    , fontText = "system-ui, sans-serif"
    , fontCode = "monospaced"
    , borderRadius = 4
    , borderRadiusLarge = 8
    , focus = "#59e7d2"
    , background =
        { base = "#20232a"
        , dark = "#4b5971"
        , light = "#3c4555"
        , tint = "#2a303b"
        , contrast = "#17191e"
        , shadow = "#111111"
        }
    , color =
        { base = "#c7cbe6"
        , dark = "#fff"
        , light = "#828fa1"
        , tint = "#3a3e4b"
        , contrast = "#333"
        , shadow = "#6e7580"
        }
    , highlight =
        { base = "#09f"
        , dark = "#4db8ff"
        , light = "#017fd3"
        , tint = "#2d4662"
        , contrast = "#00385e"
        , shadow = "#2e69a4"
        }
    , success =
        { base = "#4ac800"
        , dark = "#63dd1b"
        , light = "#3ea702"
        , tint = "#354b29"
        , contrast = "#1e5001"
        , shadow = "#37651c"
        }
    , warning =
        { base = "#fbb300"
        , dark = "#ffd469"
        , light = "#d29500"
        , tint = "#59513a"
        , contrast = "#654800"
        , shadow = "#7f6831"
        }
    , danger =
        { base = "#ff4d4f"
        , dark = "#ff9596"
        , light = "#e02d2f"
        , tint = "#5d383c"
        , contrast = "#6a0001"
        , shadow = "#893a3b"
        }
    }



-- Providers


{-| Use this if you want to create your own custom providers. This should only be useful for theme-spec interop library authors.
-}
toString : Theme -> String
toString =
    ThemeSpec.Theme.toString



-- Hash


hashString : String -> Int
hashString =
    ThemeSpec.Hash.hashString 0



-- Default


{-| Defines the dark mode strategy.

  - `SystemStrategy` uses the user system settings.
  - `ClassStrategy` uses the presence of a CSS class to determine dark mode.

-}
type DarkModeStrategy
    = SystemStrategy
    | ClassStrategy String


globalProvider_ :
    { light : Theme
    , dark : Maybe Theme
    , strategy : DarkModeStrategy
    }
    -> H.Html msg
globalProvider_ props =
    H.div []
        [ H.node "style"
            []
            [ H.text ("body { " ++ toString props.light ++ " }") ]
        , case props.dark of
            Just dark ->
                case props.strategy of
                    ClassStrategy darkClass ->
                        H.node "style"
                            []
                            [ H.text ("." ++ darkClass ++ " { " ++ toString dark ++ " }") ]

                    SystemStrategy ->
                        H.node "style"
                            []
                            [ H.text ("@media (prefers-color-scheme: dark) { body { " ++ toString dark ++ " } }") ]

            Nothing ->
                H.text ""
        ]


provider_ :
    { light : Theme
    , dark : Maybe Theme
    , strategy : DarkModeStrategy
    }
    -> List (H.Attribute msg)
    -> List (H.Html msg)
    -> H.Html msg
provider_ props attrs children =
    let
        lightString : String
        lightString =
            toString props.light
    in
    case props.dark of
        Just dark ->
            let
                darkString =
                    toString dark

                targetClass =
                    darkString
                        |> hashString
                        |> (\hash -> CSS.namespace ++ "-" ++ String.fromInt hash)
            in
            case props.strategy of
                ClassStrategy darkClass ->
                    H.div
                        (HA.class targetClass :: attrs)
                        (H.node
                            "style"
                            []
                            [ H.text ("." ++ targetClass ++ " { " ++ lightString ++ " } ." ++ darkClass ++ " ." ++ targetClass ++ " { " ++ darkString ++ " }") ]
                            :: children
                        )

                SystemStrategy ->
                    H.div
                        (HA.class targetClass :: attrs)
                        (H.node
                            "style"
                            []
                            [ H.text ("." ++ targetClass ++ " { " ++ lightString ++ " } @media (prefers-color-scheme: dark) { ." ++ targetClass ++ " { " ++ darkString ++ " } }") ]
                            :: children
                        )

        Nothing ->
            H.div (HA.attribute "style" (toString props.light) :: attrs) children


{-| -}
globalProvider : Theme -> H.Html msg
globalProvider theme =
    globalProvider_
        { light = theme
        , dark = Nothing
        , strategy = SystemStrategy
        }


{-| -}
globalProviderWithDarkMode : { light : Theme, dark : Theme, strategy : DarkModeStrategy } -> H.Html msg
globalProviderWithDarkMode props =
    globalProvider_
        { light = props.light
        , dark = Just props.dark
        , strategy = props.strategy
        }


{-| -}
provider :
    Theme
    -> List (H.Attribute msg)
    -> List (H.Html msg)
    -> H.Html msg
provider theme =
    provider_
        { light = theme
        , dark = Nothing
        , strategy = SystemStrategy
        }


{-| -}
providerWithDarkMode :
    { light : Theme, dark : Theme, strategy : DarkModeStrategy }
    -> List (H.Attribute msg)
    -> List (H.Html msg)
    -> H.Html msg
providerWithDarkMode props =
    provider_
        { light = props.light
        , dark = Just props.dark
        , strategy = props.strategy
        }



-- Accessors


{-| `var(--tmspc-font-title)`
-}
fontTitle : String
fontTitle =
    CSS.fontTitle


{-| `var(--tmspc-font-text)`
-}
fontText : String
fontText =
    CSS.fontText


{-| `var(--tmspc-font-code)`
-}
fontCode : String
fontCode =
    CSS.fontCode


{-| `var(--tmspc-border-radius)`

Usually used for the border radius of small elements. (e.g. buttons)

-}
borderRadius : String
borderRadius =
    CSS.borderRadius


{-| `var(--tmspc-border-radius-large)`

Usually used for the border radius of large elements. (e.g. cards)

-}
borderRadiusLarge : String
borderRadiusLarge =
    CSS.borderRadiusLarge


{-| `var(--tmspc-color-base)`
-}
background : String
background =
    CSS.background


{-| `var(--tmspc-background-dark)`
-}
backgroundDark : String
backgroundDark =
    CSS.backgroundDark


{-| `var(--tmspc-background-light)`
-}
backgroundLight : String
backgroundLight =
    CSS.backgroundLight


{-| `var(--tmspc-background-tint)`
-}
backgroundTint : String
backgroundTint =
    CSS.backgroundTint


{-| `var(--tmspc-background-contrast)`
-}
backgroundContrast : String
backgroundContrast =
    CSS.backgroundContrast


{-| `var(--tmspc-background-shadow)`
-}
backgroundShadow : String
backgroundShadow =
    CSS.backgroundShadow


{-| `var(--tmspc-color-base)`
-}
color : String
color =
    CSS.color


{-| `var(--tmspc-color-dark)`
-}
colorDark : String
colorDark =
    CSS.colorDark


{-| `var(--tmspc-color-light)`
-}
colorLight : String
colorLight =
    CSS.colorLight


{-| `var(--tmspc-color-tint)`
-}
colorTint : String
colorTint =
    CSS.colorTint


{-| `var(--tmspc-color-contrast)`
-}
colorContrast : String
colorContrast =
    CSS.colorContrast


{-| `var(--tmspc-color-shadow)`
-}
colorShadow : String
colorShadow =
    CSS.colorShadow


{-| `var(--tmspc-focus)`

Usually used for accessibility purposes.

-}
focus : String
focus =
    CSS.focus


{-| `var(--tmspc-highlight-base)`
-}
highlight : String
highlight =
    CSS.highlight


{-| `var(--tmspc-highlight-dark)`
-}
highlightDark : String
highlightDark =
    CSS.highlightDark


{-| `var(--tmspc-highlight-light)`
-}
highlightLight : String
highlightLight =
    CSS.highlightLight


{-| `var(--tmspc-highlight-tint)`
-}
highlightTint : String
highlightTint =
    CSS.highlightTint


{-| `var(--tmspc-highlight-contrast)`
-}
highlightContrast : String
highlightContrast =
    CSS.highlightContrast


{-| `var(--tmspc-highlight-shadow)`
-}
highlightShadow : String
highlightShadow =
    CSS.highlightShadow


{-| `var(--tmspc-success-base)`
-}
success : String
success =
    CSS.success


{-| `var(--tmspc-success-dark)`
-}
successDark : String
successDark =
    CSS.successDark


{-| `var(--tmspc-success-light)`
-}
successLight : String
successLight =
    CSS.successLight


{-| `var(--tmspc-success-tint)`
-}
successTint : String
successTint =
    CSS.successTint


{-| `var(--tmspc-success-contrast)`
-}
successContrast : String
successContrast =
    CSS.successContrast


{-| `var(--tmspc-success-shadow)`
-}
successShadow : String
successShadow =
    CSS.successShadow


{-| `var(--tmspc-warning-base)`
-}
warning : String
warning =
    CSS.warning


{-| `var(--tmspc-warning-dark)`
-}
warningDark : String
warningDark =
    CSS.warningDark


{-| `var(--tmspc-warning-light)`
-}
warningLight : String
warningLight =
    CSS.warningLight


{-| `var(--tmspc-warning-tint)`
-}
warningTint : String
warningTint =
    CSS.warningTint


{-| `var(--tmspc-warning-contrast)`
-}
warningContrast : String
warningContrast =
    CSS.warningContrast


{-| `var(--tmspc-warning-shadow)`
-}
warningShadow : String
warningShadow =
    CSS.warningShadow


{-| `var(--tmspc-danger-base)`
-}
danger : String
danger =
    CSS.danger


{-| `var(--tmspc-danger-dark)`
-}
dangerDark : String
dangerDark =
    CSS.dangerDark


{-| `var(--tmspc-danger-light)`
-}
dangerLight : String
dangerLight =
    CSS.dangerLight


{-| `var(--tmspc-danger-tint)`
-}
dangerTint : String
dangerTint =
    CSS.dangerTint


{-| `var(--tmspc-danger-contrast)`
-}
dangerContrast : String
dangerContrast =
    CSS.dangerContrast


{-| `var(--tmspc-danger-shadow)`
-}
dangerShadow : String
dangerShadow =
    CSS.dangerShadow


{-| Renders an element that showcases all the current theme's colors and settings.
-}
sample : H.Html msg
sample =
    ThemeSpec.Sample.sample
