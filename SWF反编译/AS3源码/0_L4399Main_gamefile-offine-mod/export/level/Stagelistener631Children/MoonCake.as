package export.level.Stagelistener631Children
{
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import flash.display.MovieClip;
   
   public class MoonCake extends BaseObject
   {
       
      
      private var _state:int = 1;
      
      private var mc:MovieClip;
      
      private var beAttackArray:Array;
      
      private var _hp:int = 100;
      
      public function MoonCake()
      {
         beAttackArray = [];
         super();
         this.mc = AUtils.getNewObj("MoonCake2014") as MovieClip;
         this.addChild(this.mc);
         this.mc.hit.visible = false;
         this.setFrameByHp();
      }
      
      override public function step() : void
      {
         var img:* = null;
         for each(var bm in gc.pWorld.monsterArray)
         {
            for each(var bb in bm.magicBulletArray)
            {
               if(bb.getImgMc().hitTestObject(this.mc.hit))
               {
                  if(this.beAttackArray.indexOf(bb.getAttackId()) == -1)
                  {
                     if(this._hp > 1)
                     {
                        this._hp--;
                     }
                     this.setFrameByHp();
                     this.beAttackArray.push(bb.getAttackId());
                     img = AUtils.getNewObj("HeroBeHurt");
                     img.x = 0;
                     img.y = 0;
                     this.addChild(img);
                     this.beAttackArray.push(bb.getAttackId());
                  }
               }
            }
         }
      }
      
      private function setFrameByHp() : void
      {
         this.mc.stop();
         if(this._hp <= 25)
         {
            if(this.mc.currentFrame != 1)
            {
               this.mc.gotoAndStop(1);
            }
         }
         else if(this._hp <= 50)
         {
            if(this.mc.currentFrame != 2)
            {
               this.mc.gotoAndStop(2);
            }
         }
         else if(this._hp <= 75)
         {
            if(this.mc.currentFrame != 3)
            {
               this.mc.gotoAndStop(3);
            }
         }
         else if(this.mc.currentFrame != 4)
         {
            this.mc.gotoAndStop(4);
         }
      }
      
      public function destroy() : void
      {
         this.mc = null;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(value:int) : void
      {
         _state = value;
         this.mc.gotoAndStop(value);
      }
      
      public function get hp() : int
      {
         return _hp;
      }
      
      public function set hp(value:int) : void
      {
         _hp = value;
         if(_hp < 1)
         {
            _hp = 1;
         }
         this.setFrameByHp();
      }
   }
}
