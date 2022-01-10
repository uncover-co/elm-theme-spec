module ThemeSpec.Providers exposing
    ( globalProvider
    , provider
    )

import Html as H
import Html.Attributes as HA
import ThemeSpec.CSSVariables exposing (namespace)
import ThemeSpec.Hash
import ThemeSpec.Theme exposing (Theme, toString)



-- Hash


hashString : String -> Int
hashString =
    ThemeSpec.Hash.hashString 0



-- Default


globalProvider :
    { light : Theme
    , dark : Maybe ( Maybe String, Theme )
    }
    -> H.Html msg
globalProvider props =
    H.div []
        [ H.node "style"
            []
            [ H.text ("body { " ++ toString props.light ++ " }") ]
        , case props.dark of
            Just ( maybeDarkClass, dark ) ->
                case maybeDarkClass of
                    Just darkClass ->
                        H.node "style"
                            []
                            [ H.text ("." ++ darkClass ++ " { " ++ toString dark ++ " }") ]

                    Nothing ->
                        H.node "style"
                            []
                            [ H.text ("@media (prefers-color-scheme: dark) { body { " ++ toString dark ++ " } }") ]

            Nothing ->
                H.text ""
        ]


provider :
    { light : Theme
    , dark : Maybe ( Maybe String, Theme )
    }
    -> List (H.Attribute msg)
    -> List (H.Html msg)
    -> H.Html msg
provider props attrs children =
    let
        lightString : String
        lightString =
            toString props.light
    in
    case props.dark of
        Just ( maybeDarkClass, dark ) ->
            let
                darkString =
                    toString dark

                targetClass =
                    darkString
                        |> hashString
                        |> (\hash -> namespace ++ "-" ++ String.fromInt hash)
            in
            case maybeDarkClass of
                Just darkClass ->
                    H.div
                        (HA.class targetClass :: attrs)
                        (H.node
                            "style"
                            []
                            [ H.text ("." ++ targetClass ++ " { " ++ lightString ++ " } ." ++ darkClass ++ " ." ++ targetClass ++ " { " ++ darkString ++ " }") ]
                            :: children
                        )

                Nothing ->
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
