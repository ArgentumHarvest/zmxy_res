package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ShuMaBaoLongPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function ShuMaBaoLongPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-57912759"),"_blank");
      }
   }
}
