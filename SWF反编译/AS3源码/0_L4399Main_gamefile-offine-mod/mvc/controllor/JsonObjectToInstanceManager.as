package mvc.controllor
{
   import com.superkaka.Tools.Singleton;
   import mvc.vo.Connector;
   import mvc.vo.Server;
   
   public class JsonObjectToInstanceManager extends Singleton
   {
       
      
      public function JsonObjectToInstanceManager()
      {
         super();
      }
      
      public static function getIns() : JsonObjectToInstanceManager
      {
         return Singleton.getIns(JsonObjectToInstanceManager);
      }
      
      public function getServer(sObj:Object) : Server
      {
         var server:Server = new Server();
         server.buildFromObject(sObj);
         return server;
      }
      
      public function getConnector(cObj:Object) : Connector
      {
         var connector:Connector = new Connector();
         connector.buildFromObject(cObj);
         return connector;
      }
   }
}
