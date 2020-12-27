{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "discord"
, dependencies =
  [ "aff"
  , "aff-promise"
  , "console"
  , "dotenv"
  , "effect"
  , "events"
  , "psci-support"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
