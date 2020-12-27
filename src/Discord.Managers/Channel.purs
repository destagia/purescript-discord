module Discord.Managers.Channel where

import Discord.Managers.Class (class Manager)
import Effect (Effect)

foreign import data ChannelManager :: Type
foreign import data Channel :: Type

foreign import getName :: Channel -> Effect String

instance channelManager :: Manager ChannelManager Channel

