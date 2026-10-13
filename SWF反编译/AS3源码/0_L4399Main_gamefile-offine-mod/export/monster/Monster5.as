package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener13;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster5 extends BaseMonster
   {
       
      
      public function Monster5()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 3;
         this.setHp(3000);
         this.setSHp(3000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 12;
         this._anti.exp = 35;
         this._anti.gxp = 15;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":40,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":4,
            "power":40,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-8,0],
            "attackInterval":4,
            "power":20,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.isCanBeCatchSkill = true;
         this.monsterName = "巨灵神";
         this.setAction("wait");
         this.setToCountSuppressLevel(0);
         this._anti.fallProbability = 0.4;
         this._anti.fallList = [{
            "name":"xhc",
            "bigtype":"zb"
         },{
            "name":"xhp",
            "bigtype":"zb"
         }];
         this.skillCD1 = [gc.frameClips * 3,gc.frameClips * 3];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 5];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster5");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],350,350,new Point(0,0));
            bbdc.setOffsetXY(30,-55);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,14],[2,2,2,2,7],[2,2,9,2,12],[1,1,1,1]]);
            bbdc.setFrameCount([6,4,1,6,5,5,16]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster5--BitmapData Error!");
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
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 9)
                  {
                     this.doHi2_1(direct);
                  }
               }
               else if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHi2_2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHi3(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster5Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 155;
         }
         else
         {
            b.x = this.x + 155;
         }
         b.y = this.y - 165;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         var playerArray:Array = gc.getPlayerArray();
         var rand:uint = RandomControllor.getIns().getRandom() * playerArray.length;
         var bh:BaseHero = playerArray[rand] as BaseHero;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster5Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 75;
         }
         else
         {
            b.x = this.x + 75;
         }
         b.y = this.y - 280;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_2(direct:uint) : void
      {
         var playerArray:Array = gc.getPlayerArray();
         var rand:uint = RandomControllor.getIns().getRandom() * playerArray.length;
         var bh:BaseHero = playerArray[rand] as BaseHero;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster5Bullet2_2");
         if(direct == 0)
         {
            b.x = this.x - 245;
         }
         else
         {
            b.x = this.x + 245;
         }
         b.y = this.y - 95;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var playerArray:Array = gc.getPlayerArray();
         var rand:uint = RandomControllor.getIns().getRandom() * playerArray.length;
         var bh:BaseHero = playerArray[rand] as BaseHero;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster5Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 210;
         }
         else
         {
            b.x = this.x + 210;
         }
         b.y = this.y - 80;
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
         if(this.getHp() <= 0)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener13)
            {
               StageListener13(gc.pWorld.getBaseLevelListener()).callReswarMonsterImmediately();
            }
         }
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
