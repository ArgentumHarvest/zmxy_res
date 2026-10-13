package loader
{
   import config.Config;
   import event.CommonEvent;
   import flash.events.Event;
   import my.Decrypt;
   
   public class Aloader
   {
       
      
      public var urls:Array;
      
      public var _i:uint;
      
      public var gc:Config;
      
      private var decrypt:Decrypt;
      
      private var loadIndex:int = 0;
      
      private var after:Function;
      
      public function Aloader()
      {
         urls = ["MagicWeaponv1240.swf","Commonv3720.swf","petEIconv1450.swf","EIconv3420.swf","GameMapv3840.swf","OtherMatv3570.swf","GameBackGroundv3800.swf"];
         decrypt = new Decrypt();
         super();
         gc = Config.getInstance();
         if(gc.isHideDebug)
         {
         }
         gc.eventManger.addEventListener("logout",__userLogout);
      }
      
      private function __userLogout(evt:Event) : void
      {
         decrypt.doWhenUserLogOut();
      }
      
      public function init() : void
      {
         this.next();
      }
      
      public function loadByName(name:String, func:Function) : void
      {
         decrypt.loadByName(name,func);
      }
      
      public function next() : *
      {
         if(_i >= urls.length)
         {
            GMain.getInstance().processComplete();
            gc.eventManger.dispatchEvent(new CommonEvent("LoadOver"));
            return;
         }
         trace("加载:" + urls[_i]);
         decrypt.doDecrypt(urls[_i++],next,_i + 1);
      }
   }
}
