module ThemeSpec.CSSVariables exposing
    ( background
    , backgroundContrast
    , backgroundDark
    , backgroundLight
    , backgroundShadow
    , backgroundTint
    , borderRadius
    , borderRadiusLarge
    , color
    , colorContrast
    , colorDark
    , colorLight
    , colorShadow
    , colorTint
    , danger
    , dangerContrast
    , dangerDark
    , dangerLight
    , dangerShadow
    , dangerTint
    , focus
    , fontCode
    , fontText
    , fontTitle
    , highlight
    , highlightContrast
    , highlightDark
    , highlightLight
    , highlightShadow
    , highlightTint
    , namespace
    , success
    , successContrast
    , successDark
    , successLight
    , successShadow
    , successTint
    , warning
    , warningContrast
    , warningDark
    , warningLight
    , warningShadow
    , warningTint
    )


namespace : String
namespace =
    "tmspc"


fontTitle : String
fontTitle =
    "var(--" ++ namespace ++ "-font-title)"


fontText : String
fontText =
    "var(--" ++ namespace ++ "-font-text)"


fontCode : String
fontCode =
    "var(--" ++ namespace ++ "-font-code)"


borderRadius : String
borderRadius =
    "var(--" ++ namespace ++ "-border-radius)"


borderRadiusLarge : String
borderRadiusLarge =
    "var(--" ++ namespace ++ "-border-radius-large)"


background : String
background =
    "var(--" ++ namespace ++ "-background-base)"


backgroundDark : String
backgroundDark =
    "var(--" ++ namespace ++ "-background-dark)"


backgroundLight : String
backgroundLight =
    "var(--" ++ namespace ++ "-background-light)"


backgroundTint : String
backgroundTint =
    "var(--" ++ namespace ++ "-background-tint)"


backgroundContrast : String
backgroundContrast =
    "var(--" ++ namespace ++ "-background-contrast)"


backgroundShadow : String
backgroundShadow =
    "var(--" ++ namespace ++ "-background-shadow)"


color : String
color =
    "var(--" ++ namespace ++ "-color-base)"


colorDark : String
colorDark =
    "var(--" ++ namespace ++ "-color-dark)"


colorLight : String
colorLight =
    "var(--" ++ namespace ++ "-color-light)"


colorTint : String
colorTint =
    "var(--" ++ namespace ++ "-color-tint)"


colorContrast : String
colorContrast =
    "var(--" ++ namespace ++ "-color-contrast)"


colorShadow : String
colorShadow =
    "var(--" ++ namespace ++ "-color-shadow)"


focus : String
focus =
    "var(--" ++ namespace ++ "-focus)"


highlight : String
highlight =
    "var(--" ++ namespace ++ "-highlight-base)"


highlightDark : String
highlightDark =
    "var(--" ++ namespace ++ "-highlight-dark)"


highlightLight : String
highlightLight =
    "var(--" ++ namespace ++ "-highlight-light)"


highlightTint : String
highlightTint =
    "var(--" ++ namespace ++ "-highlight-tint)"


highlightContrast : String
highlightContrast =
    "var(--" ++ namespace ++ "-highlight-contrast)"


highlightShadow : String
highlightShadow =
    "var(--" ++ namespace ++ "-highlight-shadow)"


success : String
success =
    "var(--" ++ namespace ++ "-success-base)"


successDark : String
successDark =
    "var(--" ++ namespace ++ "-success-dark)"


successLight : String
successLight =
    "var(--" ++ namespace ++ "-success-light)"


successTint : String
successTint =
    "var(--" ++ namespace ++ "-success-tint)"


successContrast : String
successContrast =
    "var(--" ++ namespace ++ "-success-contrast)"


successShadow : String
successShadow =
    "var(--" ++ namespace ++ "-success-shadow)"


warning : String
warning =
    "var(--" ++ namespace ++ "-warning-base)"


warningDark : String
warningDark =
    "var(--" ++ namespace ++ "-warning-dark)"


warningLight : String
warningLight =
    "var(--" ++ namespace ++ "-warning-light)"


warningTint : String
warningTint =
    "var(--" ++ namespace ++ "-warning-tint)"


warningContrast : String
warningContrast =
    "var(--" ++ namespace ++ "-warning-contrast)"


warningShadow : String
warningShadow =
    "var(--" ++ namespace ++ "-warning-shadow)"


danger : String
danger =
    "var(--" ++ namespace ++ "-danger-base)"


dangerDark : String
dangerDark =
    "var(--" ++ namespace ++ "-danger-dark)"


dangerLight : String
dangerLight =
    "var(--" ++ namespace ++ "-danger-light)"


dangerTint : String
dangerTint =
    "var(--" ++ namespace ++ "-danger-tint)"


dangerContrast : String
dangerContrast =
    "var(--" ++ namespace ++ "-danger-contrast)"


dangerShadow : String
dangerShadow =
    "var(--" ++ namespace ++ "-danger-shadow)"
