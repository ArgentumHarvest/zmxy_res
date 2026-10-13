package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ZaoMengZhouNian12 extends MiaoMiaoBaseInterface
   {
       
      
      public function ZaoMengZhouNian12()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-63575126"),"_blank");
      }
   }
}
