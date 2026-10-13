package petInfo.Formation
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import petInfo.PetInfo;
   
   public class PetFormation
   {
      
      public static const FORMATION_ZHUQUE:uint = 0;
      
      public static const FORMATION_XUANWU:uint = 1;
      
      public static const FORMATION_QINGLONG:uint = 2;
      
      public static const FORMATION_BAIHU:uint = 3;
      
      public static const TYPE_HP:uint = 0;
      
      public static const TYPE_HX:uint = 1;
      
      public static const TYPE_FY:uint = 2;
      
      public static const TYPE_MK:uint = 3;
       
      
      private var _anti:Antiwear;
      
      private var curPiArr:Array;
      
      public function PetFormation()
      {
         _anti = new Antiwear(new binaryEncrypt());
         curPiArr = [];
         super();
         this.init();
      }
      
      private function init() : void
      {
         this._anti.zhuque = [[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         }],[{
            "info":"血量",
            "type":0,
            "value":100
         },{
            "info":"回血",
            "type":1,
            "value":2
         }]];
         this._anti.xuanwu = [[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         }],[{
            "info":"防御",
            "type":2,
            "value":5
         },{
            "info":"魔抗",
            "type":3,
            "value":0.02
         }]];
         this._anti.qinglong = [];
         this._anti.baihu = [];
      }
      
      public function setSaveData(data:String) : void
      {
         var pi:* = null;
         var temp:Array = [];
         for each(pi in this.curPiArr)
         {
            temp.push(pi);
         }
         for each(pi in temp)
         {
            this.removePropertyToPetInfo(pi);
         }
         this._anti.ddata = data;
         for each(pi in this.curPiArr)
         {
            this.addPropertyToPetInfo(pi);
         }
      }
      
      public function resetData() : void
      {
         this._anti.ddata = "0-0_0-0_0-0_0-0";
      }
      
      public function addPropertyToPetInfo(pi:PetInfo) : void
      {
         var i:* = 0;
         var formationArr:* = null;
         var temp:* = null;
         var jie:* = 0;
         var idx:* = 0;
         var j:* = 0;
         var arr:* = null;
         var m:* = 0;
         j = 0;
         arr = null;
         if(pi.isFormationAdd)
         {
            return;
         }
         pi.isFormationAdd = true;
         this.curPiArr.push(pi);
         var dataArr:Array = (this._anti.ddata as String).split("_");
         if(dataArr.length == 4)
         {
            for(i = uint(0); i < 4; )
            {
               if(i == 0)
               {
                  formationArr = this._anti.zhuque as Array;
               }
               else if(i == 1)
               {
                  formationArr = this._anti.xuanwu as Array;
               }
               else if(i == 2)
               {
                  formationArr = this._anti.qinglong as Array;
               }
               else if(i == 3)
               {
                  formationArr = this._anti.baihu as Array;
               }
               temp = dataArr[i];
               jie = uint(temp.split("-")[0]);
               idx = uint(temp.split("-")[1]);
               if(idx > 0)
               {
                  for(j = uint(0); j < idx; )
                  {
                     if(j < formationArr.length)
                     {
                        arr = formationArr[j] as Array;
                        for each(var obj in arr)
                        {
                           this.addSinglePropertyToPetInfo(obj,pi);
                        }
                     }
                     j++;
                  }
               }
               if(jie > 0)
               {
                  for(m = uint(0); m < jie; )
                  {
                     for(j = uint(0); j < formationArr.length; )
                     {
                        arr = formationArr[j] as Array;
                        for each(obj in arr)
                        {
                           this.addSinglePropertyToPetInfo(obj,pi);
                        }
                        j++;
                     }
                     m++;
                  }
               }
               i++;
            }
         }
         else
         {
            trace("-----------阵法长度不是4-------------");
         }
      }
      
      private function addSinglePropertyToPetInfo(obj:Object, pi:PetInfo) : void
      {
         var rate:Number = NaN;
         var type:uint = obj.type;
         if(type == 0)
         {
            rate = pi.getHp() / pi.getSHp();
            pi.setHp(pi.getHp() + obj.value * rate);
            pi.setSHp(pi.getSHp() + obj.value);
         }
         else if(type == 1)
         {
            pi.setEHp(pi.getEHp() + obj.value);
         }
         else if(type == 2)
         {
            pi.setDef(pi.getDef() + obj.value);
         }
         else if(type == 3)
         {
            pi.setMDef(pi.getMDef() + obj.value);
         }
      }
      
      public function removePropertyToPetInfo(pi:PetInfo) : void
      {
         var i:* = 0;
         var formationArr:* = null;
         var temp:* = null;
         var jie:* = 0;
         var idx:* = 0;
         var j:* = 0;
         var arr:* = null;
         var m:* = 0;
         j = 0;
         arr = null;
         if(!pi.isFormationAdd)
         {
            return;
         }
         pi.isFormationAdd = false;
         var index:int = this.curPiArr.indexOf(pi);
         if(index != -1)
         {
            this.curPiArr.splice(index,1);
         }
         var dataArr:Array = (this._anti.ddata as String).split("_");
         if(dataArr.length == 4)
         {
            for(i = uint(0); i < 4; )
            {
               if(i == 0)
               {
                  formationArr = this._anti.zhuque as Array;
               }
               else if(i == 1)
               {
                  formationArr = this._anti.xuanwu as Array;
               }
               else if(i == 2)
               {
                  formationArr = this._anti.qinglong as Array;
               }
               else if(i == 3)
               {
                  formationArr = this._anti.baihu as Array;
               }
               temp = dataArr[i];
               jie = uint(temp.split("-")[0]);
               idx = uint(temp.split("-")[1]);
               if(idx > 0)
               {
                  for(j = uint(0); j < idx; )
                  {
                     if(j < formationArr.length)
                     {
                        arr = formationArr[j] as Array;
                        for each(var obj in arr)
                        {
                           this.removeSinglePropertyToPetInfo(obj,pi);
                        }
                     }
                     j++;
                  }
               }
               if(jie > 0)
               {
                  for(m = uint(0); m < jie; )
                  {
                     for(j = uint(0); j < formationArr.length; )
                     {
                        arr = formationArr[j] as Array;
                        for each(obj in arr)
                        {
                           this.removeSinglePropertyToPetInfo(obj,pi);
                        }
                        j++;
                     }
                     m++;
                  }
               }
               i++;
            }
         }
         else
         {
            trace("-----------阵法长度不是4-------------");
         }
      }
      
      private function removeSinglePropertyToPetInfo(obj:Object, pi:PetInfo) : void
      {
         var rate:Number = NaN;
         var type:uint = obj.type;
         if(type == 0)
         {
            rate = pi.getHp() / pi.getSHp();
            pi.setHp(pi.getHp() - obj.value * rate);
            pi.setSHp(pi.getSHp() - obj.value);
         }
         else if(type == 1)
         {
            pi.setEHp(pi.getEHp() - obj.value);
         }
         else if(type == 2)
         {
            pi.setDef(pi.getDef() - obj.value);
         }
         else if(type == 3)
         {
            pi.setMDef(pi.getMDef() - obj.value);
         }
      }
      
      public function getTotalInfoByFormation(formation:uint) : String
      {
         var formationArr:* = null;
         var temp:* = null;
         var jie:* = 0;
         var idx:* = 0;
         var j:* = 0;
         var arr:* = null;
         var m:* = 0;
         j = 0;
         arr = null;
         var fi:FormationInfo = new FormationInfo();
         var dataArr:Array = (this._anti.ddata as String).split("_");
         if(dataArr.length == 4)
         {
            if(formation == 0)
            {
               formationArr = this._anti.zhuque as Array;
            }
            else if(formation == 1)
            {
               formationArr = this._anti.xuanwu as Array;
            }
            else if(formation == 2)
            {
               formationArr = this._anti.qinglong as Array;
            }
            else if(formation == 3)
            {
               formationArr = this._anti.baihu as Array;
            }
            temp = dataArr[formation];
            jie = uint(temp.split("-")[0]);
            idx = uint(temp.split("-")[1]);
            fi.jie = jie;
            fi.ji = idx;
            if(idx > 0)
            {
               for(j = uint(0); j < idx; )
               {
                  if(j < formationArr.length)
                  {
                     arr = formationArr[j] as Array;
                     for each(var obj in arr)
                     {
                        fi.addObject(obj);
                     }
                  }
                  j++;
               }
            }
            if(jie > 0)
            {
               for(m = uint(0); m < jie; )
               {
                  for(j = uint(0); j < formationArr.length; )
                  {
                     arr = formationArr[j] as Array;
                     for each(obj in arr)
                     {
                        fi.addObject(obj);
                     }
                     j++;
                  }
                  m++;
               }
            }
         }
         else
         {
            trace("-----------阵法长度不是4-------------");
         }
         return fi.getInfo();
      }
      
      public function getNeedStoneByType(type:uint) : Array
      {
         var formationArr:* = null;
         var temp:* = null;
         var jie:* = 0;
         var ji:* = 0;
         var dataArr:Array = (this._anti.ddata as String).split("_");
         if(dataArr.length == 4)
         {
            if(type == 0)
            {
               formationArr = this._anti.zhuque as Array;
            }
            else if(type == 1)
            {
               formationArr = this._anti.xuanwu as Array;
            }
            else if(type == 2)
            {
               formationArr = this._anti.qinglong as Array;
            }
            else if(type == 3)
            {
               formationArr = this._anti.baihu as Array;
            }
            temp = dataArr[type];
            jie = uint(temp.split("-")[0]);
            ji = uint(temp.split("-")[1]);
            return [jie + 1,2 + 5 * jie + 2 * ji];
         }
         trace("-----------阵法长度不是4-------------");
         return [0,0];
      }
   }
}
