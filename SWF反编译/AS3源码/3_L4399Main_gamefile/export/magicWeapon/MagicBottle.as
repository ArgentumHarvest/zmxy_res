package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import export.bullet.SpecialEffectBullet;
   import export.monster.Monster1551;
   import export.monster.Monster70;
   import export.monster.Monster71;
   import export.monster.Monster72;
   import export.monster.Monster73;
   import export.monster.Monster74;
   import export.monster.Monster75;
   import export.monster.Monster76;
   import export.monster.Monster77;
   import export.monster.Monster78;
   import export.monster.Monster80;
   import export.monster.Monster81;
   import export.monster.Monster82;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   
   public class MagicBottle extends BaseMagicWeapon
   {
       
      
      private var effect:SpecialEffectBullet;
      
      public function MagicBottle(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_Bottle;
         this.mp = 20;
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicBottleBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],80,80,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicBottle--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         if(this.sourceRole.getPlayer().getLhValue() < 100)
         {
            this.setAction("wait");
            return;
         }
         effect = new SpecialEffectBullet("MagicBottleEffect3");
         if(this.sourceRole.getBBDC().getDirect() == 0)
         {
            effect.x = this.sourceRole.x - 70;
         }
         else
         {
            effect.x = this.sourceRole.x + 70;
         }
         effect.y = this.sourceRole.y;
         effect.setDisable();
         effect.setDirect(this.sourceRole.getBBDC().getDirect());
         effect.setRole(this.sourceRole);
         effect.setAction("wait");
         this.sourceRole.magicBulletArray.push(effect);
         gc.gameSence.addChild(effect);
         TweenMax.delayedCall(2,function(_self:MagicBottle):*
         {
            _self.setAction("wait");
         },[this]);
      }
      
      override public function step() : void
      {
         super.step();
         if(this.effect)
         {
            if(this.effect.isReadyToDestroy)
            {
               this.effect = null;
            }
         }
         if(gc.isSingleGame())
         {
            if(this.effect)
            {
               for each(bm in gc.pWorld.likeMonsterArray)
               {
                  if(bm is Monster70 || bm is Monster71 || bm is Monster72 || bm is Monster73 || bm is Monster74 || bm is Monster75 || bm is Monster76 || bm is Monster77 || bm is Monster78 || bm is Monster1551 || bm is Monster80 || bm is Monster81 || bm is Monster82)
                  {
                     if(HitTest.complexHitTestObject(this.effect,bm.colipse))
                     {
                        this.sourceRole.getPlayer().setLhValue(this.sourceRole.getPlayer().getLhValue() - 100);
                        var petName:String = "";
                        if(bm is Monster70 || bm is Monster72)
                        {
                           var rate:Number = 0.4;
                           if(bm is Monster70)
                           {
                              petName = "horse1";
                           }
                           else
                           {
                              petName = "monkey1";
                           }
                        }
                        else if(bm is Monster71 || bm is Monster73)
                        {
                           rate = 0.7;
                           if(bm is Monster71)
                           {
                              petName = "horse2";
                           }
                           else
                           {
                              petName = "monkey2";
                           }
                        }
                        else if(bm is Monster74)
                        {
                           rate = 0.4;
                           petName = "tigress1";
                        }
                        else if(bm is Monster75)
                        {
                           rate = 0.4;
                           petName = "turtle1";
                        }
                        else if(bm is Monster76)
                        {
                           rate = 0.4;
                           petName = "phoenix1";
                        }
                        else if(bm is Monster77)
                        {
                           rate = 0.4;
                           petName = "dragon1";
                        }
                        else if(bm is Monster78)
                        {
                           rate = 0.4;
                           petName = "rabbit1";
                        }
                        else if(bm is Monster1551)
                        {
                           rate = 0.2;
                           petName = "nian1";
                        }
                        else if(bm is Monster80)
                        {
                           rate = 0.2;
                           petName = "mouse1";
                        }
                        else if(bm is Monster81)
                        {
                           rate = 0.2;
                           petName = "neat1";
                        }
                        else if(bm is Monster82)
                        {
                           rate = 0.2;
                           petName = "terribletiger1";
                        }
                        var firstString:String = petName.substr(0,petName.length - 1);
                        if(bm.getLevel() > 1 && bm.getLevel() <= 15)
                        {
                           petName = firstString + "1";
                        }
                        else if(bm.getLevel() > 15 && bm.getLevel() <= 30)
                        {
                           petName = firstString + "2";
                        }
                        else
                        {
                           petName = firstString + "3";
                        }
                        var mc:MovieClip = AUtils.getNewObj("MagicBottleEffect2") as MovieClip;
                        bm.body.addChild(mc);
                        if(RandomControllor.getIns().getRandom() <= rate)
                        {
                           var result:Boolean = this.sourceRole.getPlayer().catchNewPet(petName,bm.getLevel());
                           if(result)
                           {
                              TweenMax.delayedCall(2,function(_bm:BaseMonster):*
                              {
                                 gc.ts.setTxt("捕捉成功！");
                                 gc.stage.addChild(gc.ts);
                                 _bm.destroy();
                              },[bm]);
                           }
                           else
                           {
                              gc.ts.setTxt("宠物栏已满！");
                              gc.stage.addChild(gc.ts);
                              TweenMax.delayedCall(2,function(_bm:BaseMonster, _mc:MovieClip):*
                              {
                                 _bm.body.removeChild(_mc);
                              },[bm,mc]);
                           }
                        }
                        else
                        {
                           gc.ts.setTxt("捕捉失败！");
                           gc.stage.addChild(gc.ts);
                           TweenMax.delayedCall(2,function(_bm:BaseMonster, _mc:MovieClip):*
                           {
                              _bm.body.removeChild(_mc);
                           },[bm,mc]);
                        }
                        this.effect = null;
                        break;
                     }
                  }
               }
            }
         }
      }
   }
}
