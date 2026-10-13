package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class XiariJiActivity extends MiaoMiaoBaseInterface
   {
       
      
      public function XiariJiActivity()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-59150729"),"_blank");
      }
   }
}
