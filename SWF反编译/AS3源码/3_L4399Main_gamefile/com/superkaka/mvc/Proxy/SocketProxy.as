package com.superkaka.mvc.Proxy
{
   import com.superkaka.Tools.CommonEvent;
   import com.superkaka.game.net.SuperSocket;
   import com.superkaka.mvc.Base.BaseProxy;
   import com.superkaka.mvc.Control.net.SMessage;
   import com.superkaka.mvc.Control.net.sm.SendDelay;
   import flash.events.Event;
   import flash.utils.ByteArray;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   
   public class SocketProxy extends BaseProxy
   {
       
      
      private var _socket:SuperSocket;
      
      private var _onConnectFunc:Function;
      
      private var _onDataFunc:Function;
      
      private var _onCloseFunc:Function;
      
      private var _onIoErrorFunc:Function;
      
      private var _onSecureErrorFunc:Function;
      
      public var heartInterval:int = 15000;
      
      private var heartIntervalIndex:int = -1;
      
      public var delayInterval:int = 3000;
      
      private var delayIntervalIndex:int = -1;
      
      public var delay:int = 0;
      
      private var delaySendTime:int;
      
      public function SocketProxy()
      {
         super();
      }
      
      public function connectTo(host:String, port:int, onConnect:Function = null, onData:Function = null, onClose:Function = null, onIoError:Function = null, onSecureError:Function = null) : void
      {
         if(!this._socket)
         {
            this._socket = new SuperSocket();
            this._onConnectFunc = onConnect;
            this._onDataFunc = onData;
            this._onCloseFunc = onClose;
            this._onIoErrorFunc = onIoError;
            this._onSecureErrorFunc = onSecureError;
            this._socket.connectTo(host,port);
            this._socket.addEventListener("data",__onData);
            this._socket.addEventListener("connect",__onConnect);
            this._socket.addEventListener("close",__onClose);
            this._socket.addEventListener("ierror",_onIoError);
            this._socket.addEventListener("serror",_onSecureError);
         }
      }
      
      protected function _onSecureError(event:Event) : void
      {
         if(this._onSecureErrorFunc != null)
         {
            this._onSecureErrorFunc.call();
            this._onSecureErrorFunc = null;
         }
         clearInterval(this.heartIntervalIndex);
      }
      
      protected function _onIoError(event:Event) : void
      {
         if(this._onIoErrorFunc != null)
         {
            this._onIoErrorFunc.call();
            this._onIoErrorFunc = null;
         }
         clearInterval(this.heartIntervalIndex);
      }
      
      protected function __onClose(evt:Event) : void
      {
         if(this._onCloseFunc != null)
         {
            this._onCloseFunc.call();
            this._onCloseFunc = null;
         }
         clearInterval(this.heartInterval);
      }
      
      protected function __onConnect(evt:Event) : void
      {
         if(this._onConnectFunc != null)
         {
            this._onConnectFunc.call();
            this._onConnectFunc = null;
         }
         if(this.heartInterval > 0)
         {
            clearInterval(this.heartInterval);
            this.heartIntervalIndex = setInterval(sendHeart,this.heartInterval);
         }
         if(this.delayInterval > 0)
         {
            clearInterval(this.delayInterval);
            this.heartIntervalIndex = setInterval(sendDelay,this.delayInterval);
         }
      }
      
      protected function __onData(evt:CommonEvent) : void
      {
         evt = evt;
         var self:SocketProxy = this;
         var data:ByteArray = evt.data as ByteArray;
         if(this._onDataFunc != null)
         {
            this._onDataFunc(data,this.name,function(fileName:String, funcName:String, body:ByteArray):*
            {
               if(fileName == "MvcReceive" && funcName == "GetDelay")
               {
                  self.delay = getTimer() - self.delaySendTime;
                  trace("延迟:" + self.delay + "ms");
               }
            });
         }
      }
      
      protected function sendHeart() : void
      {
         var sm:SMessage = new SMessage("");
         this.send(sm);
      }
      
      protected function sendDelay() : void
      {
         var sd:SendDelay = new SendDelay(this.delay);
         this.send(sd);
         this.delaySendTime = getTimer();
      }
      
      public function send(sm:SMessage) : void
      {
         var ba:* = null;
         if(_socket && _socket.isConnected())
         {
            ba = sm.getData(this.name);
            _socket.send(ba);
            try
            {
               trace("发送-head:" + sm.headJson() + ",body:" + sm.bodyJson());
            }
            catch(e:*)
            {
            }
         }
      }
      
      override public function destroy() : void
      {
         super.destroy();
         clearInterval(this.heartInterval);
         if(this._socket)
         {
            this._socket.removeEventListener("data",__onData);
            this._socket.removeEventListener("connect",__onConnect);
            this._socket.removeEventListener("close",__onClose);
            this._socket.removeEventListener("ierror",_onIoError);
            this._socket.removeEventListener("serror",_onSecureError);
            this._socket.destroy();
            this._socket = null;
         }
         this._onIoErrorFunc = null;
         this._onSecureErrorFunc = null;
         this._onCloseFunc = null;
         this._onConnectFunc = null;
         this._onDataFunc = null;
      }
      
      public function get socket() : SuperSocket
      {
         return _socket;
      }
      
      public function set socket(value:SuperSocket) : void
      {
         _socket = value;
      }
   }
}
