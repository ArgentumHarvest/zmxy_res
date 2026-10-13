package export.monster.Monster23Child
{
   import base.BaseHero;
   import config.Config;
   import event.CommonEvent;
   import export.hero.Role1;
   import export.hero.Role2;
   import export.monster.Monster24;
   import flash.display.MovieClip;
   import my.HitTest;
   
   public class Hands extends MovieClip
   {
       
      
      private var gc:Config;
      
      private var moveTime:int;
      
      private var direct:int = 0;
      
      private var directTime:int = 24;
      
      private var downTime:int = 24.0;
      
      private var downSpeed:Number = 3;
      
      public function Hands()
      {
         super();
         this.gc = Config.getInstance();
         this.moveTime = 24 * int(2 + Math.random() * 3);
      }
      
      public function step() : void
      {
         if(this.moveTime == 0)
         {
            this.downAttack();
         }
         if(this.moveTime > 0)
         {
            this.move();
            --this.moveTime;
         }
      }
      
      private function move() : void
      {
         var _loc1_:Number = NaN;
         if(this.direct == 0)
         {
            this.x -= 3;
         }
         else if(this.direct == 1)
         {
            this.x += 3;
         }
         if(this.x < -400)
         {
            this.direct = 1;
         }
         else if(this.x > 400)
         {
            this.direct = 0;
         }
         if(this.directTime == 0)
         {
            _loc1_ = Math.random();
            if(_loc1_ > 0.5)
            {
               this.direct = (this.direct + 2) % 3;
            }
            else
            {
               this.direct = (this.direct + 1) % 3;
            }
            this.directTime = int(1 + Math.random() * 2) * 24;
         }
         --this.directTime;
      }
      
      private function downAttack() : void
      {
         var _loc1_:Monster24 = null;
         if(this.y >= 126)
         {
            this.gc.vControllor.shake(10);
            --this.downTime;
            if(this.downTime == 0)
            {
               this.downTime = 24 * 1;
               this.downSpeed = 2;
               this.y = 0;
               this.moveTime = int(3 + Math.random() * 4) * 24;
               _loc1_ = this.parent.parent as Monster24;
               _loc1_.newAttackId();
            }
         }
         else
         {
            this.y += this.downSpeed;
            this.downSpeed += 0.5;
            this.checkAttack();
         }
      }
      
      private function checkAttack() : void
      {
         var _loc4_:BaseHero = null;
         var _loc5_:Object = null;
         var _loc6_:int = 0;
         var _loc1_:Monster24 = this.parent.parent as Monster24;
         var _loc2_:Array = this.gc.getPlayerArray();
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            if(!(_loc4_ = _loc2_[_loc3_] as BaseHero).isYourFather && _loc4_.beAttackIdArray.indexOf(_loc1_.getAttackId()) == -1)
            {
               if(_loc4_.colipse)
               {
                  if(HitTest.complexHitTestObject(_loc4_.colipse,this))
                  {
                     _loc6_ = (_loc5_ = _loc1_.attackBackInfoDict["hit1"]).power;
                     _loc4_.addHeroHurtMc(_loc6_);
                     _loc4_.publicToBlood(_loc6_);
                     if(_loc5_ && (_loc4_ is Role1 && !_loc4_.isGXP) || _loc4_ is Role2)
                     {
                        _loc4_.beAttackBack(_loc1_,_loc5_.attackBackSpeed[0],_loc5_.attackBackSpeed[1]);
                     }
                     _loc4_.beAttackIdArray.push(_loc1_.getAttackId());
                     _loc4_.beAttackDoing();
                     if(_loc5_.addEffect)
                     {
                        _loc4_.addCurAddEffect(_loc5_.addEffect as Array);
                     }
                     if(this.gc.gameMode == Config.MODE3)
                     {
                        this.gc.eventManger.dispatchEvent(new CommonEvent("HeroIsBeat",[_loc6_,_loc1_]));
                     }
                  }
               }
            }
            _loc3_++;
         }
      }
   }
}
