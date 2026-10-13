package base
{
   import config.*;
   import export.hero.*;
   import flash.display.MovieClip;
   import flash.filters.*;
   import flash.utils.*;
   
   public class BaseAddEffect
   {
      
      public static var POISON:String = "poison";
      
      public static var FATHER:String = "father";
      
      public static var ICE:String = "ice";
       
      
      private var sourceRole:BaseObject;
      
      private var curEffectArray:Array;
      
      private var beAttackFatherTotalCount:int = 5;
      
      private var beAttackFatherCurCount:int = 0;
      
      private var lastBeAttackTime:int;
      
      private var gc:Config;
      
      private var glow:GlowFilter;
      
      private var count:int = 0;
      
      public function BaseAddEffect(param1:BaseObject)
      {
         this.curEffectArray = [];
         super();
         this.sourceRole = param1;
         this.gc = Config.getInstance();
      }
      
      public function step() : void
      {
         var _loc2_:Object = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.curEffectArray.length)
         {
            _loc2_ = this.curEffectArray[_loc1_];
            if(_loc2_.isFirst)
            {
               _loc2_.startTime = this.count;
               _loc2_.isFirst = false;
               if(_loc2_.name == BaseAddEffect.POISON)
               {
                  this.showPoison();
               }
               if(_loc2_.name == BaseAddEffect.ICE)
               {
                  this.showIce();
               }
            }
            if(_loc2_.isForever != 1 && this.count - _loc2_.startTime >= _loc2_.time)
            {
               this.remove(_loc2_);
            }
            if(_loc2_.name == BaseAddEffect.POISON)
            {
               if(this.count % 24 == 0)
               {
                  this.sourceRole.reduceHp(_loc2_.power);
                  if(this.sourceRole is BaseHero)
                  {
                     BaseHero(this.sourceRole).addHeroHurtMc(_loc2_.power);
                  }
               }
            }
            if(_loc2_.name == BaseAddEffect.FATHER)
            {
               if(getTimer() - this.lastBeAttackTime >= _loc2_.interval)
               {
                  this.beAttackFatherCurCount = 0;
               }
            }
            _loc1_++;
         }
         if(this.sourceRole.isGXP || this.sourceRole.isYourFather)
         {
            this.myGlow();
         }
         else if(!this.sourceRole.isGXP && !this.sourceRole.isYourFather)
         {
            this.cancelGlow();
         }
         ++this.count;
      }
      
      protected function cancelGlow() : void
      {
         this.glow = null;
         this.sourceRole.filters = [];
      }
      
      protected function myGlow() : void
      {
         if(this.sourceRole.isGXP)
         {
            if(!this.glow)
            {
               this.glow = new GlowFilter(16777215,1,15,15,1.5,BitmapFilterQuality.HIGH,false,false);
            }
            else
            {
               this.glow.color = 16777215;
               if(this.glow.blurX > 6 && this.glow.alpha == 1)
               {
                  --this.glow.blurX;
                  --this.glow.blurY;
                  if(this.glow.blurX == 6)
                  {
                     this.glow.alpha = 0.8;
                  }
               }
               if(this.glow.blurX < 15 && this.glow.alpha == 0.8)
               {
                  ++this.glow.blurX;
                  ++this.glow.blurY;
                  if(this.glow.blurX == 15)
                  {
                     this.glow.alpha = 1;
                  }
               }
            }
         }
         else if(this.sourceRole.isYourFather)
         {
            if(!this.glow)
            {
               if(this.sourceRole is Role1)
               {
                  this.glow = new GlowFilter(16711680,1,15,15,1.5,BitmapFilterQuality.HIGH,false,false);
               }
               else if(this.sourceRole is Role2)
               {
                  this.glow = new GlowFilter(255,1,15,15,1.5,BitmapFilterQuality.HIGH,false,false);
               }
            }
            else
            {
               if(this.sourceRole is Role1)
               {
                  this.glow.color = 16711680;
               }
               else if(this.sourceRole is Role2)
               {
                  this.glow.color = 255;
               }
               if(this.glow.blurX > 6 && this.glow.alpha == 1)
               {
                  --this.glow.blurX;
                  --this.glow.blurY;
                  if(this.glow.blurX == 6)
                  {
                     this.glow.alpha = 0.8;
                  }
               }
               if(this.glow.blurX < 15 && this.glow.alpha == 0.8)
               {
                  ++this.glow.blurX;
                  ++this.glow.blurY;
                  if(this.glow.blurX == 15)
                  {
                     this.glow.alpha = 1;
                  }
               }
            }
         }
         this.sourceRole.filters = [this.glow];
      }
      
      private function getInfoObj(param1:String) : Object
      {
         var _loc3_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < this.curEffectArray.length)
         {
            _loc3_ = this.curEffectArray[_loc2_];
            if(_loc3_.name == param1)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function updateFather() : void
      {
         var _loc1_:Object = this.getInfoObj("father");
         if(!_loc1_)
         {
            return;
         }
         if(this.beAttackFatherCurCount < this.beAttackFatherTotalCount)
         {
            ++this.beAttackFatherCurCount;
            if(this.beAttackFatherCurCount >= this.beAttackFatherTotalCount)
            {
               this.sourceRole.setYourFather(_loc1_.time);
               this.beAttackFatherCurCount = 0;
            }
         }
         this.lastBeAttackTime = getTimer();
      }
      
      public function add(param1:Array) : void
      {
         var _loc3_:Object = null;
         var _loc4_:Object = null;
         var _loc2_:int = 0;
         while(_loc2_ < param1.length)
         {
            _loc3_ = param1[_loc2_];
            if(this.curEffectArray.indexOf(_loc3_) == -1)
            {
               _loc3_.isFirst = true;
               this.curEffectArray.push(_loc3_);
            }
            else
            {
               (_loc4_ = this.curEffectArray[this.curEffectArray.indexOf(_loc3_)]).time = _loc3_.time;
            }
            if(_loc3_.name == BaseAddEffect.POISON)
            {
               this.showPoisonUp();
            }
            _loc2_++;
         }
      }
      
      public function remove(param1:Object) : void
      {
         var _loc2_:int = this.curEffectArray.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.curEffectArray.splice(_loc2_,1);
         }
         if(param1.name == BaseAddEffect.POISON)
         {
            this.hidePoison();
         }
         if(param1.name == BaseAddEffect.ICE)
         {
            this.hideIce();
         }
      }
      
      public function init() : void
      {
         this.curEffectArray = [];
         this.count = 0;
         this.beAttackFatherCurCount = 0;
         this.hidePoison();
         this.hideIce();
      }
      
      protected function showIce() : void
      {
         var _loc1_:MovieClip = null;
         if(!this.sourceRole.getChildByName("ice"))
         {
            _loc1_ = AUtils.getNewObj("ice");
            _loc1_.name = "ice";
            _loc1_.x = -90;
            _loc1_.y = -115;
            this.sourceRole.addChild(_loc1_);
         }
         if(this.sourceRole is BaseHero)
         {
            this.gc.keyboardControl.setNoControlByPlayer(BaseHero(this.sourceRole).getPlayer());
         }
         this.sourceRole.setStatic();
      }
      
      protected function hideIce() : void
      {
         if(this.sourceRole.getChildByName("ice"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("ice"));
         }
         if(this.sourceRole is BaseHero)
         {
            this.gc.keyboardControl.setYesControlByPlayer(BaseHero(this.sourceRole).getPlayer());
         }
      }
      
      protected function showPoison() : void
      {
         var _loc1_:MovieClip = null;
         if(!this.sourceRole.getChildByName("poisonHead"))
         {
            _loc1_ = AUtils.getNewObj("poisonHead");
            _loc1_.name = "poisonHead";
            _loc1_.y = -70;
            this.sourceRole.addChild(_loc1_);
         }
      }
      
      protected function showPoisonUp() : void
      {
         var _loc1_:MovieClip = null;
         if(!this.sourceRole.getChildByName("poisonUp"))
         {
            _loc1_ = AUtils.getNewObj("poisonUp");
            _loc1_.name = "poisonUp";
            _loc1_.y = -50;
            this.sourceRole.addChild(_loc1_);
         }
      }
      
      protected function hidePoison() : void
      {
         if(this.sourceRole.getChildByName("poisonHead"))
         {
            this.sourceRole.removeChild(this.sourceRole.getChildByName("poisonHead"));
         }
      }
   }
}
