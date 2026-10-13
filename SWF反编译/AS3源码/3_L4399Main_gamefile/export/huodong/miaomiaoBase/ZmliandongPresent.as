package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ZmliandongPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function ZmliandongPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://huodong2.4399.com/2025/zmwsldgq/"),"_blank");
      }
   }
}
