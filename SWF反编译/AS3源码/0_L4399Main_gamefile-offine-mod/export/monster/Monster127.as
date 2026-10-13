package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster127 extends BaseMonster
   {
       
      
      public function Monster127()
      {
         super();
         this.horizenSpeed = 6;
         this.setHp(1800000);
         this.setSHp(1800000);
         this._anti.def = 300;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":800,
            "power":1600,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":1200,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":900,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":2000,
            "attackKind":"magic"
         };
         this.attackRange = 200;
         this.alertRange = 1000;
         this.isBoss = true;
         this.monsterName = "罗宣";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 7,gc.frameClips * 15];
         this.skillCD3 = [gc.frameClips * 9,gc.frameClips * 20];
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"cs_wq_ll_zzs",
            "bigtype":"dj"
         },{
            "name":"cs_wq_yt_zzs",
            "bigtype":"dj"
         },{
            "name":"cs_wq_qs_zzs",
            "bigtype":"dj"
         },{
            "name":"cs_wq_rc_zzs",
            "bigtype":"dj"
         }];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster127");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(5,-20);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,1,2,1,10],[2,2,2,2,2,10],[34],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,5,6,1,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster127--BitmapData Error!");
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
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 800;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 500;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(40);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit4");
         this.lastHit = "hit4";
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
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_1(direct);
                     this.doHi2_2(direct,2);
                  }
               }
               else if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_2(direct,1);
                  }
               }
               else if(p.x == 4)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_2(direct,0);
                  }
               }
               else if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2_1(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
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
      
      private function doHi1(direct:uint) : void
      {
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster127Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 100;
            b.setSpeed(-10);
         }
         else
         {
            b.x = this.x + 100;
            b.setSpeed(10);
         }
         b.setDistance(600);
         b.setDestroyWhenLastFrame(false);
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster127Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
         }
         b.y = this.y - 80;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint, index:uint) : void
      {
         var offsetX:uint = (index - 1) * 30;
         var b:EnemyMoveBullet = new EnemyMoveBullet("Monster127Bullet2_2");
         if(direct == 0)
         {
            b.x = this.x - 250 - offsetX;
            b.setSpeed(-10);
         }
         else
         {
            b.x = this.x + 250 + offsetX;
            b.setSpeed(10);
         }
         b.y = this.y - 90;
         b.setDestroyWhenLastFrame(false);
         b.setRole(this);
         b.setDistance(600);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         direct = direct;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster127Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
         }
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setDisable();
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         for each(bh in gc.getPlayerArray())
         {
            if(!bh.isYourFather())
            {
               var flag:Boolean = false;
               if(this.x > bh.x)
               {
                  if(this.bbdc.getDirect() == 0 && bh.getBBDC().getDirect() == 1)
                  {
                     flag = true;
                  }
               }
               else if(this.x < bh.x)
               {
                  if(this.bbdc.getDirect() == 1 && bh.getBBDC().getDirect() == 0)
                  {
                     flag = true;
                  }
               }
               if(flag)
               {
                  TweenMax.to(bh,1,{
                     "x":b.x,
                     "y":b.y - 20,
                     "onComplete":function(_bh:BaseHero):*
                     {
                        _bh.addCurAddEffect([{
                           "name":BaseAddEffect.STUN,
                           "time":gc.frameClips * 2
                        }]);
                     },
                     "onCompleteParams":[bh]
                  });
               }
            }
         }
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:* = null;
         var i:* = 0;
         for(i = uint(0); i < 7; )
         {
            b = new SpecialEffectBullet("Monster127Bullet4");
            b.x = this.x + (3 - i) * 150;
            b.y = this.y + 30;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit4");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            i++;
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
