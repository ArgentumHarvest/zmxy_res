package manager
{
   import config.Config;
   import my.ANumber;
   
   public class PayManager
   {
      
      static var instance:PayManager;
       
      
      private var child:Vector.<ANumber>;
      
      private var gc:Config;
      
      public function PayManager()
      {
         child = new Vector.<ANumber>();
         super();
         gc = Config.getInstance();
      }
      
      public static function getInstance() : PayManager
      {
         if(!instance)
         {
            instance = new PayManager();
         }
         return instance;
      }
      
      public function pay(propId:int, propName:String, propPrice:int, propCount:int) : void
      {
         if(gc.checkWebUid())
         {
            if(GMain.serviceHold)
            {
               GMain.serviceHold.decMoney_As3(gc.pay);
            }
         }
         else
         {
            gc.ts.setTxt("当前游戏帐号不是最新的游戏帐号，请重新登录！",9999);
            gc.stage.addChild(gc.ts);
         }
      }
   }
}
