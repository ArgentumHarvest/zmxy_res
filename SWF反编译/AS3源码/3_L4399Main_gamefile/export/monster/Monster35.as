package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.level.StageListener81;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster35 extends BaseMonster
   {
       
      
      public function Monster35()
      {
         super();
         this.normalAttackRate = 0.6;
         this.horizenSpeed = 3;
         this.setHp(150000);
         this.setSHp(150000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 62;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.2;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":999,
            "power":376,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":600,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2_3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":4,
            "power":150,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-15,0],
            "attackInterval":8,
            "power":300,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "土行孙";
         this.setToCountSuppressLevel(30);
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"xltzzzs",
            "bigtype":"dj"
         },{
            "name":"xleyzzs",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD2 = [gc.frameClips * 3,gc.frameClips * 10];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster35");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(0,-25);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[2,2,2,3,2,4],[8],[2,2,2,2,10],[2,2,2,2,10],[2,2,2,96],[9,3,2,8],[24]]);
            bbdc.setFrameCount([6,6,1,5,5,4,4,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster35--BitmapData Error!");
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
            case "hit2_1":
               this.setYourFather(48);
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
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit1_1(direct);
                  }
               }
               else if(p.x == 4)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit1_2(direct);
                  }
               }
               break;
            case "hit2_1":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHit2_1(direct);
                  }
               }
               else if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 96)
                  {
                     this.doHit2_2(direct);
                  }
                  this.setStatic();
               }
               break;
            case "hit2_2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 9)
                  {
                     this.x = this.curAttackTarget.x;
                     this.doHit2_1(direct);
                     this.doHit2_3(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 24)
                  {
                     this.doHit3(direct);
                  }
                  if(direct == 0)
                  {
                     this.speed.x = -15;
                  }
                  else
                  {
                     this.speed.x = 15;
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
         this.setYourFather(110);
         this.setAction("hit2_1");
         this.lastHit = "hit2_1";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(35);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHit1_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster35Bullet1_1");
         if(direct == 0)
         {
            b.x = this.x - 155;
         }
         else
         {
            b.x = this.x + 155;
         }
         b.y = this.y - 140;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit1_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster35Bullet1_2");
         if(direct == 0)
         {
            b.x = this.x - 135;
         }
         else
         {
            b.x = this.x + 135;
         }
         b.y = this.y - 75;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster35Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 65;
         }
         else
         {
            b.x = this.x + 65;
         }
         b.y = this.y + 15;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_2(direct:uint) : void
      {
         var b:* = null;
         var idx:uint = 0;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster35Bullet2_1")
            {
               idx = gc.gameSence.getChildIndex(bb);
            }
         }
         if(idx > 0)
         {
            b = new SpecialEffectBullet("Monster35Bullet2_2");
            if(direct == 0)
            {
               b.x = this.x - 90;
            }
            else
            {
               b.x = this.x + 90;
            }
            b.y = this.y - 180;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2_2");
            gc.gameSence.addChildAt(b,idx);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHit2_3(direct:uint) : void
      {
         var b:* = null;
         var idx:uint = 0;
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster35Bullet2_1")
            {
               idx = gc.gameSence.getChildIndex(bb);
            }
         }
         if(idx > 0)
         {
            b = new SpecialEffectBullet("Monster35Bullet2_3");
            if(direct == 0)
            {
               b.x = this.x - 80;
            }
            else
            {
               b.x = this.x + 80;
            }
            b.y = this.y - 160;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2_3");
            gc.gameSence.addChildAt(b,idx);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster35Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 120;
         }
         else
         {
            b.x = this.x + 120;
         }
         b.y = this.y - 90;
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
         return this.curAction == "hit3";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2_1" || this.curAction == "hit2_2" || this.curAction == "hit3";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.getHp() <= 0)
         {
            if(gc.pWorld.getBaseLevelListener() is StageListener81)
            {
               StageListener81(gc.pWorld.getBaseLevelListener()).showJwealSprite();
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
}
