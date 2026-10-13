package my
{
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   
   public class LightForBlackBG extends MovieClip implements ILightForBlackBG
   {
       
      
      private var _raidus:int = 150;
      
      private var _posX:Number;
      
      private var _posY:Number;
      
      protected var state:int = 0;
      
      public var continueTimes:int = 1;
      
      protected var gc:Config;
      
      public function LightForBlackBG()
      {
         super();
         gc = Config.getInstance();
      }
      
      public function step() : void
      {
      }
      
      public function light(_continueTimes:int) : void
      {
         _continueTimes = _continueTimes;
         this.continueTimes = _continueTimes;
         this.state = 1;
         gc.pWorld.getBaseLevelListener().addLightForBlackBG(this);
         if(_continueTimes != -1)
         {
            TweenMax.delayedCall(this.continueTimes,function(_self:LightForBlackBG):*
            {
               _self.dark();
            },[this]);
         }
      }
      
      public function dark() : void
      {
         this.state = 0;
         gc.pWorld.getBaseLevelListener().removeLightForBlackBG(this);
      }
      
      public function get raidus() : int
      {
         return _raidus;
      }
      
      public function set raidus(value:int) : void
      {
         _raidus = value;
      }
      
      public function get posX() : Number
      {
         return this.x;
      }
      
      public function set posX(value:Number) : void
      {
         _posX = value;
      }
      
      public function get posY() : Number
      {
         return this.y;
      }
      
      public function set posY(value:Number) : void
      {
         _posY = value;
      }
   }
}
