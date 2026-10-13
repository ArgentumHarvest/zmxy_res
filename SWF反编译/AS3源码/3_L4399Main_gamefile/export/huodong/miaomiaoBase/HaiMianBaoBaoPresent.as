package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class HaiMianBaoBaoPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function HaiMianBaoBaoPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-58555081"),"_blank");
      }
   }
}
