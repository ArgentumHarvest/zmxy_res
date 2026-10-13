package export.muti.MyComponent
{
   import flash.display.Sprite;
   
   public class MyComboBoxSingleLine extends Sprite
   {
       
      
      private var _value:uint;
      
      public function MyComboBoxSingleLine()
      {
         super();
      }
      
      public function set value(v:uint) : void
      {
         this._value = v;
      }
      
      public function get value() : uint
      {
         return this._value;
      }
   }
}
