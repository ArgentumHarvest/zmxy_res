package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ThanksGivingDay2018 extends MiaoMiaoBaseInterface
   {
       
      
      public function ThanksGivingDay2018()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59450377"),"_blank");
      }
   }
}
