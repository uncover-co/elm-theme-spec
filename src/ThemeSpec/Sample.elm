module ThemeSpec.Sample exposing (sample)

import Html as H
import Html.Attributes as HA
import ThemeSpec.CSSVariables exposing (..)


sample : H.Html msg
sample =
    let
        btnStyles :
            { id : String
            , base : String
            , hover : String
            , active : String
            }
            -> H.Html msg
        btnStyles props =
            H.node "style"
                []
                [ H.text
                    ("#"
                        ++ props.id
                        ++ "{ background: "
                        ++ props.base
                        ++ "; } "
                        ++ "#"
                        ++ props.id
                        ++ ":hover { background: "
                        ++ props.hover
                        ++ "; }"
                        ++ "#"
                        ++ props.id
                        ++ ":active { background: "
                        ++ props.active
                        ++ "; }"
                    )
                ]

        btn :
            { id : String
            , label : String
            , color : String
            , background : String
            , hover : String
            , active : String
            , shadow : String
            }
            -> H.Html msg
        btn props =
            H.div []
                [ btnStyles
                    { id = namespace ++ "-" ++ props.id
                    , base = props.background
                    , hover = props.hover
                    , active = props.active
                    }
                , H.button
                    [ HA.id (namespace ++ "-" ++ props.id)
                    , HA.style "display" "flex"
                    , HA.style "align-items" "center"
                    , HA.style "justify-content" "space-between"
                    , HA.style "cursor" "pointer"
                    , HA.style "color" props.color
                    , HA.style "width" "100%"
                    , HA.style "border" "none"
                    , HA.style "border-radius" borderRadius
                    , HA.style "font-size" "18px"
                    , HA.style "font-family" fontText
                    , HA.style "margin" "8px 0 0"
                    , HA.style "padding" "12px"
                    , HA.style "box-shadow" ("0 0 8px " ++ props.shadow)
                    ]
                    [ H.span [] [ H.text props.label ]
                    , H.span []
                        [ H.span
                            [ HA.style "display" "inline-block"
                            , HA.style "background-color" props.hover
                            , HA.style "width" "20px"
                            , HA.style "height" "20px"
                            , HA.style "border-radius" "50%"
                            , HA.style "margin" "0 8px"
                            ]
                            []
                        , H.span
                            [ HA.style "display" "inline-block"
                            , HA.style "background-color" props.active
                            , HA.style "width" "20px"
                            , HA.style "height" "20px"
                            , HA.style "border-radius" "50%"
                            , HA.style "margin" "0 8px"
                            ]
                            []
                        ]
                    ]
                ]

        colorSample :
            { id : String
            , label : String
            , base : String
            , dark : String
            , light : String
            , tint : String
            , contrast : String
            , shadow : String
            }
            -> H.Html msg
        colorSample props =
            H.div
                [ HA.style "margin" "20px 0"
                ]
                [ btn
                    { id = props.id
                    , label = props.label
                    , color = props.contrast
                    , background = props.base
                    , hover = props.light
                    , active = props.dark
                    , shadow = props.shadow
                    }
                , H.p
                    [ HA.style "padding-top" "12px"
                    , HA.style "margin" "12px 0"
                    , HA.style "padding" "16px 16px"
                    , HA.style "border-radius" borderRadius
                    , HA.style "background-color" props.tint
                    , HA.style "color" props.dark
                    , HA.style "font-size" "14px"
                    ]
                    [ H.text "Tinted backgrounds can be used to display information with semantic coloring."
                    ]
                ]
    in
    H.div
        [ HA.style "padding" "40px"
        , HA.style "border-radius" borderRadiusLarge
        , HA.style "background-color" background
        , HA.style "box-shadow" ("inset 0 0 8px " ++ colorShadow)
        , HA.style "font-family" fontText
        , HA.style "font-size" "16px"
        ]
        [ H.div []
            [ H.div
                [ HA.style "display" "flex"
                , HA.style "justify-content" "space-between"
                , HA.style "align-items" "center"
                , HA.style "padding-bottom" "20px"
                ]
                [ H.h1
                    [ HA.style "font-family" fontTitle
                    , HA.style "font-size" "40px"
                    , HA.style "color" colorDark
                    , HA.style "margin" "0px"
                    ]
                    [ H.text "Theme Sampler" ]
                ]
            , H.p
                [ HA.style "color" color
                , HA.style "margin" "0 0 16px"
                ]
                [ H.text "This sampler is using all available color and styles in your theme."
                ]
            , H.hr
                [ HA.style "margin" "20px 0"
                , HA.style "border" "none"
                , HA.style "border-top" ("2px solid " ++ colorTint)
                ]
                []
            , H.p
                [ HA.style "font-size" "14px"
                , HA.style "color" colorLight
                , HA.style "margin" "16px 0 40px"
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
                { id = "highlight"
                , label = "Highlight"
                , base = highlight
                , light = highlightLight
                , dark = highlightDark
                , tint = highlightTint
                , contrast = highlightContrast
                , shadow = highlightShadow
                }
            , colorSample
                { id = "success"
                , label = "Success"
                , base = success
                , light = successLight
                , dark = successDark
                , tint = successTint
                , contrast = successContrast
                , shadow = successShadow
                }
            , colorSample
                { id = "warning"
                , label = "Warning"
                , base = warning
                , light = warningLight
                , dark = warningDark
                , tint = warningTint
                , contrast = warningContrast
                , shadow = warningShadow
                }
            , colorSample
                { id = "danger"
                , label = "Danger"
                , base = danger
                , light = dangerLight
                , dark = dangerDark
                , tint = dangerTint
                , contrast = dangerContrast
                , shadow = dangerShadow
                }
            ]
        , H.div
            [ HA.style "display" "flex"
            , HA.style "align-items" "center"
            , HA.style "justify-content" "space-between"
            , HA.style "margin" "0"
            , HA.style "padding" "16px 16px"
            , HA.style "border-radius" borderRadius
            , HA.style "background-color" colorTint
            , HA.style "color" color
            , HA.style "font-size" "14px"
            ]
            [ H.p [ HA.style "margin" "0" ]
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
                    , HA.style "background" background
                    ]
                    []
                , H.div
                    [ HA.class (namespace ++ "-sampler-focus")
                    , HA.style "width" "20px"
                    , HA.style "height" "20px"
                    , HA.style "margin" "0 8px"
                    , HA.style "border-radius" "50%"
                    , HA.style "background" background
                    ]
                    []
                , H.div
                    [ HA.class (namespace ++ "-sampler-focus")
                    , HA.style "width" "20px"
                    , HA.style "height" "20px"
                    , HA.style "margin" "0 8px"
                    , HA.style "border-radius" "50%"
                    , HA.style "background" background
                    , HA.style "outline" ("3px solid " ++ focus)
                    , HA.style "outline-offset" "3px"
                    ]
                    []
                ]
            ]
        ]
