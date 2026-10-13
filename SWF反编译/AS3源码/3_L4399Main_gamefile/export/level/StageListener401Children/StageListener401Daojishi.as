package export.level.StageListener401Children
{
   import flash.text.TextField;
   import my.LightForBlackBG;
   
   public class StageListener401Daojishi extends LightForBlackBG
   {
       
      
      public var timeTf:TextField;
      
      public function StageListener401Daojishi()
      {
         super();
      }
      
      public function updateDisplay(count:int) : void
      {
         this.timeTf.text = (int(count / 24)).toString();
      }
   }
}
