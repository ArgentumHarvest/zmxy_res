package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener01;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster2002 extends BaseMonster
   {
       
      
      private const DEF_HP_CONST:int = 10000;
      
      private var hit3DefHp:int = 10000;
      
      private var averLevel:uint = 0;
      
      public function Monster2002()
      {
         super();
         this.horizenSpeed = 6;
         averLevel = 85;
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 6;
         this.setHp(10000 + averLevel * 20000);
         this.setSHp(this.getHp());
         this.normalAttackRate = 0.7;
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 750;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.5;
         var baseHurt:uint = 1400;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[1,0],
            "attackInterval":30,
            "power":baseHurt,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-14,-5],
            "attackInterval":999,
            "power":baseHurt,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "禄存星君";
         this.setAction("wait");
         this._anti.fallProbability = 0.75;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 9];
         this.skillCD2 = [gc.frameClips * 8,gc.frameClips * 11];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster179");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(4,-20);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[12,2,10]]);
            bbdc.setFrameCount([6,4,1,5,3,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster179--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(str == "hit3")
         {
            this.doHi3_1(0);
            return;
         }
         if(str == "hit4")
         {
            for each(var bb in this.magicBulletArray)
            {
               if(bb.getImcName() == "Monster179Bullet3_1")
               {
                  bb.destroy();
                  this.doHi3_2(0);
                  break;
               }
            }
            return;
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
            case "walk":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.setStatic();
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
         }
      }
      
      override protected function scriptFrameOverFunc(row:int) : void
      {
         var state:String = this.bbdc.getState();
         switch(state)
         {
            case "walk":
               this.bbdc.setFramePointX(0);
               break;
            case "wait":
               this.bbdc.setFramePointX(0);
               break;
            case "hit1":
               this.setAction("wait");
               break;
            case "hit2":
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.dropAura();
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 12)
                  {
                     this.doHi2_1(direct);
                  }
               }
               else if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_2(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster179Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 100;
         }
         else
         {
            b.x = this.x + 100;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster179Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 125;
         }
         else
         {
            b.x = this.x + 125;
         }
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(12);
         b.setDisable();
         b.y = this.y - 190;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster179Bullet2_2");
         if(direct == 0)
         {
            b.x = this.x - 50;
            b.setSpeed(-2,0.5);
            b.setAddSpeed(-0.5,0.125);
         }
         else
         {
            b.x = this.x + 50;
            b.setSpeed(2,0.5);
            b.setAddSpeed(0.5,0.125);
         }
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 8);
         b.y = this.y - 80;
         b.setDistance(800);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3_1(direct:uint) : void
      {
         this.hit3DefHp = 10000;
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster179Bullet3_1");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 6);
         b.setHurtCanCutDownEffect(false);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3_2(direct:uint) : void
      {
         var temp:* = null;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster179Bullet3_2");
         b.x = this.x;
         b.y = this.y + 60;
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(10);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         if(gc.isInRoom())
         {
            temp = this.curAction;
            this.curAction = "hit4";
            gc.sendMonsterAction(this);
            this.curAction = temp;
         }
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         var hit3_1:* = null;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster179Bullet3_1")
            {
               hit3_1 = bb;
               break;
            }
         }
         if(hit3_1)
         {
            if(this.hit3DefHp > 0)
            {
               this.hit3DefHp -= re;
               if(this.hit3DefHp <= 0)
               {
                  hit3_1.destroy();
                  this.doHi3_2(0);
               }
               re -= this.hit3DefHp;
               if(re < 0)
               {
                  re = 0;
               }
            }
         }
         super.reduceHp(re,canHurt);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.standInObj && this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(20);
         this.setAction("hit2");
         this.lastHit = "hit2";
         if(gc.isInRoom())
         {
            if(gc.isRoomOnwer)
            {
               gc.sendMonsterAction(this);
            }
         }
      }
      
      override protected function releSkill2() : void
      {
         var temp:* = null;
         this.newAttackId();
         this.faceToTarget();
         this.doHi3_1(0);
         if(gc.isInRoom())
         {
            if(gc.isRoomOnwer)
            {
               temp = this.curAction;
               this.curAction = "hit3";
               gc.sendMonsterAction(this);
               this.curAction = temp;
            }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override public function destroy() : void
      {
         var bl:* = null;
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.getHp() <= 0)
         {
            bl = gc.pWorld.getBaseLevelListener();
            if(bl is StageListener01)
            {
               (bl as StageListener01).fallGuihua(this.x,this.y);
            }
         }
         super.destroy();
         if(this.isBoss)
         {
            ta = gc.pWorld.getTransferDoorArray();
            for(i = 0; i < ta.length; )
            {
               mc = ta[i];
               mc.visible = true;
               i++;
            }
         }
      }
   }
}
