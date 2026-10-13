package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseMonster;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.MainGame;
   import user.User;
   
   public class Monster221 extends BaseMonster
   {
       
      
      public var isAoyi:Boolean = false;
      
      private var aoyiStep:int = 0;
      
      public function Monster221()
      {
         super();
         this.horizenSpeed = 4;
         this.setHp(10000000);
         this.setSHp(10000000);
         this._anti.def = 600;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.6;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":3300,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":10,
            "power":4000,
            "attackKind":"physics",
            "addEffect":[{
               "name":BaseAddEffect.STUN,
               "rate":0.3,
               "time":gc.frameClips * 2
            }]
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":10,
            "power":4100,
            "attackKind":"magic"
         };
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = true;
         this.monsterName = "邪.丑牛";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 6,gc.frameClips * 12];
         this.skillCD3 = [gc.frameClips * 8,gc.frameClips * 13];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
         this._anti.fallProbability = 0.2;
         this._anti.fallList = [{
            "name":"p_cycnjl",
            "bigtype":"cwzb"
         },{
            "name":"wpst_4",
            "bigtype":"dj"
         }];
         this.setHue(-150);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetNeatBmd4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(10,-20);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[30],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,3,1,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetNeatBmd4--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite4") as Sprite;
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
               if(this.isAoyi)
               {
                  if(this.aoyiStep == 1)
                  {
                     this.releSkill1WithoutMana();
                     this.aoyiStep++;
                  }
                  else if(this.aoyiStep == 0 || this.aoyiStep == 2)
                  {
                     this.releSkill2WithoutMana();
                     this.aoyiStep++;
                  }
                  else
                  {
                     this.aoyiOver();
                     this.setAction("wait");
                  }
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit2":
               if(this.isAoyi && (this.aoyiStep == 0 || this.aoyiStep == 2))
               {
                  this.aoyiStep++;
                  this.releSkill2WithoutMana();
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit3":
               if(this.isAoyi && this.aoyiStep == 1)
               {
                  this.aoyiStep++;
                  this.releSkill1WithoutMana();
               }
               else
               {
                  if(this.aoyiStep == 3)
                  {
                     this.aoyiOver();
                  }
                  this.setAction("wait");
               }
               break;
            case "hurt":
               this.aoyiOver();
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
               this.aoyiOver();
               this.dropAura();
               this.destroy();
         }
      }
      
      override protected function enterFrameFunc(p:Point) : void
      {
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         var point:Point = new Point();
         switch(state)
         {
            case "hit1":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 30;
                     }
                     else
                     {
                        point.x = this.x + 30;
                     }
                     point.y = this.y;
                     this.doHit1(direct,point);
                  }
               }
               break;
            case "hit2":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 30)
                  {
                     if(direct == 0)
                     {
                        point.x = this.x - 30;
                     }
                     else
                     {
                        point.x = this.x + 30;
                     }
                     point.y = this.y;
                     this.doHit2(direct,point);
                  }
               }
               if(direct == 0)
               {
                  if(this.isAoyi)
                  {
                     this.speed.x = -15;
                  }
                  else
                  {
                     this.speed.x = -10;
                  }
               }
               else if(this.isAoyi)
               {
                  this.speed.x = 15;
               }
               else
               {
                  this.speed.x = 10;
               }
               break;
            case "hit3":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 10)
                  {
                     this.doHit3(direct);
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
         return this.curAttackTarget != null;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget != null;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override protected function releSkill1() : void
      {
         this.faceToTarget();
         this.setYourFather(30);
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.faceToTarget();
         this.setYourFather(20);
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.isAoyi = true;
         this.aoyiStep = 0;
         this.addAoyiBuff();
         this.setYourFather(9999);
         this.releSkill1WithoutMana();
      }
      
      protected function releSkill1WithoutMana() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      protected function releSkill2WithoutMana() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function aoyiOver() : void
      {
         this.aoyiStep = 0;
         this.isAoyi = false;
         this.setYourFather(10);
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetNeat1Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 60;
         }
         else
         {
            b.x = this.x + 60;
         }
         b.y = this.y - 30;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetNeat1Bullet2");
         b.x = this.x;
         b.y = this.y;
         b.setHurtCanCutDownEffect(true);
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(30);
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetNeat4Bullet3");
         b.x = this.x - 100;
         b.y = this.y + 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("PetNeat4Bullet3");
         b.x = this.x + 100;
         b.y = this.y + 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("PetNeat4Bullet3");
         b.x = this.x + 220;
         b.y = this.y + 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new SpecialEffectBullet("PetNeat4Bullet3");
         b.x = this.x - 220;
         b.y = this.y + 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isCanMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
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
         var num:int = 0;
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
         if(this.getHp() <= 0)
         {
            MainGame.getInstance().createLikeMonster(81,this.x,this.y - 50);
            num = 1 + Math.random() * 5;
            for each(var player in gc.getUsersArray())
            {
               player.dataObject.strenthtimes += num;
            }
            gc.ts.setTxt("获得 " + num + " 点强化次数");
            gc.stage.addChild(gc.ts);
         }
         super.destroy();
      }
   }
}
