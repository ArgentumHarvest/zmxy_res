package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.MainGame;
   
   public class Monster47 extends BaseMonster
   {
       
      
      public function Monster47()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(500000);
         this.setSHp(500000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 100;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.5;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,-5],
            "attackInterval":24,
            "power":400,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":24,
            "power":500,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER47SLOW,
               "time":gc.frameClips * 5
            }]
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-4,0],
            "attackInterval":12,
            "power":100,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER47POISON,
               "time":gc.frameClips * 5
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-4,0],
            "attackInterval":999,
            "power":480,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "梼杌";
         this.setToCountSuppressLevel(40);
         this.setAction("wait");
         if(gc.curStageAndCurLevel.curStage == 46)
         {
            this._anti.fallList = [{
               "name":"xssp",
               "bigtype":"dj"
            }];
            this._anti.fallProbability = 0.5;
         }
         else
         {
            this._anti.fallProbability = 0.5;
            this._anti.fallList = [{
               "name":"wpzz",
               "bigtype":"dj"
            }];
         }
         this.skillCD1 = [gc.frameClips * 8,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 9,gc.frameClips * 9];
         this.skillCD3 = [gc.frameClips * 10,gc.frameClips * 20];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster47");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],400,300,new Point(0,0));
            if(gc.curStageAndCurLevel.curStage == 46)
            {
               bbdc.setOffsetXY(-45,-35);
            }
            else
            {
               bbdc.setOffsetXY(-45,-55);
            }
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,2,10],[2,2,10],[2,2,10],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,4,3,3,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster47--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("Monster155Spritenew") as Sprite;
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
            case "hit2":
               this.setStatic();
               this.setAction("wait");
               break;
            case "hit3":
               this.setAction("wait");
               break;
            case "hit4":
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
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi4(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster47Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 170;
         }
         else
         {
            b.x = this.x + 170;
         }
         b.y = this.y - 95;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b1:SpecialEffectBullet = new SpecialEffectBullet("Monster47Bullet2_1");
         if(direct == 0)
         {
            b1.x = this.x - 95;
         }
         else
         {
            b1.x = this.x + 95;
         }
         b1.y = this.y + 15;
         b1.setRole(this);
         b1.setDirect(direct);
         b1.setAction("hit2");
         gc.gameSence.addChild(b1);
         this.magicBulletArray.push(b1);
         var b2:SpecialEffectBullet = new SpecialEffectBullet("Monster47Bullet2_2");
         if(direct == 0)
         {
            b2.x = this.x - 60;
         }
         else
         {
            b2.x = this.x + 60;
         }
         b2.y = this.y - 50;
         b2.setRole(this);
         b2.setDirect(direct);
         b2.setAction("hit2");
         gc.gameSence.addChild(b2);
         this.magicBulletArray.push(b2);
         var b3:SpecialEffectBullet = new SpecialEffectBullet("Monster47Bullet2_3");
         if(direct == 0)
         {
            b3.x = this.x - 25;
         }
         else
         {
            b3.x = this.x + 25;
         }
         b3.y = this.y - 95;
         b3.setRole(this);
         b3.setDirect(direct);
         b3.setAction("hit2");
         gc.gameSence.addChild(b3);
         this.magicBulletArray.push(b3);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster47Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 180;
         }
         else
         {
            b.x = this.x + 180;
         }
         b.y = this.y - 130;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi4(direct:uint) : void
      {
         direct = direct;
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster47Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 100;
         }
         else
         {
            b.x = this.x + 100;
         }
         b.y = this.y - 100;
         b.setRole(this);
         b.setDisable();
         b.setHurtCanCutDownEffect(false);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         TweenMax.delayedCall(1,function():*
         {
            gc.pWorld.getBaseLevelListener().startBlackBG();
            TweenMax.delayedCall(10,function():*
            {
               gc.pWorld.getBaseLevelListener().stopBlackBG();
            });
         });
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
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.isDead())
         {
            MainGame.getInstance().createLikeMonster(75,this.x,this.y - 50);
         }
         if(gc.curStageAndCurLevel.curStage != 46)
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
      }
   }
}
