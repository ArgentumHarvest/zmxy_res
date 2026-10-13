package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.MainGame;
   
   public class Monster103 extends BaseMonster
   {
       
      
      public function Monster103()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(200000);
         this.setSHp(200000);
         this._anti.def = 48;
         this._anti.exp = 1000;
         this._anti.gxp = 500;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,-5],
            "attackInterval":999,
            "power":200,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":4,
            "power":200,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":999,
            "power":200,
            "attackKind":"physics"
         };
         this.attackRange = 300;
         this.alertRange = 250;
         this.isBoss = true;
         this.monsterName = "牛魔王";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 10];
         this._anti.fallProbability = 0;
         this._anti.fallList = [];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster103");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(15,-5);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,7],[2,1,1,1,10],[2,2,2,2,2,10],[4,4,4,4],[2,2,34]]);
            bbdc.setFrameCount([6,4,1,5,5,6,12,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster103--BitmapData Error!");
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
         if(str == "hit2_2")
         {
            bbdc.setOffsetXY(15,5);
         }
         else
         {
            bbdc.setOffsetXY(15,-5);
         }
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
            case "hit2_1":
               if(curPoint.y != 5)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(5);
               }
               this.bbdc.setState(str);
               break;
            case "hit2_2":
               if(curPoint.y != 6)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(6);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
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
               this.doHi2(this.getBBDC().getDirect());
               this.setAction("hit2_2");
               break;
            case "hit2_2":
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
               MainGame.getInstance().createMonster(104,470,370);
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2_1":
               break;
            case "hit2_2":
               if(this.getBBDC().getDirect() == 0)
               {
                  this.speed.x = -10;
               }
               else
               {
                  this.speed.x = 10;
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 34)
                  {
                     this.doHi3(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) <= 400;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) <= 80;
      }
      
      override protected function releSkill1() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(48);
         this.setAction("hit2_1");
         this.lastHit = "hit2_1";
      }
      
      override protected function releSkill2() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(40);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster103Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 120;
         }
         else
         {
            b.x = this.x + 120;
         }
         b.y = this.y - 45;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster102Bullet1");
         b.x = this.x;
         b.y = this.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(48);
         b.setHurtCanCutDownEffect(false);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster103Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 0;
         }
         else
         {
            b.x = this.x + 0;
         }
         b.y = this.y - 30;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
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
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2_2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2_1" || this.curAction == "hit2_2" || this.curAction == "hit3";
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
