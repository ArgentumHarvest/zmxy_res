package petInfo
{
   import base.BaseHero;
   import base.BasePet;
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import event.CommonEvent;
   import flash.events.EventDispatcher;
   import mvc.controllor.RandomControllor;
   import my.PetEquipObj;
   
   public class PetInfo extends EventDispatcher
   {
      
      public static var EVENT_REFRESHEQUIP:String = "event_refreshequip";
       
      
      private var gc:Config;
      
      private var petName:String;
      
      private var petChinaName:String = "";
      
      private var _isFight:uint = 0;
      
      public var skill:Array;
      
      private var doWhenLevelUp:Function = null;
      
      private var doWhenChangeState:Function = null;
      
      private var count:int = 0;
      
      protected var _anti:Antiwear;
      
      private var allSkill:Array;
      
      private var _petEquip:PetEquip;
      
      public var isFormationAdd:Boolean = false;
      
      public var isUseSkillX1:Boolean = false;
      
      public var isCannotChange:Boolean = false;
      
      public function PetInfo()
      {
         skill = [];
         _anti = new Antiwear(new binaryEncrypt());
         allSkill = ["tsml","zrsh","smzf","mfby","qlfj","sxkb","fsnl","smjc","mfjc","gjjc","fyjc"];
         super();
         gc = Config.getInstance();
         this._anti.hp = 0;
         this._anti.shp = 0;
         this._anti.level = 0;
         this._anti.curExper = 0;
         this._anti.mp = 0;
         this._anti.smp = 0;
         this._anti.def = 0;
         this._anti.atk = 0;
         this._anti.hpQuality = 0;
         this._anti.mpQuality = 0;
         this._anti.atkQuality = 0;
         this._anti.defQuality = 0;
         this._anti.lifetime = 0;
         this._anti.quality = 0;
         this._anti.perception = 0;
         this._anti.technique = 0;
         this._anti.warpower = 0;
         this._anti.ten = 10;
         this._anti.hpExp = 0;
         this._anti.mpExp = 0;
         this._anti.atkExp = 0;
         this._anti.defExp = 0;
         this._anti.ehp = 0;
         this._anti.emp = 0;
         this._anti.miss = 0;
         this._anti.mDef = 0;
         this._anti.crit = 0;
         this._anti.moveSpeed = 5;
         this._anti.potential = 0;
         this._anti.perceptionadd = 0;
         this._anti.warpoweradd = 0;
         this._anti.techniqueadd = 0;
         this._anti.perceptionprogress = 0;
         this._anti.warpowerprogress = 0;
         this._anti.techniqueprogress = 0;
         this._anti.potentiallimit = 0;
         this._anti.onehund = 100;
         this._anti.onehundred_fifty = 150;
         this._anti.night_hundred = 900;
         this._anti.two_hundred = 200;
         this._anti.three_hundred = 300;
         this._anti.four_hundred = 400;
         this._anti.two_hundred_fifty = 250;
         this._anti.five_hundred = 500;
         this._anti.seven_hundred = 700;
         this._anti.eight_hundred = 800;
         this._anti.one_thousand = 1000;
         this._anti.one_point_one_thousand = 1100;
         this._anti.one_point_two_thousand = 1200;
         this._anti.thirty = 30;
         this._anti.five = 5;
         this._anti.eight = 8;
         this._anti.sixty = 60;
         this._anti.seventy = 70;
         this._anti.fifty = 50;
         this._anti.ten = 10;
         this._anti.fourty_four_hundred = 440;
         this._anti.fifty_five_hundred = 550;
         this._anti.eatBlood = 0;
         this.count = gc.frameClips;
         this._petEquip = new PetEquip(this);
      }
      
      public function callPetToRefreshEquip(newEquipArray:Array) : void
      {
         this.dispatchEvent(new CommonEvent(EVENT_REFRESHEQUIP,[newEquipArray]));
      }
      
      public function getEquipArray() : Array
      {
         if(this._petEquip)
         {
            return this._petEquip.equipArray.concat();
         }
         return [];
      }
      
      public function refreshEquip(newEquipArray:Array) : void
      {
         if(this._petEquip)
         {
            this._petEquip.refreshEquip(newEquipArray);
         }
      }
      
      public function setPetNameAndLevel(_pname:String, petlev:uint = 1) : void
      {
         var prename:String = _pname.substr(0,_pname.length - 1);
         var preState:int = int(_pname.charAt(_pname.length - 1));
         var state:* = int(1);
         if(petlev <= 15)
         {
            state = int(1);
         }
         else if(petlev > 15 && petlev <= 30)
         {
            state = int(2);
         }
         else
         {
            state = preState;
         }
         this.petName = prename + state;
         this.transPetChinaName();
         this.addSpecialSkill();
         this.setLevel(petlev);
         this.setCurExper(0);
         this.setlifetime(100);
         if(petlev == 1)
         {
            this.setquality(1);
         }
         else
         {
            this.setquality(2);
         }
         this.initPetInfoData();
      }
      
      public function step() : void
      {
         if(this.count > 0)
         {
            this.count--;
            if(this.count == 0)
            {
               this.doPerSecond();
               this.count = gc.frameClips;
            }
         }
      }
      
      private function doPerSecond() : void
      {
         if(this.getHp() > 0)
         {
            if(this.getEHp() != 0)
            {
               if(this.getHp() + this.getEHp() > this.getSHp())
               {
                  this.setHp(this.getSHp());
               }
               else
               {
                  this.setHp(this.getHp() + this.getEHp());
               }
            }
         }
         if(this.getEMp() != 0)
         {
            if(this.getMp() + this.getEMp() > this.getSMp())
            {
               this.setMp(this.getSMp());
            }
            else
            {
               this.setMp(this.getMp() + this.getEMp());
            }
         }
      }
      
      public function reSetPetState() : void
      {
         this.setHp(this.getSHp());
         this.setMp(this.getSMp());
         this.isUseSkillX1 = false;
      }
      
      public function reSetPetStateByPercent(per:Number) : void
      {
         if(per > 1)
         {
            per = 1;
         }
         else if(per < 0)
         {
            per = 0;
         }
         this.setHp(this.getSHp() * per);
         this.setMp(this.getSMp() * per);
      }
      
      public function getPetPreName() : String
      {
         return this.petName.substr(0,this.petName.length - 1);
      }
      
      private function initPetInfoData(issetqual:Boolean = true) : void
      {
         var prename:String = this.petName.substr(0,this.petName.length - 1);
         if(prename == "monkey")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((600 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setmpQuality((600 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setatkQuality((600 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setdefQuality((200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
               }
               this.setHp(150 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 10));
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 4));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(600 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setmpQuality(600 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setatkQuality(600 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setdefQuality(200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
               }
               this.setHp(150 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 10) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 4) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "horse")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((530 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setmpQuality((640 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
                  this.setatkQuality((650 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setdefQuality((200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
               }
               this.setHp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setMp(150 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 10));
               this.setDef(4 + Math.round(RandomControllor.getIns().getRandom() * 2));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(530 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setmpQuality(640 + Math.round(RandomControllor.getIns().getRandom() * 300));
                  this.setatkQuality(650 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setdefQuality(200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
               }
               this.setHp(100 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(150 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 10) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(4 + Math.round(RandomControllor.getIns().getRandom() * 2) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "ufo")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((700 + Math.round(RandomControllor.getIns().getRandom() * 200)) * 1.3);
                  this.setmpQuality((500 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
                  this.setatkQuality((700 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setdefQuality((200 + Math.round(RandomControllor.getIns().getRandom() * 70)) * 1.3);
               }
               this.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15));
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(700 + Math.round(RandomControllor.getIns().getRandom() * 200));
                  this.setmpQuality(500 + Math.round(RandomControllor.getIns().getRandom() * 300));
                  this.setatkQuality(700 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setdefQuality(200 + Math.round(RandomControllor.getIns().getRandom() * 70));
               }
               this.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "tigress")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((800 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setmpQuality((500 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
                  this.setatkQuality((800 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setdefQuality((300 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
               }
               this.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 300));
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15));
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(800 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setmpQuality(500 + Math.round(RandomControllor.getIns().getRandom() * 300));
                  this.setatkQuality(800 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setdefQuality(300 + Math.round(RandomControllor.getIns().getRandom() * 100));
               }
               this.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 300) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "turtle")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((1000 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setmpQuality((500 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setatkQuality((800 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
                  this.setdefQuality((300 + Math.round(RandomControllor.getIns().getRandom() * 170)) * 1.3);
               }
               this.setHp(300 + Math.round(RandomControllor.getIns().getRandom() * 300));
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 15));
               this.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(1000 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setmpQuality(500 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setatkQuality(800 + Math.round(RandomControllor.getIns().getRandom() * 100));
                  this.setdefQuality(300 + Math.round(RandomControllor.getIns().getRandom() * 170));
               }
               this.setHp(300 + Math.round(RandomControllor.getIns().getRandom() * 300) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(100 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(10 + Math.round(RandomControllor.getIns().getRandom() * 15) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(5 + Math.round(RandomControllor.getIns().getRandom() * 5) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "phoenix")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((600 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
                  this.setmpQuality((600 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
                  this.setatkQuality((800 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setdefQuality((200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
               }
               this.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * 250));
               this.setMp(120 + Math.round(RandomControllor.getIns().getRandom() * 80));
               this.setAtk(16 + Math.round(RandomControllor.getIns().getRandom() * 16));
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 4));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(600 + Math.round(RandomControllor.getIns().getRandom() * 300));
                  this.setmpQuality(600 + Math.round(RandomControllor.getIns().getRandom() * 300));
                  this.setatkQuality(800 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setdefQuality(200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
               }
               this.setHp(this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * 250) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(120 + Math.round(RandomControllor.getIns().getRandom() * 80) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(16 + Math.round(RandomControllor.getIns().getRandom() * 16) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 4) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "dragon")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((this._anti.night_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setmpQuality((500 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
                  this.setatkQuality((800 + Math.round(RandomControllor.getIns().getRandom() * 300)) * 1.3);
                  this.setdefQuality((300 + Math.round(RandomControllor.getIns().getRandom() * 100)) * 1.3);
               }
               this.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
               this.setMp(150 + Math.round(RandomControllor.getIns().getRandom() * 50));
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15));
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(this._anti.night_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setmpQuality(500 + Math.round(RandomControllor.getIns().getRandom() * 100));
                  this.setatkQuality(800 + Math.round(RandomControllor.getIns().getRandom() * 300));
                  this.setdefQuality(300 + Math.round(RandomControllor.getIns().getRandom() * 100));
               }
               this.setHp(200 + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(150 + Math.round(RandomControllor.getIns().getRandom() * 50) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(15 + Math.round(RandomControllor.getIns().getRandom() * 15) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(2 + Math.round(RandomControllor.getIns().getRandom() * 6) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "rabbit")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((this._anti.eight_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
                  this.setmpQuality((this._anti.five_hundred + Math.round(RandomControllor.getIns().getRandom() * 400)) * 1.3);
                  this.setatkQuality((this._anti.eight_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
                  this.setdefQuality((this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
               }
               this.setHp(this._anti.five_hundred);
               this.setMp(this._anti.two_hundred);
               this.setAtk(this._anti.thirty);
               this.setDef(this._anti.five);
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(this._anti.eight_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
                  this.setmpQuality(this._anti.five_hundred + Math.round(RandomControllor.getIns().getRandom() * 400));
                  this.setatkQuality(this._anti.eight_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
                  this.setdefQuality(this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
               }
               this.setHp(this._anti.five_hundred + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(this._anti.two_hundred + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(this._anti.thirty + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(this._anti.five + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "nian")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.five_hundred)) * 1.3);
                  this.setmpQuality((this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund)) * 1.3);
                  this.setatkQuality((this._anti.eight_hundred + Math.round(RandomControllor.getIns().getRandom() * 400)) * 1.3);
                  this.setdefQuality((this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
               }
               this.setHp(this._anti.five_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.five_hundred));
               this.setMp(this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
               this.setAtk(this._anti.thirty + Math.round(RandomControllor.getIns().getRandom() * this._anti.thirty));
               this.setDef(this._anti.five + Math.round(RandomControllor.getIns().getRandom() * this._anti.five));
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.five_hundred));
                  this.setmpQuality(this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund));
                  this.setatkQuality(this._anti.eight_hundred + Math.round(RandomControllor.getIns().getRandom() * 400));
                  this.setdefQuality(this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
               }
               this.setHp(this._anti.five_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.five_hundred) + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred) + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(this._anti.thirty + Math.round(RandomControllor.getIns().getRandom() * this._anti.thirty) + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(this._anti.five + Math.round(RandomControllor.getIns().getRandom() * this._anti.five) + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "mouse")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
                  this.setmpQuality((this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund)) * 1.3);
                  this.setatkQuality((this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
                  this.setdefQuality((this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
               }
               this.setHp(this._anti.one_thousand);
               this.setMp(this._anti.three_hundred);
               this.setAtk(this._anti.fifty);
               this.setDef(this._anti.ten);
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
                  this.setmpQuality(this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund));
                  this.setatkQuality(this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
                  this.setdefQuality(this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
               }
               this.setHp(this._anti.one_thousand + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(this._anti.three_hundred + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(this._anti.fifty + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(this._anti.ten + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "neat")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((this._anti.one_point_one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
                  this.setmpQuality((this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund)) * 1.3);
                  this.setatkQuality((this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.four_hundred)) * 1.3);
                  this.setdefQuality((this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
               }
               this.setHp(this._anti.one_point_two_thousand);
               this.setMp(this._anti.two_hundred);
               this.setAtk(this._anti.sixty);
               this.setDef(this._anti.eight);
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(this._anti.one_point_one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
                  this.setmpQuality(this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund));
                  this.setatkQuality(this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.four_hundred));
                  this.setdefQuality(this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
               }
               this.setHp(this._anti.one_point_two_thousand + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(this._anti.two_hundred + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(this._anti.sixty + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(this._anti.eight + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "roomhorse")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((this._anti.seven_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.five_hundred)) * 1.3);
                  this.setmpQuality((this._anti.fifty_five_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty_four_hundred)) * 1.3);
                  this.setatkQuality((this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
                  this.setdefQuality((this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
               }
               this.setHp(this._anti.seven_hundred);
               this.setMp(this._anti.eight_hundred);
               this.setAtk(this._anti.fifty);
               this.setDef(this._anti.ten);
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(this._anti.seven_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.five_hundred));
                  this.setmpQuality(this._anti.fifty_five_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.fourty_four_hundred));
                  this.setatkQuality(this._anti.one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
                  this.setdefQuality(this._anti.two_hundred + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
               }
               this.setHp(this._anti.seven_hundred + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(this._anti.eight_hundred + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(this._anti.fifty + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(this._anti.ten + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         else if(prename == "terribletiger")
         {
            if(this.getquality() == 1)
            {
               if(issetqual)
               {
                  this.sethpQuality((this._anti.one_point_one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred)) * 1.3);
                  this.setmpQuality((this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund)) * 1.3);
                  this.setatkQuality((this._anti.one_point_one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred)) * 1.3);
                  this.setdefQuality((this._anti.onehundred_fifty + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehundred_fifty)) * 1.3);
               }
               this.setHp(this._anti.one_thousand);
               this.setMp(this._anti.two_hundred);
               this.setAtk(this._anti.seventy);
               this.setDef(this._anti.eight);
            }
            else
            {
               if(issetqual)
               {
                  this.sethpQuality(this._anti.one_point_one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.two_hundred));
                  this.setmpQuality(this._anti.onehund + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehund));
                  this.setatkQuality(this._anti.one_point_one_thousand + Math.round(RandomControllor.getIns().getRandom() * this._anti.three_hundred));
                  this.setdefQuality(this._anti.onehundred_fifty + Math.round(RandomControllor.getIns().getRandom() * this._anti.onehundred_fifty));
               }
               this.setHp(this._anti.one_thousand + this.gethpQuality() * this.getLevel() * 0.08);
               this.setMp(this._anti.two_hundred + this.getmpQuality() * this.getLevel() * 0.08);
               this.setAtk(this._anti.seventy + this.getatkQuality() * this.getLevel() * 0.015);
               this.setDef(this._anti.eight + this.getdefQuality() * this.getLevel() * 0.01);
            }
         }
         this.setSHp(this.getHp());
         this.setSMp(this.getMp());
         if(issetqual)
         {
            if(this.getquality() == 1)
            {
               this.setperception(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
               this.setwarpower(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
               this.settechnique(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
            }
            else
            {
               this.setperception(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
               this.setwarpower(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
               this.settechnique(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
            }
         }
      }
      
      public function refreshThreeAttribute() : void
      {
         this.deletePassiveWhenUpdata();
         if(this.getquality() == 1)
         {
            this.setperception(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
            this.setwarpower(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
            this.settechnique(gc.dataObject.two + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         }
         else
         {
            this.setperception(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.three));
            this.setwarpower(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
            this.settechnique(gc.dataObject.one + Math.round(RandomControllor.getIns().getRandom() * gc.dataObject.two));
         }
         this.addPassiveAfterUpdata();
      }
      
      public function refreshTherrAttributeByImmortality() : void
      {
         this.deletePassiveWhenUpdata();
         if(this.getperception(true) == 1)
         {
            this.setperception(this.getperception(true) + 1);
         }
         else if(RandomControllor.getIns().getRandom() > 0.5)
         {
            if(this.getperception(true) < 5)
            {
               this.setperception(this.getperception(true) + 1);
            }
         }
         else if(this.getperception(true) != 5)
         {
            if(this.getperception(true) > 1)
            {
               this.setperception(this.getperception(true) - 1);
            }
         }
         if(this.getwarpower(true) == 1)
         {
            this.setwarpower(this.getwarpower(true) + 1);
         }
         else if(RandomControllor.getIns().getRandom() > 0.5)
         {
            if(this.getwarpower(true) < 4)
            {
               this.setwarpower(this.getwarpower(true) + 1);
            }
         }
         else if(this.getwarpower(true) != 4)
         {
            if(this.getwarpower(true) > 1)
            {
               this.setwarpower(this.getwarpower(true) - 1);
            }
         }
         if(this.gettechnique(true) == 1)
         {
            this.settechnique(this.gettechnique(true) + 1);
         }
         else if(RandomControllor.getIns().getRandom() > 0.5)
         {
            if(this.gettechnique(true) < 4)
            {
               this.settechnique(this.gettechnique(true) + 1);
            }
         }
         else if(this.gettechnique(true) != 4)
         {
            if(this.gettechnique(true) > 1)
            {
               this.settechnique(this.gettechnique(true) - 1);
            }
         }
         this.addPassiveAfterUpdata();
      }
      
      public function makePetBecomeChild(value:uint = 100) : void
      {
         this.deletePassiveWhenUpdata();
         var equipArray:Array = this.getEquipArray();
         this.refreshEquip([]);
         this.setLevel(1);
         var prename:String = this.petName.substr(0,this.petName.length - 1);
         this.petName = prename + "1";
         this.transPetChinaName();
         this.setCurExper(0);
         if(this.getquality() != 1)
         {
            this.setquality(1);
            this.sethpQuality(this.gethpQuality(true) * 1.3);
            this.setmpQuality(this.getmpQuality(true) * 1.3);
            this.setatkQuality(this.getatkQuality(true) * 1.3);
            this.setdefQuality(this.getdefQuality(true) * 1.3);
         }
         this._anti.hpExp = Math.round(value * RandomControllor.getIns().getRandom());
         this._anti.mpExp = Math.round((value - this._anti.hpExp) * RandomControllor.getIns().getRandom());
         this._anti.atkExp = Math.round((value - (this._anti.hpExp + this._anti.mpExp)) * RandomControllor.getIns().getRandom());
         this._anti.defExp = Math.round(value - (this._anti.hpExp + this._anti.mpExp + this._anti.atkExp));
         this.initPetInfoData(false);
         this.refreshEquip(equipArray);
         this.addPassiveAfterUpdata();
      }
      
      public function makePetBecomeChildWithPetLevel(value:uint = 100, whichAtt:uint = 1) : void
      {
         this.deletePassiveWhenUpdata();
         var equipArray:Array = this.getEquipArray();
         this.refreshEquip([]);
         if(whichAtt == 1)
         {
            if(value == this._anti.onehund)
            {
               this._anti.hpExp = Math.round(this.getLevel() + (value - this.getLevel()) * RandomControllor.getIns().getRandom());
            }
            else
            {
               this._anti.hpExp = Math.round(this.getLevel() * 2 + (value - this.getLevel() * 2) * RandomControllor.getIns().getRandom());
            }
            this._anti.mpExp = Math.round((value - this._anti.hpExp) * RandomControllor.getIns().getRandom());
            this._anti.atkExp = Math.round((value - (this._anti.hpExp + this._anti.mpExp)) * RandomControllor.getIns().getRandom());
            this._anti.defExp = Math.round(value - (this._anti.hpExp + this._anti.mpExp + this._anti.atkExp));
         }
         else if(whichAtt == 2)
         {
            if(value == this._anti.onehund)
            {
               this._anti.mpExp = Math.round(this.getLevel() + (value - this.getLevel()) * RandomControllor.getIns().getRandom());
            }
            else
            {
               this._anti.mpExp = Math.round(this.getLevel() * 2 + (value - this.getLevel() * 2) * RandomControllor.getIns().getRandom());
            }
            this._anti.hpExp = Math.round((value - this._anti.mpExp) * RandomControllor.getIns().getRandom());
            this._anti.atkExp = Math.round((value - (this._anti.hpExp + this._anti.mpExp)) * RandomControllor.getIns().getRandom());
            this._anti.defExp = Math.round(value - (this._anti.hpExp + this._anti.mpExp + this._anti.atkExp));
         }
         else if(whichAtt == 3)
         {
            if(value == this._anti.onehund)
            {
               this._anti.atkExp = Math.round(this.getLevel() + (value - this.getLevel()) * RandomControllor.getIns().getRandom());
            }
            else
            {
               this._anti.atkExp = Math.round(this.getLevel() * 2 + (value - this.getLevel() * 2) * RandomControllor.getIns().getRandom());
            }
            this._anti.hpExp = Math.round((value - this._anti.atkExp) * RandomControllor.getIns().getRandom());
            this._anti.mpExp = Math.round((value - (this._anti.hpExp + this._anti.atkExp)) * RandomControllor.getIns().getRandom());
            this._anti.defExp = Math.round(value - (this._anti.hpExp + this._anti.mpExp + this._anti.atkExp));
         }
         else if(whichAtt == 4)
         {
            if(value == this._anti.onehund)
            {
               this._anti.defExp = Math.round(this.getLevel() + (value - this.getLevel()) * RandomControllor.getIns().getRandom());
            }
            else
            {
               this._anti.defExp = Math.round(this.getLevel() * 2 + (value - this.getLevel() * 2) * RandomControllor.getIns().getRandom());
            }
            this._anti.hpExp = Math.round((value - this._anti.defExp) * RandomControllor.getIns().getRandom());
            this._anti.mpExp = Math.round((value - (this._anti.hpExp + this._anti.defExp)) * RandomControllor.getIns().getRandom());
            this._anti.atkExp = Math.round(value - (this._anti.hpExp + this._anti.mpExp + this._anti.defExp));
         }
         this.setLevel(1);
         var prename:String = this.petName.substr(0,this.petName.length - 1);
         this.petName = prename + "1";
         this.transPetChinaName();
         this.setCurExper(0);
         if(this.getquality() != 1)
         {
            this.setquality(1);
            this.sethpQuality(this.gethpQuality(true) * 1.3);
            this.setmpQuality(this.getmpQuality(true) * 1.3);
            this.setatkQuality(this.getatkQuality(true) * 1.3);
            this.setdefQuality(this.getdefQuality(true) * 1.3);
         }
         this.initPetInfoData(false);
         this.refreshEquip(equipArray);
         this.addPassiveAfterUpdata();
      }
      
      public function refreshPetAllSkillByLevel() : void
      {
         this.deletePassiveWhenUpdata();
         this.allSkill = ["tsml","zrsh","smzf","mfby","qlfj","sxkb","fsnl","smjc","mfjc","gjjc","fyjc"];
         this.skill = [];
         this.rePetSkill();
      }
      
      public function getPetName() : String
      {
         return this.petName;
      }
      
      public function getPetChinaName() : String
      {
         return this.petChinaName;
      }
      
      public function getIntroByName(_name:String) : String
      {
         var instr:String = "";
         var harmObj:Object = this.getPetHarmObj(_name);
         switch(_name)
         {
            case "tsml":
               instr = "被动增加宠物攻击" + harmObj.first + "点";
               break;
            case "zrsh":
               instr = "被动增加宠物防御" + harmObj.first + "点";
               break;
            case "smzf":
               instr = "被动增加宠物生命" + harmObj.first + "点";
               break;
            case "mfby":
               instr = "被动增加宠物魔法" + harmObj.first + "点";
               break;
            case "qlfj":
               instr = "宠物被攻击时有" + int(harmObj.first * 100) + "%的概率发动反击";
               break;
            case "sxkb":
               instr = "提升宠物物理暴击率" + int(harmObj.first * 100) + "%,持续" + harmObj.second + "s";
               break;
            case "fsnl":
               instr = "提升宠物技能伤害" + harmObj.first + "点,持续" + harmObj.second + "s";
               break;
            case "smjc":
               instr = "提升主人" + harmObj.first + "点生命,持续" + harmObj.second + "s";
               break;
            case "mfjc":
               instr = "提升主人" + harmObj.first + "点魔法,持续" + harmObj.second + "s";
               break;
            case "gjjc":
               instr = "提升主人" + harmObj.first + "点攻击,持续" + harmObj.second + "s";
               break;
            case "fyjc":
               instr = "提升主人" + harmObj.first + "点防御,持续" + harmObj.second + "s";
               break;
            case "xj":
               instr = "附近有怪物时，自动燃烧，对怪物造成火焰伤害";
               break;
            case "lj":
               instr = "对怪物造成多次伤害";
               break;
            case "lyq":
               instr = "对前方怪物造成火焰伤害，附带灼烧效果";
               break;
            case "jgaoyi":
               instr = "拥有献祭、连击、烈焰拳才能发挥出奥义的最大威力";
               break;
            case "sp":
               instr = "吐出水泡攻击前方怪物";
               break;
            case "bd":
               instr = "对攻击（靠近）它的怪物造成冰冻效果";
               break;
            case "bz":
               instr = "对大范围的怪物造成伤害";
               break;
            case "tmaoyi":
               instr = "拥有水泡、冰冻、冰锥才能发挥出奥义的最大威力";
               break;
            case "pms":
               instr = "撕裂前方怪物";
               break;
            case "ss":
               instr = "瞬间闪烁到怪物后面";
               break;
            case "kmsk":
               instr = "飞到空中对下方怪物造成伤害";
               break;
            case "hy":
               instr = "撕咬前方怪物";
               break;
            case "sxhz":
               instr = "将怪物抓到空中，并吸取生命";
               break;
            case "hsqj":
               instr = "对前方怪物造成伤害";
               break;
            case "bhaoyi":
               instr = "拥有虎牙、嗜血虎爪、横扫千军才能发挥出奥义的最大威力";
               break;
            case "sld":
               instr = "恢复一定生命值，并对周围怪物造成伤害";
               break;
            case "txlj":
               instr = "宠物帮主人承受部分伤害，并一起恢复生命";
               break;
            case "sybh":
               instr = "对周围怪物造成伤害";
               break;
            case "xwaoyi":
               instr = "拥有水疗盾、同心链接、水湮八荒才能发挥出奥义的最大威力";
               break;
            case "np":
               instr = "当生命低于20%的时候将化成朱雀丹，数秒后满血复活";
               break;
            case "bshn":
               instr = "对前方怪物造成伤害";
               break;
            case "dhly":
               instr = "对周围怪物造成较大的伤害";
               break;
            case "zqaoyi":
               instr = "拥有涅磐、不死火鸟、地火燎原才能发挥出奥义的最大威力";
               break;
            case "fs":
               instr = "分身一起攻击敌人，分身消失后，会恢复生命";
               break;
            case "sdcc":
               instr = "释放闪电向前冲刺，对前方怪物造成伤害";
               break;
            case "ltwj":
               instr = "召唤雷电，对周围怪物造成伤害";
               break;
            case "qlaoyi":
               instr = "拥有分身、闪电冲刺、雷霆万钧才能发挥奥义的最大威力";
               break;
            case "yg":
               instr = "攻击时有概率落下一道月光";
               break;
            case "jf":
               instr = "提高宠物自身普通攻击频率和闪避能力";
               break;
            case "bs":
               instr = "飞到空中，狙击一个范围，附带冰冻";
               break;
            case "ysaoyi":
               instr = "制造一轮明月，增加触发月光概率，并且持续回复玉兔和主人的生命值";
               break;
            case "qxyl":
               instr = "连续落下七颗星，随机攻击附近怪物";
               break;
            case "bhjm":
               instr = "年兽怒吼，地动山摇，眩晕周围怪物并造成伤害";
               break;
            case "jhgy":
               instr = "召唤九个魂魄，当生命低于40%时，吸收一个魂魄，恢复50%的生命。";
               break;
            case "sc":
               instr = "低头倾身快速冲向前方怪物，进行撕咬攻击";
               break;
            case "hxfb":
               instr = "丢出三叉飞镖，之后飞回子鼠";
               break;
            case "zsaoyi":
               instr = "拥有鼠窜、回旋飞镖才能发挥出奥义的最大威力";
               break;
            case "mncz":
               instr = "侧身快速冲向前方怪物，有概率晕眩怪物";
               break;
            case "mljt":
               instr = "用力踩踏地面，产生地震或地裂效果";
               break;
            case "cnaoyi":
               instr = "拥有蛮牛冲撞、蛮力践踏才能发挥出奥义的最大威力";
               break;
            case "hybt":
               instr = "移动后沿路蔓延火焰";
               break;
            case "hhjt":
               instr = "践踏地面周围喷射出数道火花";
               break;
            case "hx":
               instr = "吼出声波，概率晕眩对前方所有的怪物";
               break;
            case "mhxs":
               instr = "扑向前方怪物，给与沉重的一击";
               break;
            case "yhaoyi":
               instr = "拥有虎啸、猛虎下山才能发挥出奥义的最大威力";
         }
         return instr;
      }
      
      public function getPetHarmObj(_name:String) : Object
      {
         var petState:int = 0;
         var harmObj:Object = {
            "first":0,
            "second":0
         };
         switch(_name)
         {
            case "tsml":
               harmObj.first = this.getCurPetState() * 8 * this.getwarpower();
               break;
            case "zrsh":
               harmObj.first = this.getCurPetState() * 4 * this.gettechnique();
               break;
            case "smzf":
               harmObj.first = this.getCurPetState() * 50 * this.getwarpower();
               break;
            case "mfby":
               harmObj.first = this.getCurPetState() * 50 * this.gettechnique();
               break;
            case "qlfj":
               harmObj.first = (0.05 + this.getCurPetState() / 100) * this.getwarpower();
               break;
            case "sxkb":
               petState = this.getCurPetState() > 3 ? 3 : this.getCurPetState();
               if(this.gettechnique() <= 4)
               {
                  harmObj.first = petState * 0.04 * this.gettechnique();
               }
               else
               {
                  harmObj.first = petState * 0.04 * 4 + 0.05 * (this.gettechnique() - 4);
               }
               harmObj.second = (25 + this.getCurPetState() * 5) * this.getwarpower() / 2;
               break;
            case "fsnl":
               harmObj.first = this.getCurPetState() * 30 * this.gettechnique();
               harmObj.second = (25 + this.getCurPetState() * 5) * this.getwarpower() / 2;
               break;
            case "smjc":
               harmObj.first = this.getCurPetState() * 70 * this.gettechnique();
               harmObj.second = (25 + this.getCurPetState() * 5) * this.getwarpower() / 2;
               break;
            case "mfjc":
               harmObj.first = this.getCurPetState() * 70 * this.gettechnique();
               harmObj.second = (25 + this.getCurPetState() * 5) * this.getwarpower() / 2;
               break;
            case "gjjc":
               harmObj.first = this.getCurPetState() * 10 * this.gettechnique();
               harmObj.second = (25 + this.getCurPetState() * 5) * this.getwarpower() / 2;
               break;
            case "fyjc":
               harmObj.first = this.getCurPetState() * 5 * this.gettechnique();
               harmObj.second = (25 + this.getCurPetState() * 5) * this.getwarpower() / 2;
               break;
            case "xj":
               harmObj.first = 0.1 * this.getAtk();
               break;
            case "lj":
               harmObj.first = this.getAtk();
               break;
            case "jgaoyi":
               harmObj.first = 0;
               break;
            case "lyq":
               harmObj.first = 6 * this.getAtk();
               break;
            case "sp":
               harmObj.first = 2 * this.getAtk();
               break;
            case "bd":
               harmObj.first = 2 * this.getAtk();
               break;
            case "bz":
               harmObj.first = 5 * this.getAtk();
               break;
            case "tmaoyi":
               harmObj.first = 0;
               break;
            case "pms":
               harmObj.first = 2 * this.getAtk();
               break;
            case "ss":
               harmObj.first = 0;
               break;
            case "kmsk":
               harmObj.first = 5 * this.getAtk();
               break;
            case "hy":
               harmObj.first = 2 * this.getAtk();
               break;
            case "sxhz":
               harmObj.first = 4 * this.getAtk();
               break;
            case "hsqj":
               harmObj.first = 6 * this.getAtk();
               break;
            case "bhaoyi":
               harmObj.first = 0;
               break;
            case "sld":
               harmObj.first = this.getAtk();
               break;
            case "txlj":
               harmObj.first = 5 * this.gettechnique();
               harmObj.second = 4 * this.getwarpower();
               break;
            case "sybh":
               harmObj.first = 6 * this.getAtk();
               break;
            case "xwaoyi":
               harmObj.first = 0;
               break;
            case "np":
               harmObj.first = 0;
               break;
            case "bshn":
               harmObj.first = 2 * this.getAtk();
               break;
            case "dhly":
               harmObj.first = 10 * this.getAtk();
               break;
            case "zqaoyi":
               harmObj.first = 0;
               break;
            case "fs":
               harmObj.first = 0;
               break;
            case "sdcc":
               harmObj.first = 2 * this.getAtk();
               break;
            case "ltwj":
               harmObj.first = 4 * this.getAtk();
               break;
            case "qlaoyi":
               harmObj.first = 0;
               break;
            case "yg":
               harmObj.first = 2 * this.getAtk();
               break;
            case "jf":
               harmObj.first = 0;
               break;
            case "bs":
               harmObj.first = 8 * this.getAtk();
               break;
            case "ysaoyi":
               harmObj.first = 0;
               break;
            case "qxyl":
               harmObj.first = this.getAtk();
               break;
            case "bhjm":
               harmObj.first = 10 * this.getAtk();
               break;
            case "jhgy":
               harmObj.first = 10 * this.getAtk();
               break;
            case "sc":
               harmObj.first = 3 * this.getAtk();
               break;
            case "hxfb":
               harmObj.first = 5 * this.getAtk();
               break;
            case "zsaoyi":
               harmObj.first = 0;
               break;
            case "mncz":
               harmObj.first = 3 * this.getAtk();
               break;
            case "mljt":
               harmObj.first = 6 * this.getAtk();
               break;
            case "hybt":
               harmObj.first = this.getAtk();
               break;
            case "hhjt":
               harmObj.first = 6 * this.getAtk();
               break;
            case "hx":
               harmObj.first = 3 * this.getAtk();
               break;
            case "mhxs":
               harmObj.first = 7 * this.getAtk();
               break;
            case "yhaoyi":
               harmObj.first = 0;
         }
         return harmObj;
      }
      
      private function getPassHarmByPetState(sname:String, state:int) : int
      {
         var harm:int = 0;
         switch(sname)
         {
            case "tsml":
               harm = state * 6 * this.getwarpower();
               break;
            case "zrsh":
               harm = state * 4 * this.gettechnique();
               break;
            case "smzf":
               harm = state * 50 * this.getwarpower();
               break;
            case "mfby":
               harm = state * 50 * this.gettechnique();
         }
         return harm;
      }
      
      private function addSpecialSkill() : void
      {
         var sname:String = "";
         var presname:String = "";
         switch(this.petName)
         {
            case "monkey1":
               sname = "xj";
               break;
            case "monkey2":
               presname = "xj";
               sname = "lj";
               break;
            case "monkey3":
               presname = "lj";
               sname = "lyq";
               break;
            case "horse1":
               sname = "sp";
               break;
            case "horse2":
               presname = "sp";
               sname = "bd";
               break;
            case "horse3":
               presname = "bd";
               sname = "bz";
               break;
            case "ufo1":
               sname = "pms";
               break;
            case "ufo2":
               presname = "pms";
               sname = "ss";
               break;
            case "ufo3":
               presname = "ss";
               sname = "kmsk";
               break;
            case "tigress1":
               sname = "hy";
               break;
            case "tigress2":
               presname = "hy";
               sname = "sxhz";
               break;
            case "tigress3":
               presname = "sxhz";
               sname = "hsqj";
               break;
            case "turtle1":
               sname = "sld";
               break;
            case "turtle2":
               presname = "sld";
               sname = "txlj";
               break;
            case "turtle3":
               presname = "txlj";
               sname = "sybh";
               break;
            case "phoenix1":
               sname = "np";
               break;
            case "phoenix2":
               presname = "np";
               sname = "bshn";
               break;
            case "phoenix3":
               presname = "bshn";
               sname = "dhly";
               break;
            case "dragon1":
               sname = "fs";
               break;
            case "dragon2":
               presname = "fs";
               sname = "sdcc";
               break;
            case "dragon3":
               presname = "sdcc";
               sname = "ltwj";
               break;
            case "rabbit1":
               sname = "yg";
               break;
            case "rabbit2":
               presname = "yg";
               sname = "jf";
               break;
            case "rabbit3":
               presname = "jf";
               sname = "bs";
               break;
            case "nian1":
               sname = "qxyl";
               break;
            case "nian2":
               sname = "qxyl";
               break;
            case "nian3":
               sname = "qxyl";
               break;
            case "nian4":
               presname = "qxyl";
               sname = "bhjm";
               break;
            case "nian5":
               presname = "bhjm";
               sname = "jhgy";
               break;
            case "mouse1":
               sname = "sc";
               break;
            case "mouse2":
               sname = "sc";
               break;
            case "mouse3":
               sname = "sc";
               break;
            case "mouse4":
               presname = "sc";
               sname = "hxfb";
               break;
            case "neat1":
               sname = "mncz";
               break;
            case "neat2":
               sname = "mncz";
               break;
            case "neat3":
               sname = "mncz";
               break;
            case "neat4":
               presname = "mncz";
               sname = "mljt";
               break;
            case "roomhorse1":
               sname = "hybt";
               break;
            case "roomhorse2":
               sname = "hybt";
               break;
            case "roomhorse3":
               sname = "hybt";
               break;
            case "roomhorse4":
               presname = "hybt";
               sname = "hhjt";
               break;
            case "terribletiger1":
               sname = "hx";
               break;
            case "terribletiger2":
               sname = "hx";
               break;
            case "terribletiger3":
               sname = "hx";
               break;
            case "terribletiger4":
               presname = "hx";
               sname = "mhxs";
         }
         if(presname != "")
         {
            this.removeSomeSkillFromAllSkill(presname);
         }
         if(sname != "")
         {
            if(!this.findHasStudySkill(sname))
            {
               if(!this.findHasInAllSkill(sname))
               {
                  this.allSkill.push(sname);
               }
            }
         }
      }
      
      public function petUpdate() : void
      {
         var nxExp:int = 0;
         var prename:* = null;
         var preState:int = 0;
         if(this.getLevel() < gc.getTotalTopLevel())
         {
            nxExp = this.getPetNextExper();
            if(this.getCurExper() >= nxExp)
            {
               this.deletePassiveWhenUpdata();
               this.setLevel(this.getLevel() + 1);
               prename = this.petName.substr(0,this.petName.length - 1);
               preState = int(this.petName.charAt(this.petName.length - 1));
               if(this.getLevel() >= 16 && this.getLevel() < 30)
               {
                  if(preState == 1)
                  {
                     this.petName = prename + (preState + 1);
                     this.addSpecialSkill();
                     if(this.doWhenChangeState != null)
                     {
                        this.doWhenChangeState();
                     }
                     this.transPetChinaName();
                     this.changePetSkillIntroduce();
                  }
               }
               else if(this.getLevel() > 30)
               {
                  if(preState == 2)
                  {
                     this.petName = prename + (preState + 1);
                     this.addSpecialSkill();
                     if(this.doWhenChangeState != null)
                     {
                        this.doWhenChangeState();
                     }
                     this.transPetChinaName();
                     this.changePetSkillIntroduce();
                  }
               }
               this.studySkillSuddenly(this.getLevel());
               this.addPassiveAfterUpdata();
               this.reSetPetAttributeValue();
               if(this.doWhenLevelUp != null)
               {
                  this.doWhenLevelUp();
               }
               this.setCurExper(this.getCurExper() - nxExp);
            }
         }
      }
      
      public function changePerceptionAdd() : void
      {
         this.deletePassiveWhenUpdata();
         this.setperceptionadd(this.getperceptionadd() + 1);
         this.addPassiveAfterUpdata();
      }
      
      public function changeWarpowerAdd() : void
      {
         this.deletePassiveWhenUpdata();
         this.setwarpoweradd(this.getwarpoweradd() + 1);
         this.addPassiveAfterUpdata();
      }
      
      public function changeTechniqueAdd() : void
      {
         this.deletePassiveWhenUpdata();
         this.settechniqueadd(this.gettechniqueadd() + 1);
         this.addPassiveAfterUpdata();
      }
      
      public function theFourShape(_isjump:Boolean = false) : void
      {
         var prename:* = null;
         var preState:int = int(this.petName.charAt(this.petName.length - 1));
         if(preState == 3 || _isjump)
         {
            this.deletePassiveWhenUpdata();
            prename = this.petName.substr(0,this.petName.length - 1);
            this.petName = prename + 4;
            this.transPetChinaName();
            this.changePetSkillIntroduce();
            this.addPassiveAfterUpdata();
            if(this.doWhenChangeState != null)
            {
               this.doWhenChangeState();
            }
         }
      }
      
      public function theFiveShape(_isjump:Boolean = false) : void
      {
         var prename:* = null;
         var preState:int = int(this.petName.charAt(this.petName.length - 1));
         if(preState == 4 || _isjump)
         {
            this.deletePassiveWhenUpdata();
            prename = this.petName.substr(0,this.petName.length - 1);
            this.petName = prename + 5;
            this.transPetChinaName();
            this.changePetSkillIntroduce();
            this.addPassiveAfterUpdata();
            if(this.doWhenChangeState != null)
            {
               this.doWhenChangeState();
            }
         }
      }
      
      public function studyEsoteric() : Boolean
      {
         var skillobj:* = null;
         skillobj = null;
         skillobj = null;
         skillobj = null;
         skillobj = null;
         skillobj = null;
         skillobj = null;
         var preState:int = int(this.petName.charAt(this.petName.length - 1));
         if(preState != 4)
         {
            gc.ts.setTxt("宠物不是第四形态");
            gc.stage.addChild(gc.ts);
            return false;
         }
         var prename:String = this.petName.substr(0,this.petName.length - 1);
         if(prename == "monkey")
         {
            if(!(this.skill.length < this.getperception() && this.skill.length < 8))
            {
               gc.ts.setTxt("该宠物技能已满");
               gc.stage.addChild(gc.ts);
               return false;
            }
            skillobj = {
               "sname":"jgaoyi",
               "sinfo":getIntroByName("jgaoyi")
            };
            this.skill.push(skillobj);
            gc.ts.setTxt("领悟成功");
            gc.stage.addChild(gc.ts);
         }
         else if(prename == "horse")
         {
            if(!(this.skill.length < this.getperception() && this.skill.length < 8))
            {
               gc.ts.setTxt("该宠物技能已满");
               gc.stage.addChild(gc.ts);
               return false;
            }
            skillobj = {
               "sname":"tmaoyi",
               "sinfo":getIntroByName("tmaoyi")
            };
            this.skill.push(skillobj);
            gc.ts.setTxt("领悟成功");
            gc.stage.addChild(gc.ts);
         }
         else if(prename == "tigress")
         {
            if(!(this.skill.length < this.getperception() && this.skill.length < 8))
            {
               gc.ts.setTxt("该宠物技能已满");
               gc.stage.addChild(gc.ts);
               return false;
            }
            skillobj = {
               "sname":"bhaoyi",
               "sinfo":getIntroByName("bhaoyi")
            };
            this.skill.push(skillobj);
            gc.ts.setTxt("领悟成功");
            gc.stage.addChild(gc.ts);
         }
         else if(prename == "turtle")
         {
            if(!(this.skill.length < this.getperception() && this.skill.length < 8))
            {
               gc.ts.setTxt("该宠物技能已满");
               gc.stage.addChild(gc.ts);
               return false;
            }
            skillobj = {
               "sname":"xwaoyi",
               "sinfo":getIntroByName("xwaoyi")
            };
            this.skill.push(skillobj);
            gc.ts.setTxt("领悟成功");
            gc.stage.addChild(gc.ts);
         }
         else if(prename == "phoenix")
         {
            if(!(this.skill.length < this.getperception() && this.skill.length < 8))
            {
               gc.ts.setTxt("该宠物技能已满");
               gc.stage.addChild(gc.ts);
               return false;
            }
            skillobj = {
               "sname":"zqaoyi",
               "sinfo":getIntroByName("zqaoyi")
            };
            this.skill.push(skillobj);
            gc.ts.setTxt("领悟成功");
            gc.stage.addChild(gc.ts);
         }
         else if(prename == "dragon")
         {
            if(!(this.skill.length < this.getperception() && this.skill.length < 8))
            {
               gc.ts.setTxt("该宠物技能已满");
               gc.stage.addChild(gc.ts);
               return false;
            }
            skillobj = {
               "sname":"qlaoyi",
               "sinfo":getIntroByName("qlaoyi")
            };
            this.skill.push(skillobj);
            gc.ts.setTxt("领悟成功");
            gc.stage.addChild(gc.ts);
         }
         else if(prename == "rabbit")
         {
            if(!(this.skill.length < this.getperception() && this.skill.length < 8))
            {
               gc.ts.setTxt("该宠物技能已满");
               gc.stage.addChild(gc.ts);
               return false;
            }
            skillobj = {
               "sname":"ysaoyi",
               "sinfo":getIntroByName("ysaoyi")
            };
            this.skill.push(skillobj);
            gc.ts.setTxt("领悟成功");
            gc.stage.addChild(gc.ts);
         }
         return true;
      }
      
      public function addMouseAoYi(_pn:String, _sname:String) : void
      {
         var slen:* = 0;
         var skillobj:* = null;
         var aystr:* = null;
         for each(var obj in this.skill)
         {
            if(obj.sname == _sname)
            {
               return;
            }
         }
         var prename:String = this.petName.substr(0,this.petName.length - 1);
         if(prename == _pn)
         {
            slen = uint(this.skill.length);
            if(slen >= this.getperception())
            {
               gc.ts.setTxt("技能已满，无法领悟奥义");
               gc.stage.addChild(gc.ts);
               return;
            }
            skillobj = {
               "sname":_sname,
               "sinfo":getIntroByName(_sname)
            };
            this.skill.push(skillobj);
            aystr = "";
            if(_sname == "zsaoyi")
            {
               aystr = "子鼠奥义";
            }
            else if(_sname == "cnaoyi")
            {
               aystr = "丑牛奥义";
            }
            else if(_sname == "yhaoyi")
            {
               aystr = "寅虎奥义";
            }
            gc.ts.setTxt("成功领悟" + aystr);
            gc.stage.addChild(gc.ts);
         }
      }
      
      public function removeMouseAoYi(_sname:String = "") : void
      {
         var slen:uint = this.skill.length;
         var index:int = -1;
         for each(var obj in this.skill)
         {
            if(obj.sname == _sname)
            {
               index = this.skill.indexOf(obj);
               this.skill.splice(index,1);
               break;
            }
         }
      }
      
      public function delSomeOneSkillBySkillName(_sname:String) : void
      {
         this.deletePassiveWhenUpdata();
         var slen:uint = this.skill.length;
         var index:int = -1;
         for each(var obj in this.skill)
         {
            if(obj.sname == _sname)
            {
               index = this.skill.indexOf(obj);
               this.skill.splice(index,1);
               this.allSkill.push(obj.sname);
               break;
            }
         }
         this.addPassiveAfterUpdata();
      }
      
      public function addSomeOneSkillByRandom() : void
      {
         var sit:int = 0;
         var sary:Array = this.getAllSpecialSkill();
         for each(var obj in this.skill)
         {
            sit = sary.indexOf(obj.sname);
            if(sit != -1)
            {
               sary.splice(sit,1);
            }
         }
         var s:uint = Math.round(RandomControllor.getIns().getRandom() * (sary.length - 1));
         var skillobj:Object = {
            "sname":sary[s],
            "sinfo":getIntroByName(sary[s])
         };
         this.skill.push(skillobj);
         var sit2:int = this.allSkill.indexOf(sary[s]);
         this.allSkill.splice(sit2,1);
      }
      
      public function hasStudyAllSpecialSkill() : uint
      {
         var sit:int = 0;
         var sary:Array = this.getAllSpecialSkill();
         for each(var obj in this.skill)
         {
            sit = sary.indexOf(obj.sname);
            if(sit != -1)
            {
               sary.splice(sit,1);
            }
         }
         return sary.length;
      }
      
      private function getAllSpecialSkill() : Array
      {
         var preState:int = int(this.petName.charAt(this.petName.length - 1));
         var prename:String = this.petName.substr(0,this.petName.length - 1);
         var ary:Array = [];
         if(prename == "monkey")
         {
            if(preState == 1)
            {
               ary.push("xj");
            }
            else if(preState == 2)
            {
               ary.push("xj","lj");
            }
            else if(preState == 3)
            {
               ary.push("xj","lj","lyq");
            }
            else if(preState == 4)
            {
               ary.push("xj","lj","lyq");
            }
         }
         else if(prename == "horse")
         {
            if(preState == 1)
            {
               ary.push("sp");
            }
            else if(preState == 2)
            {
               ary.push("sp","bd");
            }
            else if(preState == 3)
            {
               ary.push("sp","bd","bz");
            }
            else if(preState == 4)
            {
               ary.push("sp","bd","bz");
            }
         }
         else if(prename == "ufo")
         {
            if(preState == 1)
            {
               ary.push("pms");
            }
            else if(preState == 2)
            {
               ary.push("pms","ss");
            }
            else if(preState == 3)
            {
               ary.push("pms","ss","kmsk");
            }
         }
         else if(prename == "tigress")
         {
            if(preState == 1)
            {
               ary.push("hy");
            }
            else if(preState == 2)
            {
               ary.push("hy","sxhz");
            }
            else if(preState == 3)
            {
               ary.push("hy","sxhz","hsqj");
            }
            else if(preState == 4)
            {
               ary.push("hy","sxhz","hsqj");
            }
         }
         else if(prename == "turtle")
         {
            if(preState == 1)
            {
               ary.push("sld");
            }
            else if(preState == 2)
            {
               ary.push("sld","txlj");
            }
            else if(preState == 3)
            {
               ary.push("sld","txlj","sybh");
            }
            else if(preState == 4)
            {
               ary.push("sld","txlj","sybh");
            }
         }
         else if(prename == "phoenix")
         {
            if(preState == 1)
            {
               ary.push("np");
            }
            else if(preState == 2)
            {
               ary.push("np","bshn");
            }
            else if(preState == 3)
            {
               ary.push("np","bshn","dhly");
            }
            else if(preState == 4)
            {
               ary.push("np","bshn","dhly");
            }
         }
         else if(prename == "dragon")
         {
            if(preState == 1)
            {
               ary.push("fs");
            }
            else if(preState == 2)
            {
               ary.push("fs","sdcc");
            }
            else if(preState == 3)
            {
               ary.push("fs","sdcc","ltwj");
            }
            else if(preState == 4)
            {
               ary.push("fs","sdcc","ltwj");
            }
         }
         else if(prename == "rabbit")
         {
            if(preState == 1)
            {
               ary.push("yg");
            }
            else if(preState == 2)
            {
               ary.push("yg","jf");
            }
            else if(preState == 3)
            {
               ary.push("yg","jf","bs");
            }
            else if(preState == 4)
            {
               ary.push("yg","jf","bs");
            }
         }
         else if(prename == "nian")
         {
            if(preState == 1)
            {
               ary.push("qxyl");
            }
            else if(preState == 2)
            {
               ary.push("qxyl");
            }
            else if(preState == 3)
            {
               ary.push("qxyl");
            }
            else if(preState == 4)
            {
               ary.push("qxyl","bhjm");
            }
            else if(preState == 5)
            {
               ary.push("qxyl","bhjm","jhgy");
            }
         }
         else if(prename == "mouse")
         {
            if(preState == 1)
            {
               ary.push("sc");
            }
            else if(preState == 2)
            {
               ary.push("sc");
            }
            else if(preState == 3)
            {
               ary.push("sc");
            }
            else if(preState == 4)
            {
               ary.push("sc","hxfb");
            }
         }
         else if(prename == "neat")
         {
            if(preState == 1)
            {
               ary.push("mncz");
            }
            else if(preState == 2)
            {
               ary.push("mncz");
            }
            else if(preState == 3)
            {
               ary.push("mncz");
            }
            else if(preState == 4)
            {
               ary.push("mncz","mljt");
            }
         }
         else if(prename == "roomhorse")
         {
            if(preState == 1)
            {
               ary.push("hybt");
            }
            else if(preState == 2)
            {
               ary.push("hybt");
            }
            else if(preState == 3)
            {
               ary.push("hybt");
            }
            else if(preState == 4)
            {
               ary.push("hybt","hhjt");
            }
         }
         else if(prename == "terribletiger")
         {
            if(preState == 1)
            {
               ary.push("hx");
            }
            else if(preState == 2)
            {
               ary.push("hx");
            }
            else if(preState == 3)
            {
               ary.push("hx");
            }
            else if(preState == 4)
            {
               ary.push("hx","mhxs");
            }
         }
         return ary;
      }
      
      private function rePetSkill() : void
      {
         var i:* = 0;
         var preState:int = int(this.petName.charAt(this.petName.length - 1));
         var prename:String = this.petName.substr(0,this.petName.length - 1);
         if(prename == "monkey")
         {
            if(preState == 1)
            {
               this.allSkill.push("xj");
            }
            else if(preState == 2)
            {
               this.allSkill.push("xj","lj");
            }
            else if(preState == 3)
            {
               this.allSkill.push("xj","lj","lyq");
            }
            else if(preState == 4)
            {
               this.allSkill.push("xj","lj","lyq");
            }
         }
         else if(prename == "horse")
         {
            if(preState == 1)
            {
               this.allSkill.push("sp");
            }
            else if(preState == 2)
            {
               this.allSkill.push("sp","bd");
            }
            else if(preState == 3)
            {
               this.allSkill.push("sp","bd","bz");
            }
            else if(preState == 4)
            {
               this.allSkill.push("sp","bd","bz");
            }
         }
         else if(prename == "ufo")
         {
            if(preState == 1)
            {
               this.allSkill.push("pms");
            }
            else if(preState == 2)
            {
               this.allSkill.push("pms","ss");
            }
            else if(preState == 3)
            {
               this.allSkill.push("pms","ss","kmsk");
            }
         }
         else if(prename == "tigress")
         {
            if(preState == 1)
            {
               this.allSkill.push("hy");
            }
            else if(preState == 2)
            {
               this.allSkill.push("hy","sxhz");
            }
            else if(preState == 3)
            {
               this.allSkill.push("hy","sxhz","hsqj");
            }
            else if(preState == 4)
            {
               this.allSkill.push("hy","sxhz","hsqj");
            }
         }
         else if(prename == "turtle")
         {
            if(preState == 1)
            {
               this.allSkill.push("sld");
            }
            else if(preState == 2)
            {
               this.allSkill.push("sld","txlj");
            }
            else if(preState == 3)
            {
               this.allSkill.push("sld","txlj","sybh");
            }
            else if(preState == 4)
            {
               this.allSkill.push("sld","txlj","sybh");
            }
         }
         else if(prename == "phoenix")
         {
            if(preState == 1)
            {
               this.allSkill.push("np");
            }
            else if(preState == 2)
            {
               this.allSkill.push("np","bshn");
            }
            else if(preState == 3)
            {
               this.allSkill.push("np","bshn","dhly");
            }
            else if(preState == 4)
            {
               this.allSkill.push("np","bshn","dhly");
            }
         }
         else if(prename == "dragon")
         {
            if(preState == 1)
            {
               this.allSkill.push("fs");
            }
            else if(preState == 2)
            {
               this.allSkill.push("fs","sdcc");
            }
            else if(preState == 3)
            {
               this.allSkill.push("fs","sdcc","ltwj");
            }
            else if(preState == 4)
            {
               this.allSkill.push("fs","sdcc","ltwj");
            }
         }
         else if(prename == "rabbit")
         {
            if(preState == 1)
            {
               this.allSkill.push("yg");
            }
            else if(preState == 2)
            {
               this.allSkill.push("yg","jf");
            }
            else if(preState == 3)
            {
               this.allSkill.push("yg","jf","bs");
            }
            else if(preState == 4)
            {
               this.allSkill.push("yg","jf","bs");
            }
         }
         else if(prename == "nian")
         {
            if(preState == 1)
            {
               this.allSkill.push("qxyl");
            }
            else if(preState == 2)
            {
               this.allSkill.push("qxyl");
            }
            else if(preState == 3)
            {
               this.allSkill.push("qxyl");
            }
            else if(preState == 4)
            {
               this.allSkill.push("qxyl","bhjm");
            }
            else if(preState == 5)
            {
               this.allSkill.push("qxyl","bhjm","jhgy");
            }
         }
         else if(prename == "mouse")
         {
            if(preState == 1)
            {
               this.allSkill.push("sc");
            }
            else if(preState == 2)
            {
               this.allSkill.push("sc");
            }
            else if(preState == 3)
            {
               this.allSkill.push("sc");
            }
            else if(preState == 4)
            {
               this.allSkill.push("sc","hxfb");
            }
         }
         else if(prename == "neat")
         {
            if(preState == 1)
            {
               this.allSkill.push("mncz");
            }
            else if(preState == 2)
            {
               this.allSkill.push("mncz");
            }
            else if(preState == 3)
            {
               this.allSkill.push("mncz");
            }
            else if(preState == 4)
            {
               this.allSkill.push("mncz","mljt");
            }
         }
         else if(prename == "roomhorse")
         {
            if(preState == 1)
            {
               this.allSkill.push("hybt");
            }
            else if(preState == 2)
            {
               this.allSkill.push("hybt");
            }
            else if(preState == 3)
            {
               this.allSkill.push("hybt");
            }
            else if(preState == 4)
            {
               this.allSkill.push("hybt","hhjt");
            }
         }
         else if(prename == "terribletiger")
         {
            if(preState == 1)
            {
               this.allSkill.push("hx");
            }
            else if(preState == 2)
            {
               this.allSkill.push("hx");
            }
            else if(preState == 3)
            {
               this.allSkill.push("hx");
            }
            else if(preState == 4)
            {
               this.allSkill.push("hx","mhxs");
            }
         }
         for(i = uint(2); i <= this.getLevel(); )
         {
            this.studySkillSuddenly(i);
            i++;
         }
         this.addPassiveAfterUpdata();
      }
      
      private function reSetPetAttributeValue() : void
      {
         this.setSHp(this.getSHp() + this.gethpQuality() * 0.08);
         this.setHp(this.getSHp());
         this.setSMp(this.getSMp() + this.getmpQuality() * 0.08);
         this.setMp(this.getSMp());
         this.setAtk(this.getAtk() + this.getatkQuality() * 0.015);
         this.setDef(this.getDef() + this.getdefQuality() * 0.01);
      }
      
      private function checkLevel() : void
      {
         var diff:* = 0;
         var i:* = 0;
         if(this.getLevel() > gc.getTotalTopLevel())
         {
            diff = uint(this.getLevel() - gc.getTotalTopLevel());
            for(i = uint(0); i < diff; )
            {
               this.setSHp(this.getSHp() - this.gethpQuality() * 0.08);
               this.setHp(this.getSHp());
               this.setSMp(this.getSMp() - this.getmpQuality() * 0.08);
               this.setMp(this.getSMp());
               this.setAtk(this.getAtk() - this.getatkQuality() * 0.015);
               this.setDef(this.getDef() - this.getdefQuality() * 0.01);
               i++;
            }
            this.setLevel(gc.getTotalTopLevel());
         }
      }
      
      public function getPetNextExper() : int
      {
         var nexper:int = 0;
         if(this.getLevel() <= 10)
         {
            nexper = this.getLevel() * 50;
         }
         else
         {
            nexper = (this.getLevel() + 1) * (this.getLevel() + 1) * (5 + (this.getLevel() - 10) * 2);
         }
         return nexper;
      }
      
      public function getCurPetState() : uint
      {
         var state:String = this.petName.charAt(this.petName.length - 1);
         return int(state);
      }
      
      public function findHasStudySkill(sname:String) : Boolean
      {
         for(var slen:uint = this.skill.length; slen-- > 0; )
         {
            if(sname == this.skill[slen].sname)
            {
               return true;
            }
         }
         return false;
      }
      
      private function removeSomeSkillFromAllSkill(sname:String) : void
      {
         var sit:int = this.allSkill.indexOf(sname);
         if(sit != -1)
         {
            this.allSkill.splice(sit,1);
         }
      }
      
      private function findHasInAllSkill(sname:String) : Boolean
      {
         for(var alen:uint = this.allSkill.length; alen-- > 0; )
         {
            if(sname == this.allSkill[alen])
            {
               return true;
            }
         }
         return false;
      }
      
      public function studySkillSuddenly(level:uint) : void
      {
         var i:* = 0;
         var skillobj:* = null;
         for(i = uint(0); i < 100; )
         {
            if(level == 3 * (i + 1) - 1)
            {
               break;
            }
            if(i == 59)
            {
               return;
            }
            i++;
         }
         if(this.skill.length >= this.getperception())
         {
            return;
         }
         if(RandomControllor.getIns().getRandom() > 0.4)
         {
            return;
         }
         var alen:uint = this.allSkill.length;
         var rand:uint = RandomControllor.getIns().getRandom() * alen;
         var sit:int = this.allSkill.indexOf(this.allSkill[rand]);
         if(sit != -1)
         {
            skillobj = {
               "sname":this.allSkill[rand],
               "sinfo":getIntroByName(this.allSkill[rand])
            };
            this.skill.push(skillobj);
            this.allSkill.splice(sit,1);
         }
      }
      
      public function changePetSkillIntroduce() : void
      {
         for(var slen:uint = this.skill.length; slen-- > 0; )
         {
            this.skill[slen].sinfo = this.getIntroByName(this.skill[slen].sname);
         }
      }
      
      private function hasStudyPassiveSkill(sname:String) : void
      {
         var rate:Number = NaN;
         rate = NaN;
         var harmObj:Object = this.getPetHarmObj(sname);
         if(sname == "tsml")
         {
            this.setAtk(this.getAtk() + harmObj.first);
         }
         else if(sname == "zrsh")
         {
            this.setDef(this.getDef() + harmObj.first);
         }
         else if(sname == "smzf")
         {
            rate = this.getHp() / this.getSHp();
            this.setHp(this.getHp() + harmObj.first * rate);
            this.setSHp(this.getSHp() + harmObj.first);
         }
         else if(sname == "mfby")
         {
            rate = this.getMp() / this.getSMp();
            this.setMp(this.getMp() + harmObj.first * rate);
            this.setSMp(this.getSMp() + harmObj.first);
         }
      }
      
      public function deletePassiveWhenUpdata() : void
      {
         var rate:Number = NaN;
         rate = NaN;
         var slen:uint = this.skill.length;
         var sname:String = "";
         for(var harmObj:Object = {
            "first":0,
            "second":0
         }; slen-- > 0; )
         {
            sname = this.skill[slen].sname;
            harmObj = this.getPetHarmObj(sname);
            if(sname == "tsml")
            {
               this.setAtk(this.getAtk() - harmObj.first);
            }
            else if(sname == "zrsh")
            {
               this.setDef(this.getDef() - harmObj.first);
            }
            else if(sname == "smzf")
            {
               rate = this.getHp() / this.getSHp();
               this.setHp(this.getHp() - harmObj.first * rate);
               this.setSHp(this.getSHp() - harmObj.first);
            }
            else if(sname == "mfby")
            {
               rate = this.getMp() / this.getSMp();
               this.setMp(this.getMp() - harmObj.first * rate);
               this.setSMp(this.getSMp() - harmObj.first);
            }
         }
         if(this.isFight)
         {
            gc.petFormation.removePropertyToPetInfo(this);
         }
      }
      
      public function addPassiveAfterUpdata() : void
      {
         var slen:uint = this.skill.length;
         for(var sname:String = ""; slen-- > 0; )
         {
            sname = this.skill[slen].sname;
            this.hasStudyPassiveSkill(sname);
         }
         if(this.isFight)
         {
            gc.petFormation.addPropertyToPetInfo(this);
         }
      }
      
      public function findPetUsedMagic(sname:String) : uint
      {
         switch(sname)
         {
            case "tsml":
            case "zrsh":
            case "smzf":
            case "mfby":
            case "qlfj":
               return 0;
            case "sxkb":
            case "fsnl":
            case "smjc":
            case "mfjc":
            case "gjjc":
               break;
            case "fyjc":
               break;
            case "xj":
               return 50;
            case "lj":
               return 70;
            case "lyq":
               return 90;
            case "jgaoyi":
               return 100;
            case "sp":
               return 60;
            case "bd":
               return 90;
            case "bz":
               return 120;
            case "tmaoyi":
               return 100;
            case "pms":
               return 50;
            case "ss":
               return 70;
            case "kmsk":
               return 90;
            case "hy":
               return 50;
            case "sxhz":
               return 70;
            case "hsqj":
               return 90;
            case "bhaoyi":
               return 100;
            case "sld":
               return 50;
            case "txlj":
               return 70;
            case "sybh":
               return 90;
            case "xwaoyi":
               return 100;
            case "np":
               return 100;
            case "bshn":
               return 70;
            case "dhly":
               return 90;
            case "zqaoyi":
               return 100;
            case "fs":
               return 50;
            case "sdcc":
               return 70;
            case "ltwj":
               return 90;
            case "qlaoyi":
               return 100;
            case "yg":
               return 0;
            case "jf":
               return 70;
            case "bs":
               return 90;
            case "ysaoyi":
               return 100;
            case "qxyl":
               return 50;
            case "bhjm":
               return 70;
            case "jhgy":
               return 90;
            case "sc":
               return 50;
            case "hxfb":
               return 70;
            case "zsaoyi":
               return 100;
            case "mncz":
               return 50;
            case "mljt":
               return 70;
            case "cnaoyi":
               return 100;
            case "hybt":
               return 50;
            case "hhjt":
               return 70;
            case "hx":
               return 50;
            case "mhxs":
               return 70;
            case "yhaoyi":
               return 100;
            default:
               return 0;
         }
         return 100;
      }
      
      private function transPetChinaName() : void
      {
         switch(this.petName)
         {
            case "monkey1":
               this.petChinaName = "火丸";
               break;
            case "monkey2":
               this.petChinaName = "灵猴";
               break;
            case "monkey3":
               this.petChinaName = "火猿";
               break;
            case "monkey4":
               this.petChinaName = "烈焰金刚";
               break;
            case "horse1":
               this.petChinaName = "雪球";
               break;
            case "horse2":
               this.petChinaName = "雪马";
               break;
            case "horse3":
               this.petChinaName = "寒野";
               break;
            case "horse4":
               this.petChinaName = "极寒天马";
               break;
            case "ufo1":
               this.petChinaName = "小飞";
               break;
            case "ufo2":
               this.petChinaName = "裂云";
               break;
            case "ufo3":
               this.petChinaName = "冲霄";
               break;
            case "tigress1":
               this.petChinaName = "虎丸";
               break;
            case "tigress2":
               this.petChinaName = "白灵虎";
               break;
            case "tigress3":
               this.petChinaName = "白虎将军";
               break;
            case "tigress4":
               this.petChinaName = "白虎战神";
               break;
            case "turtle1":
               this.petChinaName = "龟布";
               break;
            case "turtle2":
               this.petChinaName = "墨玄龟";
               break;
            case "turtle3":
               this.petChinaName = "玄武将军";
               break;
            case "turtle4":
               this.petChinaName = "玄武大帝";
               break;
            case "phoenix1":
               this.petChinaName = "雀蛋";
               break;
            case "phoenix2":
               this.petChinaName = "炎皇雀";
               break;
            case "phoenix3":
               this.petChinaName = "朱雀将军";
               break;
            case "phoenix4":
               this.petChinaName = "朱雀女皇";
               break;
            case "dragon1":
               this.petChinaName = "龙仔";
               break;
            case "dragon2":
               this.petChinaName = "绿英龙";
               break;
            case "dragon3":
               this.petChinaName = "青龙将军";
               break;
            case "dragon4":
               this.petChinaName = "青龙妖圣";
               break;
            case "rabbit1":
               this.petChinaName = "月兔";
               break;
            case "rabbit2":
               this.petChinaName = "疾风兔";
               break;
            case "rabbit3":
               this.petChinaName = "寒冰玉兔";
               break;
            case "rabbit4":
               this.petChinaName = "冰霜月神";
               break;
            case "nian1":
               this.petChinaName = "小年兽";
               break;
            case "nian2":
               this.petChinaName = "小年兽";
               break;
            case "nian3":
               this.petChinaName = "小年兽";
               break;
            case "nian4":
               this.petChinaName = "年兽";
               break;
            case "nian5":
               this.petChinaName = "大年兽";
               break;
            case "mouse1":
               this.petChinaName = "子鼠元帅";
               break;
            case "mouse2":
               this.petChinaName = "子鼠元帅";
               break;
            case "mouse3":
               this.petChinaName = "子鼠元帅";
               break;
            case "mouse4":
               this.petChinaName = "子鼠大元帅";
               break;
            case "neat1":
               this.petChinaName = "丑牛元帅";
               break;
            case "neat2":
               this.petChinaName = "丑牛元帅";
               break;
            case "neat3":
               this.petChinaName = "丑牛元帅";
               break;
            case "neat4":
               this.petChinaName = "丑牛大元帅";
               break;
            case "roomhorse1":
               this.petChinaName = "炎马";
               break;
            case "roomhorse2":
               this.petChinaName = "炎马";
               break;
            case "roomhorse3":
               this.petChinaName = "炎马";
               break;
            case "roomhorse4":
               this.petChinaName = "烈迦";
               break;
            case "terribletiger1":
               this.petChinaName = "寅虎元帅";
               break;
            case "terribletiger2":
               this.petChinaName = "寅虎元帅";
               break;
            case "terribletiger3":
               this.petChinaName = "寅虎元帅";
               break;
            case "terribletiger4":
               this.petChinaName = "寅虎大元帅";
         }
      }
      
      public function transPetChinaSkillName(_name:String) : String
      {
         switch(_name)
         {
            case "tsml":
               return "天生蛮力";
            case "zrsh":
               return "自然守护";
            case "smzf":
               return "生命祝福";
            case "mfby":
               return "魔法庇佑";
            case "qlfj":
               return "强力反击";
            case "sxkb":
               return "嗜血狂暴";
            case "fsnl":
               return "法术能量";
            case "smjc":
               return "生命加成";
            case "mfjc":
               return "魔法加成";
            case "gjjc":
               return "攻击加成";
            case "fyjc":
               return "防御加成";
            case "xj":
               return "献祭";
            case "lj":
               return "连击";
            case "lyq":
               return "烈焰拳";
            case "jgaoyi":
               return "金刚奥义";
            case "sp":
               return "水泡";
            case "bd":
               return "冰冻";
            case "bz":
               return "冰锥";
            case "tmaoyi":
               return "天马奥义";
            case "pms":
               return "魔破击";
            case "ss":
               return "瞬闪";
            case "kmsk":
               return "狂魔闪空";
            case "hy":
               return "虎牙";
            case "sxhz":
               return "嗜血虎爪";
            case "hsqj":
               return "横扫千军";
            case "bhaoyi":
               return "白虎奥义";
            case "sld":
               return "水疗盾";
            case "txlj":
               return "同心链接";
            case "sybh":
               return "水湮八荒";
            case "xwaoyi":
               return "玄武奥义";
            case "np":
               return "涅磐";
            case "bshn":
               return "不死火鸟";
            case "dhly":
               return "地火燎原";
            case "zqaoyi":
               return "朱雀奥义";
            case "fs":
               return "分身";
            case "sdcc":
               return "闪电冲刺";
            case "ltwj":
               return "雷霆万钧";
            case "qlaoyi":
               return "青龙奥义";
            case "yg":
               return "月光";
            case "jf":
               return "疾风";
            case "bs":
               return "冰陨";
            case "ysaoyi":
               return "月神奥义";
            case "qxyl":
               return "七星陨落";
            case "bhjm":
               return "八荒俱灭";
            case "jhgy":
               return "九魂归元";
            case "sc":
               return "鼠窜";
            case "hxfb":
               return "回旋飞镖";
            case "zsaoyi":
               return "子鼠奥义";
            case "mncz":
               return "蛮牛冲撞";
            case "mljt":
               return "蛮力践踏";
            case "cnaoyi":
               return "丑牛奥义";
            case "hybt":
               return "火焰奔腾";
            case "hhjt":
               return "火花践踏";
            case "hx":
               return "虎啸";
            case "mhxs":
               return "猛虎下山";
            case "yhaoyi":
               return "寅虎奥义";
            default:
               return "";
         }
      }
      
      private function getSkillSaveString() : String
      {
         var i:* = 0;
         var slen:uint = this.skill.length;
         var str:String = "";
         for(i = uint(0); i < slen; )
         {
            str += this.skill[i].sname;
            if(i != slen - 1)
            {
               str += "~";
            }
            i++;
         }
         return str;
      }
      
      private function setSkillSaveString(data:String) : void
      {
         var ary:* = null;
         var alen:* = 0;
         var aslen:int = 0;
         var i:* = 0;
         var skillobj:* = null;
         var sit:int = 0;
         this.skill = [];
         if(data != "")
         {
            ary = data.split("~");
            alen = uint(ary.length);
            for(i = uint(0); i < alen; )
            {
               skillobj = {
                  "sname":ary[i],
                  "sinfo":getIntroByName(ary[i])
               };
               this.skill.push(skillobj);
               sit = this.allSkill.indexOf(ary[i]);
               if(sit != -1)
               {
                  this.allSkill.splice(sit,1);
               }
               i++;
            }
         }
         this.addSpecialSkill();
      }
      
      public function getEquipSaveString() : String
      {
         var returnString:String = "";
         if(this._petEquip)
         {
            for each(var petEquip in this._petEquip.equipArray)
            {
               returnString += petEquip.getEquipSaveObj();
               returnString += ";";
            }
         }
         return returnString;
      }
      
      public function getSaveString() : String
      {
         this.deletePassiveWhenUpdata();
         var equipArray:Array = this.getEquipArray();
         if(this.isFight && this.isThisPetAliveInFight() && GMain.getInstance().curState == "gameStarted")
         {
            this.callPetToRefreshEquip([]);
         }
         else
         {
            this.refreshEquip([]);
         }
         var saveStr:String = this.petName + "|" + this.getHp() + "|" + this.getSHp() + "|" + this.getMp() + "|" + this.getSMp() + "|" + this.getLevel() + "|" + this.getCurExper() + "|" + this.getAtk() + "|" + this.getDef() + "|" + this.gethpQuality(true) + "|" + this.getmpQuality(true) + "|" + this.getatkQuality(true) + "|" + this.getdefQuality(true) + "|" + this.getlifetime() + "|" + this.getquality() + "|" + this.getperception(true) + "|" + this.gettechnique(true) + "|" + this.getwarpower(true) + "|" + this.isFight + "|" + this.getSkillSaveString() + "|" + this.gethpExp() + "|" + this.getmpExp() + "|" + this.getatkExp() + "|" + this.getdefExp() + "|" + this.getpotential() + "|" + this.getperceptionadd() + "|" + this.getwarpoweradd() + "|" + this.gettechniqueadd() + "|" + this.getperceptionprogress() + "|" + this.getwarpowerprogress() + "|" + this.gettechniqueprogress() + "|" + this.getpotentiallimit();
         if(this.isFight && this.isThisPetAliveInFight() && GMain.getInstance().curState == "gameStarted")
         {
            this.callPetToRefreshEquip(equipArray);
         }
         else
         {
            this.refreshEquip(equipArray);
         }
         saveStr += "&" + this.getEquipSaveString();
         this.addPassiveAfterUpdata();
         return saveStr;
      }
      
      private function isThisPetAliveInFight() : Boolean
      {
         var pi:* = null;
         for each(var bh in gc.getPlayerArray())
         {
            pi = bh.getPet();
            if(pi)
            {
               if(pi.petInfo == this)
               {
                  return true;
               }
            }
         }
         return false;
      }
      
      public function setSaveString(data:String) : void
      {
         var equipArray:* = null;
         var petEquip:* = null;
         var bigType:Array = data.split("&");
         var ary:Array = (bigType[0] as String).split("|");
         this.petName = ary[0];
         if(this.petName == "nea1")
         {
            this.petName = "neat1";
         }
         if(this.petName.indexOf("dragon") != -1)
         {
            trace("setsave--:data:" + data);
         }
         this.setSHp(int(ary[2]));
         this.setHp(this.getSHp());
         this.setSMp(int(ary[4]));
         this.setMp(this.getSMp());
         this.setLevel(int(ary[5]));
         this.setCurExper(int(ary[6]));
         this.setAtk(int(ary[7]));
         this.setDef(int(ary[8]));
         this.sethpQuality(int(ary[9]));
         this.setmpQuality(int(ary[10]));
         this.setatkQuality(int(ary[11]));
         this.setdefQuality(int(ary[12]));
         this.setlifetime(int(ary[13]));
         this.setquality(int(ary[14]));
         this.setperception(int(ary[15]));
         this.settechnique(int(ary[16]));
         this.setwarpower(int(ary[17]));
         this.isFight = int(ary[18]);
         this.setSkillSaveString(ary[19]);
         if(ary[20] != undefined)
         {
            this.sethpExp(int(ary[20]));
            if(this.gethpExp() > this._anti.two_hundred_fifty)
            {
               this.sethpExp(this._anti.two_hundred_fifty);
            }
         }
         if(ary[21] != undefined)
         {
            this.setmpExp(int(ary[21]));
            if(this.gethpExp() + this.getmpExp() > this._anti.two_hundred_fifty)
            {
               this.setmpExp(this._anti.two_hundred_fifty - this.gethpExp());
            }
         }
         if(ary[22] != undefined)
         {
            this.setatkExp(int(ary[22]));
            if(this.gethpExp() + this.getmpExp() + this.getatkExp() > this._anti.two_hundred_fifty)
            {
               this.setatkExp(this._anti.two_hundred_fifty - (this.gethpExp() + this.getmpExp()));
            }
         }
         if(ary[23] != undefined)
         {
            this.setdefExp(int(ary[23]));
            if(this.gethpExp() + this.getmpExp() + this.getatkExp() + this.getdefExp() > this._anti.two_hundred_fifty)
            {
               this.setdefExp(this._anti.two_hundred_fifty - (this.gethpExp() + this.getmpExp() + this.getatkExp()));
            }
         }
         if(ary[24] != undefined)
         {
            this.setpotential(int(ary[24]));
         }
         if(ary[25] != undefined)
         {
            this.setperceptionadd(int(ary[25]));
         }
         if(ary[26] != undefined)
         {
            this.setwarpoweradd(int(ary[26]));
         }
         if(ary[27] != undefined)
         {
            this.settechniqueadd(int(ary[27]));
         }
         if(ary[28] != undefined)
         {
            this.setperceptionprogress(int(ary[28]));
         }
         if(ary[29] != undefined)
         {
            this.setwarpowerprogress(int(ary[29]));
         }
         if(ary[30] != undefined)
         {
            this.settechniqueprogress(int(ary[30]));
         }
         if(ary[31] != undefined)
         {
            this.setpotentiallimit(int(ary[31]));
         }
         this.transPetChinaName();
         this.checkLevel();
         if(bigType.length > 1)
         {
            equipArray = [];
            ary = (bigType[1] as String).split(";");
            for each(var saveString in ary)
            {
               if(saveString != "")
               {
                  petEquip = new PetEquipObj();
                  petEquip.setEquipSaveObj(saveString);
                  petEquip.setPetInfo(this);
                  petEquip.checkDataAbnormal(gc.dataXml.petequip.pequip.(@fillname == petEquip.getFillName()));
                  equipArray.push(petEquip);
               }
            }
            this.refreshEquip(equipArray);
         }
      }
      
      private function checkPetBaseProperty() : void
      {
         this._anti.liubai = 1000;
         this._anti.yibaisanshisan = 133;
         this._anti.lingdianlingba = 0.08;
         this._anti.erbaiwu = 800;
         this._anti.yibailingliu = 106;
         this._anti.lingdianlingyiwu = 0.015;
         this._anti.sanshier = 60;
         this._anti.ershiyi = 21;
         this._anti.shi = 10;
         this._anti.qi = 7;
         this._anti.lingdianlingyi = 0.01;
         var maxHpByLevel:int = Math.ceil(this._anti.liubai + (this.getLevel() - 1) * this.gethpQuality() * this._anti.lingdianlingba);
         var maxMpByLevel:int = Math.ceil(this._anti.erbaiwu + (this.getLevel() - 1) * this.getmpQuality() * this._anti.lingdianlingba);
         var maxAtkByLevel:int = Math.ceil(this._anti.sanshier + (this.getLevel() - 1) * this.getatkQuality() * this._anti.lingdianlingyiwu);
         var maxDefByLevel:int = Math.ceil(this._anti.shi + (this.getLevel() - 1) * this.getdefQuality() * this._anti.lingdianlingyi);
         if(this.getSHp() > maxHpByLevel)
         {
            this.setSHp(maxHpByLevel);
            this.setHp(this.getSHp());
         }
         if(this.getSMp() > maxMpByLevel)
         {
            this.setSMp(maxMpByLevel);
            this.setMp(this.getSMp());
         }
         if(this.getAtk() > maxAtkByLevel)
         {
            this.setAtk(maxAtkByLevel);
         }
         if(this.getDef() > maxDefByLevel)
         {
            this.setDef(maxDefByLevel);
         }
      }
      
      public function setHp(v:int) : void
      {
         this._anti.hp = v;
      }
      
      public function setSHp(v:int) : void
      {
         this._anti.shp = v;
      }
      
      public function setLevel(v:int) : void
      {
         this._anti.level = v;
      }
      
      public function setCurExper(v:int) : void
      {
         if(this.getLevel() == gc.getTotalTopLevel())
         {
            this._anti.curExper = 0;
            return;
         }
         this._anti.curExper = v;
         this.petUpdate();
      }
      
      public function setMp(v:int) : void
      {
         this._anti.mp = v;
      }
      
      public function setSMp(v:int) : void
      {
         this._anti.smp = v;
      }
      
      public function setDef(v:int) : void
      {
         this._anti.def = v;
      }
      
      public function setAtk(v:int) : void
      {
         this._anti.atk = v;
      }
      
      public function sethpQuality(v:int) : void
      {
         this._anti.hpQuality = v;
      }
      
      public function sethpExp(v:int) : void
      {
         this._anti.hpExp = v;
      }
      
      public function setmpQuality(v:int) : void
      {
         this._anti.mpQuality = v;
      }
      
      public function setmpExp(v:int) : void
      {
         this._anti.mpExp = v;
      }
      
      public function setatkQuality(v:int) : void
      {
         this._anti.atkQuality = v;
      }
      
      public function setatkExp(v:int) : void
      {
         this._anti.atkExp = v;
      }
      
      public function setdefQuality(v:int) : void
      {
         this._anti.defQuality = v;
      }
      
      public function setdefExp(v:int) : void
      {
         this._anti.defExp = v;
      }
      
      public function setlifetime(v:int) : void
      {
         this._anti.lifetime = v;
      }
      
      public function setquality(v:uint) : void
      {
         this._anti.quality = v;
      }
      
      public function setperception(v:uint) : void
      {
         this._anti.perception = v;
      }
      
      public function settechnique(v:uint) : void
      {
         this._anti.technique = v;
      }
      
      public function setwarpower(v:uint) : void
      {
         this._anti.warpower = v;
      }
      
      public function getCurExper() : int
      {
         return this._anti.curExper;
      }
      
      public function getLevel() : int
      {
         return this._anti.level;
      }
      
      public function getHp() : int
      {
         if(this.gethpQuality(true) > 2000)
         {
            return 1;
         }
         return this._anti.hp;
      }
      
      public function getSHp() : uint
      {
         if(this.gethpQuality(true) > 2000)
         {
            return 1;
         }
         return this._anti.shp;
      }
      
      public function getMp() : int
      {
         if(this.getmpQuality(true) > 2000)
         {
            return 1;
         }
         return this._anti.mp;
      }
      
      public function getSMp() : int
      {
         if(this.getmpQuality(true) > 2000)
         {
            return 1;
         }
         return this._anti.smp;
      }
      
      public function getDef() : int
      {
         if(this.getdefQuality(true) > 2000)
         {
            return 1;
         }
         return this._anti.def;
      }
      
      public function getAtk() : int
      {
         if(this.getatkQuality(true) > 2000)
         {
            return 1;
         }
         return this._anti.atk;
      }
      
      public function setEHp(v:int) : void
      {
         this._anti.ehp = v;
      }
      
      public function getEHp() : int
      {
         return this._anti.ehp;
      }
      
      public function setEMp(v:int) : void
      {
         this._anti.emp = v;
      }
      
      public function getEMp() : int
      {
         return this._anti.emp;
      }
      
      public function setMiss(v:Number) : void
      {
         this._anti.miss = v;
      }
      
      public function getMiss() : Number
      {
         return this._anti.miss;
      }
      
      public function setMDef(v:Number) : void
      {
         this._anti.mDef = v;
      }
      
      public function getMDef() : Number
      {
         return this._anti.mDef;
      }
      
      public function setCrit(v:Number) : void
      {
         this._anti.crit = v;
      }
      
      public function getCrit() : Number
      {
         return this._anti.crit;
      }
      
      public function setMoveSpeed(v:Number) : void
      {
         this._anti.moveSpeed = v;
      }
      
      public function getMoveSpeed() : Number
      {
         return this._anti.moveSpeed;
      }
      
      public function setEatBlood(v:Number) : void
      {
         this._anti.eatBlood = v;
      }
      
      public function getEatBlood() : Number
      {
         return this._anti.eatBlood;
      }
      
      public function gethpQuality(isbase:Boolean = false) : int
      {
         if(isbase)
         {
            return this._anti.hpQuality;
         }
         return this._anti.hpQuality + this._anti.hpExp;
      }
      
      public function gethpExp() : int
      {
         return this._anti.hpExp;
      }
      
      public function getmpQuality(isbase:Boolean = false) : int
      {
         if(isbase)
         {
            return this._anti.mpQuality;
         }
         return this._anti.mpQuality + this._anti.mpExp;
      }
      
      public function getmpExp() : int
      {
         return this._anti.mpExp;
      }
      
      public function getatkQuality(isbase:Boolean = false) : int
      {
         if(isbase)
         {
            return this._anti.atkQuality;
         }
         return this._anti.atkQuality + this._anti.atkExp;
      }
      
      public function getatkExp() : int
      {
         return this._anti.atkExp;
      }
      
      public function getdefQuality(isbase:Boolean = false) : int
      {
         if(isbase)
         {
            return this._anti.defQuality;
         }
         return this._anti.defQuality + this._anti.defExp;
      }
      
      public function getdefExp() : int
      {
         return this._anti.defExp;
      }
      
      public function getlifetime() : int
      {
         if(this._anti.lifetime > 100)
         {
            return 100;
         }
         return this._anti.lifetime;
      }
      
      public function getquality() : int
      {
         return this._anti.quality;
      }
      
      public function getperception(isbase:Boolean = false) : int
      {
         if(isbase)
         {
            if(this._anti.perception > 8)
            {
               return 5;
            }
            return this._anti.perception;
         }
         return this._anti.perception + this._anti.perceptionadd;
      }
      
      public function gettechnique(isbase:Boolean = false) : int
      {
         if(isbase)
         {
            if(this._anti.technique > 8)
            {
               return 4;
            }
            return this._anti.technique;
         }
         return this._anti.technique + this._anti.techniqueadd;
      }
      
      public function getwarpower(isbase:Boolean = false) : int
      {
         if(isbase)
         {
            if(this._anti.warpower > 8)
            {
               return 4;
            }
            return this._anti.warpower;
         }
         return this._anti.warpower + this._anti.warpoweradd;
      }
      
      public function setpotential(v:uint) : void
      {
         this._anti.potential = v;
      }
      
      public function getpotential() : uint
      {
         return this._anti.potential;
      }
      
      public function setperceptionadd(v:uint) : void
      {
         this._anti.perceptionadd = v;
      }
      
      public function getperceptionadd() : uint
      {
         return this._anti.perceptionadd;
      }
      
      public function setwarpoweradd(v:uint) : void
      {
         this._anti.warpoweradd = v;
      }
      
      public function getwarpoweradd() : uint
      {
         return this._anti.warpoweradd;
      }
      
      public function settechniqueadd(v:uint) : void
      {
         this._anti.techniqueadd = v;
      }
      
      public function gettechniqueadd() : uint
      {
         return this._anti.techniqueadd;
      }
      
      public function setperceptionprogress(v:uint) : void
      {
         this._anti.perceptionprogress = v;
      }
      
      public function getperceptionprogress() : uint
      {
         return this._anti.perceptionprogress;
      }
      
      public function setwarpowerprogress(v:uint) : void
      {
         this._anti.warpowerprogress = v;
      }
      
      public function getwarpowerprogress() : uint
      {
         return this._anti.warpowerprogress;
      }
      
      public function settechniqueprogress(v:uint) : void
      {
         this._anti.techniqueprogress = v;
      }
      
      public function gettechniqueprogress() : uint
      {
         return this._anti.techniqueprogress;
      }
      
      public function setpotentiallimit(v:uint) : void
      {
         this._anti.potentiallimit = v;
      }
      
      public function getpotentiallimit() : uint
      {
         return this._anti.potentiallimit;
      }
      
      public function setDoWhenLevelUp(f:Function) : void
      {
         this.doWhenLevelUp = f;
      }
      
      public function setDoWhenChangeState(f:Function) : void
      {
         this.doWhenChangeState = f;
      }
      
      private function getDeCodeValue(v:Number) : int
      {
         return v * 10 + 5;
      }
      
      private function enCodeValue(v:int) : Number
      {
         return (v - 5) / 10;
      }
      
      public function checkDataAbnormal(xmllist:XMLList) : void
      {
         if(xmllist == null || xmllist.length() <= 0)
         {
            return;
         }
         if(xmllist.hpquality != undefined)
         {
            if(this.gethpQuality(true) > int(xmllist.hpquality) + this._anti.ten)
            {
               this.sethpQuality(int(xmllist.hpquality));
            }
         }
         if(xmllist.mpquality != undefined)
         {
            if(this.getmpQuality(true) > int(xmllist.mpquality) + this._anti.ten)
            {
               this.setmpQuality(int(xmllist.mpquality));
            }
         }
         if(xmllist.atkquality != undefined)
         {
            if(this.getatkQuality(true) > int(xmllist.atkquality) + this._anti.ten)
            {
               this.setatkQuality(int(xmllist.atkquality));
            }
         }
         if(xmllist.defquality != undefined)
         {
            if(this.getdefQuality(true) > int(xmllist.defquality) + this._anti.ten)
            {
               this.setdefQuality(int(xmllist.defquality));
            }
         }
         if(xmllist.perception != undefined)
         {
            if(this.getperception(true) > int(xmllist.perception))
            {
               this.setperception(int(xmllist.perception));
            }
         }
         if(xmllist.technique != undefined)
         {
            if(this.gettechnique(true) > int(xmllist.technique))
            {
               this.settechnique(int(xmllist.technique));
            }
         }
         if(xmllist.warpower != undefined)
         {
            if(this.getwarpower(true) > int(xmllist.warpower))
            {
               this.setwarpower(int(xmllist.warpower));
            }
         }
         if(xmllist.perceptionall != undefined)
         {
            if(this.getperception(true) + this.getperceptionadd() > int(xmllist.perceptionall))
            {
               this.setperceptionadd(int(xmllist.perceptionall) - this.getperception(true));
            }
         }
         if(xmllist.warpowerall != undefined)
         {
            if(this.getwarpower(true) + this.getwarpoweradd() > int(xmllist.warpowerall))
            {
               this.setwarpoweradd(int(xmllist.warpoweradd) - this.getwarpower(true));
            }
         }
         if(xmllist.techniqueall != undefined)
         {
            if(this.gettechnique(true) + this.gettechniqueadd() > int(xmllist.techniqueall))
            {
               this.settechniqueadd(int(xmllist.techniqueall) - this.gettechnique(true));
            }
         }
         var equipArray:Array = this.getEquipArray();
         if(equipArray.length > 0)
         {
            this.refreshEquip([]);
         }
         if(equipArray.length > 0)
         {
            this.refreshEquip(equipArray);
         }
         this.addPassiveAfterUpdata();
      }
      
      public function get isFight() : uint
      {
         return _isFight;
      }
      
      public function set isFight(value:uint) : void
      {
         _isFight = value;
         if(value == 1)
         {
            gc.petFormation.addPropertyToPetInfo(this);
         }
         else
         {
            gc.petFormation.removePropertyToPetInfo(this);
         }
      }
   }
}
