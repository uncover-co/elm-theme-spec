module Main exposing (main)

import ElmBook exposing (Book, book, withChapters)
import ElmBook.Chapter exposing (chapter, renderComponent)
import Html exposing (..)
import ThemeSpec exposing (darkTheme, lightTheme)


main : Book ()
main =
    book "ThemeSpec"
        |> withChapters
            [ chapter "Global"
                |> renderComponent
                    (div []
                        [ ThemeSpec.globalProvider lightTheme
                        , ThemeSpec.sample
                        ]
                    )
            , chapter "Global Dark Mode"
                |> renderComponent
                    (div []
                        [ ThemeSpec.globalProviderWithDarkMode
                            { light = lightTheme
                            , dark = darkTheme
                            , class = Just "elm-book-dark-mode"
                            }
                        , ThemeSpec.sample
                        ]
                    )
            , chapter "Global Dark Mode (System)"
                |> renderComponent
                    (div []
                        [ ThemeSpec.globalProviderWithDarkMode
                            { light = lightTheme
                            , dark = darkTheme
                            , class = Nothing
                            }
                        , ThemeSpec.sample
                        ]
                    )
            , chapter "Provider"
                |> renderComponent
                    (div []
                        [ ThemeSpec.provider lightTheme
                            []
                            [ ThemeSpec.sample
                            , ThemeSpec.provider darkTheme
                                []
                                [ ThemeSpec.sample ]
                            ]
                        ]
                    )
            , chapter "Provider Dark Mode"
                |> renderComponent
                    (div []
                        [ ThemeSpec.providerWithDarkMode
                            { light = lightTheme
                            , dark = darkTheme
                            , class = Just "elm-book-dark-mode"
                            }
                            []
                            [ ThemeSpec.sample
                            , ThemeSpec.providerWithDarkMode
                                { light = darkTheme
                                , dark = lightTheme
                                , class = Just "elm-book-dark-mode"
                                }
                                []
                                [ ThemeSpec.sample ]
                            ]
                        ]
                    )
            , chapter "Provider Dark Mode (System)"
                |> renderComponent
                    (div []
                        [ ThemeSpec.providerWithDarkMode
                            { light = lightTheme
                            , dark = darkTheme
                            , class = Nothing
                            }
                            []
                            [ ThemeSpec.sample
                            , ThemeSpec.providerWithDarkMode
                                { light = darkTheme
                                , dark = lightTheme
                                , class = Nothing
                                }
                                []
                                [ ThemeSpec.sample ]
                            ]
                        ]
                    )
            ]
