package mvc.controllor
{
   import com.superkaka.Tools.Singleton;
   import mvc.vo.Connector;
   import mvc.vo.Server;
   
   public class ServersControllor extends Singleton
   {
       
      
      public var servers:Vector.<Server>;
      
      public var curServer:Server;
      
      public var curConnector:Connector;
      
      public function ServersControllor()
      {
         servers = new Vector.<Server>();
         super();
      }
      
      public static function getIns() : ServersControllor
      {
         return Singleton.getIns(ServersControllor);
      }
   }
}
