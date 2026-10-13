package export.monster
{
   import base.*;
   import com.greensock.*;
   import event.*;
   import export.hero.*;
   import export.monster.Monster23Child.*;
   import flash.display.*;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.utils.*;
   import manager.*;
   import my.*;
   import user.*;
   
   public class Monster24 extends BaseMonster
   {
       
      
      private var h1:Hands;
      
      private var h2:Hands;
      
      private var stick:MovieClip;
      
      private var bg:Sprite;
      
      private var fireTime:int;
      
      private var fireCount:int = 2;
      
      public function Monster24()
      {
         super();
         this.isBoss = true;
         this.monsterName = "牛魔王";
         this.horizenSpeed = 3;
         this.Hp = sHp = 200000;
         this.mysee = 300;
         this.isattback = 50;
         this.attackRange = 400;
         this.def = 0;
         this.exp = 100;
         this.gxp = 20;
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":2,
            "attackBackSpeed":[6,-5],
            "attackInterval":4,
            "power":400,
            "attackKind":"magic"
         };
         this.attackBackInfoDict["hit2"] = {
            "hitMaxCount":30,
            "attackBackSpeed":[2,-10],
            "attackInterval":4,
            "power":300,
            "attackKind":"magic"
         };
         this.fireTime = 24 * int(2 + Math.random() * 5);
      }
      
      override protected function __added(param1:Event) : void
      {
         var idx1:int = 0;
         var idx2:int = 0;
         var evt:Event = param1;
         this.bg = AUtils.getNewObj("Monster24BG");
         this.bg.y = this.y;
         this.bg.x = this.x;
         this.bg.alpha = 0;
         TweenMax.to(this.bg,2,{
            "alpha":1,
            "onComplete":function():*
            {
               init();
            }
         });
         if(gc.hero1)
         {
            idx1 = gc.gameSence.getChildIndex(gc.hero1);
         }
         else
         {
            idx1 = 99999;
         }
         if(gc.hero2)
         {
            idx2 = gc.gameSence.getChildIndex(gc.hero2);
         }
         else
         {
            idx2 = 99999;
         }
         gc.gameSence.addChildAt(this.bg,Math.min(idx1,idx2));
         super.__added(evt);
      }
      
      private function init() : void
      {
         this.h1 = AUtils.getNewObj("export.monster.Monster23Child.Hands");
         this.h2 = AUtils.getNewObj("export.monster.Monster23Child.Hands");
         var _loc1_:Matrix = this.h2.transform.matrix;
         _loc1_.a = -1;
         this.h2.transform.matrix = _loc1_;
         this.stick = new MovieClip();
         this.stick.name = "stick";
         this.stick.x = 0;
         this.stick.y = 18;
         this.h1.x = -300;
         this.h2.x = 300;
         this.stick.addChild(this.h1);
         this.stick.addChild(this.h2);
         this.addChild(this.stick);
      }
      
      override protected function move() : void
      {
      }
      
      override protected function myIntelligence() : void
      {
         if(this.h1)
         {
            this.h1.step();
         }
         if(this.h2)
         {
            this.h2.step();
         }
         if(this.body)
         {
            if(this.body.heart)
            {
               this.body.heart.step();
            }
         }
         if(this.fireTime > 0)
         {
            --this.fireTime;
            if(this.fireTime == 0)
            {
               this.fire();
               this.fireTime = 24 * int(2 + Math.random() * 5);
            }
         }
      }
      
      private function fire() : void
      {
         var _loc2_:Fire = null;
         var _loc1_:int = 0;
         while(_loc1_ < this.fireCount)
         {
            _loc2_ = new Fire(this);
            _loc2_.x = 900 + Math.random() * 800;
            _loc2_.y = 520;
            gc.gameSence.addChild(_loc2_);
            gc.otherList.push(_loc2_);
            _loc1_++;
         }
         switch(this.fireCount)
         {
            case 2:
               this.fireCount = 4;
               break;
            case 4:
               this.fireCount = 6;
               break;
            case 6:
               this.fireCount = 2;
         }
      }
      
      override public function beAttack(param1:BaseHero) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Object = null;
         var _loc5_:Boolean = false;
         var _loc6_:int = 0;
         if(this.beAttackIdArray.indexOf(param1.getAttackId()) != -1)
         {
            return;
         }
         if(this.body)
         {
            if(this.body.heart)
            {
               if(this.body.heart.alpha != 1)
               {
                  return;
               }
            }
         }
         if(this.isYourFather)
         {
            return;
         }
         if(param1.body && this.colipse)
         {
            if(param1.body.stick)
            {
               if(AUtils.testIntersects(this.colipse,param1.body.stick,gc.gameSence) && HitTest.complexHitTestObject(this.colipse,param1.body.stick))
               {
                  ++User.batterNum;
                  this.isattack = true;
                  if(!(param1 is Role2Shadow))
                  {
                     this.curAttackTarget = param1;
                  }
                  else
                  {
                     this.curAttackTarget = Role2Shadow(param1).source;
                  }
                  if(param1 is Role1)
                  {
                     SoundManager.play("BeattackByRole1");
                  }
                  else if(param1 is Role2 || param1 is Role2Shadow)
                  {
                     SoundManager.play("BeattackByRole2");
                  }
                  this.drawMonsterHp();
                  this.showHpSlip();
                  _loc2_ = param1.getRealPower(param1.lastHit);
                  _loc3_ = param1.roleProperies.getBasePower();
                  if(_loc4_ = param1.attackBackInfoDict[param1.curAction])
                  {
                     _loc5_ = _loc4_.attackKind == "magic" ? true : false;
                  }
                  _loc6_ = this.getRealHurt(_loc2_,_loc4_);
                  this.Hp -= _loc6_;
                  if(this.isDead() && this.curAction != "dead")
                  {
                     this.toDead();
                     this.curAction = "dead";
                  }
                  this.beAttackIdArray.push(param1.getAttackId());
                  gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc6_,this.curAttackTarget]));
                  this.addMonHurtMc(_loc6_,_loc3_,_loc5_);
                  this.addBeAttackEffect(param1);
               }
            }
         }
      }
      
      override public function beMagicAttack(param1:*, param2:BaseObject, param3:Boolean = false) : Boolean
      {
         var _loc4_:int = 0;
         var _loc5_:Object = null;
         var _loc6_:Boolean = false;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         if(this.isYourFather)
         {
            return false;
         }
         if(this.body)
         {
            if(this.body.heart)
            {
               if(this.body.heart.alpha != 1)
               {
                  return false;
               }
            }
         }
         if(param3 || this.colipse && AUtils.testIntersects(this.colipse,param1,gc.gameSence) && HitTest.complexHitTestObject(this,param1))
         {
            ++User.batterNum;
            if(!(param2 is Role2Shadow))
            {
               this.curAttackTarget = param2;
            }
            else
            {
               this.curAttackTarget = Role2Shadow(param2).source;
            }
            this.drawMonsterHp();
            this.isattack = true;
            this.showHpSlip();
            if(param2 is Role2Shadow)
            {
               _loc4_ = param2.getRealPower(param2.curAction);
            }
            else
            {
               _loc4_ = param2.getRealPower(param1.curAction);
            }
            if(param2 is Role1)
            {
               SoundManager.play("BeattackByRole1");
            }
            else if(param2 is Role2 || param2 is Role2Shadow)
            {
               SoundManager.play("BeattackByRole2");
            }
            if(_loc5_ = param2.attackBackInfoDict[param1.curAction])
            {
               _loc6_ = _loc5_.attackKind == "magic" ? true : false;
            }
            _loc7_ = this.getRealHurt(_loc4_,_loc5_);
            this.Hp -= _loc7_;
            if(param2 is BaseHero)
            {
               _loc8_ = BaseHero(param2).roleProperies.getBasePower();
            }
            else
            {
               _loc8_ = _loc7_;
            }
            gc.eventManger.dispatchEvent(new CommonEvent("MonsterIsBeat",[_loc4_,this.curAttackTarget]));
            this.addMonHurtMc(_loc7_,_loc8_,_loc6_);
            if(this.isDead() && this.curAction != "dead")
            {
               this.toDead();
               this.curAction = "dead";
            }
            this.addBeAttackEffect(param2);
            return true;
         }
         return false;
      }
      
      private function toDead() : void
      {
         var i:* = undefined;
         var equip:* = undefined;
         this.isYourFather = true;
         var isFall:* = true;
         var fillName:* = "jgz";
         i = 0;
         while(i < gc.player1.zblist.length)
         {
            equip = gc.player1.zblist[i];
            if(equip.fillName == fillName)
            {
               isFall = false;
               break;
            }
            i++;
         }
         i = 0;
         while(i < gc.player2.zblist.length)
         {
            equip = gc.player2.zblist[i];
            if(equip.fillName == fillName)
            {
               isFall = false;
               break;
            }
            i++;
         }
         i = 0;
         while(i < gc.player1.curarray.length)
         {
            equip = gc.player1.curarray[i];
            if(equip.fillName == fillName)
            {
               isFall = false;
               break;
            }
            i++;
         }
         i = 0;
         while(i < gc.player2.curarray.length)
         {
            equip = gc.player2.curarray[i];
            if(equip.fillName == fillName)
            {
               isFall = false;
               break;
            }
            i++;
         }
         if(isFall)
         {
            if(gc.player1.zblist.length < 25)
            {
               gc.player1.zblist.push(gc.allEquip.findByName(fillName));
               setTimeout(function():*
               {
                  gc.showFloatTip("获得 金钢琢");
               },1000);
            }
            else
            {
               setTimeout(function():*
               {
                  gc.showFloatTip("背包已满，无法获得 金刚琢");
               },1000);
            }
         }
         if(gc.monster24RewardTimes < gc.MONSTER24_PER_DAY_TIMES)
         {
            gc.gongxun += gc.monster24Reward;
            ++gc.monster24RewardTimes;
            gc.showFloatTip("获得 战功 + " + gc.monster24Reward);
            if(gc.isHideDebug)
            {
               gc.memory.setStorage();
            }
         }
         TweenMax.to(this,2,{
            "alpha":0,
            "onComplete":function():*
            {
               destroy();
               var _loc1_:* = AUtils.getNewObj("export.scene.Ending");
               gc.gameInfo.addChild(_loc1_);
               gc.keyboardControl.stopAllControl();
            }
         });
      }
   }
}
