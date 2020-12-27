module Discord.Managers.Manager where

import Prelude

import Control.Promise (Promise, toAffE)
import Data.Function.Uncurried (Fn1, Fn2, runFn1, runFn2)
import Discord.Managers.Channel (Channel, ChannelManager)
import Discord.Managers.Class (class Manager)
import Effect (Effect)
import Effect.Aff (Aff)

foreign import _fetch :: forall mgr a. Manager mgr a => Fn2 mgr String (Effect (Promise a))
foreign import _cache :: forall mgr a. Manager mgr a => Fn1 mgr (Effect (Array a))

fetch :: forall mgr a. Manager mgr a => mgr -> String -> Aff a
fetch mgr id = toAffE $ runFn2 _fetch mgr id

getCacheChannels :: forall a. Manager ChannelManager a => ChannelManager -> Effect (Array Channel)
getCacheChannels mgr = runFn1 _cache mgr