package export.level.StageListener112Child
{
   import flash.display.Sprite;
   import flash.text.TextField;
   
   public class Stage112Info extends Sprite
   {
       
      
      public var timeCountTf:TextField;
      
      public var totalJwealTf:TextField;
      
      public function Stage112Info()
      {
         super();
         this.timeCountTf.text = "0";
         this.totalJwealTf.text = "0";
      }
      
      public function updateTimeCountDisplay(tc:uint) : void
      {
         this.timeCountTf.text = tc.toString();
      }
      
      public function updateTotalJwealDisplay(tj:uint) : void
      {
         this.totalJwealTf.text = tj.toString();
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
