package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class WeiXinNeiHanPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function WeiXinNeiHanPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-57647004"),"_blank");
      }
   }
}
