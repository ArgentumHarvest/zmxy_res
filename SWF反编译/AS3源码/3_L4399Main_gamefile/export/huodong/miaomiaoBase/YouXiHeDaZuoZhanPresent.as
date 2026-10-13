package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class YouXiHeDaZuoZhanPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function YouXiHeDaZuoZhanPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-57164583"),"_blank");
      }
   }
}
