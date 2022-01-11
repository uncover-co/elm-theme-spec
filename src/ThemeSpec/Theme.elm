module ThemeSpec.Theme exposing
    ( Theme
    , ThemeColor
    , toString
    )

import ThemeSpec.CSSVariables exposing (namespace)


type alias ThemeColor =
    { base : String
    , light : String
    , dark : String
    , tint : String
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
      focus : String
    , background : ThemeColor
    , color : ThemeColor
    , highlight : ThemeColor
    , success : ThemeColor
    , warning : ThemeColor
    , danger : ThemeColor
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
            , ( label ++ "-dark", .dark themeColor )
            , ( label ++ "-light", .light themeColor )
            , ( label ++ "-tint", .tint themeColor )
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

      -- Colors - Simples
      , ( "focus", theme.focus )
      ]
    , -- Colors – Rich
      [ ( "color", .color )
      , ( "background", .background )
      , ( "highlight", .highlight )
      , ( "success", .success )
      , ( "warning", .warning )
      , ( "danger", .danger )
      ]
        |> List.concatMap colorVars
    ]
        |> List.concat
        |> List.map (\( k, v ) -> "--" ++ namespace ++ "-" ++ k ++ ":" ++ v)
        |> String.join ";"
