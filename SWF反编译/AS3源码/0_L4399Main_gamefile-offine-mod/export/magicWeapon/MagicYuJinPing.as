package export.magicWeapon
{
   import base.BaseBitmapDataClip;
   import base.BaseBitmapDataPool;
   import base.BaseBullet;
   import base.BaseHero;
   import base.BaseMagicWeapon;
   import base.BaseMonster;
   import com.greensock.TweenMax;
   import event.CommonEvent;
   import export.bullet.EnemyMoveBullet;
   import export.bullet.FollowBaseObjectBullet;
   import export.bullet.SpecialEffectBullet;
   import export.monster.Monster48;
   import export.monster.Monster49;
   import export.monster.Monster50;
   import export.monster.Monster51;
   import export.monster.Monster52;
   import flash.geom.Point;
   import mvc.controllor.RandomControllor;
   import my.KeyCodeCombo;
   import my.MyEquipObj;
   
   public class MagicYuJinPing extends BaseMagicWeapon
   {
       
      
      protected var bossSkillInterval:uint = 20;
      
      protected var skillInterval:uint = 20;
      
      protected var isCatching:Boolean = false;
      
      protected var isCanBeBreak:Boolean = true;
      
      protected const TYPE_DOWN_DOWN_J:uint = 1;
      
      protected const TYPE_UP_UP_J:uint = 2;
      
      protected const TYPE_DOWN_UP_J:uint = 3;
      
      public function MagicYuJinPing(bo:BaseHero)
      {
         super(bo);
         this.bmwId = BaseMagicWeapon.BMW_YuJinPing;
         this.mp = 140;
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
         var bmdArray:Array = BaseBitmapDataPool.getBitmapDataArrayByName("MagicYuJinPingBmd");
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
         throw new Error("MagicYuJinPingBmd--BitmapData Error!");
      }
      
      public function checkCombo(comboArr:Array) : void
      {
         var skillKeyCode1:* = null;
         var skillKeyCode2:* = null;
         var skillKeyCode3:* = null;
         var skillFabao:* = null;
         var fabaoKcc:* = null;
         skillFabao = null;
         fabaoKcc = null;
         var keyCode:Array = [];
         for each(var kcc in comboArr)
         {
            keyCode.push(kcc.keyCode);
         }
         if(!this.isUsing())
         {
            if(this.sourceRole)
            {
               skillKeyCode1 = gc.keyboardControl.getCombo1ByPlayer(this.sourceRole.getPlayer());
               skillKeyCode2 = gc.keyboardControl.getCombo2ByPlayer(this.sourceRole.getPlayer());
               skillKeyCode3 = gc.keyboardControl.getCombo3ByPlayer(this.sourceRole.getPlayer());
               if(keyCode.join(",").indexOf(skillKeyCode1) != -1)
               {
                  this.showBossSkillByType(1);
                  comboArr.length = 0;
               }
               else if(keyCode.join(",").indexOf(skillKeyCode2) != -1)
               {
                  this.showBossSkillByType(2);
                  comboArr.length = 0;
               }
               else if(keyCode.join(",").indexOf(skillKeyCode3) != -1)
               {
                  this.showBossSkillByType(3);
                  comboArr.length = 0;
               }
            }
         }
         if(!this.isCatching)
         {
            if(!this.isUsing())
            {
               if(comboArr.length > 0)
               {
                  skillFabao = gc.keyboardControl.getFaBaoByPlayer(this.sourceRole.getPlayer());
                  fabaoKcc = comboArr[comboArr.length - 1] as KeyCodeCombo;
                  if(fabaoKcc.keyCode.toString() == skillFabao)
                  {
                     if(this.sourceRole)
                     {
                        if(this.sourceRole.roleProperies.getMMP() >= mp)
                        {
                           this.startCatchSkillNew();
                           this.isCatching = true;
                           this.sourceRole.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.sourceRole.roleProperies.getMMP() - mp]));
                        }
                     }
                  }
               }
            }
         }
         else if(this.isCanBeBreak)
         {
            for each(var bb in this.sourceRole.magicBulletArray)
            {
               if(bb.getImcName() == "MagicYuJinPingSkillUseEffect")
               {
                  skillFabao = gc.keyboardControl.getFaBaoByPlayer(this.sourceRole.getPlayer());
                  fabaoKcc = comboArr[comboArr.length - 1] as KeyCodeCombo;
                  if(fabaoKcc)
                  {
                     if(fabaoKcc.keyCode.toString() != skillFabao)
                     {
                        bb.destroy();
                        this.isCatching = false;
                     }
                  }
               }
            }
         }
      }
      
      private function showBossSkillByType(type:uint) : void
      {
         type = type;
         if(this.curAction == "hit")
         {
            return;
         }
         if(this.sourceRole)
         {
            var obj:Object = this.sourceRole.getPlayer().findBossSkillByBossSkillType(type);
            if(obj)
            {
               var skillName:String = obj.skillName;
               var needMp:uint = obj.needLh;
               if(skillName != "")
               {
                  if(this.sourceRole.roleProperies.getMMP() >= needMp)
                  {
                     this.showEffectWhenUseSkill();
                     this.setAction("hit");
                     TweenMax.delayedCall(1.7,function(_self:*, _skillName:String, _point:Point, _direct:uint):*
                     {
                        _self.showBossSkill(_skillName,_point,_direct);
                     },[this,skillName,new Point(this.x,this.y),this.getBBDC().getDirect()]);
                     if(this.sourceRole)
                     {
                        TweenMax.delayedCall(this.bossSkillInterval,function(_self:*):*
                        {
                           _self.setAction("wait");
                        },[this]);
                     }
                     this.sourceRole.roleProperies.dispatchEvent(new CommonEvent("SetMMp",[this.sourceRole.roleProperies.getMMP() - needMp]));
                  }
               }
            }
         }
      }
      
      private function showBossSkill(skillName:String, point:Point, direct:uint) : void
      {
         skillName = skillName;
         point = point;
         direct = direct;
         if(this.sourceRole)
         {
            var b:SpecialEffectBullet = new SpecialEffectBullet("BossSkill_" + skillName);
            b.x = point.x;
            b.y = point.y;
            b.setRole(this.sourceRole);
            b.setDirect(direct);
            b.setAction("BossSkill_" + skillName);
            gc.gameSence.addChild(b);
            this.sourceRole.magicBulletArray.push(b);
            if(skillName == "bs_nh")
            {
               b.setDisable();
               for each(bm in gc.pWorld.monsterArray)
               {
                  if(!bm.isYourFather() && !(bm is Monster49) && !(bm is Monster50) && !(bm is Monster51) && !(bm is Monster52) && !(bm is Monster48))
                  {
                     TweenMax.to(bm,1,{
                        "x":this.x,
                        "y":this.y - 100
                     });
                  }
               }
            }
            else if(skillName == "bs_erishiba_3")
            {
               b.setDisable();
               var target:BaseMonster = gc.pWorld.monsterArray[int(RandomControllor.getIns().getRandom() * gc.pWorld.monsterArray.length)];
               if(target)
               {
                  b = new SpecialEffectBullet("BossSkill_bs_erishiba_3_bullet1");
                  b.x = target.x;
                  b.y = target.y;
                  b.setRole(this.sourceRole);
                  b.setDirect(direct);
                  b.setAction("BossSkill_" + skillName);
                  gc.gameSence.addChild(b);
                  this.sourceRole.magicBulletArray.push(b);
               }
            }
            else if(skillName == "bs_erishiba_5")
            {
               b.setDisable();
               this.bs_erishiba_5();
            }
            else if(skillName == "bs_erishiba_7")
            {
               b.setDisable();
               target = gc.pWorld.monsterArray[int(RandomControllor.getIns().getRandom() * gc.pWorld.monsterArray.length)];
               if(target)
               {
                  var pos:Point = new Point(target.x,target.y);
                  this.singleErshiba_7(pos);
                  TweenMax.delayedCall(0.4,function(_self:*, _pos:Point):*
                  {
                     _self.singleErshiba_7(new Point(_pos.x - 80,_pos.y));
                  },[this,pos]);
                  TweenMax.delayedCall(0.8,function(_self:*, _pos:Point):*
                  {
                     _self.singleErshiba_7(new Point(_pos.x + 80,_pos.y));
                  },[this,pos]);
               }
            }
            else if(skillName == "bs_erishiba_11")
            {
               b.setDisable();
               b.setDestroyWhenLastFrame(false);
               b.setDestroyInCount(30);
               b.setFuncWhenEnterFrame(ershiba_11Enter);
            }
            else if(skillName == "bs_erishiba_13")
            {
               for(var i:uint = 0; i < 5; )
               {
                  b = new SpecialEffectBullet("Monster159Bullet3");
                  b.x = this.x + (RandomControllor.getIns().getRandom() - 0.5) * 1200;
                  b.y = 510;
                  b.setRole(this.sourceRole);
                  b.setDirect(direct);
                  b.setAction("BossSkill_bs_erishiba_13");
                  gc.gameSence.addChild(b);
                  this.sourceRole.magicBulletArray.push(b);
                  i++;
               }
            }
            else if(skillName == "bs_erishiba_14")
            {
               b = new SpecialEffectBullet("Monster162Bullet3");
               if(direct == 0)
               {
                  b.x = this.x - 45;
               }
               else
               {
                  b.x = this.x + 45;
               }
               b.y = this.y + 85;
               b.setRole(this.sourceRole);
               b.setDirect(direct);
               b.setAction("BossSkill_bs_erishiba_14");
               gc.gameSence.addChild(b);
               this.sourceRole.magicBulletArray.push(b);
            }
         }
      }
      
      private function ershiba_11Enter(bb:BaseBullet) : void
      {
         if(bb.getDirect() == -1)
         {
            bb.x -= 15;
         }
         else
         {
            bb.x += 15;
         }
         var monArray:Array = gc.pWorld.monsterArray;
         for each(var bm in monArray)
         {
            if(bb.hitTestObject(bm.colipse))
            {
               bb.destroy();
               this.showErshiba_11(bm);
               break;
            }
         }
      }
      
      private function showErshiba_11(bm:BaseMonster) : void
      {
         var b:FollowBaseObjectBullet = new FollowBaseObjectBullet("Monster157Bullet2");
         b.x = bm.x;
         b.y = bm.y;
         b.setRole(this.sourceRole);
         b.setDirect(0);
         b.setAction("BossSkill_bs_erishiba_11");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
      }
      
      private function singleErshiba_7(pos:Point) : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("Monster150Bullet4");
         b.x = pos.x;
         b.y = pos.y + 50;
         b.setRole(this.sourceRole);
         b.setDirect(0);
         b.setAction("BossSkill_bs_erishiba_7");
         gc.gameSence.addChild(b);
         this.sourceRole.magicBulletArray.push(b);
      }
      
      private function bs_erishiba_5() : void
      {
         var target:BaseMonster = gc.pWorld.monsterArray[int(RandomControllor.getIns().getRandom() * gc.pWorld.monsterArray.length)];
         if(target)
         {
            var stoneLen:uint = 5;
            for(var i:uint = 0; i < stoneLen; )
            {
               var b:SpecialEffectBullet = new SpecialEffectBullet("BossSkill_bs_erishiba_5_bullet");
               b.x = this.x + (2 - i) * 75;
               b.y = this.y + 75;
               b.setRole(this.sourceRole);
               b.setDirect(0);
               b.setDestroyWhenLastFrame(false);
               b.setDisable();
               b.setAction("BossSkill_bs_erishiba_5");
               gc.gameSence.addChild(b);
               this.sourceRole.magicBulletArray.push(b);
               var targetY:Number = this.y - (100 + i % 2 * 75);
               TweenMax.to(b,1,{
                  "y":targetY,
                  "onComplete":function(_b:SpecialEffectBullet, _target:BaseMonster, _self:BaseHero):*
                  {
                     var eb:* = null;
                     var p:* = null;
                     if(!_target.isDead())
                     {
                        eb = new EnemyMoveBullet("Monster147Bullet2");
                        eb.x = _b.x;
                        eb.y = _b.y;
                        eb.setRole(_self);
                        p = AUtils.GetNextPointByTwoObj(eb,_target);
                        eb.setSpeed(8 * p.x,8 * p.y);
                        eb.setAddSpeed(p.x,p.y);
                        eb.setDistance(2000);
                        eb.setDestroyWhenLastFrame(false);
                        eb.setDirect(0);
                        eb.setAction("BossSkill_bs_erishiba_5");
                        gc.gameSence.addChild(eb);
                        _self.magicBulletArray.push(eb);
                     }
                     _b.destroy();
                  },
                  "onCompleteParams":[b,target,this.sourceRole]
               });
               i++;
            }
         }
      }
      
      private function showEffectWhenUseSkill() : void
      {
         var b:* = null;
         if(this.sourceRole)
         {
            b = new SpecialEffectBullet("MagicYuJinPingBossSkillEffect");
            b.x = this.x;
            b.y = this.y;
            b.setRole(this.sourceRole);
            b.setDisable();
            b.setDirect(0);
            b.setAction("hit1");
            gc.gameSence.addChild(b);
            this.sourceRole.magicBulletArray.push(b);
         }
      }
      
      override public function showSkill() : void
      {
         this.setAction("hit");
         if(this.sourceRole)
         {
            TweenMax.delayedCall(this.skillInterval,function(_self:*):*
            {
               _self.isCatching = false;
               _self.setAction("wait");
            },[this]);
         }
      }
      
      override public function useSkill() : void
      {
      }
      
      protected function startCatchSkillNew() : void
      {
         this.startCatchSkill();
      }
      
      private function startCatchSkill() : void
      {
         var b:SpecialEffectBullet = new SpecialEffectBullet("MagicYuJinPingSkillUseEffect");
         var direct:uint = this.sourceRole.getBBDC().getDirect();
         b.x = this.x;
         b.y = this.y;
         b.setRole(this.sourceRole);
         b.setDisable();
         b.setFuncWhenEnterFrame(checkCatchSkillSuccess);
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
      
      protected function checkCatchSkillSuccess(bb:BaseBullet) : void
      {
         if(this.sourceRole)
         {
            for each(bb in this.sourceRole.magicBulletArray)
            {
               if(bb.getImcName() == "MagicYuJinPingSkillUseEffect")
               {
                  if(bb.getImgMc())
                  {
                     if(bb.getImgMc().currentFrame == bb.getImgMc().totalFrames - 1)
                     {
                        for each(var bm in gc.pWorld.monsterArray)
                        {
                           if(bm.isCanBeCatchSkill)
                           {
                              if(!bm.isBeTryCatchSkill)
                              {
                                 if(RandomControllor.getIns().getRandom() <= 0.5)
                                 {
                                    gc.ts.setTxt("吸收成功，激活技能成功");
                                    gc.stage.addChild(gc.ts);
                                    this.sourceRole.getPlayer().achieveBossSkill(bm.monsterName);
                                 }
                                 else
                                 {
                                    gc.ts.setTxt("吸收成功，激活技能失败");
                                    gc.stage.addChild(gc.ts);
                                 }
                                 bm.isBeTryCatchSkill = true;
                              }
                              else
                              {
                                 gc.ts.setTxt("您已经吸收过该BOSS");
                                 gc.stage.addChild(gc.ts);
                              }
                              break;
                           }
                        }
                     }
                  }
               }
            }
         }
      }
   }
}
