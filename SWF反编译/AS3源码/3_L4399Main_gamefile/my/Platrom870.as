package my
{
   import flash.external.ExternalInterface;
   
   public class Platrom870 extends Singleton
   {
       
      
      private var info:Object;
      
      private var type:String = "870Game";
      
      public function Platrom870()
      {
         super();
      }
      
      public static function getIns() : Platrom870
      {
         return Singleton.getIns(Platrom870);
      }
      
      public function get is870() : Boolean
      {
         if(info)
         {
            return info.indexOf(type) >= 0;
         }
         if(ExternalInterface.available)
         {
            info = ExternalInterface.call("eval","navigator.userAgent");
            if(info)
            {
               return info.indexOf(type) >= 0;
            }
         }
         return false;
      }
      
      public function jsCall(funName:String, data:Object) : void
      {
         try
         {
            ExternalInterface.call("console.log","方法名:",funName,"参数:",data);
            ExternalInterface.call(funName,data);
         }
         catch(errObject:Error)
         {
            trace("log=" + data);
         }
      }
      
      public function openModule(openName:String) : void
      {
         jsCall("setGameStatus",1);
         if(is870)
         {
            jsCall("setGameStatus",1);
         }
      }
      
      public function closeModule(openName:String) : void
      {
         jsCall("setGameStatus",0);
         if(is870)
         {
            jsCall("setGameStatus",0);
         }
      }
      
      public function changeSceneStatus(data:Object) : void
      {
         jsCall("changeSceneStatus",data);
         if(is870)
         {
            jsCall("changeSceneStatus",data);
         }
      }
   }
}
