package export.huodong.tuya
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class TuyaSaiPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function TuyaSaiPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-48124712.html"),"_blank");
      }
   }
}
