package export.pet
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BasePet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import flash.display.Sprite;
   import flash.geom.Point;
   import petInfo.PetInfo;
   
   public class PetPhoenix1 extends BasePet
   {
       
      
      public function PetPhoenix1(bh:BaseHero, pi:PetInfo)
      {
         super(bh,pi);
         this.horizenSpeed = 5;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":999,
            "power":12,
            "attackKind":"physics"
         };
         this.attackRange = 100;
         this.setAction("wait");
         this.skillCD1 = [gc.frameClips * 4,gc.frameClips * 8];
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("PetPhoenixBmd1");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[2,2,2,3,2,4],[8,120],[2,2,2,2,10],[2,2,2,10]]);
            bbdc.setFrameCount([6,[1,1],5,4]);
            bbdc.setEnterFrameCallBack(enterFrameFunc,exitFrameFunc);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.body.addChild(bbdc);
            return;
         }
         throw new Error("PetPhoenixBmd1--BitmapData Error!");
      }
      
      override protected function newColipse() : void
      {
         this.colipse = AUtils.getNewObj("ObjectBaseSprite3") as Sprite;
         this.colipse.visible = false;
         this.addChild(this.colipse);
      }
      
      override public function setAction(str:String) : void
      {
         if(this.curAction == "hit2")
         {
            if(str == "hurt")
            {
               return;
            }
         }
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
               if(curPoint.x != 0 && curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "hit1":
               if(curPoint.y != 3)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(3);
               }
               this.bbdc.setState(str);
               break;
            case "hit2":
               if(curPoint.x != 1 && curPoint.y != 1)
               {
                  this.bbdc.setFramePointX(1);
                  this.bbdc.setFramePointY(1);
               }
               this.bbdc.setState(str);
               break;
            case "dead":
               if(curPoint.y != 2)
               {
                  this.bbdc.setFramePointX(0);
                  this.bbdc.setFramePointY(2);
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
               this.doHit2_2(this.getBBDC().getDirect(),new Point(this.x,this.y));
               this._petInfo.setHp(this._petInfo.getSHp());
               this.setAction("wait");
               break;
            case "hurt":
               this.setStatic();
               this.setAction("wait");
               break;
            case "dead":
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
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 3)
                  {
                     if(this.bbdc.getCurFrameCount() == 10)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x - 75;
                        }
                        else
                        {
                           point.x = this.x + 75;
                        }
                        point.y = this.y - 30;
                        this.doHit1(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit1",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
               break;
            case "hit2":
               if(gc.isSingleGame() || gc.sid == this.sourceRole.sid)
               {
                  if(p.x == 1)
                  {
                     if(this.bbdc.getCurFrameCount() == 120)
                     {
                        if(direct == 0)
                        {
                           point.x = this.x;
                        }
                        else
                        {
                           point.x = this.x;
                        }
                        point.y = this.y - 60;
                        this.doHit2_1(direct,point);
                        gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2",this.getBBDC().getDirect(),point.x,point.y,[]);
                     }
                  }
               }
         }
      }
      
      override protected function beforeSkill1Start() : Boolean
      {
         if(this._petInfo.findHasStudySkill("np"))
         {
            if(this._petInfo.getMp() >= this._petInfo.findPetUsedMagic("np"))
            {
               if(this.curAction != "hit2")
               {
                  if(this._petInfo.getHp() / this._petInfo.getSHp() <= 0.2)
                  {
                     return true;
                  }
               }
            }
         }
         return false;
      }
      
      override protected function releSkill1() : void
      {
         this.newAttackId();
         this.setAction("hit2");
         this.lastHit = "hit2";
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"hit2Action",this.getBBDC().getDirect(),0,0,[]);
         }
         this._petInfo.setMp(this._petInfo.getMp() - this._petInfo.findPetUsedMagic("np"));
      }
      
      private function doHit1(direct:uint, point:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("PetPhoenix1Bullet1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_1(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetPhoenix1Bullet2_1");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDisable();
         b.setDestroyWhenLastFrame(false);
         b.setDestroyInCount(gc.frameClips * 5);
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      private function doHit2_2(direct:uint, point:Point) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("PetPhoenix1Bullet2_2");
         b.x = point.x;
         b.y = point.y;
         b.setRole(this);
         b.setDisable();
         b.setDirect(direct);
         b.setAction("hit2");
         gc.gameSence.addChild(b);
         this.magicBulletArray.push(b);
      }
      
      override public function setOtherAttack(attackKind:String, direct:uint, point:Point, params:Array = null, initTimer:uint = 0) : void
      {
         switch(attackKind)
         {
            case "hit1":
               this.doHit1(direct,point);
               break;
            case "hit2":
               this.doHit2_1(direct,point);
               break;
            case "hit2Action":
               this.releSkill1();
               break;
            case "normalHit":
               this.normalHit();
         }
      }
      
      override protected function normalHit() : void
      {
         this.newAttackId();
         this.setAction("hit1");
         this.lastHit = "hit1";
         if(gc.sid == this.sourceRole.sid)
         {
            this.faceToTarget();
            gc.sendPetAttack(this.sourceRole.getRoleId(),"normalHit",this.getBBDC().getDirect(),0,0,[]);
         }
      }
      
      override public function getRealPower(cur:String, crit:Boolean = true) : int
      {
         var critValue:uint = !!this.getCriteValue(crit) ? 2 : 1;
         var hurtAdd:uint = this.getMagicAddValue();
         var wsAdd:Number = !!this.isGXP ? 1.2 : 1;
         switch(cur)
         {
            case "hit1":
               return (this._petInfo.getAtk() + hurtAdd) * critValue * wsAdd * this.hurtBaseEffectRate();
            case "hit2":
               return 0;
            default:
               return 0;
         }
      }
      
      override protected function exitFrameFunc(p:Point) : void
      {
      }
      
      override public function setAttackBack(p:Point) : void
      {
         if(this.curAction == "hit2")
         {
            return;
         }
         super.setAttackBack(p);
      }
      
      override public function reduceHp(re:int, canHurt:Boolean = false) : void
      {
         if(this.curAction == "hit2")
         {
            re /= 3;
         }
         super.reduceHp(re,canHurt);
      }
      
      override protected function myIntelligence() : void
      {
         if(!this.isBeAttacking())
         {
            super.myIntelligence();
         }
      }
      
      override protected function isCannotMoveWhenAttackOnFloor() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2";
      }
   }
}
