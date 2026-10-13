package my
{
   import base.BaseHero;
   import config.*;
   import export.*;
   import flash.geom.*;
   
   public class ViewControllor
   {
       
      
      private var gc:Config;
      
      private var role1:BaseHero;
      
      private var role2:BaseHero;
      
      private var maxRightX:Number;
      
      private var maxBGRightX:Number;
      
      private var canBackward:Number = 0;
      
      private var thisStopX:Number = 0;
      
      private var lastPointX:Number = 0;
      
      private var isAutoCamera:Boolean = false;
      
      private var shakeVal:Number = 0;
      
      var count:int = 0;
      
      public function ViewControllor()
      {
         super();
         this.gc = Config.getInstance();
         this.maxRightX = 940 - this.gc.gameSence.width;
         this.maxBGRightX = 940 - this.gc.bg1.width;
      }
      
      public function shake(param1:int) : void
      {
         if(this.shakeVal == 0)
         {
            this.shakeVal = param1;
         }
      }
      
      public function step() : void
      {
         var _loc3_:StopPoint = null;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:StopPoint = null;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc1_:Rectangle = this.role1.colipse.getBounds(this.gc.gameSence.parent);
         var _loc2_:Rectangle = _loc1_;
         if(this.role2)
         {
            _loc2_ = this.role2.colipse.getBounds(this.gc.gameSence.parent);
         }
         var _loc4_:Number = this.maxRightX;
         var _loc5_:Number = this.maxBGRightX;
         var _loc6_:Number = 0;
         if((this.gc.pWorld.getStopPointArray() as Array).length > 0)
         {
            _loc3_ = this.gc.pWorld.getStopPointArray()[0] as StopPoint;
            if(this.lastPointX == 0)
            {
               _loc10_ = (this.gc.pWorld.getStopPointArray() as Array)[(this.gc.pWorld.getStopPointArray() as Array).length - 1] as StopPoint;
               this.lastPointX = _loc10_.getDataX();
            }
         }
         if(_loc3_)
         {
            _loc9_ = this.gc.gameSence.localToGlobal(new Point(_loc3_.getDataX(),_loc3_.y)).x;
         }
         else
         {
            this.thisStopX = -this.lastPointX + 870;
         }
         ++this.count;
         if(_loc1_.x >= 940 * 2 / 3 && _loc2_.x >= 940 / 5)
         {
            _loc8_ = (_loc7_ = Math.max(this.getMaxSpeedBetweenToPlayer(),0)) * (this.gc.bg1.width - 940) / (this.gc.gameSence.width - 940);
            if(this.thisStopX != 0 && this.gc.gameSence.x > this.thisStopX)
            {
               this.gc.gameSence.x -= _loc7_;
               this.gc.bg1.x -= _loc8_;
               if(this.canBackward != -99)
               {
                  this.canBackward += _loc7_;
               }
            }
            else if(_loc3_ && !_loc3_.isSendMonster)
            {
               this.gc.gameSence.x -= _loc7_;
               this.gc.bg1.x -= _loc8_;
               this.canBackward += _loc7_;
               if(_loc9_ <= 980 && _loc9_ >= 900)
               {
                  if(_loc3_)
                  {
                     this.canBackward = _loc3_.getLeftDataX();
                     this.thisStopX = this.gc.gameSence.x;
                     _loc3_.touch();
                  }
               }
               else
               {
                  this.canBackward = -99;
                  this.thisStopX = 0;
               }
            }
         }
         else if(_loc1_.x >= 940 / 5 && _loc2_.x >= 940 * 2 / 3)
         {
            _loc8_ = (_loc7_ = Math.max(this.getMaxSpeedBetweenToPlayer(),0)) * (this.gc.bg1.width - 940) / (this.gc.gameSence.width - 940);
            if(this.thisStopX != 0 && this.gc.gameSence.x > this.thisStopX)
            {
               this.gc.gameSence.x -= _loc7_;
               this.gc.bg1.x -= _loc8_;
               if(this.canBackward != -99)
               {
                  this.canBackward += _loc7_;
               }
            }
            else if(_loc3_ && !_loc3_.isSendMonster)
            {
               this.gc.gameSence.x -= _loc7_;
               this.gc.bg1.x -= _loc8_;
               this.canBackward += _loc7_;
               if(_loc9_ <= 980 && _loc9_ >= 900)
               {
                  if(_loc3_)
                  {
                     this.canBackward = _loc3_.getLeftDataX();
                     this.thisStopX = this.gc.gameSence.x;
                     _loc3_.touch();
                  }
               }
               else
               {
                  this.canBackward = -99;
                  this.thisStopX = 0;
               }
            }
         }
         else if(_loc1_.x <= 940 * 2 / 3 && _loc2_.x <= 940 / 5 && (this.canBackward > 0 || this.canBackward == -99))
         {
            if(this.canBackward > 0 || this.canBackward == -99)
            {
               _loc8_ = (_loc7_ = Math.min(this.getMinSpeedBetweenToPlayer(),0)) * (this.gc.bg1.width - 940) / (this.gc.gameSence.width - 940);
               if(this.gc.gameSence.x - _loc7_ <= 0)
               {
                  this.gc.gameSence.x -= _loc7_;
                  this.gc.bg1.x -= _loc8_;
                  if(this.canBackward > 0)
                  {
                     this.canBackward -= -_loc7_;
                  }
               }
            }
         }
         else if(_loc1_.x <= 940 / 5 && _loc2_.x <= 940 * 2 / 3 && (this.canBackward > 0 || this.canBackward == -99))
         {
            if(this.canBackward > 0 || this.canBackward == -99)
            {
               _loc8_ = (_loc7_ = Math.min(this.getMinSpeedBetweenToPlayer(),0)) * (this.gc.bg1.width - 940) / (this.gc.gameSence.width - 940);
               if(this.gc.gameSence.x - _loc7_ <= 0)
               {
                  this.gc.gameSence.x -= _loc7_;
                  this.gc.bg1.x -= _loc8_;
                  if(this.canBackward > 0)
                  {
                     this.canBackward -= -_loc7_;
                  }
               }
            }
         }
         if(this.shakeVal > 0)
         {
            this.gc.gameSence.x += this.shakeVal;
            this.shakeVal *= -1;
         }
         else if(this.shakeVal < 0)
         {
            this.gc.gameSence.x += this.shakeVal;
            this.shakeVal = 0;
         }
         if(this.shakeVal == 0)
         {
            if(this.isAutoCamera && _loc3_)
            {
               _loc11_ = Math.min(!!this.gc.hero1 ? Number(this.gc.hero1.x) : Number(99999),!!this.gc.hero2 ? Number(this.gc.hero2.x) : Number(99999));
               if((_loc12_ = this.gc.gameSence.localToGlobal(new Point(_loc11_,0)).x) > 450)
               {
                  _loc13_ = !!this.gc.hero1 ? int(Math.abs(this.gc.hero1.speed.x)) : 0;
                  _loc14_ = !!this.gc.hero2 ? int(Math.abs(this.gc.hero2.speed.x)) : 0;
                  if(Math.max(_loc13_,_loc14_) + 10 <= 30)
                  {
                     _loc7_ = Math.max(_loc13_,_loc14_) + 10;
                  }
                  else
                  {
                     _loc7_ = 30;
                  }
                  this.gc.gameSence.x -= _loc7_;
                  _loc8_ = _loc7_ * (this.gc.bg1.width - 940) / (this.gc.gameSence.width - 940);
                  this.gc.bg1.x -= _loc8_;
               }
               else
               {
                  this.isAutoCamera = false;
               }
               if(_loc9_ <= 1000 && _loc9_ >= 880)
               {
                  this.isAutoCamera = false;
               }
            }
         }
      }
      
      public function getLastPointX() : Number
      {
         return this.lastPointX;
      }
      
      public function setAutoCamera() : void
      {
         this.isAutoCamera = true;
      }
      
      private function getMaxSpeedBetweenToPlayer() : Number
      {
         var _loc1_:Number = -99;
         if(this.role1)
         {
            _loc1_ = this.role1.speed.x;
         }
         if(this.role2)
         {
            _loc1_ = _loc1_ > this.role2.speed.x ? Number(_loc1_) : Number(this.role2.speed.x);
         }
         return _loc1_;
      }
      
      private function getMinSpeedBetweenToPlayer() : Number
      {
         var _loc1_:Number = 99;
         if(this.role1)
         {
            _loc1_ = this.role1.speed.x;
         }
         if(this.role2)
         {
            _loc1_ = _loc1_ < this.role2.speed.x ? Number(_loc1_) : Number(this.role2.speed.x);
         }
         return _loc1_;
      }
      
      public function destroy() : void
      {
         this.role1 = null;
         this.role2 = null;
         this.isAutoCamera = false;
         this.shakeVal = 0;
      }
      
      public function setRole1(param1:BaseHero) : void
      {
         this.role1 = param1;
      }
      
      public function setRole2(param1:BaseHero) : void
      {
         this.role2 = param1;
      }
   }
}
