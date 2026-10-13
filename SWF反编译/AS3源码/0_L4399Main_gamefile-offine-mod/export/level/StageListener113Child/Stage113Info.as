package export.level.StageListener113Child
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class Stage113Info extends Sprite
   {
       
      
      public var timeCountTf:TextField;
      
      public var bloodTf:TextField;
      
      public function Stage113Info()
      {
         super();
         this.timeCountTf.text = "0";
         this.bloodTf.text = "0";
      }
      
      public function updateTimeCountDisplay(tc:uint) : void
      {
         this.timeCountTf.text = tc.toString();
      }
      
      public function updateBloodDisplay(tc:uint) : void
      {
         this.bloodTf.text = tc.toString();
      }
   }
}
