package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ZaoMengDaLiBaoPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function ZaoMengDaLiBaoPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-58554745"),"_blank");
      }
   }
}
