package petInfo
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import my.PetEquipObj;
   
   public class PetJNSuit
   {
      
      public static var SUIT_ADD_CRIT:uint = 256;
      
      public static var SUIT_ADD_EATBLOOD:uint = 512;
      
      public static var SUIT_ADD_ATK:uint = 768;
      
      public static var SUIT_ADD_MDEF:uint = 1024;
      
      public static var SUIT_ADD_HP:uint = 1280;
       
      
      private var _anti:Antiwear;
      
      public function PetJNSuit()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         _anti.suit_array = [["p_cylhjl"],["p_jlcylhjl"],["p_sscylhjl"],["p_cybxjl"],["p_jlcybxjl"],["p_sscybxjl"],["p_cynsjl"],["p_jlcynsjl"],["p_sscynsjl"],["p_cygsjl"],["p_jlcygsjl"],["p_sscygsjl"],["p_cykljl"],["p_jlcykljl"],["p_sscykljl"],["p_cyzsjl"],["p_jlcyzsjl"],["p_sscyzsjl"],["p_cycnjl"],["p_jlcycnjl"],["p_sscycnjl"],["p_cyymjl"],["p_jlcyymjl"],["p_sscyymjl"],["p_cyyhjl"],["p_jlcyyhjl"],["p_sscyyhjl"]];
         _anti.suit_cn_array = [["烈火精灵"],["烈火精灵"],["烈火精灵"],["冰雪精灵"],["冰雪精灵"],["冰雪精灵"],["年兽精灵"],["年兽精灵"],["年兽精灵"],["钢石精灵"],["钢石精灵"],["钢石精灵"],["狂雷精灵"],["狂雷精灵"],["狂雷精灵"],["子鼠精灵\n子鼠奥义"],["子鼠精灵\n子鼠奥义"],["子鼠精灵\n子鼠奥义"],["丑牛精灵\n丑牛奥义"],["丑牛精灵\n丑牛奥义"],["丑牛精灵\n丑牛奥义"],["炎马精灵"],["炎马精灵"],["炎马精灵"],["寅虎精灵\n寅虎奥义"],["寅虎精灵\n寅虎奥义"],["寅虎精灵\n寅虎奥义"]];
         _anti.effect = [[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":500
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":1000
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":2500
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":500
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":1000
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":2500
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":1000
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":2000
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":3000
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":500
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":1000
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":2500
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":500
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":1000
         }],[{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":2500
         }],[],[],[],[],[],[],[{
            "name":"攻击",
            "type":SUIT_ADD_ATK,
            "value":100
         }],[{
            "name":"攻击",
            "type":SUIT_ADD_ATK,
            "value":200
         }],[{
            "name":"攻击",
            "type":SUIT_ADD_ATK,
            "value":300
         }],[],[],[]];
         _anti.suit_name_cn_array = ["朱雀专属","朱雀专属","朱雀专属","白虎专属","白虎专属","白虎专属","年兽专属","年兽专属","年兽专属","玄武专属","玄武专属","玄武专属","青龙专属","青龙专属","青龙专属","子鼠专属","子鼠专属","子鼠专属","丑牛专属","丑牛专属","丑牛专属","炎马专属","炎马专属","炎马专属","寅虎专属","寅虎专属","寅虎专属"];
      }
      
      private function getSuitTypeByEquip(pEquip:PetEquipObj) : int
      {
         var idx:int = 0;
         var obj:* = null;
         var i:* = 0;
         var suitArrayCopy:Array = _anti.suit_array.concat();
         var curSuitArray:Array = [];
         var ename:String = pEquip.getFillName();
         for(i = uint(0); i < suitArrayCopy.length; )
         {
            curSuitArray = suitArrayCopy[i] as Array;
            idx = curSuitArray.indexOf(ename);
            if(idx != -1)
            {
               return i;
            }
            i++;
         }
         return -1;
      }
      
      private function getSuitArrayBySuitType(type:int) : Array
      {
         if(type == -1)
         {
            return [];
         }
         return _anti.suit_array.concat()[type] as Array;
      }
      
      private function getSuitCnArrayBySuitType(type:int) : Array
      {
         if(type == -1)
         {
            return [];
         }
         return _anti.suit_cn_array.concat()[type];
      }
      
      public function getSuitEffectByEquip(pEquip:PetEquipObj) : Array
      {
         var returnArray:Array = [];
         var suitId:int = getSuitTypeByEquip(pEquip);
         if(suitId == -1)
         {
            return returnArray;
         }
         return this.getSuitEffectByType(suitId);
      }
      
      private function getSuitEffectByType(type:int) : Array
      {
         var newObj:* = null;
         var returnArray:Array = [];
         var effectArray:Array = _anti.effect[type];
         for each(var obj in effectArray)
         {
            newObj = AUtils.clone(obj);
            if(int(newObj.value) < 1)
            {
               newObj.stringValue = newObj.value * 100 + "%";
            }
            else
            {
               newObj.stringValue = newObj.value;
            }
            returnArray.push(newObj);
         }
         return returnArray;
      }
      
      public function getSuitNumByEquip(_pEquip:PetEquipObj) : uint
      {
         var suitId:int = getSuitTypeByEquip(_pEquip);
         var suitArray:Array = getSuitArrayBySuitType(suitId);
         return suitArray.length;
      }
      
      public function getSuitEffectByEquipArray(equipArray:Array) : Array
      {
         var temp:Array = equipArray.concat();
         var arr:Array = [];
         for each(var pEquip in temp)
         {
            if((pEquip.getFillName() == "p_cylhjl" || pEquip.getFillName() == "p_jlcylhjl" || pEquip.getFillName() == "p_sscylhjl") && pEquip.getPetInfo().getPetName().indexOf("phoenix") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cybxjl" || pEquip.getFillName() == "p_jlcybxjl" || pEquip.getFillName() == "p_sscybxjl") && pEquip.getPetInfo().getPetName().indexOf("tigress") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cynsjl" || pEquip.getFillName() == "p_jlcynsjl" || pEquip.getFillName() == "p_sscynsjl") && pEquip.getPetInfo().getPetName().indexOf("nian") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cygsjl" || pEquip.getFillName() == "p_jlcygsjl" || pEquip.getFillName() == "p_sscygsjl") && pEquip.getPetInfo().getPetName().indexOf("turtle") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cykljl" || pEquip.getFillName() == "p_jlcykljl" || pEquip.getFillName() == "p_sscykljl") && pEquip.getPetInfo().getPetName().indexOf("dragon") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cyzsjl" || pEquip.getFillName() == "p_jlcyzsjl" || pEquip.getFillName() == "p_sscyzsjl") && pEquip.getPetInfo().getPetName().indexOf("mouse") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cycnjl" || pEquip.getFillName() == "p_jlcycnjl" || pEquip.getFillName() == "p_sscycnjl") && pEquip.getPetInfo().getPetName().indexOf("neat") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cyymjl" || pEquip.getFillName() == "p_jlcyymjl" || pEquip.getFillName() == "p_sscyymjl") && pEquip.getPetInfo().getPetName().indexOf("roomhorse") != -1)
            {
               arr.push(pEquip);
            }
            else if((pEquip.getFillName() == "p_cyyhjl" || pEquip.getFillName() == "p_jlcyyhjl" || pEquip.getFillName() == "p_sscyyhjl") && pEquip.getPetInfo().getPetName().indexOf("terribletiger") != -1)
            {
               arr.push(pEquip);
            }
         }
         var returnArray:Array = [];
         var suitType:int = -1;
         for each(pEquip in arr)
         {
            if(suitType == -1)
            {
               suitType = this.getSuitTypeByEquip(pEquip);
               if(suitType == -1)
               {
                  return returnArray;
               }
            }
            else if(suitType != this.getSuitTypeByEquip(pEquip))
            {
               return returnArray;
            }
         }
         if(suitType != -1)
         {
            if(arr.length == this.getSuitArrayBySuitType(suitType).length)
            {
               returnArray = this.getSuitEffectByType(suitType);
            }
         }
         return returnArray;
      }
      
      public function getSuitNameByEquip(pEquip:PetEquipObj, newEquipArray:Array) : Array
      {
         var obj:* = null;
         var i:* = 0;
         var curSuitName:* = null;
         var curSuitCnName:* = null;
         i = 0;
         var flag:Boolean = false;
         curSuitName = null;
         curSuitCnName = null;
         var returnArray:Array = [];
         var suitId:int = getSuitTypeByEquip(pEquip);
         var suitArray:Array = getSuitArrayBySuitType(suitId);
         var suitCnArray:Array = getSuitCnArrayBySuitType(suitId);
         if(suitId == -1)
         {
            return returnArray;
         }
         if(newEquipArray.length == 0)
         {
            for(i = uint(0); i < suitArray.length; )
            {
               curSuitName = suitArray[i];
               curSuitCnName = suitCnArray[i];
               obj = {};
               obj.name = curSuitName;
               obj.cnname = curSuitCnName;
               obj.value = 0;
               returnArray.push(obj);
               i++;
            }
            return returnArray;
         }
         var ename:String = pEquip.getFillName();
         var idx:int = suitArray.indexOf(ename);
         obj = {};
         if(idx != -1)
         {
            obj.name = suitArray[idx];
            obj.value = 1;
            obj.cnname = suitCnArray[idx];
            suitArray.splice(idx,1);
            suitCnArray.splice(idx,1);
            returnArray.push(obj);
         }
         for(i = uint(0); i < suitArray.length; )
         {
            flag = false;
            curSuitName = suitArray[i];
            curSuitCnName = suitCnArray[i];
            obj = {};
            for each(var pe in newEquipArray)
            {
               ename = pe.getFillName();
               if(ename == curSuitName)
               {
                  obj.name = curSuitName;
                  obj.cnname = curSuitCnName;
                  obj.value = 1;
                  flag = true;
                  returnArray.push(obj);
               }
            }
            if(!flag)
            {
               obj.name = curSuitName;
               obj.cnname = curSuitCnName;
               obj.value = 0;
               returnArray.push(obj);
            }
            i++;
         }
         return returnArray;
      }
      
      public function getSuitCnNameByEquip(equip:PetEquipObj) : String
      {
         var type:int = this.getSuitTypeByEquip(equip);
         if(type < 0)
         {
            return "";
         }
         return this._anti.suit_name_cn_array[type];
      }
      
      public function hasEquipTheSuit(newEquipArray:Array) : Boolean
      {
         var ary:* = null;
         var sit:int = 0;
         var suitArrayCopy:Array = _anti.suit_array.concat();
         for(var slen:uint = suitArrayCopy.length; slen-- > 0; )
         {
            ary = suitArrayCopy[slen];
            for each(var equip in newEquipArray)
            {
               if((equip.getFillName() == "p_cylhjl" || equip.getFillName() == "p_jlcylhjl" || equip.getFillName() == "p_sscylhjl") && equip.getPetInfo().getPetName().indexOf("phoenix") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cybxjl" || equip.getFillName() == "p_jlcybxjl" || equip.getFillName() == "p_sscybxjl") && equip.getPetInfo().getPetName().indexOf("tigress") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cynsjl" || equip.getFillName() == "p_jlcynsjl" || equip.getFillName() == "p_sscynsjl") && equip.getPetInfo().getPetName().indexOf("nian") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cygsjl" || equip.getFillName() == "p_jlcygsjl" || equip.getFillName() == "p_sscygsjl") && equip.getPetInfo().getPetName().indexOf("turtle") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cykljl" || equip.getFillName() == "p_jlcykljl" || equip.getFillName() == "p_sscykljl") && equip.getPetInfo().getPetName().indexOf("dragon") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cyzsjl" || equip.getFillName() == "p_jlcyzsjl" || equip.getFillName() == "p_sscyzsjl") && equip.getPetInfo().getPetName().indexOf("mouse") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cycnjl" || equip.getFillName() == "p_jlcycnjl" || equip.getFillName() == "p_sscycnjl") && equip.getPetInfo().getPetName().indexOf("neat") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cyymjl" || equip.getFillName() == "p_jlcyymjl" || equip.getFillName() == "p_sscyymjl") && equip.getPetInfo().getPetName().indexOf("roomhorse") == -1)
               {
                  return false;
               }
               if((equip.getFillName() == "p_cyyhjl" || equip.getFillName() == "p_jlcyyhjl" || equip.getFillName() == "p_sscyyhjl") && equip.getPetInfo().getPetName().indexOf("terribletiger") == -1)
               {
                  return false;
               }
               sit = ary.indexOf(equip.getFillName());
               if(sit != -1)
               {
                  ary.splice(sit,1);
               }
            }
            if(ary.length == 0)
            {
               return true;
            }
         }
         return false;
      }
   }
}
