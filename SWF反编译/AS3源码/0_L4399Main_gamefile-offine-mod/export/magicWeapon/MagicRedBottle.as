package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
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
   import my.HitTest;
   import my.MyEquipObj;
   
   public class MagicRedBottle extends MagicYuJinPing
   {
       
      
      private var isCatchedPet:Boolean = false;
      
      public function MagicRedBottle(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_RedBottle;
         this.mp = 100;
         this.isCanBeBreak = false;
         var equip:MyEquipObj = this.sourceRole.getPlayer().getCurEquipByType("zbfb");
         if(equip)
         {
            if(equip.getWX().indexOf("木") != -1)
            {
               this.bossSkillInterval = 10;
               this.skillInterval = 10;
            }
         }
      }
      
      override protected function initBBDC() : void
      {
         var body:* = null;
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicRedBottleBmd");
         if(bmdArray)
         {
            body = {
               "name":"body",
               "source":bmdArray
            };
            bbdc = new BaseBitmapDataClip([body],100,100,new Point(0,0));
            bbdc.setOffsetXY(1,-10);
            bbdc.setFrameStopCount([[10],[9999]]);
            bbdc.setFrameCount([1,1]);
            bbdc.setAddScriptWhenFrameOver(scriptFrameOverFunc);
            this.addChild(bbdc);
            return;
         }
         throw new Error("MagicYuJinPingBmd--BitmapData Error!");
      }
      
      override public function showSkill() : void
      {
         this.setAction("hit");
      }
      
      private function reset(bb:BaseBullet) : void
      {
         this.isCatching = false;
         this.isCatchedPet = false;
         if(this.sourceRole)
         {
            this.setAction("wait");
         }
      }
      
      override protected function startCatchSkillNew() : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("MagicRedBottleEffect");
         var direct:uint = this.sourceRole.getBBDC().getDirect();
         b.x = this.x;
         b.y = this.y;
         b.setRole(this.sourceRole);
         b.setDisable();
         b.setFuncWhenEnterFrame(checkCatchSkillSuccess);
         b.setFuncWhenDestroy(reset);
         if(this.isCanBeBreak)
         {
            b.setHurtCanCutDownEffect(true);
         }
         else
         {
            b.setHurtCanCutDownEffect(false);
         }
         b.setDirect(direct);
         b.setAction("hit1");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
         this.showSkill();
      }
      
      override protected function checkCatchSkillSuccess(bb:BaseBullet) : void
      {
         bb = bb;
         if(this.sourceRole)
         {
            trace("---------------------this.isCatchedPet：" + this.isCatchedPet);
            if(!this.isCatchedPet)
            {
               for each(bm in gc.pWorld.likeMonsterArray)
               {
                  if(bm is Monster70 || bm is Monster71 || bm is Monster72 || bm is Monster73 || bm is Monster74 || bm is Monster75 || bm is Monster76 || bm is Monster77 || bm is Monster78 || bm is Monster1551 || bm is Monster80 || bm is Monster81 || bm is Monster82)
                  {
                     if(HitTest.complexHitTestObject(bb,bm.colipse))
                     {
                        var petName:String = "";
                        if(bm is Monster70 || bm is Monster72)
                        {
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
                           petName = "tigress1";
                        }
                        else if(bm is Monster75)
                        {
                           petName = "turtle1";
                        }
                        else if(bm is Monster76)
                        {
                           petName = "phoenix1";
                        }
                        else if(bm is Monster77)
                        {
                           petName = "dragon1";
                        }
                        else if(bm is Monster78)
                        {
                           petName = "rabbit1";
                        }
                        else if(bm is Monster1551)
                        {
                           petName = "nian1";
                        }
                        else if(bm is Monster80)
                        {
                           petName = "mouse1";
                        }
                        else if(bm is Monster81)
                        {
                           petName = "neat1";
                        }
                        else if(bm is Monster82)
                        {
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
                        var result:Boolean = this.sourceRole.getPlayer().catchNewPet(petName,bm.getLevel());
                        trace("result-->:" + result);
                        if(result)
                        {
                           bm.destroy();
                           TweenMax.delayedCall(2,function():*
                           {
                              gc.ts.setTxt("捕捉成功！");
                              gc.stage.addChild(gc.ts);
                           });
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
                        this.isCatchedPet = true;
                        break;
                     }
                  }
               }
            }
            for each(bm in gc.pWorld.monsterArray)
            {
               if(bm.isCanBeCatchSkill)
               {
                  if(!bm.isBeTryCatchSkill)
                  {
                     if(HitTest.complexHitTestObject(bb,bm.colipse))
                     {
                        gc.ts.setTxt("吸收成功，激活技能成功");
                        gc.stage.addChild(gc.ts);
                        this.sourceRole.getPlayer().achieveBossSkill(bm.monsterName);
                        bm.isBeTryCatchSkill = true;
                        break;
                     }
                  }
               }
            }
         }
      }
   }
}
