package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   
   public class Monster138 extends BaseMonster
   {
       
      
      public function Monster138()
      {
         super();
         this.horizenSpeed = 4;
         this.monsterName = "二郎神";
         this.isBoss = true;
         this.setHp(1200000);
         this.setSHp(1200000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 108;
         this._anti.exp = 2000;
         this._anti.gxp = 1000;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":8,
            "power":1300,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-35,-4],
            "attackInterval":24,
            "power":2000,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 3
            }]
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-4,2],
            "attackInterval":3,
            "power":1000,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,2],
            "attackInterval":15,
            "power":328,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit5"] = {
            "hitMaxCount":999,
            "attackBackSpeed":[-4,2],
            "attackInterval":24,
            "power":492,
            "attackKind":"magic"
         };
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 10,gc.frameClips * 10];
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      override protected function __added(evt:Event) : void
      {
         super.__added(evt);
         this.dohit5(this.bbdc.getDirect());
      }
      
      private function dohit5(direct:int) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster138Buff");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 999);
         b.setDirect(direct);
         b.setAction("hit5");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster22");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],400,300,new Point(0,0));
            bbdc.setOffsetXY(22,-65);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[2,2,2,2,2,10],[2,2,10],[2,2,10],[1,1,2,1,1,2],[1,1,2,1,1,10],[2,30],[2,2,8],[8]]);
            bbdc.setFrameCount([6,4,6,3,3,6,6,2,3,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster22--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
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
               if(curPoint.y != 9)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(9);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 8)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(8);
               }
               this.bbdc.setState(str);
               break;
            case "hit2_1":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "hit2_2":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit3_1":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit3_2":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
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
            case "hit2_1":
               this.setPositionAfterTarget();
               this.setAction("hit2_2");
               break;
            case "hit2_2":
               this.setAction("wait");
               break;
            case "hit3_1":
               this.setAction("hit3_2");
               break;
            case "hit3_2":
               this.setAction("wait");
               break;
            case "hit4":
               this.setAction("wait");
               break;
            case "hit7":
               this.setStatic();
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
      
      private function setPositionAfterTarget() : void
      {
         if(this.curAttackTarget)
         {
            if(this.curAttackTarget.getBBDC().getDirect() == 0)
            {
               this.x = this.curAttackTarget.x + 180;
               this.turnLeft();
            }
            else
            {
               this.x = this.curAttackTarget.x - 180;
               this.turnRight();
            }
            this.y = this.curAttackTarget.y - 60;
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
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     this.doHit1(direct);
                  }
               }
               break;
            case "hit2_1":
               break;
            case "hit2_2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3_1":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit3(direct);
                  }
               }
               break;
            case "hit3_2":
               break;
            case "hit4":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     this.doHit4_1(direct);
                  }
                  else if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.checkDoHit4();
                  }
               }
         }
      }
      
      private function doHit1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster22Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 220;
         }
         else
         {
            b.x = this.x + 220;
         }
         b.y = this.y - 40;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster22Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 140;
         }
         else
         {
            b.x = this.x + 140;
         }
         b.y = this.y - 160;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(24);
         this.setAction("hit2_1");
         this.lastHit = "hit2_1";
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(26);
         this.setAction("hit3_1");
         this.lastHit = "hit3_1";
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 300;
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 500;
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster22Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 140;
         }
         else
         {
            b.x = this.x + 140;
         }
         b.y = this.y - 160;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster22Bullet4_1");
         if(direct == 0)
         {
            b.x = this.x - 170;
         }
         else
         {
            b.x = this.x + 170;
         }
         b.y = this.y - 160;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function checkDoHit4() : void
      {
         var flag:Boolean = false;
         for each(var bh in gc.getPlayerArray())
         {
            flag = false;
            if(this.x > bh.x)
            {
               if(this.getBBDC().getDirect() == 0 && bh.getBBDC().getDirect() == 1)
               {
                  flag = true;
               }
            }
            else if(this.getBBDC().getDirect() == 1 && bh.getBBDC().getDirect() == 0)
            {
               flag = true;
            }
            if(flag)
            {
               bh.addCurAddEffect([{
                  "name":BaseAddEffect.ERLANGSHEN_HP_REJECT,
                  "time":gc.frameClips * 10
               }]);
               break;
            }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2_1" || this.curAction == "hit2_2" || this.curAction == "hit3_1" || this.curAction == "hit3_2" || this.curAction == "hit4";
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
         super.destroy();
         if(this.getHp() <= 0)
         {
            if(gc.allTask)
            {
               gc.allTask.killRewardMonster("Monster138");
            }
         }
      }
   }
}
