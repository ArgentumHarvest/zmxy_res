package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class WeiXinLPZPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function WeiXinLPZPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59362269"),"_blank");
      }
   }
}
