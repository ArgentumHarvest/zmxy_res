package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster115 extends BaseMonster
   {
       
      
      public function Monster115()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(500000);
         this.setSHp(500000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.mDef = 0.5;
         this._anti.def = 100;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":400,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":500,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER115SLOW,
               "time":gc.frameClips * 8
            }]
         };
         this.isBoss = true;
         this.monsterName = "饕餮";
         this.setAction("wait");
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
         this.skillCD1 = [gc.frameClips * 5,gc.frameClips * 13];
         this.skillCD2 = [gc.frameClips * 6,gc.frameClips * 12];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster115");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],400,300,new Point(0,0));
            bbdc.setOffsetXY(5,-30);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,9],[2,2,2,10],[2,27],[2,2,20]]);
            bbdc.setFrameCount([6,4,1,5,4,2,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster115--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("Monster115Object") as Sprite;
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
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 27)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 20)
                  {
                     this.doHit3(direct);
                  }
               }
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster115Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 150;
         }
         else
         {
            b.x = this.x + 150;
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
         direct = direct;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster115Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 40;
         }
         else
         {
            b.x = this.x + 40;
         }
         b.y = this.y - 30;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var targetPoint:Point = new Point();
         if(direct == 0)
         {
            targetPoint.x = this.x - 30;
         }
         else
         {
            targetPoint.x = this.x + 30;
         }
         targetPoint.y = this.y - 40;
         for each(bo in gc.getPlayerAndPetArray())
         {
            TweenMax.to(bo,1,{
               "x":targetPoint.x,
               "y":targetPoint.y,
               "onComplete":function(_bo:BaseObject):*
               {
                  _bo.addCurAddEffect([{
                     "name":BaseAddEffect.MONSTER115REDUCEHP,
                     "time":gc.frameClips * 9
                  }]);
               },
               "onCompleteParams":[bo]
            });
         }
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:* = null;
         var hurt:int = 500 + RandomControllor.getIns().getRandom() * 400;
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":hurt,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER115SLOW,
               "time":gc.frameClips * 8
            }]
         };
         b = new SpecialEffectBullet("Monster115Bullet3");
         b.x = this.x + 95;
         b.y = this.y + 60;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster115Bullet3");
         b.x = this.x - 95;
         b.y = this.y + 60;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster115Bullet3");
         b.x = this.x + 240;
         b.y = this.y + 60;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("Monster115Bullet3");
         b.x = this.x - 240;
         b.y = this.y + 60;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(30);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget != null && AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget) <= 300;
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(50);
         this.setAction("hit3");
         this.lastHit = "hit3";
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
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.getHp() < 0)
         {
            MainGame.getInstance().createLikeMonster(77,this.x,this.y - 50);
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
