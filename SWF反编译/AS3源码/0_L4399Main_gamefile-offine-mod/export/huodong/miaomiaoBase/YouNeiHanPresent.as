package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class YouNeiHanPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function YouNeiHanPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-58463358"),"_blank");
      }
   }
}
