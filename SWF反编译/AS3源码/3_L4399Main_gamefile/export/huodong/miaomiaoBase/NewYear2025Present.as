package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class NewYear2025Present extends MiaoMiaoBaseInterface
   {
       
      
      public function NewYear2025Present()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-64176498"),"_blank");
      }
   }
}
