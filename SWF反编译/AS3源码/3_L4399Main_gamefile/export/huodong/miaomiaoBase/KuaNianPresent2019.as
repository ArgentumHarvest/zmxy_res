package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class KuaNianPresent2019 extends MiaoMiaoBaseInterface
   {
       
      
      public function KuaNianPresent2019()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59544296"),"_blank");
      }
   }
}
