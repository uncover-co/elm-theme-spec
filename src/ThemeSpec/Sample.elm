module ThemeSpec.Sample exposing (sample)

import Html as H
import Html.Attributes as HA
import ThemeSpec.CSSVariables exposing (..)


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
                    , HA.style "margin-left" "12px"
                    , HA.title ("" ++ colorName ++ "-dark")
                    ]
                    []
                ]

        colorSample :
            { label : String
            , base : String
            , dark : String
            , light : String
            , tint : String
            , contrast : String
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
                    , HA.style "color" props.contrast
                    , HA.style "width" "100%"
                    , HA.style "border" "none"
                    , HA.style "border-radius" borderRadius
                    , HA.style "background-color" props.base
                    , HA.style "font-size" "18px"
                    , HA.style "font-family" fontText
                    , HA.style "margin" "8px 0 0"
                    , HA.style "padding" "12px"
                    , HA.style "box-shadow" ("0 0 8px " ++ props.shadow)
                    , HA.title ("" ++ colorName ++ " / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName ++ "-contrast") ] [ H.text props.label ]
                    , shapes colorName props.light props.dark
                    ]
                , H.p
                    [ HA.style "padding-top" "12px"
                    , HA.style "margin" "12px 0"
                    , HA.style "padding" "16px 16px"
                    , HA.style "border-radius" borderRadius
                    , HA.style "background-color" props.tint
                    , HA.style "color" props.dark
                    , HA.style "font-size" "14px"
                    , HA.title (colorName ++ "-tint / border-radius")
                    ]
                    [ H.span [ HA.title ("font-text / " ++ colorName ++ "-dark") ]
                        [ H.text "Tinted backgrounds can be used to display information with semantic coloring." ]
                    ]
                ]
    in
    H.div
        [ HA.style "padding" "40px"
        , HA.style "border-radius" borderRadiusLarge
        , HA.style "background-color" background
        , HA.style "box-shadow" ("inset 0 0 8px " ++ backgroundShadow)
        , HA.style "font-family" fontText
        , HA.style "font-size" "16px"
        , HA.title "background / border-radius-large"
        ]
        [ H.div []
            [ H.h1
                [ HA.style "font-family" fontTitle
                , HA.style "font-size" "40px"
                , HA.style "color" colorDark
                , HA.style "margin" "0px"
                , HA.style "padding-bottom" "12px"
                , HA.title "font-title / color-dark"
                ]
                [ H.text "Theme Sampler" ]
            , H.p
                [ HA.style "color" color
                , HA.style "margin" "0 0 16px"
                , HA.title "font-text / color"
                ]
                [ H.text "This sampler is using "
                , H.span
                    [ HA.style "color" colorDark
                    , HA.style "font-weight" "bold"
                    , HA.title "font-text / color-dark"
                    ]
                    [ H.text "all available color and styles" ]
                , H.text " in your theme. You can hover over any element to figure out it's base styles."
                ]
            , H.hr
                [ HA.style "margin" "20px 0"
                , HA.style "border" "none"
                , HA.style "border-top" ("2px solid " ++ backgroundLight)
                , HA.title "background-light"
                ]
                []
            , H.div
                [ HA.style "display" "flex"
                , HA.style "align-items" "center"
                , HA.style "justify-content" "space-between"
                , HA.style "margin" "0"
                , HA.style "padding" "16px 16px"
                , HA.style "border-radius" borderRadius
                , HA.style "background-color" backgroundTint
                , HA.style "color" backgroundContrast
                , HA.style "font-size" "14px"
                , HA.title "background-tint / border-radius"
                ]
                [ H.p
                    [ HA.style "margin" "0"
                    , HA.title "font-text / background-contrast"
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
                        , HA.style "border-radius" "50%"
                        , HA.style "background" backgroundLight
                        , HA.title "background-light / focus (outline)"
                        ]
                        []
                    , H.div
                        [ HA.class (namespace ++ "-sampler-focus")
                        , HA.style "width" "20px"
                        , HA.style "height" "20px"
                        , HA.style "margin" "0 8px"
                        , HA.style "border-radius" "50%"
                        , HA.style "background" backgroundDark
                        , HA.title "background-dark / focus (outline)"
                        ]
                        []
                    , H.div
                        [ HA.class (namespace ++ "-sampler-focus")
                        , HA.style "width" "20px"
                        , HA.style "height" "20px"
                        , HA.style "margin" "0 8px"
                        , HA.style "border-radius" "50%"
                        , HA.style "background" backgroundDark
                        , HA.style "outline" ("3px solid " ++ focus)
                        , HA.style "outline-offset" "3px"
                        , HA.title "background-dark / focus (outline)"
                        ]
                        []
                    ]
                ]
            , H.p
                [ HA.style "font-size" "14px"
                , HA.style "color" colorLight
                , HA.style "margin" "16px 0 40px"
                , HA.title "color-light"
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
                { label = "Highlight"
                , base = highlight
                , light = highlightLight
                , dark = highlightDark
                , tint = highlightTint
                , contrast = highlightContrast
                , shadow = highlightShadow
                }
            , colorSample
                { label = "Success"
                , base = success
                , light = successLight
                , dark = successDark
                , tint = successTint
                , contrast = successContrast
                , shadow = successShadow
                }
            , colorSample
                { label = "Warning"
                , base = warning
                , light = warningLight
                , dark = warningDark
                , tint = warningTint
                , contrast = warningContrast
                , shadow = warningShadow
                }
            , colorSample
                { label = "Danger"
                , base = danger
                , light = dangerLight
                , dark = dangerDark
                , tint = dangerTint
                , contrast = dangerContrast
                , shadow = dangerShadow
                }
            , colorSample
                { label = "Color"
                , base = color
                , light = colorLight
                , dark = colorDark
                , tint = colorTint
                , contrast = colorContrast
                , shadow = colorShadow
                }
            ]
        ]
