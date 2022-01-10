module ThemeSpec exposing
    ( Theme, ThemeColor
    , lightTheme, darkTheme
    , globalProvider, provider, globalProviderWithDarkMode, providerWithDarkMode
    , sample
    , background, borderRadius, borderRadiusLarge, color, colorContrast, colorDark, colorLight, colorShadow, colorTint, danger, dangerContrast, dangerDark, dangerLight, dangerShadow, dangerTint, focus, fontCode, fontText, fontTitle, highlight, highlightContrast, highlightDark, highlightLight, highlightShadow, highlightTint, success, successContrast, successDark, successLight, successShadow, successTint, warning, warningContrast, warningDark, warningLight, warningShadow, warningTint
    , toString
    , DarkModeStrategy(..)
    )

{-| ThemeSpec is a theme specification that can be used across a variety of projects to quickly theme them based on CSS vars. Themes are scoped and multiple can be used at the same time in an application. ThemeSpec is fully compatible with darkmode and any theme can have dark variants.


# Theme

@docs Theme, ThemeColor


# Default Themes

@docs lightTheme, darkTheme


# Setup

@docs globalProvider, provider, globalProviderWithDarkMode, providerWithDarkMode


# Theme Sample

@docs sample


# Theme Variables

@docs background, borderRadius, borderRadiusLarge, color, colorContrast, colorDark, colorLight, colorShadow, colorTint, danger, dangerContrast, dangerDark, dangerLight, dangerShadow, dangerTint, focus, fontCode, fontText, fontTitle, highlight, highlightContrast, highlightDark, highlightLight, highlightShadow, highlightTint, success, successContrast, successDark, successLight, successShadow, successTint, warning, warningContrast, warningDark, warningLight, warningShadow, warningTint


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
    , background : String
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
    , background = "#fdfdfd"
    , color =
        { base = "#555"
        , dark = "#333"
        , light = "#999"
        , tint = "#eaeaea"
        , contrast = "#fff"
        , shadow = "#dfdfdf"
        }
    , highlight =
        { base = "#09f"
        , dark = "#0291f0"
        , light = "#1aa3ff"
        , tint = "#e8f3ff"
        , contrast = "#fff"
        , shadow = "#9cf"
        }
    , success =
        { base = "#4ac800"
        , dark = "#47be02"
        , light = "#55d00d"
        , tint = "#eef7e9"
        , contrast = "#fff"
        , shadow = "#8ed466"
        }
    , warning =
        { base = "#fbb300"
        , dark = "#f3ad02"
        , light = "#ffba0e"
        , tint = "#fbf7eb"
        , contrast = "#fff"
        , shadow = "#f5c95b"
        }
    , danger =
        { base = "#ff4d4f"
        , dark = "#f24648"
        , light = "#ff6264"
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
    , background = "#20232a"
    , color =
        { base = "#ddd"
        , dark = "#fff"
        , light = "#aaa"
        , tint = "#444"
        , contrast = "#333"
        , shadow = "#202020"
        }
    , highlight =
        { base = "#09f"
        , dark = "#0291f0"
        , light = "#1aa3ff"
        , tint = "#2d4662"
        , contrast = "#fff"
        , shadow = "#2e69a4"
        }
    , success =
        { base = "#4ac800"
        , dark = "#47be02"
        , light = "#55d00d"
        , tint = "#354b29"
        , contrast = "#fff"
        , shadow = "#549d2a"
        }
    , warning =
        { base = "#fbb300"
        , dark = "#f3ad02"
        , light = "#ffba0e"
        , tint = "#59513a"
        , contrast = "#fff"
        , shadow = "#b79543"
        }
    , danger =
        { base = "#ff4d4f"
        , dark = "#f24648"
        , light = "#ff6264"
        , tint = "#5d383c"
        , contrast = "#fff"
        , shadow = "#c75657"
        }
    }



-- Providers


{-| -}
toString : Theme -> String
toString =
    ThemeSpec.Theme.toString



-- Hash


hashString : String -> Int
hashString =
    ThemeSpec.Hash.hashString 0



-- Default


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


{-| -}
fontTitle : String
fontTitle =
    CSS.fontTitle


{-| -}
fontText : String
fontText =
    CSS.fontText


{-| -}
fontCode : String
fontCode =
    CSS.fontCode


{-| -}
borderRadius : String
borderRadius =
    CSS.borderRadius


{-| -}
borderRadiusLarge : String
borderRadiusLarge =
    CSS.borderRadiusLarge


{-| -}
background : String
background =
    CSS.background


{-| -}
color : String
color =
    CSS.color


{-| -}
colorDark : String
colorDark =
    CSS.colorDark


{-| -}
colorLight : String
colorLight =
    CSS.colorLight


{-| -}
colorTint : String
colorTint =
    CSS.colorTint


{-| -}
colorContrast : String
colorContrast =
    CSS.colorContrast


{-| -}
colorShadow : String
colorShadow =
    CSS.colorShadow


{-| -}
focus : String
focus =
    CSS.focus


{-| -}
highlight : String
highlight =
    CSS.highlight


{-| -}
highlightDark : String
highlightDark =
    CSS.highlightDark


{-| -}
highlightLight : String
highlightLight =
    CSS.highlightLight


{-| -}
highlightTint : String
highlightTint =
    CSS.highlightTint


{-| -}
highlightContrast : String
highlightContrast =
    CSS.highlightContrast


{-| -}
highlightShadow : String
highlightShadow =
    CSS.highlightShadow


{-| -}
success : String
success =
    CSS.success


{-| -}
successDark : String
successDark =
    CSS.successDark


{-| -}
successLight : String
successLight =
    CSS.successLight


{-| -}
successTint : String
successTint =
    CSS.successTint


{-| -}
successContrast : String
successContrast =
    CSS.successContrast


{-| -}
successShadow : String
successShadow =
    CSS.successShadow


{-| -}
warning : String
warning =
    CSS.warning


{-| -}
warningDark : String
warningDark =
    CSS.warningDark


{-| -}
warningLight : String
warningLight =
    CSS.warningLight


{-| -}
warningTint : String
warningTint =
    CSS.warningTint


{-| -}
warningContrast : String
warningContrast =
    CSS.warningContrast


{-| -}
warningShadow : String
warningShadow =
    CSS.warningShadow


{-| -}
danger : String
danger =
    CSS.danger


{-| -}
dangerDark : String
dangerDark =
    CSS.dangerDark


{-| -}
dangerLight : String
dangerLight =
    CSS.dangerLight


{-| -}
dangerTint : String
dangerTint =
    CSS.dangerTint


{-| -}
dangerContrast : String
dangerContrast =
    CSS.dangerContrast


{-| -}
dangerShadow : String
dangerShadow =
    CSS.dangerShadow


{-| Renders an element that showcases all the current theme's colors and settings.
-}
sample : H.Html msg
sample =
    ThemeSpec.Sample.sample
