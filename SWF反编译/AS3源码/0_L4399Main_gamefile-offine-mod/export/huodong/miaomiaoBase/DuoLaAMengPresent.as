package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class DuoLaAMengPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function DuoLaAMengPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-58352736"),"_blank");
      }
   }
}
