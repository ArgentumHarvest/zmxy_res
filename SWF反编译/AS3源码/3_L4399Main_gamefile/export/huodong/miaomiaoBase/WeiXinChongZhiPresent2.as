package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class WeiXinChongZhiPresent2 extends MiaoMiaoBaseInterface
   {
       
      
      public function WeiXinChongZhiPresent2()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59118219"),"_blank");
      }
   }
}
