package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.monster.Monster186Children.Monster186Bullet3;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.MainGame;
   
   public class Monster186 extends BaseMonster
   {
       
      
      private var _m187:Monster187;
      
      public function Monster186()
      {
         super();
         this.normalAttackRate = 0.8;
         this.horizenSpeed = 3;
         this.setHp(3600000);
         this.setSHp(3600000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 500;
         this._anti.exp = 5000;
         this._anti.gxp = 2000;
         this._anti.mDef = 0.6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-6,-5],
            "attackInterval":10,
            "power":1000,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":999,
            "power":80,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-3,0],
            "attackInterval":24,
            "power":4000,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-13,0],
            "attackInterval":8,
            "power":2500,
            "attackKind":"physics"
         };
         this.isBoss = true;
         this.monsterName = "蚊妖";
         this.setAction("wait");
         this.setToCountSuppressLevel(80);
         this._anti.fallProbability = 0.2;
         this._anti.fallList = [{
            "name":"ttslsp1",
            "bigtype":"dj"
         },{
            "name":"hmzjns3",
            "bigtype":"jns"
         },{
            "name":"syzqjns3",
            "bigtype":"jns"
         },{
            "name":"jhsjjns3",
            "bigtype":"jns"
         },{
            "name":"mdsjns3",
            "bigtype":"jns"
         }];
         this.skillCD1 = [gc.frameClips * 10,gc.frameClips * 30];
         this.skillCD2 = [gc.frameClips * 5,gc.frameClips * 25];
         this.skillCD3 = [gc.frameClips * 10,gc.frameClips * 28];
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
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster186");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],370,300,new Point(0,0));
            bbdc.setOffsetXY(0,-35);
            bbdc.setFrameStopCount([[3,3,3,3,3,3],[4,4,4,4],[8],[2,2,2,2,2,10],[2,2],[2,2,10],[30],[30]]);
            bbdc.setFrameCount([6,4,1,6,14,3,1,1]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster186--BitmapData Error!");
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
            case "hit4":
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
         var repeatIdx:int = 0;
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               repeatIdx = this.bbdc.getCurKeyFrameIndex();
               if(repeatIdx == 0)
               {
                  if(p.x == 0)
                  {
                     if(this.bbdc.getCurFrameCount() == 2)
                     {
                        this.doHi1(direct);
                     }
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
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     this.doHi3(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     this.doHi4(direct);
                  }
                  if(direct == 0)
                  {
                     this.speed.x = -20;
                  }
                  else
                  {
                     this.speed.x = 20;
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
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 400;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(20);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(10);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.faceToTarget();
         this.setYourFather(35);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster186Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 300;
         }
         else
         {
            b.x = this.x + 300;
         }
         b.y = this.y - 210;
         b.setHurtCanCutDownEffect(true);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(30);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster186Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 205;
         }
         else
         {
            b.x = this.x + 205;
         }
         b.y = this.y - 45;
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(10);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b.setFuncWhenDestroy(callMonster187);
      }
      
      private function callMonster187(bb:BaseBullet) : void
      {
         if(!this.isDead() && !this._m187)
         {
            this._m187 = MainGame.getInstance().createMonster(187,bb.x,bb.y - 30) as Monster187;
            this._m187.addEventListener("monsterdestroy",m187Destroy);
            gc.gameSence.addChild(this._m187);
         }
      }
      
      protected function m187Destroy(event:Event) : void
      {
         this._m187.removeEventListener("monsterdestroy",m187Destroy);
         this._m187 = null;
      }
      
      private function doHi3(direct:uint) : void
      {
         var i:* = 0;
         var windNum:int = 1;
         if(this.getHp() / this.getSHp() < 0.25)
         {
            windNum = 4;
         }
         else if(this.getHp() / this.getSHp() < 0.5)
         {
            windNum = 3;
         }
         else if(this.getHp() / this.getSHp() < 0.75)
         {
            windNum = 2;
         }
         for(i = uint(0); i < windNum; )
         {
            this.dosingleHit3((i + 1) * gc.frameClips * 5);
            i++;
         }
      }
      
      private function dosingleHit3(time:int) : void
      {
         var b:Monster186Bullet3 = new Monster186Bullet3("Monster186Bullet3");
         var randX:Number = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 800;
         b.x = randX;
         b.y = 440;
         b.taraget = gc.getRandomPlayer();
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(time);
         b.setDistance(9999);
         b.setRole(this);
         b.setDirect(0);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHi4(direct:uint) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster186Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 135;
         }
         else
         {
            b.x = this.x + 135;
         }
         b.y = this.y - 120;
         b.setHurtCanCutDownEffect(false);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(30);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b.setFuncWhenHit(hit4Hit);
      }
      
      private function hit4Hit(bb:BaseBullet) : void
      {
         if(!this.isDead())
         {
            this.cureHp(bb.finallHurt);
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
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         var ta:* = null;
         var i:int = 0;
         var mc:* = null;
         if(this.getHp() <= 0)
         {
            if(this._m187)
            {
               this._m187.removeEventListener("monsterdestroy",m187Destroy);
               this._m187.destroy();
               this._m187 = null;
               MainGame.getInstance().createMonster(186,this.x,this.y);
            }
            else if(this.isBoss)
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
         super.destroy();
      }
   }
}
