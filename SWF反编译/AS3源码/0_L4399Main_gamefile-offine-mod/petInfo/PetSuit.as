package petInfo
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import my.PetEquipObj;
   
   public class PetSuit
   {
      
      public static var SUIT_ADD_CRIT:uint = 256;
      
      public static var SUIT_ADD_EATBLOOD:uint = 512;
      
      public static var SUIT_ADD_ATK:uint = 768;
      
      public static var SUIT_ADD_MDEF:uint = 1024;
      
      public static var SUIT_ADD_HP:uint = 1280;
       
      
      private var _anti:Antiwear;
      
      public function PetSuit()
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         _anti.suit_array = [["p_cyst","p_cyyf","p_cymz","p_cyxz"],["p_jlcyst","p_jlcyyf","p_jlcymz","p_jlcyxz"],["p_sscyst","p_sscyyf","p_sscymz","p_sscyxz"],["p_cztk","p_czst","p_czkj","p_czzx"],["p_jlcztk","p_jlczst","p_jlczkj","p_jlczzx"],["p_sscztk","p_ssczst","p_ssczkj","p_ssczzx"]];
         _anti.suit_cn_array = [["赤烟手套","赤烟铠甲","赤烟头盔","赤烟战靴"],["赤烟手套","赤烟铠甲","赤烟头盔","赤烟战靴"],["赤烟手套","赤烟铠甲","赤烟头盔","赤烟战靴"],["叱咤头盔","叱咤手套","叱咤铠甲","叱咤战鞋"],["叱咤头盔","叱咤手套","叱咤铠甲","叱咤战鞋"],["叱咤头盔","叱咤手套","叱咤铠甲","叱咤战鞋"]];
         _anti.effect = [[{
            "name":"魔抗",
            "type":SUIT_ADD_MDEF,
            "value":0.1
         },{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":1000
         }],[{
            "name":"魔抗",
            "type":SUIT_ADD_MDEF,
            "value":0.2
         },{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":2000
         }],[{
            "name":"魔抗",
            "type":SUIT_ADD_MDEF,
            "value":0.3
         },{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":4000
         }],[{
            "name":"吸血",
            "type":SUIT_ADD_EATBLOOD,
            "value":0.02
         },{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":1000
         }],[{
            "name":"吸血",
            "type":SUIT_ADD_EATBLOOD,
            "value":0.04
         },{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":2000
         }],[{
            "name":"吸血",
            "type":SUIT_ADD_EATBLOOD,
            "value":0.06
         },{
            "name":"生命",
            "type":SUIT_ADD_HP,
            "value":4000
         }]];
         _anti.suit_name_cn_array = ["赤烟套装","赤烟套装","赤烟套装","叱咤套装","叱咤套装","叱咤套装"];
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
            if(pEquip.type != "zbjn")
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
