package com.superkaka.game.net
{
   import com.superkaka.Tools.CommonEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IOErrorEvent;
   import flash.events.ProgressEvent;
   import flash.events.SecurityErrorEvent;
   import flash.net.Socket;
   import flash.utils.ByteArray;
   import flash.utils.setTimeout;
   
   public class SuperSocket extends EventDispatcher
   {
      
      public static const DATA:String = "data";
      
      public static const CONNECT:String = "connect";
      
      public static const CLOSE:String = "close";
      
      public static const SECURE_ERROR:String = "serror";
      
      public static const IO_ERROR:String = "ierror";
       
      
      private var _socket:Socket;
      
      private var _buffer:ByteArray;
      
      private var _host:String = "";
      
      private var _port:int;
      
      public function SuperSocket()
      {
         _buffer = new ByteArray();
         super(null);
         _buffer.endian = "littleEndian";
      }
      
      public function isConnected() : Boolean
      {
         return this._socket && this._socket.connected;
      }
      
      public function connectTo(host:String, port:int) : void
      {
         if(!_socket)
         {
            this._host = host;
            this._port = port;
            _socket = new Socket();
            _socket.addEventListener("connect",__connectHandler);
            _socket.addEventListener("close",__closeHandler);
            _socket.addEventListener("ioError",__socketIOHandler);
            _socket.addEventListener("socketData",__onDataHandler);
            _socket.addEventListener("securityError",__securityError);
         }
         if(!_socket.connected)
         {
            _socket.connect(this._host,this._port);
         }
      }
      
      protected function __securityError(event:SecurityErrorEvent) : void
      {
         event = event;
         trace("---安全沙箱错误---");
         this.dispatchEvent(new CommonEvent("serror"));
         setTimeout(function(_self:SuperSocket):*
         {
            trace("---自动重连---");
            _self.connectTo(_self._host,_self._port);
         },1000,this);
      }
      
      protected function __socketIOHandler(evt:IOErrorEvent) : void
      {
         trace("---服务端没有开启---");
         this.dispatchEvent(new CommonEvent("ierror"));
      }
      
      public function send(data:ByteArray) : void
      {
         trace("---发送数据---len:" + data.length);
         _socket.writeBytes(data);
         _socket.flush();
      }
      
      protected function __closeHandler(event:Event) : void
      {
         trace("---服务端关闭---");
         this.dispatchEvent(new CommonEvent("close"));
      }
      
      protected function __onDataHandler(evt:ProgressEvent) : void
      {
         var packageLen:int = 0;
         var body:* = null;
         var getBa:ByteArray = new ByteArray();
         _socket.readBytes(_buffer,_buffer.length);
         while(_buffer.bytesAvailable >= 4)
         {
            packageLen = _buffer.readInt();
            if(_buffer.bytesAvailable < packageLen)
            {
               _buffer.position -= 4;
               break;
            }
            body = new ByteArray();
            body.endian = "littleEndian";
            if(packageLen > 0)
            {
               _buffer.readBytes(body,0,packageLen);
            }
            this.dispatchEvent(new CommonEvent("data",body));
         }
         if(_buffer.bytesAvailable == 0)
         {
            _buffer.length = 0;
            _buffer.clear();
         }
      }
      
      protected function __connectHandler(evt:Event) : void
      {
         trace("---连接上---");
         this.dispatchEvent(new CommonEvent("connect"));
      }
      
      public function destroy() : void
      {
         trace("-------------------------------destroy--------------------------------");
         if(this._socket)
         {
            if(_socket.connected)
            {
               this._socket.close();
            }
            _socket.removeEventListener("connect",__connectHandler);
            _socket.removeEventListener("close",__closeHandler);
            _socket.removeEventListener("ioError",__socketIOHandler);
            _socket.removeEventListener("socketData",__onDataHandler);
            this._socket = null;
         }
         if(this._buffer)
         {
            this._buffer.length = 0;
            this._buffer.clear();
         }
      }
   }
}
