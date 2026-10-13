package my
{
   public class KeyCodeCombo
   {
       
      
      private var _keyCode:uint;
      
      private var _startTimer:uint = 18;
      
      public var isDestroy:Boolean = false;
      
      public function KeyCodeCombo(value:uint)
      {
         super();
         this._keyCode = value;
      }
      
      public function step() : void
      {
         if(this._startTimer > 0)
         {
            this._startTimer--;
            if(this._startTimer == 0)
            {
               this.isDestroy = true;
            }
         }
      }
      
      public function get keyCode() : uint
      {
         return _keyCode;
      }
      
      public function set keyCode(value:uint) : void
      {
         _keyCode = value;
      }
      
      public function get startTimer() : uint
      {
         return _startTimer;
      }
      
      public function set startTimer(value:uint) : void
      {
         _startTimer = value;
      }
   }
}
