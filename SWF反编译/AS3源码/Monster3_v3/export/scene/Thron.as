package export.scene
{
   import base.BaseHero;
   import config.*;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.*;
   import my.*;
   
   public class Thron extends MovieClip
   {
       
      
      public var isUp:Boolean;
      
      public var isthron:Sprite;
      
      private var gc:Config;
      
      private var originalX:Number;
      
      private var originalY:Number;
      
      private var gravity:Number = 0;
      
      public var isfalling:Boolean = false;
      
      private var count:uint = 0;
      
      private var idid:int = 1;
      
      private var checkPerCount:int = 5;
      
      public function Thron()
      {
         super();
         this.gc = Config.getInstance();
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:Event) : void
      {
         this.originalX = this.x;
         this.originalY = this.y;
      }
      
      private function removed(param1:Event) : void
      {
      }
      
      public function step() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:BaseHero = null;
         if(this.count % this.checkPerCount == 0)
         {
            _loc1_ = this.gc.getPlayerArray().length;
            while(_loc1_-- > 0)
            {
               _loc2_ = this.gc.getPlayerArray()[_loc1_];
               if(Math.abs(this.x - _loc2_.x) < 80)
               {
                  if(this.isUp)
                  {
                     this.checkFallDown(_loc2_);
                  }
                  if(Math.abs(this.y - _loc2_.y) < 90)
                  {
                     this.colwho(_loc2_);
                  }
               }
            }
         }
         if(this.isUp && this.isfalling)
         {
            this.fallDown();
         }
         this.reBack();
      }
      
      protected function colwho(param1:BaseHero) : void
      {
         if(param1.body)
         {
            if(param1.isYourFather)
            {
               return;
            }
            if(param1.beAttackIdArray.indexOf(this.getAttackId()) != -1)
            {
               return;
            }
            if(HitTest.complexHitTestObject(this,param1.colipse))
            {
               param1.beAttackBack(this,10,10);
               param1.reduceHp(30);
               param1.addHeroHurtMc(30);
               param1.beAttackDoing();
               param1.beAttackIdArray.push(this.getAttackId());
            }
         }
      }
      
      private function getAttackId() : String
      {
         return this.name + this.idid;
      }
      
      private function remove() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function fallDown() : void
      {
         if(this.isfalling)
         {
            ++this.gravity;
            this.y += this.gravity;
         }
      }
      
      private function checkFallDown(param1:BaseHero) : void
      {
         if(!this.isfalling)
         {
            if(this.x - this.width / 2 <= param1.x + param1.width / 2 - 5 && this.x + this.width / 2 >= param1.x - param1.width / 2 + 5)
            {
               if(this.currentLabel != "fall")
               {
                  this.gotoAndPlay(2);
               }
            }
         }
      }
      
      private function reBack() : void
      {
         if(this.isUp)
         {
            if(this.y >= 500)
            {
               this.visible = false;
               if(this.y >= 1000)
               {
                  this.visible = true;
                  this.isfalling = false;
                  this.gravity = 0;
                  this.x = this.originalX;
                  this.y = this.originalY;
                  ++this.idid;
               }
            }
         }
         else if(this.count++ >= 24)
         {
            ++this.idid;
            this.count = 0;
         }
      }
   }
}
