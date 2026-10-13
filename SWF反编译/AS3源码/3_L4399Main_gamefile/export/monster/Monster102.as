package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.MainGame;
   
   public class Monster102 extends BaseMonster
   {
       
      
      private var turnBackInterval:uint = 96;
      
      private var turnBackIntervalCount:uint = 0;
      
      public function Monster102()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(100000);
         this.setSHp(100000);
         this.normalAttackRate = 1;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 100;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this._anti.mDef = 0.3;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "power":150,
            "attackKind":"physics"
         };
         this.isBoss = true;
         this.monsterName = "牛魔王";
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 1,gc.frameClips * 10];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster102");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(-10,-25);
            bbdc.setFrameStopCount([[4,4,4,4]]);
            bbdc.setFrameCount([4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster102--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSpriteMonster102") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(str != "dead" && str != "wait")
         {
            str = "wait";
         }
         super.setAction(str);
         var curPoint:Point = this.bbdc.getCurPoint();
         switch(str)
         {
            case "wait":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "dead":
               MainGame.getInstance().createMonster(103,800,300);
               this.dropAura();
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         state;
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster102Bullet1");
         b.x = this.x;
         b.y = this.y;
         b.setDestroyWhenLastFrame(false);
         b.setHurtCanCutDownEffect(false);
         b.setDestroyInCount(gc.frameClips * 10);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return true;
      }
      
      override protected function releSkill1() : void
      {
         this.doHi1(0);
      }
      
      override protected function move() : void
      {
         if(this.isCanMoveByStage())
         {
            super.move();
         }
      }
      
      override protected function hasAttackTarget() : void
      {
         if(this.beforeSkill1Start() && this.skillCD1[0] == 0)
         {
            this.releSkill1();
            this.skillCD1[0] = this.skillCD1[1];
         }
      }
      
      override protected function myIntelligence() : void
      {
         this.hasAttackTarget();
         if(this.getBBDC().getDirect() == 0)
         {
            this.speed.x = -10;
         }
         else
         {
            this.speed.x = 10;
         }
         if(this.isCanMoveByStage())
         {
            this.setYourFather(2);
         }
         else if(this.turnBackIntervalCount < this.turnBackInterval)
         {
            this.turnBackIntervalCount++;
            if(this.turnBackIntervalCount == this.turnBackInterval)
            {
               if(this.getBBDC().getDirect() == 0)
               {
                  this.turnRight();
               }
               else
               {
                  this.turnLeft();
               }
               this.turnBackIntervalCount = 0;
            }
         }
      }
      
      override protected function attackTarget() : void
      {
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return true;
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1";
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
