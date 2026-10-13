package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster26 extends BaseMonster
   {
       
      
      private var isStopInSky:Boolean = false;
      
      public function Monster26()
      {
         super();
         this.horizenSpeed = 4;
         this.setHp(50000);
         this.setSHp(50000);
         this.attackRange = 200;
         this.alertRange = 1000;
         this._anti.def = 88;
         this._anti.exp = 330;
         this._anti.gxp = 150;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "aaaaaa":24,
            "power":510,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2_1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-5,0],
            "attackInterval":999,
            "power":520,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2_2"] = {
            "hitMaxCount":9999,
            "attackBackSpeed":[-10,0],
            "attackInterval":48,
            "power":260,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-2,-4],
            "attackInterval":5,
            "power":510,
            "attackKind":"magic"
         };
         this.isFly = true;
         this.graity = 0;
         this.isBoss = true;
         this.monsterName = "持国天王";
         this.setAction("wait");
         this._anti.fallProbability = 0.1;
         this._anti.fallList = [{
            "name":"tdlzjzzs",
            "bigtype":"dj"
         }];
         this.skillCD1 = [gc.frameClips * 7,gc.frameClips * 7];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 30];
         this.skillCD3 = [gc.frameClips * 15,gc.frameClips * 30];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster26");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],250,350,new Point(0,0));
            bbdc.setOffsetXY(0,-10);
            bbdc.setFrameStopCount([[2,2,2,2,2,2],[8],[3,3],[10],[3,3]]);
            bbdc.setFrameCount([6,1,2,1,8]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster26--BitmapData Error!");
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
               if(curPoint.y != 0)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(0);
               }
               this.bbdc.setState(str);
               break;
            case "hurt":
               if(curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "hit3":
               if(curPoint.y != 4)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(4);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               this.dropAura();
               this.destroy();
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
               this.callMonster28();
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
         }
      }
      
      private function callMonster28() : void
      {
         var xx:Number = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 200;
         var yy:Number = this.y + (RandomControllor.getIns().getRandom() - 0.5) * 100;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster26BulletCallMonster28");
         b.x = xx;
         b.y = yy;
         b.setRole(this);
         b.setDirect(0);
         b.setDisable();
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         MainGame.getInstance().createMonster(28,xx,yy);
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 3)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHi2_1(direct);
                  }
               }
               break;
            case "hit3":
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && this.curAttackTarget.standInObj;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 250;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(25);
         this.setAction("hit3");
         this.lastHit = "hit3";
         this.doHi3(this.getBBDC().getDirect());
      }
      
      override protected function releSkill3() : void
      {
         trace("---releSkill3---");
         this.newAttackId();
         this.setYourFather(15);
         TweenMax.to(this,1,{
            "x":this.curAttackTarget.x + (RandomControllor.getIns().getRandom() - 0.5) * 200,
            "y":150
         });
         TweenMax.delayedCall(15,function(_self:Monster26):*
         {
            _self.isStopInSky = false;
         },[this]);
         this.isStopInSky = true;
      }
      
      override protected function move() : void
      {
         if(!this.isStopInSky)
         {
            super.move();
         }
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster26Bullet1");
         b.x = this.x - 0;
         b.y = this.y - 0;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2_1(direct:uint) : void
      {
         direct = direct;
         if(this.curAttackTarget)
         {
            var b:SpecialEffectBullet = new SpecialEffectBullet("Monster26Bullet2_1");
            b.x = this.curAttackTarget.x;
            b.y = this.curAttackTarget.y - 350;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2_1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            if(this.curAttackTarget.standInObj)
            {
               var point:Point = new Point(b.x,this.curAttackTarget.standInObj.y);
               TweenMax.delayedCall(1,function(_self:Monster26, _direct:uint, _point:Point):*
               {
                  _self.doHi2_2(_direct,_point);
               },[this,direct,point]);
            }
            b = new SpecialEffectBullet("Monster26Bullet2_1");
            b.x = this.curAttackTarget.x + 50;
            b.y = this.curAttackTarget.y - 350;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2_1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            if(this.curAttackTarget.standInObj)
            {
               point = new Point(b.x,this.curAttackTarget.standInObj.y);
               TweenMax.delayedCall(1,function(_self:Monster26, _direct:uint, _point:Point):*
               {
                  _self.doHi2_2(_direct,_point);
               },[this,direct,point]);
            }
            b = new SpecialEffectBullet("Monster26Bullet2_1");
            b.x = this.curAttackTarget.x - 50;
            b.y = this.curAttackTarget.y - 350;
            b.setRole(this);
            b.setDirect(direct);
            b.setAction("hit2_1");
            gc.gameSence.addChild(b);
            this.magicBulletArray.push(b);
            if(this.curAttackTarget.standInObj)
            {
               point = new Point(b.x,this.curAttackTarget.standInObj.y);
               TweenMax.delayedCall(1,function(_self:Monster26, _direct:uint, _point:Point):*
               {
                  _self.doHi2_2(_direct,_point);
               },[this,direct,point]);
            }
         }
      }
      
      public function doHi2_2(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster26Bullet2_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDestroyWhenLastFrame(false);
         b.setDirect(direct);
         b.setAction("hit2_2");
         gc.gameSence.bgContainer.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster26Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 75;
         }
         else
         {
            b.x = this.x + 75;
         }
         b.y = this.y - 60;
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
