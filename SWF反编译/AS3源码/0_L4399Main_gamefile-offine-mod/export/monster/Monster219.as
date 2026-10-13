package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import export.pet.PetMouse4Bullet3;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import my.MainGame;
   import user.User;
   
   public class Monster219 extends BaseMonster
   {
       
      
      private var _aoyiStep:uint = 0;
      
      public function Monster219()
      {
         super();
         this.horizenSpeed = 4;
         this.setHp(10000000);
         this.setSHp(10000000);
         this._anti.def = 600;
         this._anti.exp = 500;
         this._anti.gxp = 250;
         this._anti.mDef = 0.65;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":3500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":10,
            "power":1500,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,0],
            "attackInterval":10,
            "power":1500,
            "attackKind":"magic"
         };
         this.attackRange = 250;
         this.alertRange = 1000;
         this.isBoss = true;
         this.monsterName = "邪.子鼠";
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 10];
         this.skillCD2 = [gc.frameClips * 4,gc.frameClips * 10];
         this.skillCD3 = [gc.frameClips * 6,gc.frameClips * 15];
         this._anti.fallProbability = 0.25;
         this._anti.fallList = [{
            "name":"p_cyzsjl",
            "bigtype":"cwzb"
         }];
         this.curAddEffect.add([{
            "name":"father",
            "time":gc.frameClips * 1,
            "interval":1000,
            "isForever":1
         }]);
         this.setHue(-150);
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetMouseBmd2");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],200,200,new Point(0,0));
            bbdc.setOffsetXY(-20,-25);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,10],[2,2,10],[4,4,1,10],[2,2,10]]);
            bbdc.setFrameCount([6,4,1,5,3,4,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetMouseBmd2--BitmapData Error!");
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
               this._aoyiStep = 0;
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
               if(this._aoyiStep != 0)
               {
                  this._aoyiStep++;
                  if(this._aoyiStep == 4)
                  {
                     this.releSkill1WithoutMana();
                  }
                  else if(this._aoyiStep > 7)
                  {
                     this.setAction("wait");
                  }
                  else
                  {
                     this.releSkill2WithoutMana();
                  }
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit2":
               if(this._aoyiStep != 0)
               {
                  this._aoyiStep++;
                  this.releSkill2WithoutMana();
               }
               else
               {
                  this.setAction("wait");
               }
               break;
            case "hit3":
               if(this._aoyiStep != 0)
               {
                  if(this._aoyiStep == 3)
                  {
                     this._aoyiStep++;
                     this.releSkill1WithoutMana();
                  }
                  else if(this._aoyiStep == 7)
                  {
                     this._aoyiStep = 0;
                     this.setAction("wait");
                  }
                  else
                  {
                     this._aoyiStep++;
                     this.bbdc.setFramePointX(0);
                  }
               }
               else
               {
                  this.setAction("wait");
               }
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
               if(p.x == 3)
               {
                  this.setStatic();
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
                     this.doHit2(direct,point);
                  }
               }
               else if(direct == 0)
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
                     this.doHit3(direct,point);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         if(dis > 300)
         {
            return false;
         }
         return this.curAttackTarget != null;
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         if(dis > 400)
         {
            return false;
         }
         return this.curAttackTarget != null;
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         var dis:Number = AUtils.GetDisBetweenTwoObj(this,this.curAttackTarget);
         if(dis > 400)
         {
            return false;
         }
         return this.curAttackTarget != null;
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         super.reduceHp(re,canHurt);
      }
      
      override protected function releSkill1() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(10);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.addAoyiBuff();
         this._aoyiStep = 1;
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(10);
         this.releSkill1WithoutMana();
      }
      
      protected function releSkill1WithoutMana() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      protected function releSkill2WithoutMana() : void
      {
         this.faceToTarget();
         this.newAttackId();
         this.setYourFather(20);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetMouse1Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 20;
         }
         else
         {
            b.x = this.x + 20;
         }
         b.y = this.y + 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2(direct:uint, point:Point) : void
      {
         trace("------------dohit2--------------");
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetMouse1Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 40;
         }
         else
         {
            b.x = this.x + 40;
         }
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 1);
         b.setFuncWhenHit(hit2Hit);
         b.y = this.y + 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function hit2Hit(bb:BaseBullet) : void
      {
         this.cureHp(this.getSHp() * 0.2);
      }
      
      private function doHit3(direct:uint, point:Point) : void
      {
         var b:* = null;
         trace("------------dohit3--------------");
         b = new PetMouse4Bullet3("PetMouse1Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 20;
            b.setSpeed(-35,0);
            b.setAddSpeed(1,0);
         }
         else
         {
            b.x = this.x + 20;
            b.setSpeed(35,0);
            b.setAddSpeed(-1,0);
         }
         b.setDestroyWhenLastFrame(false);
         b.setDistance(9999);
         b.y = this.y + 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new PetMouse4Bullet3("PetMouse1Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 20;
            b.setSpeed(-35,-4);
            b.setAddSpeed(1,0.25);
         }
         else
         {
            b.x = this.x + 20;
            b.setSpeed(35,-4);
            b.setAddSpeed(-1,0.25);
         }
         b.setDestroyWhenLastFrame(false);
         b.setDistance(9999);
         b.y = this.y + 10;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         b = new PetMouse4Bullet3("PetMouse1Bullet3");
         if(direct == 0)
         {
            b.x = this.x - 20;
            b.setSpeed(-35,-8);
            b.setAddSpeed(1,0.125);
         }
         else
         {
            b.x = this.x + 20;
            b.setSpeed(35,-8);
            b.setAddSpeed(-1,0.125);
         }
         b.setDestroyWhenLastFrame(false);
         b.setDistance(9999);
         b.y = this.y + 10;
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
            MainGame.getInstance().createLikeMonster(80,this.x,this.y - 50);
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
