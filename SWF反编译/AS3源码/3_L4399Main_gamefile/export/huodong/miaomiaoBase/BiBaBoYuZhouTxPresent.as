package export.huodong.miaomiaoBase
{
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class BiBaBoYuZhouTxPresent extends MiaoMiaoBaseInterface
   {
       
      
      public function BiBaBoYuZhouTxPresent()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-57846419"),"_blank");
      }
   }
}
