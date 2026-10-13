package my
{
   public class MyEquipObj
   {
       
      
      public var showid:uint = 1;
      
      public var ename:String = "";
      
      public var fillName:String = "";
      
      public var type:String = "";
      
      public var user:String = "";
      
      public var quality:String = "";
      
      public var color;
      
      public var ehp:int;
      
      public var emp:int;
      
      public var eatt:int;
      
      public var edef:int;
      
      public var emiss:Number;
      
      public var ecrit:Number;
      
      public var eahp:int;
      
      public var eamp:int;
      
      public var aStrengthen:Object;
      
      public var etype:String;
      
      public var instruction:String = "";
      
      public var isStrengthen:Boolean = false;
      
      public var value:uint;
      
      private var saveObj:Object;
      
      private var saveString:String = "";
      
      public function MyEquipObj(param1:uint = 0, param2:String = "", param3:String = "", param4:String = "", param5:String = "", param6:String = "", param7:* = null, param8:int = 0, param9:int = 0, param10:int = 0, param11:int = 0, param12:Number = 0.0, param13:Number = 0.0, param14:int = 0, param15:int = 0, param16:Object = null, param17:String = "")
      {
         this.saveObj = {};
         super();
         this.showid = param1;
         this.ename = param2;
         this.fillName = param3;
         this.type = param4;
         this.user = param5;
         this.quality = param6;
         this.color = param7;
         this.ehp = param8;
         this.emp = param9;
         this.eatt = param10;
         this.edef = param11;
         this.ecrit = param12;
         this.emiss = param13;
         this.eahp = param14;
         this.eamp = param15;
         this.aStrengthen = param16;
         this.instruction = param17;
         this.trans(param4);
         this.transValue();
      }
      
      private function strengthenEquip() : void
      {
      }
      
      public function setInstruction(param1:*) : void
      {
         if(this.instruction == "")
         {
            if(this.fillName == "dhqf")
            {
               this.instruction = "于" + param1 + "击败龟丞相获得此法宝";
            }
            else if(this.fillName == "jgz")
            {
               this.instruction = "于" + param1 + "击败牛魔王获得此法宝";
            }
         }
      }
      
      private function trans(param1:String) : void
      {
         switch(param1)
         {
            case "zbfj":
               this.etype = "防具";
               break;
            case "zbwq":
               this.etype = "武器";
               break;
            case "zbsp":
               this.etype = "饰 品";
               break;
            case "zbfb":
               this.etype = "法 宝";
         }
      }
      
      private function transValue() : void
      {
         switch(this.quality)
         {
            case "粗 糙":
               this.value = 10;
               break;
            case "普 通":
               this.value = 20;
               break;
            case "优 秀":
               this.value = 40;
               break;
            case "精 良":
               this.value = 80;
               break;
            case "史 诗":
               this.value = 160;
               break;
            case "传 说":
               this.value = 320;
         }
      }
      
      public function getEquipSaveObj() : String
      {
         this.saveString = this.showid + "|" + this.ename + "|" + this.fillName + "|" + this.type + "|" + this.user + "|" + this.quality + "|" + this.color + "|" + this.ehp + "|" + this.emp + "|" + this.eatt + "|" + this.edef + "|" + this.emiss + "|" + this.ecrit + "|" + this.eahp + "|" + this.eamp + "|" + this.etype + "|" + this.instruction + "|" + this.isStrengthen + "|" + this.value;
         return this.saveString;
      }
      
      public function setEquipSaveObj(param1:String) : void
      {
         var _loc2_:Array = param1.split("|");
         this.showid = _loc2_[0];
         this.ename = _loc2_[1];
         this.fillName = _loc2_[2];
         this.type = _loc2_[3];
         this.user = _loc2_[4];
         this.quality = _loc2_[5];
         this.color = _loc2_[6];
         this.ehp = _loc2_[7];
         this.emp = _loc2_[8];
         this.eatt = _loc2_[9];
         this.edef = _loc2_[10];
         this.emiss = _loc2_[11];
         this.ecrit = _loc2_[12];
         this.eahp = _loc2_[13];
         this.eamp = _loc2_[14];
         this.etype = _loc2_[15];
         this.instruction = _loc2_[16];
         this.isStrengthen = _loc2_[17];
         this.value = _loc2_[18];
      }
      
      public function setOldEquipSaveObj(param1:Object) : void
      {
         this.showid = param1.showid;
         this.ename = param1.ename;
         this.fillName = param1.fillName;
         this.type = param1.type;
         this.user = param1.user;
         this.quality = param1.quality;
         this.color = param1.color;
         this.ehp = param1.ehp;
         this.emp = param1.emp;
         this.eatt = param1.eatt;
         this.edef = param1.edef;
         this.emiss = param1.emiss;
         this.ecrit = param1.ecrit;
         this.eahp = param1.eahp;
         this.eamp = param1.eamp;
         this.aStrengthen = param1.aStrengthen;
         this.etype = param1.etype;
         this.instruction = param1.instruction;
         this.isStrengthen = param1.isStrengthen;
         this.value = param1.value;
      }
   }
}
