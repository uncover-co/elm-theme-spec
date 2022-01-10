# ThemeSpec

A reusable theme specification for web applications.

ThemeSpec is a theme specification that can be used across a variety of projects to quickly theme them based on CSS vars. Themes are scoped and multiple can be used in the same page of an application. ThemeSpec is fully compatible with dark mode and any theme can have dark variants toggled through system preferences or CSS classes.

## Setup

After defining one or more themes you can "provide" them through your application.

```elm
import ThemeSpec as TS
import Html exposing (..)
import Html.Attributes exposing (..)


main : Html msg
main =
    div []
        [ TS.globalProvider TS.lightTheme
        , ...
        , p
            [ style "color" TS.color ]
            [ text "My color won't change if the user goes to dark mode." ]
        , ...
        , TS.providerWithDarkMode
            { light = TS.lightTheme
            , dark = TS.darkTheme
            , strategy = TS.ClassStrategy "is-dark"
            }
            []
            [ p
                [ style "background" TS.background ]
                [ text "My color will change based on the user's dark mode!" ]
            ]
        ]
```
