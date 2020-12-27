module Test.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Discord.Client (Client, getChannels, login, mkClient)
import Discord.Events (messageEvent, readyEvent)
import Discord.Managers.Channel (Channel, getName)
import Discord.Managers.Manager (fetch)
import Discord.Types (Message)
import Dotenv (loadFile)
import Effect (Effect)
import Effect.Aff (Aff, launchAff_)
import Effect.Class (liftEffect)
import Effect.Class.Console (log)
import Node.Events.EventEmitter (on')
import Node.Process (lookupEnv)

onLogin :: Client -> String -> Effect Unit
onLogin client channelId = do
  launchAff_ $ do 
    channels <- liftEffect $ getChannels client
    channel <- fetch channels channelId :: Aff Channel
    liftEffect $ do
      name <- getName channel
      log name
    pure channel

onMessage :: Message -> Effect Unit
onMessage message = do
  log message.content

type TestConfigs = {
  token :: String,
  testChannelId :: String
}

loadTestConfigs :: Effect (Maybe TestConfigs)
loadTestConfigs = do
  mDiscordToken <- lookupEnv "TEST_DISCORD_TOKEN"
  mDiscordChannelId <- lookupEnv "TEST_DISCORD_CHANNEL_ID"
  pure do
    discordToken <- mDiscordToken
    discordChannelId <- mDiscordChannelId
    pure { token: discordToken, testChannelId: discordChannelId }

main :: Effect Unit
main = launchAff_ do
  _ <- loadFile
  liftEffect do
    maybeTestConfigs <- loadTestConfigs
    case maybeTestConfigs of
      Nothing -> log "failed to load test configs"
      Just testConfigs -> do
        client <- mkClient
        log "logging in..."
        login client testConfigs.token
        _ <- on' readyEvent (onLogin client testConfigs.testChannelId) client
        _ <- on' messageEvent onMessage client
        pure unit