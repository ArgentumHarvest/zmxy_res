package export.monster
{
   import base.BaseMonster;
   import export.bullet.*;
   import flash.display.MovieClip;
   
   public class Monster26 extends BaseMonster
   {
       
      
      protected var addEffectObj:Object;
      
      private var minLevel:int;
      
      public function Monster26()
      {
         var _loc3_:* = undefined;
         var _loc4_:* = undefined;
         trace("===Monster26===");
         super();
         this.isBoss = true;
         this.monsterName = "龙王";
         this.horizenSpeed = 4;
         if(gc.hero1)
         {
            this.minLevel = gc.hero1.roleProperies.getLevel();
         }
         if(gc.hero2)
         {
            this.minLevel = gc.hero2.roleProperies.getLevel() < this.minLevel ? int(gc.hero2.roleProperies.getLevel()) : int(this.minLevel);
         }
         if(this.minLevel > 20)
         {
            this.Hp = sHp = 40000;
         }
         else
         {
            this.Hp = sHp = 12000;
         }
         this.mysee = 300;
         this.attackRange = 400;
         if(this.minLevel > 20)
         {
            this.def = 150;
            this.isattback = 20;
            this.exp = 300;
            this.gxp = 100;
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":30,
               "attackBackSpeed":[6,-5],
               "attackInterval":999,
               "power":200,
               "attackKind":"physics"
            };
            this.attackBackInfoDict["hit2"] = {
               "hitMaxCount":30,
               "attackBackSpeed":[10,-2],
               "attackInterval":999,
               "power":35,
               "attackKind":"magic"
            };
            this.attackBackInfoDict["hit3"] = {
               "hitMaxCount":40,
               "attackBackSpeed":[0,0],
               "attackInterval":999,
               "power":100,
               "addEffect":[{
                  "name":"ice",
                  "time":24 * 5,
                  "power":0
               }],
               "attackKind":"magic"
            };
            this.attackBackInfoDict["hit4"] = {
               "hitMaxCount":30,
               "attackBackSpeed":[20,-20],
               "attackInterval":999,
               "power":300,
               "attackKind":"magic"
            };
         }
         else
         {
            this.def = 50;
            this.isattback = 40;
            this.exp = 150;
            this.gxp = 70;
            this.attackBackInfoDict["hit1"] = {
               "hitMaxCount":30,
               "attackBackSpeed":[6,-5],
               "attackInterval":999,
               "power":90,
               "attackKind":"physics"
            };
            this.attackBackInfoDict["hit2"] = {
               "hitMaxCount":30,
               "attackBackSpeed":[10,-2],
               "attackInterval":999,
               "power":17,
               "attackKind":"magic"
            };
            this.attackBackInfoDict["hit3"] = {
               "hitMaxCount":40,
               "attackBackSpeed":[0,0],
               "attackInterval":999,
               "power":20,
               "addEffect":[{
                  "name":"ice",
                  "time":24 * 2,
                  "power":0
               }],
               "attackKind":"magic"
            };
            this.attackBackInfoDict["hit4"] = {
               "hitMaxCount":30,
               "attackBackSpeed":[20,-20],
               "attackInterval":999,
               "power":150,
               "attackKind":"magic"
            };
         }
         var _loc1_:* = true;
         var _loc2_:* = "dhqf";
         _loc3_ = 0;
         while(_loc3_ < gc.player1.zblist.length)
         {
            if((_loc4_ = gc.player1.zblist[_loc3_]).fillName == _loc2_)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < gc.player2.zblist.length)
         {
            if((_loc4_ = gc.player2.zblist[_loc3_]).fillName == _loc2_)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < gc.player1.curarray.length)
         {
            if((_loc4_ = gc.player1.curarray[_loc3_]).fillName == _loc2_)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         _loc3_ = 0;
         while(_loc3_ < gc.player2.curarray.length)
         {
            if((_loc4_ = gc.player2.curarray[_loc3_]).fillName == _loc2_)
            {
               _loc1_ = false;
               break;
            }
            _loc3_++;
         }
         trace("isFall:" + _loc1_);
         if(_loc1_)
         {
            this.probability = 1;
            this.fallList = [{
               "name":"dhqf",
               "bigtype":"zb"
            }];
         }
         else if(this.minLevel > 20)
         {
            this.probability = 0.1;
            this.fallList = [{
               "name":"qxsh",
               "bigtype":"zb"
            },{
               "name":"jhcz",
               "bigtype":"zb"
            },{
               "name":"ryjgb",
               "bigtype":"zb"
            }];
         }
         else
         {
            this.probability = 0.2;
            this.fallList = [{
               "name":"zqj",
               "bigtype":"zb"
            },{
               "name":"qld",
               "bigtype":"zb"
            },{
               "name":"bhz",
               "bigtype":"zb"
            },{
               "name":"xwj",
               "bigtype":"zb"
            },{
               "name":"qlp",
               "bigtype":"zb"
            }];
         }
      }
      
      override protected function myIntelligence() : void
      {
         super.myIntelligence();
      }
      
      override protected function hasAttackTarget() : void
      {
         var _loc1_:Number = NaN;
         if(this.isAttacking())
         {
            return;
         }
         if(this.curAttackTarget)
         {
            if(Math.abs(this.x - this.curAttackTarget.x) <= 100)
            {
               if(this.skillCD3 == 0)
               {
                  this.setYourFather(38);
                  this.releSkill3();
                  if(this.minLevel > 20)
                  {
                     this.skillCD3 = 300;
                  }
                  else
                  {
                     this.skillCD3 = 400;
                  }
               }
               else if(this.count % 36 == 0)
               {
                  if(this.randomNum(isattback))
                  {
                     this.attackTarget();
                  }
                  else
                  {
                     this.normalWalk();
                  }
               }
               else
               {
                  this.normalWalk();
               }
            }
            else if(Math.abs(this.x - this.curAttackTarget.x) <= 450)
            {
               if(this.skillCD1 == 0 && this.skillCD2 == 0)
               {
                  _loc1_ = Math.random();
                  if(_loc1_ < 0.5)
                  {
                     this.setYourFather(44);
                     this.releSkill1();
                     if(this.minLevel > 20)
                     {
                        this.skillCD1 = 550;
                     }
                     else
                     {
                        this.skillCD1 = 700;
                     }
                  }
                  else
                  {
                     this.setYourFather(67);
                     this.releSkill2();
                     if(this.minLevel > 20)
                     {
                        this.skillCD2 = 400;
                     }
                     else
                     {
                        this.skillCD2 = 500;
                     }
                  }
               }
               else if(this.skillCD1 == 0)
               {
                  this.setYourFather(44);
                  this.releSkill1();
                  if(this.minLevel > 20)
                  {
                     this.skillCD1 = 550;
                  }
                  else
                  {
                     this.skillCD1 = 700;
                  }
               }
               else if(this.skillCD2 == 0)
               {
                  this.setYourFather(67);
                  this.releSkill2();
                  if(this.minLevel > 20)
                  {
                     this.skillCD2 = 400;
                  }
                  else
                  {
                     this.skillCD2 = 500;
                  }
               }
               else if(this.count % 24 == 0)
               {
                  if(this.randomNum(isattback))
                  {
                     this.attackTarget();
                  }
                  else
                  {
                     this.normalWalk();
                  }
               }
               else
               {
                  this.followTarget();
               }
            }
            else
            {
               this.followTarget();
            }
         }
      }
      
      public function doHit1() : void
      {
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Monster26Bullet1");
         _loc1_.x = this.x;
         _loc1_.y = this.y;
         _loc1_.setRole(this);
         _loc1_.setAction(this.lastHit);
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
      
      override protected function releSkill1() : void
      {
         this.setYourFather(90);
         this.newAttackId();
         this.lastHit = "hit2";
         this.curAction = "hit2";
      }
      
      override protected function releSkill2() : void
      {
         this.setYourFather(85);
         this.newAttackId();
         this.lastHit = "hit3";
         this.curAction = "hit3";
      }
      
      override protected function releSkill3() : void
      {
         this.setYourFather(24);
         this.newAttackId();
         this.lastHit = "hit4";
         this.curAction = "hit4";
         var _loc1_:SpecialEffectBullet = new SpecialEffectBullet("Monster26Bullet2");
         _loc1_.x = this.curAttackTarget.x - 65;
         _loc1_.y = this.y - 120;
         _loc1_.setRole(this);
         _loc1_.setAction(this.lastHit);
         gc.gameSence.addChild(_loc1_);
         this.magicBulletArray.push(_loc1_);
      }
      
      override protected function isCannotMoveWhenAttack() : Boolean
      {
         return this.curAction == "hit2";
      }
      
      override public function isAttacking() : Boolean
      {
         return this.curAction == "hit1" || this.curAction == "hit2" || this.curAction == "hit3" || this.curAction == "hit4";
      }
      
      override public function destroy() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         var _loc3_:MovieClip = null;
         super.destroy();
         if(this.isBoss)
         {
            _loc1_ = gc.pWorld.getTransferDoorArray();
            _loc2_ = 0;
            while(_loc2_ < _loc1_.length)
            {
               _loc3_ = _loc1_[_loc2_];
               _loc3_.visible = true;
               _loc2_++;
            }
         }
      }
   }
}
