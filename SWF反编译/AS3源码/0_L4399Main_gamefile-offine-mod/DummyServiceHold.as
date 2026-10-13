package
{
   import config.Config;
   
   public class DummyServiceHold
   {
       
      
      public var isLog:Object;
      
      public function DummyServiceHold()
      {
         this.isLog = {
            "uid":"local",
            "name":"本地玩家"
         };
         super();
      }
      
      public function getTotalRechargedFun() : int
      {
         trace("[DummyServiceHold] getTotalRechargedFun");
         return 1000;
      }
      
      public function getData(cover:Boolean, slot:int) : void
      {
         trace("[DummyServiceHold] getData",cover,slot);
      }
      
      public function saveData(title:String, data:*, cover:Boolean, slot:int) : void
      {
         trace("[DummyServiceHold] saveData",title,slot);
      }
      
      public function showLogPanel() : void
      {
         trace("[DummyServiceHold] showLogPanel");
      }
      
      public function getServerTime() : void
      {
         trace("[DummyServiceHold] getServerTime");
         var cfg:Config = Config.getInstance();
         var d:Date = new Date();
         var s:String = d.fullYear + "-" + (d.month + 1) + "-" + d.date + " 00:00:00";
         cfg.onGetServerTime(s);
      }
      
      public function getBalance() : void
      {
      }
      
      public function payMoney_As3(param1:int) : void
      {
      }
      
      public function decMoney_As3(param1:int) : void
      {
      }
   }
}
