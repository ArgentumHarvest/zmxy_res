package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class BiBaBoTogetherPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function BiBaBoTogetherPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-56529881"),"_blank");
      }
   }
}
