package mvc.controllor
{
   import com.superkaka.Tools.Singleton;
   import com.superkaka.game.Const.GameConst;
   import com.superkaka.game.Const.ProtocolDict;
   import com.superkaka.mvc.Base.BaseControl;
   import com.superkaka.mvc.ControlFactory;
   import com.superkaka.mvc.ProxyFactory;
   import flash.utils.ByteArray;
   import mvc.control.SocketsSendControl;
   import mvc.net.sm.JoinRoom;
   import mvc.net.sm.LoginConnector;
   import mvc.net.sm.LoginGate;
   import mvc.proxy.FbSocketProxy;
   import mvc.proxy.GameSocketProxy;
   import mvc.proxy.GateSocketProxy;
   import mvc.vo.Server;
   import my.DebugArea;
   
   public class SocketConnectManager extends Singleton
   {
       
      
      public function SocketConnectManager()
      {
         super();
      }
      
      public static function getIns() : SocketConnectManager
      {
         return Singleton.getIns(SocketConnectManager);
      }
      
      public function connectToGate() : void
      {
         DebugArea.getIns().traceOut("连接服务器！");
         ProxyFactory.getIns().destroyProxy(GateSocketProxy);
         var sp:GateSocketProxy = ProxyFactory.getIns().initProxy(GateSocketProxy) as GateSocketProxy;
         sp.connectTo(GameConst.GATE_IP,GameConst.GATE_PORT,onGateConnect,onData,onGateDisConnect,onGateIoError,onGateSecureError);
      }
      
      public function connectToFb(ip:String, port:int) : void
      {
         if(ProxyFactory.getIns().getProxy(FbSocketProxy))
         {
            return;
         }
         var sp:FbSocketProxy = ProxyFactory.getIns().initProxy(FbSocketProxy) as FbSocketProxy;
         sp.connectTo(ip,port,onFbConnect,onData,onFbDisConnect);
      }
      
      private function onGateSecureError() : void
      {
         DebugArea.getIns().traceOut("安全沙箱错误！");
      }
      
      private function onGateIoError() : void
      {
         DebugArea.getIns().traceOut("IO错误！");
      }
      
      public function connectToGame(ip:String, port:int) : void
      {
         trace("connectToGame-ip:" + ip + ",port:" + port);
         var sp:GameSocketProxy = ProxyFactory.getIns().initProxy(GameSocketProxy) as GameSocketProxy;
         sp.connectTo(ip,port,onGameConnect,onData,onGameDisConnect);
      }
      
      private function onData(data:ByteArray, codeName:String) : void
      {
         var key:int = 0;
         var len:int = 0;
         var i:* = 0;
         var encodeType:int = data.readByte();
         var crypt:int = data.readByte();
         var compressd:int = data.readByte();
         if(encodeType == 1)
         {
            key = ProtocolDict.getIns().getDecodeKey(codeName);
            len = data.length;
            for(i = uint(0); i < len; )
            {
               data[i] ^= key;
               i++;
            }
         }
         if(crypt == 1)
         {
         }
         var path:String = data.readUTF();
         var body:ByteArray = new ByteArray();
         body.endian = "littleEndian";
         body.writeBytes(data,data.position);
         body.position = 0;
         if(compressd == 1)
         {
            body.uncompress("zlib");
         }
         var pathArr:Array = path.split(".");
         var fileName:String = pathArr.shift();
         var funcName:String = pathArr.shift();
         var cls:Class = AUtils.getClass("mvc.control.net.rm." + fileName);
         var control:BaseControl = ControlFactory.getIns().getControl(cls);
         control[funcName](body);
         data.clear();
         body.clear();
      }
      
      private function onGateDisConnect() : void
      {
         DebugArea.getIns().traceOut("连接断开！");
         ProxyFactory.getIns().destroyProxy(GateSocketProxy);
         ProtocolDict.getIns().reset("GATE");
      }
      
      private function onGateConnect() : void
      {
         DebugArea.getIns().traceOut("发送连接！");
         var sm:LoginGate = new LoginGate(GameConst.UID);
         var ssc:SocketsSendControl = ControlFactory.getIns().getControl(SocketsSendControl) as SocketsSendControl;
         ssc.sendToGate(sm);
      }
      
      private function onGameConnect() : void
      {
         var randServer:* = null;
         var sm:* = null;
         var ssc:* = null;
         if(ServersControllor.getIns().servers.length > 0)
         {
            randServer = ServersControllor.getIns().servers[int(RandomControllor.getIns().getRandom() * ServersControllor.getIns().servers.length)];
            if(randServer)
            {
               sm = new LoginConnector(GameConst.UID,GameConst.loginKey,GameConst.gateServerId,ServersControllor.getIns().curServer.id);
               ssc = ControlFactory.getIns().getControl(SocketsSendControl) as SocketsSendControl;
               ssc.send(sm);
            }
         }
      }
      
      private function onGameDisConnect() : void
      {
         ProxyFactory.getIns().destroyProxy(GameSocketProxy);
      }
      
      private function onFbConnect() : void
      {
         var sm:JoinRoom = new JoinRoom(GameConst.roomKey,GameConst.roomId,MyUserManager.getIns().socketPlayer.gameKey);
         var ssc:SocketsSendControl = ControlFactory.getIns().getControl(SocketsSendControl) as SocketsSendControl;
         ssc.sendToFb(sm);
      }
      
      private function onFbDisConnect() : void
      {
         ProxyFactory.getIns().destroyProxy(FbSocketProxy);
         trace("onFbDisConnect");
      }
   }
}
