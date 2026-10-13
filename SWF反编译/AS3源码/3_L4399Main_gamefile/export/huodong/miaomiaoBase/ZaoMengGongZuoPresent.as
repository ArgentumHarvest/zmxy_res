package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ZaoMengGongZuoPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function ZaoMengGongZuoPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-63430945"),"_blank");
      }
   }
}
