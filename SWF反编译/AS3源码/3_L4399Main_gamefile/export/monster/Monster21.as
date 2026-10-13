package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster21 extends BaseMonster
   {
       
      
      public function Monster21()
      {
         super();
         this.horizenSpeed = 3;
         this.monsterName = "朱子真";
         this.isBoss = true;
         this.isCanBeCatchSkill = true;
         this.setHp(40000);
         this.setSHp(40000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 84;
         this._anti.exp = 280;
         this._anti.gxp = 140;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":8,
            "power":256,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":24,
            "power":256,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,2],
            "attackInterval":12,
            "power":256,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "time":gc.frameClips * 2
            }]
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,2],
            "attackInterval":24,
            "power":500,
            "attackKind":"magic"
         };
         this.setAction("wait");
         this.setToCountSuppressLevel(20);
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 6];
         this.skillCD2 = [gc.frameClips * 20,gc.frameClips * 20];
         this.skillCD3 = [gc.frameClips * 10,gc.frameClips * 10];
         this._anti.fallProbability = 0.2;
         this._anti.fallList = [{
            "name":"zjksf",
            "bigtype":"zb"
         },{
            "name":"zjqj",
            "bigtype":"zb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster21");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],400,300,new Point(0,0));
            bbdc.setOffsetXY(15,-50);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,10],[2,2,2,3,3,3,3,12],[2,2,1,1,20],[2,2,31,20],[2,2,5,15]]);
            bbdc.setFrameCount([6,4,1,6,8,5,4,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster21--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite5") as Sprite;
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
               if(curPoint.y != 7)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(7);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit4":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
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
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 15)
                  {
                     this.doHit1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHit3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 31)
                  {
                     this.doHit4_1(direct);
                  }
               }
               else if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHit4_2(direct);
                  }
               }
         }
      }
      
      private function doHit1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster21Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 300;
         }
         else
         {
            b.x = this.x + 300;
         }
         b.y = this.y - 180;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(40);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 600;
      }
      
      private function doHit2(direct:uint) : void
      {
         for each(var bh in gc.getPlayerArray())
         {
            if(!bh.isYourFather())
            {
               TweenMax.to(bh,1,{
                  "x":this.x,
                  "y":this.y - 50
               });
            }
         }
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster21Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 130;
         }
         else
         {
            b.x = this.x + 130;
         }
         b.y = this.y - 220;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster21Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 320;
         }
         else
         {
            b.x = this.x + 320;
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
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster21Bullet4_1");
         if(direct == 0)
         {
            b.x = this.x - 45;
         }
         else
         {
            b.x = this.x + 45;
         }
         b.y = this.y - 304;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster21Bullet4_2");
         if(direct == 0)
         {
            b.x = this.x - 300;
         }
         else
         {
            b.x = this.x + 300;
         }
         b.y = this.y - 220;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
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
