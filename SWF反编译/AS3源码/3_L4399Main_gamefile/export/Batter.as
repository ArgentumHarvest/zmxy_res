package export
{
   import flash.display.Sprite;
   import my.ANumber;
   
   public class Batter extends Sprite
   {
       
      
      private var numSprite:ANumber;
      
      public function Batter()
      {
         super();
      }
      
      public function addBatterNum(bnum:uint) : *
      {
         var _x:Number = NaN;
         var _y:Number = NaN;
         if(bnum < 10)
         {
            _x = 4;
            _y = 28.3;
         }
         else if(bnum < 100)
         {
            _x = -44.6;
            _y = 28.3;
         }
         else
         {
            _x = -95.6;
            _y = 28.3;
         }
         if(numSprite && contains(numSprite))
         {
            removeChild(numSprite);
            numSprite = null;
         }
         numSprite = new ANumber();
         numSprite.aNumMC("num",bnum,_x,_y,50);
         addChild(numSprite);
      }
   }
}
