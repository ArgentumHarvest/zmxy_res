package export.huodong.yikatong
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class YiKaTongPresent2015 extends MiaoMiaoBaseInterface
   {
       
      
      public function YiKaTongPresent2015()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-47711183.html"),"_blank");
      }
   }
}
