package export.monster.Monster23Child
{
   import base.*;
   import config.*;
   import event.*;
   import export.hero.*;
   import flash.display.MovieClip;
   import my.*;
   
   public class Fire extends MovieClip
   {
       
      
      private var gc:Config;
      
      private var bb:BaseMonster;
      
      public function Fire(param1:BaseMonster)
      {
         super();
         this.gc = Config.getInstance();
         this.bb = param1;
      }
      
      public function step() : void
      {
         if(this.currentFrame > 24)
         {
            this.checkAttack();
         }
         if(this.currentFrame >= 36)
         {
            this.destroy();
         }
      }
      
      public function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         var _loc1_:int = this.gc.otherList.indexOf(this);
         if(_loc1_ != -1)
         {
            this.gc.otherList.splice(_loc1_,1);
         }
      }
      
      private function checkAttack() : void
      {
         var _loc3_:BaseHero = null;
         var _loc4_:Object = null;
         var _loc5_:int = 0;
         if(this.gc.isYourFather)
         {
            return;
         }
         var _loc1_:Array = this.gc.getPlayerArray();
         var _loc2_:int = 0;
         while(_loc2_ < _loc1_.length)
         {
            _loc3_ = _loc1_[_loc2_] as BaseHero;
            if(!_loc3_.isYourFather && _loc3_.beAttackIdArray.indexOf(this.bb.getAttackId()) == -1)
            {
               if(_loc3_.colipse)
               {
                  if(HitTest.complexHitTestObject(_loc3_.colipse,this))
                  {
                     _loc5_ = (_loc4_ = this.bb.attackBackInfoDict["hit2"]).power;
                     _loc3_.publicSetBlood(_loc5_);
                     _loc3_.addHeroHurtMc(_loc5_);
                     if(_loc4_ && (_loc3_ is Role1 && !_loc3_.isGXP) || _loc3_ is Role2)
                     {
                        _loc3_.beAttackBack(this.bb,_loc4_.attackBackSpeed[0],_loc4_.attackBackSpeed[1]);
                     }
                     _loc3_.beAttackIdArray.push(this.bb.getAttackId());
                     _loc3_.beAttackDoing();
                     if(_loc4_.addEffect)
                     {
                        _loc3_.addCurAddEffect(_loc4_.addEffect as Array);
                     }
                     if(this.gc.gameMode == Config.MODE3)
                     {
                        this.gc.eventManger.dispatchEvent(new CommonEvent("HeroIsBeat",[_loc5_,this.bb]));
                     }
                  }
               }
            }
            _loc2_++;
         }
      }
   }
}
