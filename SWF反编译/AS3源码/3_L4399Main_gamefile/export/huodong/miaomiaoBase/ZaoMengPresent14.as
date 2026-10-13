package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ZaoMengPresent14 extends MiaoMiaoBaseInterface
   {
       
      
      public function ZaoMengPresent14()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-64244194"),"_blank");
      }
   }
}
