package export.monster
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMonster;
   import export.bullet.SpecialEffectBullet;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   
   public class Monster4 extends BaseMonster
   {
       
      
      public function Monster4()
      {
         super();
         this.horizenSpeed = 3;
         this.setHp(1000);
         this.setSHp(1000);
         this.attackRange = 250;
         this.alertRange = 1000;
         this._anti.def = 8;
         this._anti.exp = 20;
         this._anti.gxp = 10;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-10,-5],
            "attackInterval":999,
            "power":50,
            "attackKind":"physics"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[-8,-2],
            "attackInterval":999,
            "power":34,
            "attackKind":"magic"
         };
         this.isBoss = true;
         this.isCanBeCatchSkill = true;
         this.monsterName = "千里眼";
         this.setAction("wait");
         this.setToCountSuppressLevel(10);
         this._anti.fallProbability = 0.45;
         this._anti.fallList = [{
            "name":"kyg",
            "bigtype":"zb"
         },{
            "name":"kyz",
            "bigtype":"zb"
         }];
         this.skillCD1 = [gc.frameClips * 6,gc.frameClips * 6];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("Monster4");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],190,190,new Point(0,0));
            bbdc.setOffsetXY(0,-10);
            bbdc.setFrameStopCount([[2,3,4,3,3],[4,4,4,4],[8],[2,2,2,2,2,8],[4,4,4,2,7],[2,2,2,2,29,23]]);
            bbdc.setFrameCount([5,4,1,5,5,6]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("Monster4--BitmapData Error!");
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
                  if(this.bbdc.getCurFrameCount() == 1)
                  {
                     this.doHi1(direct);
                  }
               }
               break;
            case "hit2":
               if(p.x == 3)
               {
                  if(this.bbdc.getCurFrameCount() == 2)
                  {
                     this.doHi2_1(direct);
                  }
               }
               else if(p.x == 4)
               {
                  if(this.bbdc.getCurFrameCount() == 9)
                  {
                     this.doHi2_2(direct);
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         return this.curAttackTarget && AUtils.GetDisBetweenTwoObj(this.curAttackTarget,this) < 500;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setYourFather(45);
         this.setAction("hit2");
         this.lastHit = "hit2";
      }
      
      private function doHi1(direct:uint) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster4Bullet1");
         if(direct == 0)
         {
            b.x = this.x - 155;
         }
         else
         {
            b.x = this.x + 155;
         }
         b.y = this.y;
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
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster4Bullet2_1");
         if(direct == 0)
         {
            b.x = this.x - 40;
         }
         else
         {
            b.x = this.x + 40;
         }
         b.y = this.y - 70;
         b.setRole(this);
         b.setDisable();
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
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster4Bullet2_2");
         if(direct == 0)
         {
            b.x = this.x - 195;
         }
         else
         {
            b.x = this.x + 195;
         }
         b.y = this.y - 50;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit2");
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
         var flag:Boolean = true;
         for each(var bm in gc.pWorld.monsterArray)
         {
            if(bm is Monster2)
            {
               if(!bm.isDead())
               {
                  flag = false;
               }
            }
         }
         if(flag && this.isBoss)
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
