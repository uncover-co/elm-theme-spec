module Main exposing (main)

import ElmBook exposing (Book, book, withChapters)
import ElmBook.Chapter exposing (chapter, renderComponentList)
import ThemeSpec


baseTheme : ThemeSpec.Theme
baseTheme =
    ThemeSpec.lightTheme


darkTheme : ThemeSpec.Theme
darkTheme =
    ThemeSpec.darkTheme


main : Book ()
main =
    book "ThemeSpec"
        |> withChapters
            [ chapter "Sampler"
                |> renderComponentList
                    [ ( "Light Theme"
                      , ThemeSpec.provider
                            { light = baseTheme
                            , dark = Nothing
                            }
                            []
                            [ ThemeSpec.sample
                            ]
                      )
                    , ( "Dark Theme"
                      , ThemeSpec.provider
                            { light = darkTheme
                            , dark = Nothing
                            }
                            []
                            [ ThemeSpec.sample
                            ]
                      )
                    , ( "Dynamic"
                      , ThemeSpec.provider
                            { light = baseTheme
                            , dark = Just ( Just "elm-book-dark-mode", darkTheme )
                            }
                            []
                            [ ThemeSpec.sample
                            ]
                      )
                    ]
            ]
