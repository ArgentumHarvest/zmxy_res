package mvc.control
{
   import com.superkaka.Tools.DebugArea;
   import com.superkaka.mvc.Control.SocketSendControl;
   import com.superkaka.mvc.Control.net.SMessage;
   import com.superkaka.mvc.ProxyFactory;
   import mvc.proxy.FbSocketProxy;
   import mvc.proxy.GameSocketProxy;
   import mvc.proxy.GateSocketProxy;
   
   public class SocketsSendControl extends SocketSendControl
   {
       
      
      public function SocketsSendControl()
      {
         super();
      }
      
      public function sendToGate(sm:SMessage) : void
      {
         var sp:GateSocketProxy = ProxyFactory.getIns().getProxy(GateSocketProxy) as GateSocketProxy;
         if(sp)
         {
            sp.send(sm);
         }
         else
         {
            trace("没有连接GATE服务器");
            DebugArea.getIns().showInfo("Gate服发送");
         }
         sm.destroy();
      }
      
      public function send(sm:SMessage) : void
      {
         var sp:GameSocketProxy = ProxyFactory.getIns().getProxy(GameSocketProxy) as GameSocketProxy;
         if(sp)
         {
            sp.send(sm);
         }
         else
         {
            trace("没有连接GAME服务器");
            DebugArea.getIns().showInfo("Game服发送");
         }
         sm.destroy();
      }
      
      public function sendToFb(sm:SMessage) : void
      {
         var sp:FbSocketProxy = ProxyFactory.getIns().getProxy(FbSocketProxy) as FbSocketProxy;
         if(sp)
         {
            sp.send(sm);
         }
         else
         {
            trace("没有连接FB服务器");
            DebugArea.getIns().showInfo("FB服发送");
         }
         sm.destroy();
      }
   }
}
