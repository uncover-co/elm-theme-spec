module Main exposing (main)

import ElmBook exposing (Book, book, withChapterGroups, withChapters)
import ElmBook.Chapter exposing (chapter, render, renderComponent)
import ElmBook.ComponentOptions
import Html exposing (..)
import Html.Attributes exposing (..)
import ThemeProvider
import ThemeSpec exposing (darkTheme, lightTheme)


viewSideBySide : Html msg -> Html msg -> Html msg
viewSideBySide left right =
    div [ style "display" "flex" ]
        [ div [ style "flex-grow" "1" ] [ left ]
        , div [ style "flex-grow" "1" ] [ right ]
        ]


main : Book ()
main =
    book "ThemeSpec"
        |> withChapterGroups
            [ ( "Theme Spec"
              , [ chapter "About Theme Spec"
                    |> render """
A common theme specification.

> **Background**
- `base` e.g. the main background color
- `light` e.g. small callouts and details
- `contrast` e.g. usually darker than `light`. used as the background underneath your main background on card lists, etc.

> **Baseline**
- `base` e.g. the main text color
- `light` e.g. the color used for faded text
- `contrast` e.g. used for things ui details with higher contrast

> **Primary**
- `base` e.g. the main button color
- `light` e.g. used for branded icons
- `contrast` e.g. the text on top of the main button color

> **Secondary**
- `base` e.g. the secondary button color. commonly similar to the baseline color.
- `light` e.g. used for icons and such
- `contrast` e.g. the color on top of the button

"""
                ]
              )
            , ( "Theme Provider"
              , [ chapter "Global"
                    |> renderComponent
                        (div []
                            [ ThemeProvider.globalProvider (ThemeSpec.theme lightTheme)
                            , ThemeSpec.sample
                            ]
                        )
                , chapter "Global Dark Mode"
                    |> renderComponent
                        (div []
                            [ ThemeProvider.globalProviderWithDarkMode
                                { light = ThemeSpec.theme lightTheme
                                , dark = ThemeSpec.theme darkTheme
                                , strategy = ThemeProvider.ClassStrategy "elm-book-dark-mode"
                                }
                            , ThemeSpec.sample
                            ]
                        )
                , chapter "Global Dark Mode (System)"
                    |> renderComponent
                        (div []
                            [ ThemeProvider.globalProviderWithDarkMode
                                { light = ThemeSpec.theme lightTheme
                                , dark = ThemeSpec.theme darkTheme
                                , strategy = ThemeProvider.SystemStrategy
                                }
                            , ThemeSpec.sample
                            ]
                        )
                , chapter "Provider"
                    |> ElmBook.Chapter.withComponentOptions [ ElmBook.ComponentOptions.fullWidth True ]
                    |> renderComponent
                        (ThemeProvider.provider (ThemeSpec.theme lightTheme)
                            []
                            [ viewSideBySide
                                ThemeSpec.sample
                                (ThemeProvider.provider (ThemeSpec.theme darkTheme)
                                    []
                                    [ ThemeSpec.sample ]
                                )
                            ]
                        )
                , chapter "Provider Dark Mode"
                    |> ElmBook.Chapter.withComponentOptions [ ElmBook.ComponentOptions.fullWidth True ]
                    |> renderComponent
                        (ThemeProvider.providerWithDarkMode
                            { light = ThemeSpec.theme lightTheme
                            , dark = ThemeSpec.theme darkTheme
                            , strategy = ThemeProvider.ClassStrategy "elm-book-dark-mode"
                            }
                            []
                            [ viewSideBySide
                                ThemeSpec.sample
                                (ThemeProvider.providerWithDarkMode
                                    { light = ThemeSpec.theme darkTheme
                                    , dark = ThemeSpec.theme lightTheme
                                    , strategy = ThemeProvider.ClassStrategy "elm-book-dark-mode"
                                    }
                                    []
                                    [ ThemeSpec.sample ]
                                )
                            ]
                        )
                , chapter "Provider Dark Mode (System)"
                    |> ElmBook.Chapter.withComponentOptions [ ElmBook.ComponentOptions.fullWidth True ]
                    |> renderComponent
                        (div []
                            [ ThemeProvider.providerWithDarkMode
                                { light = ThemeSpec.theme lightTheme
                                , dark = ThemeSpec.theme darkTheme
                                , strategy = ThemeProvider.SystemStrategy
                                }
                                []
                                [ viewSideBySide
                                    ThemeSpec.sample
                                    (ThemeProvider.providerWithDarkMode
                                        { light = ThemeSpec.theme darkTheme
                                        , dark = ThemeSpec.theme lightTheme
                                        , strategy = ThemeProvider.SystemStrategy
                                        }
                                        []
                                        [ ThemeSpec.sample ]
                                    )
                                ]
                            ]
                        )
                ]
              )
            ]
