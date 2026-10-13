package export.level.StageListener111Child
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class Stage111Info extends Sprite
   {
       
      
      public var timeCountTf:TextField;
      
      public var dropRateAddTf:TextField;
      
      public var buyTimesAddTf:TextField;
      
      public function Stage111Info()
      {
         super();
      }
      
      public function updateTimeCountDisplay(tc:uint) : void
      {
         this.timeCountTf.text = tc.toString();
         this.timeCountTf.width = this.timeCountTf.textWidth + 10;
      }
      
      public function updateThrowTimeDisplay(tc:uint) : void
      {
         this.dropRateAddTf.text = tc.toString() + "%";
         this.dropRateAddTf.width = this.dropRateAddTf.textWidth + 10;
      }
      
      public function updateChangeLuckDisplay(tc:uint) : void
      {
         this.buyTimesAddTf.text = tc.toString();
         this.buyTimesAddTf.width = this.buyTimesAddTf.textWidth + 10;
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
