module Discord.Events where

import Prelude

import Discord.Client (Client)
import Discord.Types (Message)
import Effect (Effect)
import Node.Events.Event (Event(..))

type DiscordEvent listener = Event Client listener

readyEvent :: DiscordEvent (Effect Unit)
readyEvent = Event "ready"

messageEvent :: DiscordEvent (Message -> Effect Unit)
messageEvent = Event "message"