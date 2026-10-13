package export.huodong.sign
{
   import export.huodong.miaomiaoBase.MiaoMiaoBaseInterface;
   import flash.events.MouseEvent;
   
   public class SignUpEveryDay extends MiaoMiaoBaseInterface
   {
       
      
      public function SignUpEveryDay()
      {
         super();
      }
      
      override protected function gClick(e:MouseEvent) : void
      {
         gc.openUrl("https://huodong2.4399.com/2021/yxhpcsign/?strcode=4f88f574");
      }
   }
}
