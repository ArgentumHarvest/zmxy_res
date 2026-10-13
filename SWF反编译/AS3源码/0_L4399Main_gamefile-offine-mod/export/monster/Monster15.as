package export.monster
{
   import base.BaseAddEffect;
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class Monster15 extends BaseMonster
   {
       
      
      public function Monster15()
      {
         super();
         this.horizenSpeed = 3;
         this.setHp(10000);
         this.setSHp(10000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 36;
         this._anti.exp = 130;
         this._anti.gxp = 65;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":8,
            "power":104,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":10,
            "power":50,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit3"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":104,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit4"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[0,0],
            "attackInterval":999,
            "power":104,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.isCanBeCatchSkill = true;
         this.monsterName = "多闻天王";
         this.setAction("wait");
         this.setToCountSuppressLevel(10);
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 6];
         this.skillCD2 = [gc.frameClips * 20,gc.frameClips * 20];
         this.skillCD3 = [gc.frameClips * 10,gc.frameClips * 10];
         this._anti.fallProbability = 0.25;
         this._anti.fallList = [{
            "name":"hylc",
            "bigtype":"zb"
         },{
            "name":"hylz",
            "bigtype":"zb"
         }];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster15");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],300,350,new Point(0,0));
            bbdc.setOffsetXY(0,-75);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[4,4,4,4],[8],[2,2,2,2,2,7],[19,16],[2,2,2,30],[29,2,20],[2,2,40]]);
            bbdc.setFrameCount([6,4,1,6,2,4,3,3]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster15--BitmapData Error!");
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
            case "hit4":
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
         var state:String = this.bbdc.getState();
         var direct:uint = this.getBBDC().getDirect();
         switch(state)
         {
            case "hit1":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 19)
                  {
                     this.setYourFather(15);
                     this.doHit1_1(direct);
                  }
               }
               else if(p.x == 1)
               {
                  if(this.bbdc.getCurFrameCount() == 16)
                  {
                     this.doHit1_2(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 26)
                  {
                     this.doHit2(direct);
                  }
               }
               break;
            case "hit3":
               if(p.x == 0)
               {
                  if(this.bbdc.getCurFrameCount() == 29)
                  {
                     this.doHit3_1(direct);
                  }
               }
               else if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 14)
                  {
                     this.doHit3_2(direct);
                  }
               }
               break;
            case "hit4":
               if(p.x == 2)
               {
                  if(this.bbdc.getCurFrameCount() == 40)
                  {
                     this.doHit4(direct);
                  }
               }
         }
      }
      
      private function doHit1_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster15Bullet1_1");
         if(direct == 0)
         {
            b.x = this.x - 80;
         }
         else
         {
            b.x = this.x + 80;
         }
         b.y = this.y - 120;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit1_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster15Bullet1_2");
         if(direct == 0)
         {
            b.x = this.x - 190;
         }
         else
         {
            b.x = this.x + 190;
         }
         b.y = this.y - 90;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(15);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 200;
      }
      
      override protected function releSkill2() : void
      {
         this.newAttackId();
         this.setYourFather(42);
         this.setAction("hit3");
         this.lastHit = "hit3";
      }
      
      override protected function beforeSkill2Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 800;
      }
      
      override protected function releSkill3() : void
      {
         this.newAttackId();
         this.setYourFather(30);
         this.setAction("hit4");
         this.lastHit = "hit4";
      }
      
      override protected function beforeSkill3Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 800;
      }
      
      private function doHit2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster15Bullet2");
         if(direct == 0)
         {
            b.x = this.x - 140;
         }
         else
         {
            b.x = this.x + 140;
         }
         b.y = this.y - 300;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3_1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster15Bullet3_1");
         if(direct == 0)
         {
            b.x = this.x;
         }
         else
         {
            b.x = this.x;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit3_2(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster15Bullet3_2");
         if(direct == 0)
         {
            b.x = this.x - 580;
         }
         else
         {
            b.x = this.x + 580;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit3");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit4(direct:uint) : void
      {
         direct = direct;
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster15Bullet4");
         if(direct == 0)
         {
            b.x = this.x - 300;
         }
         else
         {
            b.x = this.x + 300;
         }
         b.y = this.y - 185;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit4");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
         var playerArray:Array = gc.getPlayerArray();
         for each(bo in playerArray)
         {
            if(this.bbdc.getDirect() == 0)
            {
               if(bo.x < this.x)
               {
                  TweenMax.to(bo,1.5,{
                     "x":this.x - 150,
                     "y":this.y - 50,
                     "onComplete":function(_bo:BaseObject):*
                     {
                        _bo.addCurAddEffect([{
                           "name":BaseAddEffect.SIDATIANWANG_SAN_MP_LOST,
                           "time":gc.frameClips * 4,
                           "mpSource":bo.roleProperies.getMMP()
                        }]);
                     },
                     "onCompleteParams":[bo]
                  });
               }
            }
            else if(bo.x > this.x)
            {
               TweenMax.to(bo,1.5,{
                  "x":this.x - 150,
                  "y":this.y - 50,
                  "onComplete":function(_bo:BaseObject):*
                  {
                     _bo.addCurAddEffect([{
                        "name":BaseAddEffect.SIDATIANWANG_SAN_MP_LOST,
                        "time":gc.frameClips * 4,
                        "mpSource":bo.roleProperies.getMMP()
                     }]);
                  },
                  "onCompleteParams":[bo]
               });
            }
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
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
