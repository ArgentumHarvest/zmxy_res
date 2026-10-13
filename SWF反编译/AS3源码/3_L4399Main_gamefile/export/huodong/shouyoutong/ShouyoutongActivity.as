package export.huodong.shouyoutong
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ShouyoutongActivity extends MiaoMiaoBaseInterface
   {
       
      
      public function ShouyoutongActivity()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-54803686"),"_blank");
      }
   }
}
