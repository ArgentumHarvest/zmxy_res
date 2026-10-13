package export.huodong.wuyijie
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class WuyiJieInterface extends MiaoMiaoBaseInterface
   {
       
      
      public function WuyiJieInterface()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums-thread-tagid-80615-id-47032056.html"),"_blank");
      }
   }
}
