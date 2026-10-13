package my
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import petInfo.PetInfo;
   
   public class PetEquipObj
   {
       
      
      private var gc:Config;
      
      public var type:String;
      
      public var user:String;
      
      public var color;
      
      public var instruction:String;
      
      public var etype:String;
      
      private var _anti:Antiwear;
      
      private var petInfo:PetInfo;
      
      public function PetEquipObj(_showid:uint = 0, _ename:String = "", _fillName:String = "", _type:String = "", _user:String = "", _quality:String = "", _color:* = null, _ehp:int = 0, _emp:int = 0, _eatt:int = 0, _edef:int = 0, _ecrit:Number = 0.0, _emiss:Number = 0.0, _eahp:int = 0, _eamp:int = 0, _eatblood:Number = 0.0, _magicdef:Number = 0.0, _speed:Number = 0.0, _inst:String = "", stobj:Object = null)
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.__magicdef = -1;
         this._anti.__eamp = -1;
         this._anti.__eahp = -1;
         this._anti.__emiss = -1;
         this._anti.__ecrit = -1;
         this._anti.__edef = -1;
         this._anti.__eatt = -1;
         this._anti.__emp = -1;
         this._anti.__ehp = -1;
         this._anti.__eatblood = -1;
         this._anti.__speed = -1;
         this._anti.zero = 0;
         this._anti.one = 1;
         this._anti.two = 2;
         this._anti.three = 3;
         this._anti.four = 4;
         this._anti.five = 5;
         this._anti.six = 6;
         this._anti.seven = 7;
         this._anti.eigth = 8;
         this._anti.night = 9;
         this._anti.ten = 10;
         this._anti.one_hundred = 100;
         this._anti.two_hundred = 200;
         this._anti.three_hundred = 300;
         this.setShowId(_showid);
         this.setEname(_ename);
         this.setFillName(_fillName);
         this.type = _type;
         this.user = _user;
         this._anti.quality = _quality;
         this.color = _color;
         this.setehp(_ehp);
         this.setemp(_emp);
         this.seteatt(_eatt);
         this.setedef(_edef);
         this.setecrit(_ecrit);
         this.setemiss(_emiss);
         this.seteahp(_eahp);
         this.seteamp(_eamp);
         this.setmagicdef(_magicdef);
         this.seteatblood(_eatblood);
         this.setspeed(_speed);
         if(stobj != null)
         {
            this._anti.strengthObj = stobj;
         }
         else
         {
            this._anti.strengthObj = {};
         }
         this.setStrengthValue(0);
         this.instruction = _inst;
         this.trans(_type);
         this.transValue();
      }
      
      public function setPetInfo(_petInfo:PetInfo) : void
      {
         this.petInfo = _petInfo;
      }
      
      public function getPetInfo() : PetInfo
      {
         return this.petInfo;
      }
      
      private function trans(s:String) : void
      {
         switch(s)
         {
            case "zbmz":
               this.etype = "帽子";
               break;
            case "zbyf":
               this.etype = "衣服";
               break;
            case "zbst":
               this.etype = "手套";
               break;
            case "zbxz":
               this.etype = "鞋子";
               break;
            case "zbjn":
               this.etype = "精灵";
         }
      }
      
      private function transValue() : void
      {
         switch(this._anti.quality)
         {
            case "粗 糙":
               this.setValue(10);
               break;
            case "普 通":
               this.setValue(20);
               break;
            case "优 秀":
               this.setValue(40);
               break;
            case "精 良":
               this.setValue(80);
               break;
            case "史 诗":
               this.setValue(160);
               break;
            case "传 说":
               this.setValue(320);
               break;
            case "邪 灵":
               this.setValue(640);
               break;
            case "魂 器":
               this.setValue(1280);
               break;
            default:
               this.setValue(0);
         }
      }
      
      public function setValue(v:int) : void
      {
         this._anti.value = v;
      }
      
      public function getValue() : int
      {
         return this._anti.value;
      }
      
      public function setShowId(value:uint) : void
      {
         this._anti.showid = value;
      }
      
      public function getShowId() : uint
      {
         return this._anti.showid;
      }
      
      public function setEname(value:String) : void
      {
         this._anti.ename = value;
      }
      
      public function getEname() : String
      {
         return this._anti.ename;
      }
      
      public function ename() : String
      {
         return this._anti.ename;
      }
      
      public function setFillName(fn:String) : void
      {
         this._anti.fillName = fn;
      }
      
      public function getFillName() : String
      {
         return this._anti.fillName;
      }
      
      public function setehp(value:int) : void
      {
         this._anti.ehp = value;
      }
      
      public function getehp(isbase:Boolean = false) : int
      {
         if(this._anti.__ehp >= 0)
         {
            return this._anti.__ehp;
         }
         if(!isbase)
         {
            return this._anti.ehp + this.getShpValue();
         }
         return this._anti.ehp;
      }
      
      public function setemp(value:int) : void
      {
         this._anti.emp = value;
      }
      
      public function getemp(isbase:Boolean = false) : int
      {
         if(this._anti.__emp >= 0)
         {
            return this._anti.__emp;
         }
         if(!isbase)
         {
            return this._anti.emp + this.getSmpValue();
         }
         return this._anti.emp;
      }
      
      public function seteatt(value:int) : void
      {
         this._anti.eatt = value;
      }
      
      public function geteatt(isbase:Boolean = false) : int
      {
         if(this._anti.__eatt >= 0)
         {
            return this._anti.__eatt;
         }
         if(!isbase)
         {
            return this._anti.eatt + this.getSatkValue();
         }
         return this._anti.eatt;
      }
      
      public function setedef(value:int) : void
      {
         this._anti.edef = value;
      }
      
      public function getedef(isbase:Boolean = false) : int
      {
         if(this._anti.__edef >= 0)
         {
            return this._anti.__edef;
         }
         if(!isbase)
         {
            return this._anti.edef + this.getSdefValue();
         }
         return this._anti.edef;
      }
      
      public function setecrit(value:Number) : void
      {
         this._anti.ecrit = value;
      }
      
      public function getecrit() : Number
      {
         if(this._anti.__ecrit >= 0)
         {
            return this._anti.__ecrit;
         }
         return Number(Number(this._anti.ecrit).toFixed(2));
      }
      
      public function setemiss(value:Number) : void
      {
         this._anti.emiss = value;
      }
      
      public function getemiss() : Number
      {
         if(this._anti.__emiss >= 0)
         {
            return this._anti.__emiss;
         }
         return Number(Number(this._anti.emiss).toFixed(2));
      }
      
      public function seteahp(value:int) : void
      {
         this._anti.eahp = value;
      }
      
      public function geteahp() : int
      {
         if(this._anti.__eahp >= 0)
         {
            return this._anti.__eahp;
         }
         return this._anti.eahp;
      }
      
      public function seteamp(value:int) : void
      {
         this._anti.eamp = value;
      }
      
      public function geteamp() : int
      {
         if(this._anti.__eamp >= 0)
         {
            return this._anti.__eamp;
         }
         return this._anti.eamp;
      }
      
      public function setmagicdef(value:Number) : void
      {
         this._anti.magicdef = value;
      }
      
      public function getmagicdef() : Number
      {
         if(this._anti.__magicdef >= 0)
         {
            return this._anti.__magicdef;
         }
         return Number(Number(this._anti.magicdef).toFixed(2));
      }
      
      public function seteatblood(value:Number) : void
      {
         this._anti.eatblood = value;
      }
      
      public function geteatblood(isbase:Boolean = false) : Number
      {
         if(this._anti.__eatblood >= 0)
         {
            return this._anti.__eatblood;
         }
         if(!isbase)
         {
            return Number((Number(this._anti.eatblood + this.getSeatbloodValue())).toFixed(2));
         }
         return Number(Number(this._anti.eatblood).toFixed(2));
      }
      
      public function setspeed(value:Number) : void
      {
         this._anti.speed = value;
      }
      
      public function getspeed() : Number
      {
         if(this._anti.__speed >= 0)
         {
            return this._anti.__speed;
         }
         return Number(Number(this._anti.speed).toFixed(1));
      }
      
      public function setStrengthValue(value:uint) : void
      {
         this._anti.strengthval = value;
         this.setStrengthAttributeValue();
      }
      
      public function getStrengthValue() : int
      {
         return this._anti.strengthval;
      }
      
      public function getStrengthProgress() : int
      {
         if(this._anti.quality == "优 秀")
         {
            return int(this.getStrengthValue() - this.getStrengthLevel() * 10);
         }
         if(this._anti.quality == "精 良")
         {
            return int(this.getStrengthValue() - this.getStrengthLevel() * 20);
         }
         return int(this.getStrengthValue() - this.getStrengthLevel() * 40);
      }
      
      public function getStrengthLevel() : int
      {
         if(this._anti.quality == "优 秀")
         {
            return int(this.getStrengthValue() / 10);
         }
         if(this._anti.quality == "精 良")
         {
            return int(this.getStrengthValue() / 20);
         }
         return int(this.getStrengthValue() / 40);
      }
      
      public function getNextNeedValue() : int
      {
         if(this._anti.quality == "优 秀")
         {
            return this._anti.ten;
         }
         if(this._anti.quality == "精 良")
         {
            return this._anti.ten * this._anti.two;
         }
         return this._anti.ten * this._anti.four;
      }
      
      private function setStrengthAttributeValue() : void
      {
         if(this._anti.strengthObj.hp != undefined)
         {
            this.setShpValue(this.getStrengthLevel() * this._anti.strengthObj.hp);
         }
         else
         {
            this.setShpValue(0);
         }
         if(this._anti.strengthObj.mp != undefined)
         {
            this.setSmpValue(this.getStrengthLevel() * this._anti.strengthObj.mp);
         }
         else
         {
            this.setSmpValue(0);
         }
         if(this._anti.strengthObj.atk != undefined)
         {
            this.setSatkValue(this.getStrengthLevel() * this._anti.strengthObj.atk);
         }
         else
         {
            this.setSatkValue(0);
         }
         if(this._anti.strengthObj.def != undefined)
         {
            this.setSdefValue(this.getStrengthLevel() * this._anti.strengthObj.def);
         }
         else
         {
            this.setSdefValue(0);
         }
         if(this._anti.strengthObj.eatblood != undefined)
         {
            this.setSeatbloodValue(this.getStrengthLevel() * this._anti.strengthObj.eatblood);
         }
         else
         {
            this.setSeatbloodValue(0);
         }
      }
      
      public function getEquipSaveObj() : String
      {
         var saveString:String = "";
         return this.getFillName() + "|" + this._anti.ehp + "|" + this._anti.emp + "|" + this._anti.eatt + "|" + this._anti.edef + "|" + this._anti.emiss + "|" + this._anti.ecrit + "|" + this._anti.eahp + "|" + this._anti.eamp + "|" + this._anti.magicdef + "|" + this._anti.speed + "|" + this.getStrengthValue() + "|" + this._anti.eatblood;
      }
      
      public function setEquipSaveObj(data:*) : void
      {
         var getArray:Array = data.split("|");
         this.setFillName(getArray[0]);
         this.setehp(int(getArray[1]));
         this.setemp(int(getArray[2]));
         this.seteatt(int(getArray[3]));
         this.setedef(int(getArray[4]));
         this.setemiss(Number(getArray[5]));
         this.setecrit(Number(getArray[6]));
         this.seteahp(int(getArray[7]));
         this.seteamp(int(getArray[8]));
         this.setmagicdef(Number(getArray[9]));
         this.setspeed(Number(getArray[10]));
         if(getArray[12] != undefined)
         {
            if(getArray[12] == "NaN")
            {
               this.seteatblood(0);
            }
            else
            {
               this.seteatblood(Number(getArray[12]));
            }
         }
         var fillName:String = this.getFillName();
         var idx:int = fillName.indexOf("\n");
         while(idx != -1)
         {
            fillName = fillName.replace("\n","");
            idx = fillName.indexOf("\n");
         }
         idx = fillName.indexOf("\r");
         while(idx != -1)
         {
            fillName = fillName.replace("\r","");
            idx = fillName.indexOf("\r");
         }
         idx = fillName.indexOf("\r\n");
         while(idx != -1)
         {
            fillName = fillName.replace("\r\n","");
            idx = fillName.indexOf("\r\n");
         }
         this.setFillName(fillName);
         var tempEquip:PetEquipObj = gc.allEquip.findByName(fillName);
         if(!tempEquip)
         {
            throw new Error("没找到你的宠物装备！fillName:" + fillName);
         }
         this.setShowId(tempEquip.getShowId());
         this.setEname(tempEquip.getEname());
         this.type = tempEquip.type;
         this.user = tempEquip.user;
         this._anti.quality = tempEquip.quality;
         this.color = tempEquip.color;
         this._anti.strengthObj = tempEquip._anti.strengthObj;
         this.trans(this.type);
         this.transValue();
         if(getArray[11] != undefined)
         {
            this.setStrengthValue(int(getArray[11]));
         }
      }
      
      public function setShpValue(v:int) : void
      {
         this._anti.ShpValue = v;
      }
      
      public function getShpValue() : int
      {
         return this._anti.ShpValue;
      }
      
      public function setSmpValue(v:int) : void
      {
         this._anti.SmpValue = v;
      }
      
      public function getSmpValue() : int
      {
         return this._anti.SmpValue;
      }
      
      public function setSatkValue(v:int) : void
      {
         this._anti.SatkValue = v;
      }
      
      public function getSatkValue() : int
      {
         return this._anti.SatkValue;
      }
      
      public function setSdefValue(v:int) : void
      {
         this._anti.SdefValue = v;
      }
      
      public function getSdefValue() : int
      {
         return this._anti.SdefValue;
      }
      
      public function setSeatbloodValue(v:Number) : void
      {
         this._anti.SeatbloodValue = v;
      }
      
      public function getSeatbloodValue() : Number
      {
         return this._anti.SeatbloodValue;
      }
      
      public function checkDataAbnormal(xmllist:XMLList) : void
      {
         if(xmllist == null || xmllist.length() <= 0)
         {
            return;
         }
         if(xmllist.ehp != undefined)
         {
            if(this.getehp(true) > int(xmllist.ehp) + this._anti.ten)
            {
               this._anti.__ehp = 0;
            }
         }
         if(xmllist.emp != undefined)
         {
            if(this.getemp(true) > int(xmllist.emp) + this._anti.ten)
            {
               this._anti.__emp = 0;
            }
         }
         if(xmllist.eatt != undefined)
         {
            if(this.geteatt(true) > int(xmllist.eatt) + this._anti.ten)
            {
               this._anti.__eatt = 0;
            }
         }
         if(xmllist.edef != undefined)
         {
            if(this.getedef(true) > int(xmllist.edef) + this._anti.ten)
            {
               this._anti.__edef = 0;
            }
         }
         if(xmllist.ecrit != undefined)
         {
            if(this.getecrit() > Number(xmllist.ecrit))
            {
               this._anti.__ecrit = 0;
            }
         }
         if(xmllist.emiss != undefined)
         {
            if(this.getemiss() > Number(xmllist.emiss))
            {
               this._anti.__emiss = 0;
            }
         }
         if(xmllist.eahp != undefined)
         {
            if(this.geteahp() > int(xmllist.eahp))
            {
               this._anti.__eahp = 0;
            }
         }
         if(xmllist.eamp != undefined)
         {
            if(this.geteamp() > int(xmllist.eamp))
            {
               this._anti.__eamp = 0;
            }
         }
         if(xmllist.magicdef != undefined)
         {
            if(this.getmagicdef() > Number(xmllist.magicdef))
            {
               this._anti.__magicdef = 0;
            }
         }
         if(xmllist.speed != undefined)
         {
            if(this.getspeed() > Number(xmllist.speed))
            {
               this._anti.__speed = 0;
            }
         }
         if(xmllist.eatblood != undefined)
         {
            if(this.geteatblood(true) > Number(xmllist.eatblood))
            {
               this._anti.__eatblood = 0;
            }
         }
      }
      
      public function get quality() : String
      {
         return this._anti.quality;
      }
      
      public function set quality(value:String) : void
      {
         this._anti.quality = value;
      }
   }
}
