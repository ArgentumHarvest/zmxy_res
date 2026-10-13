package my
{
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   
   public class ANumber extends Sprite
   {
       
      
      var stime:uint = 0;
      
      var sid:uint;
      
      public function ANumber()
      {
         super();
      }
      
      public function aNumMC(param1:String, param2:int, param3:int, param4:int, param5:int) : *
      {
         var _loc7_:uint = 0;
         var _loc8_:DisplayObject = null;
         var _loc6_:* = 0;
         while(_loc6_ < String(param2).length)
         {
            _loc7_ = int(String(param2).charAt(_loc6_));
            (_loc8_ = AUtils.getNewObj(param1 + _loc7_) as DisplayObject).x = _loc6_ * param5;
            addChild(_loc8_);
            _loc6_++;
         }
         this.x = param3;
         this.y = param4;
      }
      
      public function aNumImage(param1:String, param2:int, param3:int, param4:int, param5:int) : *
      {
         var _loc7_:uint = 0;
         var _loc8_:* = undefined;
         var _loc6_:* = 0;
         while(_loc6_ < String(param2).length)
         {
            _loc7_ = int(String(param2).charAt(_loc6_));
            (_loc8_ = AUtils.getImageObj(param1 + _loc7_)).x = _loc6_ * param5;
            addChild(_loc8_);
            _loc6_++;
         }
         this.sid = setInterval(this.update,40);
         this.x = param3;
         this.y = param4;
      }
      
      public function update() : *
      {
         y -= 3;
         ++this.stime;
         if(this.stime > 24 * 1)
         {
            clearInterval(this.sid);
            parent.removeChild(this);
            return;
         }
      }
   }
}
