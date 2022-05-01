module Main exposing (main)

import ElmBook exposing (Book, book, withChapters)
import ElmBook.Chapter exposing (chapter, renderComponent)
import Html exposing (..)
import ThemeProvider
import ThemeSpec exposing (darkTheme, lightTheme)


main : Book ()
main =
    book "ThemeSpec"
        |> withChapters
            [ chapter "Global"
                |> renderComponent
                    (div []
                        [ ThemeProvider.globalProvider lightTheme
                        , ThemeSpec.sample
                        ]
                    )
            , chapter "Global Dark Mode"
                |> renderComponent
                    (div []
                        [ ThemeProvider.globalProviderWithDarkMode
                            { light = lightTheme
                            , dark = darkTheme
                            , strategy = ThemeProvider.ClassStrategy "elm-book-dark-mode"
                            }
                        , ThemeSpec.sample
                        ]
                    )
            , chapter "Global Dark Mode (System)"
                |> renderComponent
                    (div []
                        [ ThemeProvider.globalProviderWithDarkMode
                            { light = lightTheme
                            , dark = darkTheme
                            , strategy = ThemeProvider.SystemStrategy
                            }
                        , ThemeSpec.sample
                        ]
                    )
            , chapter "Provider"
                |> renderComponent
                    (ThemeProvider.provider
                        lightTheme
                        []
                        [ ThemeSpec.sample
                        , ThemeProvider.provider darkTheme
                            []
                            [ ThemeSpec.sample ]
                        ]
                    )
            , chapter "Provider Dark Mode"
                |> renderComponent
                    (ThemeProvider.providerWithDarkMode
                        { light = lightTheme
                        , dark = darkTheme
                        , strategy = ThemeProvider.ClassStrategy "elm-book-dark-mode"
                        }
                        []
                        [ ThemeSpec.sample
                        , ThemeProvider.providerWithDarkMode
                            { light = darkTheme
                            , dark = lightTheme
                            , strategy = ThemeProvider.ClassStrategy "elm-book-dark-mode"
                            }
                            []
                            [ ThemeSpec.sample ]
                        ]
                    )
            , chapter "Provider Dark Mode (System)"
                |> renderComponent
                    (div []
                        [ ThemeProvider.providerWithDarkMode
                            { light = lightTheme
                            , dark = darkTheme
                            , strategy = ThemeProvider.SystemStrategy
                            }
                            []
                            [ ThemeSpec.sample
                            , ThemeProvider.providerWithDarkMode
                                { light = darkTheme
                                , dark = lightTheme
                                , strategy = ThemeProvider.SystemStrategy
                                }
                                []
                                [ ThemeSpec.sample ]
                            ]
                        ]
                    )
            ]
