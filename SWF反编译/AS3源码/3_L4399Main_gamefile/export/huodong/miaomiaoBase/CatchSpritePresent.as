package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class CatchSpritePresent extends MiaoMiaoBaseInterface
   {
       
      
      public function CatchSpritePresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-57192817"),"_blank");
      }
   }
}
