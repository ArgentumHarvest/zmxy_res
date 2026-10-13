package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster43 extends BaseMonster
   {
       
      
      public function Monster43()
      {
         super();
         this.horizenSpeed = 5;
         this.setHp(500000);
         this.setSHp(500000);
         this.attackRange = 200;
         this.alertRange = 1000;
         this._anti.def = 94;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.3;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,-5],
            "attackInterval":24,
            "power":480,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2_1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":24,
            "power":480,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2_2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":480,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-4,0],
            "attackInterval":999,
            "power":800,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-4,0],
            "attackInterval":999,
            "power":480,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.monsterName = "小龙女";
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"wplvdyl",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 20,gc.frameClips * 20];
         this.skillCD2 = [gc.frameClips * 8,gc.frameClips * 13];
         this.skillCD3 = [gc.frameClips * 20,gc.frameClips * 20];
         this.skillCD4 = [gc.frameClips * 4.5,gc.frameClips * 4.5];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster43");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,250,new Point(0,0));
            bbdc.setOffsetXY(15,-35);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,3,2,2,10],[2,10],[2,2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,6,2,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster43--BitmapData Error!");
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
                  if(this.bbdc.getCurFrameCount() == 3)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     this.doHi2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 8)
                  {
                     this.doHi3(direct);
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
         return this.standInObj && this.curAttackTarget;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return true;
      }
      
      override protected function beforeSkill4Start() : Boolean
      {
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster43Bullet4_1")
            {
               return true;
            }
         }
         return false;
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
         trace("--releSkill3--");
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster43Bullet4_1");
         b.x = this.x;
         b.y = this.y + 40;
         b.setRole(this);
         b.setDirect(1);
         b.setDisable();
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 9);
         b.setAction("hit1");
         var idx:uint = gc.gameSence.getChildIndex(this);
         gc.gameSence.addChildAt(b,idx);
         this.magicBulletArray.push(b);
      }
      
      override protected function releSkill4() : void
      {
         var b:* = null;
         var atk:uint = (this.getSHp() - this.getHp()) * 0.002;
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-4,0],
            "attackInterval":999,
            "power":atk,
            "attackKind":"magic"
         };
         for each(var bh in gc.getPlayerArray())
         {
            if(AUtils.GetDisBetweenTwoObj(bh,this) <= 175)
            {
               b = new SpecialEffectBullet("Monster43Bullet4_2");
               b.x = bh.x;
               b.y = this.y + 30;
               b.setRole(this);
               b.setDirect(1);
               b.setFuncWhenHit(cureHpWhenHit4Hit);
               b.setAction("hit4");
               gc.gameSence.addChild(b);
               this.magicBulletArray.push(b);
            }
         }
      }
      
      private function cureHpWhenHit4Hit(bb:BaseBullet) : void
      {
         this.cureHp((this.getSHp() - this.getHp()) / 100);
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster43Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 140;
         }
         else
         {
            b.x = this.x + 140;
         }
         b.y = this.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster43Bullet2_1");
         b.x = this.x;
         b.y = this.y - 200;
         b.setRole(this);
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 12);
         b.setFuncWhenInCount(doHit2_2,3,0);
         b.setDirect(direct);
         b.setAction("hit2_1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_2() : void
      {
         var sourceBb:* = null;
         var b:* = null;
         var point:* = null;
         if(!this.curAttackTarget)
         {
            return;
         }
         for each(var bb in this.magicBulletArray)
         {
            if(bb.getImcName() == "Monster43Bullet2_1")
            {
               sourceBb = bb;
               break;
            }
         }
         if(sourceBb)
         {
            b = new EnemyMoveBullet("Monster43Bullet2_2");
            b.x = sourceBb.x;
            b.y = sourceBb.y;
            b.setRole(this);
            point = AUtils.GetNextPointByTwoObj(b,this.curAttackTarget);
            b.setSpeed(point.x * 3,point.y * 3);
            b.setAddSpeed(point.x,point.y);
            b.setDistance(1000);
            b.setDestroyWhenLastFrame(false);
            b.setDirect(1);
            b.setAction("hit2_2");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
         }
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:* = null;
         if(this.standInObj && this.curAttackTarget)
         {
            b = new SpecialEffectBullet("Monster43Bullet3");
            b.x = this.curAttackTarget.x;
            b.y = 510;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit3");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
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
      
      override public function destroy() : void
      {
         var go:* = null;
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         super.destroy();
         if(this.getHp() <= 0)
         {
            go = AUtils.getNewObj("GOGO");
            go.x = 860;
            go.y = 300;
            go.scaleX = 0.7;
            go.scaleY = 0.7;
            gc.gameInfo.addChild(go);
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
