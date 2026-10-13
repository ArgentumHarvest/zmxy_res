package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import base.BaseObject;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import my.MainGame;
   
   public class Monster2003 extends BaseMonster
   {
       
      
      private var buffIndex:int = 0;
      
      public var isCall:Boolean = false;
      
      private var isInBuff:Boolean = false;
      
      public function Monster2003()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 3;
         this.setHp(6000000);
         this.setSHp(6000000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 500;
         this._anti.exp = 5000;
         this._anti.gxp = 2000;
         this._anti.mDef = 0.5;
         this._anti.miss = 0.2;
         this._anti.crit = 0.2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":3000,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":3000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":3000,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "赤月神君";
         this.setAction("wait");
         this.setToCountSuppressLevel(80);
         this._anti.fallProbability = 0.2;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 10,gc.frameClips * 15];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
         this.buffIndex = setTimeout(doBuff,15000);
      }
      
      private function doBuff() : void
      {
         this.getBBDC().alpha = 0.5;
         this._anti.miss = 0.6;
         this.isInBuff = true;
         this.buffIndex = setTimeout(clearBuff,9000);
      }
      
      private function clearBuff() : void
      {
         this.getBBDC().alpha = 1;
         this._anti.miss = 0.2;
         this.isInBuff = false;
         this.buffIndex = setTimeout(doBuff,15000);
      }
      
      public function setCall() : void
      {
         this.isCall = true;
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"cs_wq_ll",
            "bigtype":"zb"
         },{
            "name":"cs_wq_qs",
            "bigtype":"zb"
         },{
            "name":"cs_wq_rc",
            "bigtype":"zb"
         },{
            "name":"cs_wq_yt",
            "bigtype":"zb"
         }];
         this.setHue(150);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster205");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],400,300,new Point(0,0));
            bbdc.setOffsetXY(30,-15);
            bbdc.setFrameStopCount([[3,3,3,3,3,3],[4,4,4,4],[8],[2,2,2,2,2,10],[2,2,10,2,2,10],[3,3,3,3,3,3],[30]]);
            bbdc.setFrameCount([6,4,1,6,6,6,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster205--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite2") as Sprite;
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
            case "hit3":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
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
            case "hit3":
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
         var count:int = 0;
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1_1(direct);
                  }
               }
               else if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1_2(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 3)
                  {
                     this.doHi2_1(direct);
                     this.doHi2_2(direct);
                  }
               }
               else if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 3)
                  {
                     this.doHi2_2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  count = this.bbdc.getCurFrameCount();
                  if(count == 30)
                  {
                     this.doHi3(direct);
                  }
                  if(count > 25)
                  {
                     if(direct == 0)
                     {
                        if(this.x < 50)
                        {
                           this.speed.x = 0;
                        }
                        else
                        {
                           this.speed.x = -50;
                        }
                     }
                     else if(this.x > 880)
                     {
                        this.speed.x = 0;
                     }
                     else
                     {
                        this.speed.x = 50;
                     }
                  }
                  else
                  {
                     this.speed.x = 0;
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(25);
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
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(60);
         this.setAction("hit3");
         this.lastHit = "hit3";
         if(gc.isInRoom())
         {
            if(gc.isRoomOnwer)
            {
               gc.sendMonsterAction(this);
            }
         }
      }
      
      private function doHi1_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster205Bullet1_1");
         if(direct == 0)
         {
            b.x = this.x - 194;
         }
         else
         {
            b.x = this.x + 194;
         }
         b.y = this.y - 177;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi1_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster205Bullet1_2");
         if(direct == 0)
         {
            b.x = this.x - 307;
         }
         else
         {
            b.x = this.x + 307;
         }
         b.y = this.y - 18;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster205Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 123;
         }
         else
         {
            b.x = this.x + 123;
         }
         b.y = this.y - 150;
         b.setHurtCanCutDownEffect(false);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster205Bullet2_2");
         if(direct == 0)
         {
            b.x = this.x - 153;
         }
         else
         {
            b.x = this.x + 153;
         }
         b.y = this.y - 167;
         b.setRole(this);
         b.setHurtCanCutDownEffect(false);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster205Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 70;
         }
         else
         {
            b.x = this.x + 70;
         }
         b.y = this.y - 20;
         b.setHurtCanCutDownEffect(false);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function beMagicAttack(_target:BaseBullet, sr:BaseObject, force:Boolean = false) : Boolean
      {
         var bool:Boolean = super.beMagicAttack(_target,sr,force);
         if(!bool)
         {
         }
         return bool;
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
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit3";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         clearTimeout(this.buffIndex);
         if(this.getHp() <= 0)
         {
            if(this.isCall)
            {
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
            else if(gc.isInRoom())
            {
               if(gc.isRoomOnwer)
               {
                  MainGame.getInstance().createMonster(2004,this.x,this.y,-1,2);
               }
            }
         }
         super.destroy();
      }
   }
}
