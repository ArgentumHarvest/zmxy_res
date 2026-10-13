package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ZqQiandaoPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function ZqQiandaoPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59767218"),"_blank");
      }
   }
}
