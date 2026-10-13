package export.rank
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import my.MyEquipObj;
   
   public class RankUser
   {
       
      
      private var _anti:Antiwear;
      
      public var curEquipArray:Array;
      
      private var gc:Config;
      
      public function RankUser(s:String)
      {
         var curEquip:* = null;
         var curEquipArray:* = null;
         var eqArr:* = null;
         var equip:* = null;
         var wx:* = null;
         var wxObj:* = null;
         var skillString:* = null;
         var skillArray:* = null;
         var pillString:* = null;
         var pillArray:* = null;
         var pillHp:int = 0;
         _anti = new Antiwear(new binaryEncrypt());
         curEquipArray = [];
         super();
         gc = Config.getInstance();
         this.setRoleId(1);
         this.setLevel(1);
         this.setHp(0);
         this.setMp(0);
         this.setAtk(0);
         this.setDefense(0);
         this.setCrit(0);
         this.setMiss(0);
         this.setHx(0);
         this.setHl(0);
         this.setMagicDef(0);
         this.setEatblood(0);
         this.setGongXun(0);
         this.setRankDiff(0);
         this.setUserName("火星");
         this.setScore(0);
         this.setPillHp(0);
         this.setBeidongSkill("");
         var arr:Array = s.split("|");
         if(arr.length == 6)
         {
            this.setRoleId(arr[0]);
            this.setLevel(arr[1]);
            this.initPropertysByLevelAndRoleId();
            curEquip = arr[2];
            curEquipArray = curEquip.split("~");
            for each(var str in curEquipArray)
            {
               eqArr = str.split("=");
               if(eqArr.length >= 13)
               {
                  try
                  {
                     equip = gc.allEquip.findByName(eqArr[0]) as MyEquipObj;
                     equip.setstrengthValue(eqArr[1]);
                     equip.setehp(eqArr[2]);
                     equip.setemp(eqArr[3]);
                     equip.seteatt(eqArr[4]);
                     equip.setedef(eqArr[5]);
                     equip.setecrit(eqArr[6]);
                     equip.setemiss(eqArr[7]);
                     equip.seteahp(eqArr[8]);
                     equip.seteamp(eqArr[9]);
                     equip.setmagicdef(eqArr[10]);
                     equip.setELevel(eqArr[11]);
                     wx = eqArr[12];
                     wxObj = {};
                     if(wx.length == 5)
                     {
                        if(wx.charAt(0) == "1")
                        {
                           wxObj.jin = true;
                        }
                        if(wx.charAt(1) == "1")
                        {
                           wxObj.mu = true;
                        }
                        if(wx.charAt(2) == "1")
                        {
                           wxObj.shui = true;
                        }
                        if(wx.charAt(3) == "1")
                        {
                           wxObj.huo = true;
                        }
                        if(wx.charAt(4) == "1")
                        {
                           wxObj.tu = true;
                        }
                     }
                     equip.setWX(wxObj);
                     if(eqArr.length >= 14)
                     {
                        equip.setEupdata(eqArr[13]);
                     }
                     if(eqArr.length >= 15)
                     {
                        equip.setMutiLevel(eqArr[14]);
                     }
                     equip.strengthenEquip();
                     this.curEquipArray.push(equip);
                     this.setHp(this.getHp() + equip.getehp());
                     this.setMp(this.getMp() + equip.getemp());
                     this.setAtk(this.getAtk() + equip.geteatt());
                     this.setDefense(this.getDefense() + equip.getedef());
                     this.setCrit(this.getCrit() + equip.getecrit() * 100);
                     this.setMiss(this.getMiss() + equip.getemiss() * 100);
                     this.setHx(this.getHx() + equip.geteahp());
                     this.setHl(this.getHl() + equip.geteamp());
                     this.setMagicDef(this.getMagicDef() + equip.getmagicdef() * 100);
                  }
                  catch(e:*)
                  {
                     trace("RankUser-Throw Error!");
                  }
               }
            }
            if(this.getRoleId() == 1)
            {
               if(int(arr[3]) == 1)
               {
                  this.setCrit(this.getCrit() + 5);
                  this.setEatblood(this.getEatBlood() + 5);
               }
            }
            skillString = arr[4];
            this.setBeidongSkill(skillString);
            skillArray = skillString.split(",");
            this.addAllPassive(skillArray);
            pillString = arr[5];
            pillArray = pillString.split("_");
            pillHp = pillArray[0];
            this.setHp(this.getHp() + pillHp);
            this.setPillHp(pillHp);
         }
      }
      
      private function initPropertysByLevelAndRoleId() : void
      {
         if(this.getRoleId() == 1)
         {
            this.setHp(80 + 50 * (this.getLevel() - 1));
            this.setMp(50 + 20 * (this.getLevel() - 1));
            this.setDefense(2 + 2 * (this.getLevel() - 1));
            this.setAtk(10 + 5 * (this.getLevel() - 1));
         }
         else if(this.getRoleId() == 2)
         {
            this.setHp(50 + 20 * (this.getLevel() - 1));
            this.setMp(100 + 40 * (this.getLevel() - 1));
            this.setDefense(this.getLevel() - 1);
            this.setAtk(12 + 8 * (this.getLevel() - 1));
         }
         else if(this.getRoleId() == 3)
         {
            this.setHp(100 + 70 * (this.getLevel() - 1));
            this.setMp(35 + 15 * (this.getLevel() - 1));
            this.setDefense(4 + (this.getLevel() - 1));
            this.setAtk(20 + 6 * (this.getLevel() - 1));
         }
         else if(this.getRoleId() == 4)
         {
            this.setHp(70 + 30 * (this.getLevel() - 1));
            this.setMp(70 + 30 * (this.getLevel() - 1));
            this.setDefense(this.getLevel());
            this.setAtk(16 + 4 * (this.getLevel() - 1));
         }
      }
      
      private function addAllPassive(skillArray:Array) : void
      {
         var num:* = 0;
         var plen:uint = skillArray.length;
         while(plen-- > 0)
         {
            num = uint(skillArray[plen]);
            this.addPassive(plen,num);
         }
      }
      
      public function addPassive(_type:uint, _level:uint) : void
      {
         this.analyPassive(_type,_level);
      }
      
      private function analyPassive(_type:uint, _level:uint, i:int = 1) : void
      {
         var hpPassive:int = 0;
         var mpPassive:int = 0;
         var critPassive:int = 0;
         var selfhpPassive:int = 0;
         var selfmpPassive:int = 0;
         if(_level != 0)
         {
            switch(int(_type))
            {
               case 0:
                  hpPassive = (_level * 100 + 100) * i;
                  this.setHp(this.getHp() + hpPassive);
                  break;
               case 1:
                  mpPassive = (_level * 100 + 100) * i;
                  this.setMp(this.getMp() + mpPassive);
                  break;
               case 2:
                  critPassive = (_level * 1 + 1) * i;
                  this.setCrit(this.getCrit() + critPassive);
                  break;
               case 3:
                  selfhpPassive = (_level + 1) * i;
                  this.setHx(this.getHx() + selfhpPassive);
                  break;
               case 4:
                  selfmpPassive = (_level + 1) * i;
                  this.setHl(this.getHl() + selfmpPassive);
            }
         }
      }
      
      public function getRankObject() : Object
      {
         return this._anti.rankObject;
      }
      
      public function setBeidongSkill(incr:String) : void
      {
         this._anti.beidongSkill = incr;
      }
      
      public function getBeidongSkill() : String
      {
         return this._anti.beidongSkill;
      }
      
      public function setPillHp(incr:int) : void
      {
         this._anti.pillHp = incr;
      }
      
      public function getPillHp() : int
      {
         return this._anti.pillHp;
      }
      
      public function setScore(incr:int) : void
      {
         this._anti.score = incr;
      }
      
      public function getScore() : int
      {
         return this._anti.score;
      }
      
      private function setLevel(incr:int) : void
      {
         this._anti.level = incr;
      }
      
      public function getLevel() : int
      {
         return this._anti.level;
      }
      
      private function setRoleId(incr:int) : void
      {
         this._anti.roleId = incr;
      }
      
      public function getRoleId() : int
      {
         return this._anti.roleId;
      }
      
      private function setMagicDef(incr:int) : void
      {
         this._anti.magicDef = incr;
      }
      
      public function getMagicDef() : int
      {
         return this._anti.magicDef;
      }
      
      public function setGongXun(incr:int) : void
      {
         this._anti.gongXun = incr;
      }
      
      public function getGongXun() : int
      {
         return this._anti.gongXun;
      }
      
      private function setMp(eb:int) : void
      {
         this._anti.mp = eb;
      }
      
      public function getMp() : int
      {
         return this._anti.mp;
      }
      
      public function setUserName(incr:String) : void
      {
         this._anti.userName = incr;
      }
      
      public function getUserName() : String
      {
         return this._anti.userName;
      }
      
      private function setHp(eb:int) : void
      {
         this._anti.hp = eb;
      }
      
      public function getHp() : int
      {
         return this._anti.hp;
      }
      
      public function setRankDiff(eb:int) : void
      {
         this._anti.rankDiff = eb;
      }
      
      public function getRankDiff() : int
      {
         return this._anti.rankDiff;
      }
      
      private function setEatblood(eb:int) : void
      {
         this._anti.eatblood = eb;
      }
      
      public function getEatBlood() : int
      {
         return this._anti.eatblood;
      }
      
      private function setAtk(incr:int) : void
      {
         this._anti.atk = incr;
      }
      
      public function getAtk() : int
      {
         return this._anti.atk;
      }
      
      private function setDefense(incr:int) : void
      {
         this._anti.defense = incr;
      }
      
      public function getDefense() : int
      {
         return this._anti.defense;
      }
      
      private function setMiss(incr:int) : void
      {
         this._anti.miss = incr;
      }
      
      public function getMiss() : int
      {
         return this._anti.miss;
      }
      
      private function setCrit(incr:int) : void
      {
         this._anti.crit = incr;
      }
      
      public function getCrit() : int
      {
         return this._anti.crit;
      }
      
      private function setHl(hl:int) : void
      {
         this._anti.hl = hl;
      }
      
      public function getHl() : int
      {
         return this._anti.hl;
      }
      
      private function setHx(hx:int) : void
      {
         this._anti.hx = hx;
      }
      
      public function getHx() : int
      {
         return this._anti.hx;
      }
   }
}
