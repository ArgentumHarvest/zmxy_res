package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster6 extends BaseMonster
   {
       
      
      public function Monster6()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 3;
         this.setHp(6000);
         this.setSHp(6000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 28;
         this._anti.exp = 70;
         this._anti.gxp = 35;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":80,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2_1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":80,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":4,
            "power":20,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":12,
            "power":80,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "增长天王";
         this.isCanBeCatchSkill = true;
         this.setAction("wait");
         this.setToCountSuppressLevel(0);
         this._anti.fallProbability = 0.35;
         this._anti.fallList = [{
            "name":"qybd",
            "bigtype":"zb"
         },{
            "name":"qyfp",
            "bigtype":"zb"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 8];
         this.skillCD2 = [gc.frameClips * 3,gc.frameClips * 10];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster6");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,400,new Point(0,0));
            bbdc.setOffsetXY(0,-55);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,2,18],[2,2,2,9],[2,2,19,50],[2,2,2,2,7,17]]);
            bbdc.setFrameCount([6,4,1,7,4,4,6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster6--BitmapData Error!");
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
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 9)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_1(direct);
                  }
               }
               else if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     this.doHi2_2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 5)
               {
                  if(this.bbdc.getCurFrameCount() == 17)
                  {
                     this.doHi3(direct);
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
         this.setYourFather(70);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(35);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster6Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 155;
         }
         else
         {
            b.x = this.x + 155;
         }
         b.y = this.y - 70;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster6Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 45;
         }
         else
         {
            b.x = this.x + 45;
         }
         b.y = this.y - 90;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint) : void
      {
         var b1:SpecialEffectBullet = new SpecialEffectBullet("Monster6Bullet2_2");
         b1.x = this.x;
         b1.y = this.y - 500;
         b1.setRole(this);
         b1.setDirect(direct);
         b1.setAction("hit2_2");
         gc.gameSence.addChild(b1);
         this.magicBulletArray.push(b1);
         var b2:SpecialEffectBullet = new SpecialEffectBullet("Monster6Bullet2_2");
         b2.x = this.x - 200;
         b2.y = this.y - 500;
         b2.setRole(this);
         b2.setDirect(direct);
         b2.setAction("hit2_2");
         gc.gameSence.addChild(b2);
         this.magicBulletArray.push(b2);
         var b3:SpecialEffectBullet = new SpecialEffectBullet("Monster6Bullet2_2");
         b3.x = this.x + 200;
         b3.y = this.y - 500;
         b3.setRole(this);
         b3.setDirect(direct);
         b3.setAction("hit2_2");
         gc.gameSence.addChild(b3);
         this.magicBulletArray.push(b3);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster6Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 55;
         }
         else
         {
            b.x = this.x + 55;
         }
         b.y = this.y - 95;
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
