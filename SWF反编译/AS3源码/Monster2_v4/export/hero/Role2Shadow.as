package export.hero
{
   import base.*;
   import config.*;
   import export.bullet.*;
   
   public class Role2Shadow extends BaseHero
   {
       
      
      public var source:Role2;
      
      private var maxCount:int = 192.0;
      
      public function Role2Shadow()
      {
         super();
         this.horizenSpeed = 8;
         this.curAction = "walk";
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":200,
            "attackBackSpeed":[6,-7],
            "attackInterval":999,
            "attackKind":"magic"
         };
      }
      
      override protected function stepOther() : void
      {
      }
      
      override public function step() : void
      {
         super.step();
         --this.maxCount;
         if(this.maxCount <= 0)
         {
            this.destroy();
            this.source.shadow = null;
         }
      }
      
      public function doHit3() : void
      {
         this.lastHit = "hit3";
         this.curAction = "hit3";
         this.setStatic();
      }
      
      public function doHit5() : void
      {
         this.lastHit = "hit5";
         this.curAction = "hit5";
         this.setStatic();
      }
      
      public function SpecialAttack() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Role2Bullet3");
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         _loc1_.setRole(this);
         if(this.source.isGXP)
         {
            _loc1_.setScale(1.8,1.8);
         }
         _loc1_.setAction(this.lastHit);
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
      
      public function setSource(param1:Role2) : void
      {
         this.source = param1;
      }
      
      public function cureRole() : void
      {
         var _loc2_:int = 0;
         var _loc4_:BaseHero = null;
         var _loc1_:Array = gc.getPlayerArray();
         var _loc3_:int = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(!((_loc4_ = BaseHero(_loc1_[_loc3_])) is Role2))
            {
               if(gc.gameMode != Config.MODE3)
               {
                  if(Math.abs(_loc4_.x - this.x) <= 200 && Math.abs(_loc4_.y - this.y) <= 160)
                  {
                     _loc2_ = this.getRealPower("hit5");
                     _loc4_.cureHp(_loc2_);
                  }
               }
            }
            else if(Math.abs(_loc4_.x - this.x) <= 200 && Math.abs(_loc4_.y - this.y) <= 160)
            {
               _loc2_ = this.getRealPower("hit5");
               _loc4_.cureHp(_loc2_);
            }
            _loc3_++;
         }
      }
      
      override public function getRealPower(param1:String) : int
      {
         var _loc2_:Number = 1;
         if(this.source.isGXP)
         {
            _loc2_ = 1.5;
         }
         switch(param1)
         {
            case "hit3":
               return this.source.roleProperies.getPower() * 0.8 * _loc2_;
            case "hit5":
               return (this.source.roleProperies.getSMMP() / 8 + 8) * _loc2_;
            default:
               return 0;
         }
      }
      
      override public function destroy() : void
      {
         var _loc1_:int = 0;
         if(this.parent)
         {
            this.parent.removeChild(this);
            _loc1_ = gc.otherList.indexOf(this);
            if(_loc1_ != -1)
            {
               gc.otherList.splice(_loc1_,1);
            }
         }
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit3" || this.curAction == "hit4" || this.curAction == "hit5";
      }
      
      override public function isNormalHit() : Boolean
      {
         return false;
      }
   }
}
