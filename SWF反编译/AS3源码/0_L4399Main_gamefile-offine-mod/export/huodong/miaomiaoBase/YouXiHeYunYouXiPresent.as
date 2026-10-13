package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class YouXiHeYunYouXiPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function YouXiHeYunYouXiPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-63579377"),"_blank");
      }
   }
}
