package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ShiZhouNianZZPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function ShiZhouNianZZPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-62101922"),"_blank");
      }
   }
}
