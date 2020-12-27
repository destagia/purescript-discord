module Discord.Client where

import Data.Function.Uncurried (Fn2, runFn2)
import Discord.Managers.Channel (ChannelManager)
import Effect (Effect)
import Node.Events.EventEmitter (class EventEmitter, defaultEmit, defaultEventNames, defaultGetMaxListeners, defaultListenerCount, defaultListeners, defaultOn, defaultOnce, defaultPrependListener, defaultPrependOnceListener, defaultRemoveAllListeners, defaultRemoveListener, defaultSetMaxListeners)
import Prelude (Unit)

foreign import data Client :: Type

foreign import mkClient :: Effect Client

foreign import getChannels :: Client -> Effect ChannelManager

foreign import _login :: Fn2 Client String (Effect Unit)

login :: Client -> String -> Effect Unit
login client token = runFn2 _login client token

instance discordEventEmitter :: EventEmitter Client where
  on event listener client = defaultOn event listener client
  once event listener client = defaultOnce event listener client
  prependListener event listener client = defaultPrependListener event listener client
  prependOnceListener event listener client = defaultPrependOnceListener event listener client
  removeListener event listener client = defaultRemoveListener event listener client
  removeAllListeners event client = defaultRemoveAllListeners event client
  emit event args client = defaultEmit event args client
  listeners event client = defaultListeners event client
  listenerCount event client = defaultListenerCount event client
  getMaxListeners client = defaultGetMaxListeners client
  setMaxListeners count client = defaultSetMaxListeners count client
  eventNames client = defaultEventNames client
