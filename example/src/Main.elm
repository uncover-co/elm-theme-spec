module Main exposing (main)

import ElmBook exposing (Book, book, withChapters, withComponentOptions)
import ElmBook.Chapter exposing (chapter, renderComponent)
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
        |> withChapters
            [ chapter "Global"
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
