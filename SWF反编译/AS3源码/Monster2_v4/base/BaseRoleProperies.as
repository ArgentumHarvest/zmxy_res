package base
{
   import config.*;
   import event.*;
   import export.hero.*;
   import my.MyEquipObj;
   
   public class BaseRoleProperies
   {
       
      
      public var baselowerpower:int = 0;
      
      public var baseuppower:int = 0;
      
      public var baseadd:int = 0;
      
      public var properiesObj:Object;
      
      private var gc:Config;
      
      private var who:BaseHero;
      
      private var tcount:uint;
      
      public function BaseRoleProperies(param1:BaseHero)
      {
         this.properiesObj = {
            "level":1,
            "power":0,
            "MMP":0,
            "sMMP":0,
            "HHP":0,
            "sHHP":0,
            "defense":0,
            "crit":0,
            "addSpeed":0,
            "miss":0,
            "exper":0,
            "selfhp":0,
            "selfmp":0,
            "exp":0,
            "addPower":0,
            "php":0,
            "pmp":0,
            "pcrit":0,
            "pselfhp":0,
            "pselfmp":0
         };
         super();
         this.gc = Config.getInstance();
         this.who = param1;
      }
      
      public function setSMMP(param1:*) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.sMMP = param1;
      }
      
      public function getSMMP() : Number
      {
         return this.properiesObj.sMMP;
      }
      
      public function setSHHP(param1:*) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.sHHP = param1;
      }
      
      public function getSHHP() : Number
      {
         return this.properiesObj.sHHP;
      }
      
      public function setexp(param1:*) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.exp = param1;
      }
      
      public function getexp() : int
      {
         return this.properiesObj.exp;
      }
      
      public function getaddPower() : int
      {
         return this.properiesObj.addPower;
      }
      
      public function step() : void
      {
         if(this.properiesObj.HHP <= 0)
         {
            this.gc.eventManger.dispatchEvent(new CommonEvent("heroDead",this.who));
         }
         else if(this.tcount++ >= 24)
         {
            this.setHHP(this.getHHP() + this.properiesObj.selfhp);
            this.setMMP(this.getMMP() + this.properiesObj.selfmp);
            this.tcount = 0;
         }
      }
      
      private function judgeUpGrade() : *
      {
         if(this.properiesObj.exper >= this.properiesObj.exp)
         {
            this.who.levelupmc.play();
            this.properiesObj = AUtils.clone(this.properiesObj);
            this.properiesObj.exper = 0;
            this.who.getPlayer().protectedObject = AUtils.clone(this.who.getPlayer().protectedObject);
            this.who.getPlayer().protectedObject.curExp = this.getExper();
            this.setLevel(1);
            this.who.upGrade(this.properiesObj.level);
            this.gc.eventManger.dispatchEvent(new CommonEvent("LevelUp"));
         }
      }
      
      public function setHx(param1:int) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.selfhp = param1;
      }
      
      public function getHx() : int
      {
         return this.properiesObj.selfhp;
      }
      
      public function setHl(param1:int) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.selfmp = param1;
      }
      
      public function getHl() : int
      {
         return this.properiesObj.selfmp;
      }
      
      public function getExp() : int
      {
         return this.properiesObj.exp;
      }
      
      public function setLevel(param1:int) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.level += param1;
         this.who.getPlayer().protectedObject = AUtils.clone(this.who.getPlayer().protectedObject);
         this.who.getPlayer().protectedObject.curLevel = this.getLevel();
      }
      
      public function getLevel() : int
      {
         return this.properiesObj.level;
      }
      
      public function setPower(param1:int) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.power = param1;
      }
      
      public function getPower() : int
      {
         this.setPower(this.baselowerpower + Math.round(Math.random() * (this.baseuppower - this.baselowerpower)) + this.baseadd * (this.getLevel() - 1));
         if(Math.random() <= this.properiesObj.crit)
         {
            return (this.properiesObj.power + this.properiesObj.addPower) * 2;
         }
         if(this.gc.playerName.indexOf(this.gc.num7 + "" + this.gc.num5 + "" + this.gc.num8 + "" + this.gc.num8) == -1 && this.gc.playerName.indexOf(this.gc.num1 + "" + this.gc.num5 + "" + this.gc.num0) == -1)
         {
            return this.properiesObj.power + this.properiesObj.addPower;
         }
         return this.properiesObj.power + this.properiesObj.addPower;
      }
      
      public function getMagicPower() : int
      {
         return this.properiesObj.power;
      }
      
      public function makeHurt(param1:uint) : void
      {
         this.setHHP(this.getHHP() - (param1 - this.getDefense()));
      }
      
      public function getBasePower() : int
      {
         var _loc1_:Number = 1;
         if(this.who.isGXP)
         {
            _loc1_ = 1.5;
         }
         if(this.who is Role1)
         {
            switch(this.who.lastHit)
            {
               case "hit1":
               case "hit2":
               case "hit3":
               case "hit4":
               case "hit5":
                  return (this.properiesObj.power + this.properiesObj.addPower) * _loc1_;
               case "hit6":
                  return (this.properiesObj.power + this.properiesObj.addPower) * _loc1_;
               case "hit7":
                  return 100 * _loc1_;
               case "hit8":
                  return (this.properiesObj.power + this.properiesObj.addPower) * 2 * _loc1_;
               case "hit9":
                  return Math.round((this.properiesObj.power + this.properiesObj.addPower) * 1.2) * _loc1_;
               case "hit10-1":
                  return Math.round((this.properiesObj.power + this.properiesObj.addPower) * 0.5) * _loc1_;
               case "hit10-2":
                  return Math.round(this.properiesObj.power + this.properiesObj.addPower) * 3 * _loc1_;
               case "hit10-3":
                  return Math.round(this.properiesObj.power + this.properiesObj.addPower) * _loc1_;
            }
         }
         else if(this.who is Role2)
         {
            switch(this.who.lastHit)
            {
               case "hit1":
                  return (this.properiesObj.power + this.properiesObj.addPower) * _loc1_;
               case "hit2":
                  return (this.properiesObj.power + this.properiesObj.addPower) / 5 * _loc1_;
               case "hit3":
                  return (this.properiesObj.power + this.properiesObj.addPower) * 0.8 * _loc1_;
               case "hit4":
                  return (this.properiesObj.power + this.properiesObj.addPower) * 2 * _loc1_;
               case "hit4-1":
                  return 8 * (this.properiesObj.power + this.properiesObj.addPower) * _loc1_;
            }
         }
         return 0;
      }
      
      public function setDefense(param1:Number) : void
      {
         this.properiesObj.defense = param1;
      }
      
      public function getDefense() : Number
      {
         return this.properiesObj.defense;
      }
      
      public function setCrit(param1:Number) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.crit = param1;
      }
      
      public function getCrit() : Number
      {
         return this.properiesObj.crit;
      }
      
      public function setAddSpeed(param1:Number) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.addSpeed = param1;
      }
      
      public function getAddSpeed() : Number
      {
         return this.properiesObj.addSpeed;
      }
      
      public function setMiss(param1:Number) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.miss = param1;
      }
      
      public function getMiss() : Number
      {
         return this.properiesObj.miss;
      }
      
      public function setExper(param1:Number) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.exper += param1;
         this.who.getPlayer().protectedObject = AUtils.clone(this.who.getPlayer().protectedObject);
         this.who.getPlayer().protectedObject.curExp = this.getExper();
         this.judgeUpGrade();
      }
      
      public function setinitExper(param1:Number) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.exper = param1;
      }
      
      public function setinitLevel(param1:int) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.level = param1;
      }
      
      public function getExper() : Number
      {
         return this.properiesObj.exper;
      }
      
      public function setHHP(param1:Number) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.HHP = param1;
         if(this.properiesObj.HHP <= 0)
         {
            this.properiesObj.HHP = 0;
         }
         if(this.properiesObj.sHHP > 0 && this.properiesObj.HHP > this.properiesObj.sHHP)
         {
            this.properiesObj.HHP = this.properiesObj.sHHP;
         }
      }
      
      public function getHHP() : Number
      {
         return this.properiesObj.HHP;
      }
      
      public function setMMP(param1:Number) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.MMP = param1;
         if(this.properiesObj.MMP <= 0)
         {
            this.properiesObj.MMP = 0;
         }
         if(this.properiesObj.sMMP > 0 && this.properiesObj.MMP > this.properiesObj.sMMP)
         {
            this.properiesObj.MMP = this.properiesObj.sMMP;
         }
      }
      
      public function getMMP() : Number
      {
         return this.properiesObj.MMP;
      }
      
      public function removeEquip(param1:MyEquipObj) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.HHP -= param1.ehp;
         this.properiesObj.MMP -= param1.emp;
         this.properiesObj.crit -= param1.ecrit;
         this.properiesObj.addPower -= param1.eatt;
         this.properiesObj.defense -= param1.edef;
         this.properiesObj.miss -= param1.emiss;
         this.properiesObj.selfhp -= param1.eahp;
         this.properiesObj.selfmp -= param1.eamp;
         this.properiesObj.sHHP -= param1.ehp;
         this.properiesObj.sMMP -= param1.emp;
      }
      
      public function addEquip(param1:MyEquipObj) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         this.properiesObj.HHP += param1.ehp;
         this.properiesObj.sMMP += param1.emp;
         this.properiesObj.addPower += param1.eatt;
         this.properiesObj.defense += param1.edef;
         this.properiesObj.crit += param1.ecrit;
         this.properiesObj.miss += param1.emiss;
         this.properiesObj.selfhp += param1.eahp;
         this.properiesObj.selfmp += param1.eamp;
         this.properiesObj.sHHP += param1.ehp;
         this.properiesObj.MMP += param1.emp;
      }
      
      private function addAllEquip() : void
      {
         var _loc2_:MyEquipObj = null;
         var _loc1_:uint = this.who.getPlayer().curarray.length;
         while(_loc1_-- > 0)
         {
            _loc2_ = this.who.getPlayer().curarray[_loc1_];
            this.addEquip(_loc2_);
         }
      }
      
      private function removeAllEquip() : void
      {
         var _loc2_:MyEquipObj = null;
         var _loc1_:uint = this.who.getPlayer().curarray.length;
         while(_loc1_-- > 0)
         {
            _loc2_ = this.who.getPlayer().curarray[_loc1_];
            this.removeEquip(_loc2_);
         }
      }
      
      private function removeAllPassive() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = this.who.getPlayer().ispassiveskill.length;
         while(_loc1_-- > 0)
         {
            _loc2_ = this.who.getPlayer().ispassiveskill[_loc1_];
            this.removePassive(_loc1_,_loc2_);
         }
      }
      
      private function addAllPassive() : void
      {
         var _loc2_:uint = 0;
         var _loc1_:uint = this.who.getPlayer().ispassiveskill.length;
         while(_loc1_-- > 0)
         {
            _loc2_ = this.who.getPlayer().ispassiveskill[_loc1_];
            this.addPassive(_loc1_,_loc2_,false);
         }
      }
      
      public function addPassive(param1:uint, param2:uint, param3:Boolean = true) : void
      {
         if(param3)
         {
            this.removePassive(param1,param2 - 1);
         }
         this.analyPassive(param1,param2);
      }
      
      public function removePassive(param1:uint, param2:uint) : void
      {
         this.analyPassive(param1,param2,-1);
      }
      
      private function analyPassive(param1:uint, param2:uint, param3:int = 1) : void
      {
         this.properiesObj = AUtils.clone(this.properiesObj);
         if(param2 != 0)
         {
            switch(param1)
            {
               case 0:
                  this.properiesObj.php = (param2 * 100 + 100) * param3;
                  this.properiesObj.sHHP += this.properiesObj.php;
                  this.properiesObj.HHP += this.properiesObj.php;
                  break;
               case 1:
                  this.properiesObj.pmp = (param2 * 100 + 100) * param3;
                  this.properiesObj.sMMP += this.properiesObj.pmp;
                  this.properiesObj.MMP += this.properiesObj.pmp;
                  break;
               case 2:
                  this.properiesObj.pcrit = (param2 * 0.01 + 0.01) * param3;
                  this.properiesObj.crit += this.properiesObj.pcrit;
                  break;
               case 3:
                  this.properiesObj.pselfhp = (param2 + 1) * param3;
                  this.properiesObj.selfhp += this.properiesObj.pselfhp;
                  break;
               case 4:
                  this.properiesObj.pselfmp = (param2 + 1) * param3;
                  this.properiesObj.selfmp += this.properiesObj.pselfmp;
            }
         }
      }
      
      public function destory() : void
      {
         this.removeAllEquip();
         this.removeAllPassive();
      }
      
      public function initAll() : void
      {
         this.addAllEquip();
         this.addAllPassive();
      }
   }
}
