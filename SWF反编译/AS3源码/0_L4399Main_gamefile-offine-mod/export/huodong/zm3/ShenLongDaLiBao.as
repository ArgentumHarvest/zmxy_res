package export.huodong.zm3
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class ShenLongDaLiBao extends MiaoMiaoBaseInterface
   {
       
      
      public function ShenLongDaLiBao()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         navigateToURL(new URLRequest("https://my.4399.com/forums/thread-56872275"),"_blank");
      }
   }
}
