package mvc.control.net.rm
{
   import com.superkaka.game.Const.GameConst;
   import com.superkaka.mvc.Control.net.rm.GameReceiveControl;
   import com.superkaka.mvc.ProxyFactory;
   import flash.utils.ByteArray;
   import mvc.controllor.JsonObjectToInstanceManager;
   import mvc.controllor.RandomControllor;
   import mvc.controllor.ServersControllor;
   import mvc.controllor.SocketConnectManager;
   import mvc.proxy.GateSocketProxy;
   import mvc.vo.Server;
   
   public class MyGateReceiveControl extends GameReceiveControl
   {
       
      
      public function MyGateReceiveControl()
      {
         super();
      }
      
      public function GetServerInfoReturn(body:ByteArray) : void
      {
         var s:* = null;
         trace("-------GetServerInfoReturn----------");
         var str:String = body.readUTFBytes(body.bytesAvailable);
         trace("str:" + str);
         var jObj:Object = JSON.parse(str);
         var serverArr:Array = jObj.servers;
         var key:String = jObj.key;
         var serverId:int = jObj.serverId;
         var connector:Object = jObj.connector;
         if(!connector)
         {
            trace("全部连接服爆满了！请稍后连接游戏！");
            return;
         }
         GameConst.loginKey = key;
         GameConst.gateServerId = serverId;
         ProxyFactory.getIns().destroyProxy(GateSocketProxy);
         ServersControllor.getIns().servers.length = 0;
         for each(var sObj in serverArr)
         {
            s = JsonObjectToInstanceManager.getIns().getServer(sObj);
            ServersControllor.getIns().servers.push(s);
         }
         ServersControllor.getIns().curConnector = JsonObjectToInstanceManager.getIns().getConnector(connector);
         this.connectServer();
      }
      
      private function connectServer() : void
      {
         var randServer:* = null;
         if(ServersControllor.getIns().servers.length > 0)
         {
            randServer = ServersControllor.getIns().servers[int(RandomControllor.getIns().getRandom() * ServersControllor.getIns().servers.length)];
            if(randServer)
            {
               ServersControllor.getIns().curServer = randServer;
               SocketConnectManager.getIns().connectToGame(ServersControllor.getIns().curConnector.ip,ServersControllor.getIns().curConnector.port);
            }
         }
      }
   }
}
