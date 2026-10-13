package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class XiaoHuDuiPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function XiaoHuDuiPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-53173902.html"),"_blank");
      }
   }
}
