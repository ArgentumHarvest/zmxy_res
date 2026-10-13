package task
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   
   public class Task
   {
       
      
      private var rwid:uint;
      
      private var rwname:String;
      
      private var rwdict:String;
      
      public var rwaward:Array;
      
      private var isComplete:Boolean = false;
      
      private var hasGetAward:Boolean = false;
      
      public var allaward:Array;
      
      private var isaccept:Boolean = true;
      
      private var _anti:Antiwear;
      
      public function Task(_rwid:uint, _rwname:String, _rwdict:String, _rwneedAry:Array, _rwaward:Array, _isaccept:Boolean = true)
      {
         rwaward = [];
         _anti = new Antiwear(new binaryEncrypt());
         super();
         this.rwid = _rwid;
         this.rwname = _rwname;
         this.rwdict = _rwdict;
         var temp:* = _rwneedAry;
         this._anti.rwneedAry = temp;
         this.allaward = _rwaward;
         this.isaccept = _isaccept;
         this._anti.randomAry = [1,2,1];
      }
      
      public function getrwId() : uint
      {
         return rwid;
      }
      
      public function getMonsterByRwId() : int
      {
         switch(int(this.rwid) - 500)
         {
            case 0:
               return 138;
            case 1:
               return 180;
            case 2:
               return 215;
            case 3:
               return 216;
            default:
               return 0;
         }
      }
      
      public function getrwname() : String
      {
         return rwname;
      }
      
      public function setRandomAry(ary:Array) : void
      {
         this._anti.randomAry = ary;
      }
      
      public function getRandomAry() : Array
      {
         return this._anti.randomAry;
      }
      
      public function getrwdict() : String
      {
         return rwdict;
      }
      
      public function setHasGetAward(_bool:Boolean) : void
      {
         this.hasGetAward = _bool;
      }
      
      public function getHasGetAward() : Boolean
      {
         return hasGetAward;
      }
      
      public function getIsComplete() : Boolean
      {
         return isComplete;
      }
      
      public function setIsaccept(_bool:Boolean) : void
      {
         this.isaccept = _bool;
      }
      
      public function getIsaccept() : Boolean
      {
         return this.isaccept;
      }
      
      public function getAllAward() : Array
      {
         return this.allaward;
      }
      
      public function getTaskPro() : String
      {
         var i:* = 0;
         var str:String = "";
         var nlen:uint = this._anti.rwneedAry.length;
         for(i = uint(0); i < nlen; )
         {
            str += this._anti.rwneedAry[i].name + " " + this._anti.rwneedAry[i].curhas + "/" + this._anti.rwneedAry[i].neednum + "  ";
            i++;
         }
         return str;
      }
      
      private function enCurHas(v:int) : int
      {
         return v * 100 + 201;
      }
      
      private function deCurHas(v:int) : int
      {
         return (v - 201) / 100;
      }
      
      public function judgeNeed(str:String) : Boolean
      {
         var i:* = 0;
         var arr:* = null;
         if(!this.isaccept)
         {
            return false;
         }
         var nlen:uint = this._anti.rwneedAry.length;
         for(i = uint(0); i < nlen; )
         {
            if(this._anti.rwneedAry[i].mname == str)
            {
               if(this._anti.rwneedAry[i].curhas < this._anti.rwneedAry[i].neednum)
               {
                  arr = this._anti.rwneedAry;
                  arr[i].curhas++;
                  this._anti.rwneedAry = arr;
                  this.judgeComplete();
                  return true;
               }
            }
            i++;
         }
         this.judgeComplete();
         return false;
      }
      
      public function hasChangeTask() : Boolean
      {
         var i:* = 0;
         var nlen:uint = this._anti.rwneedAry.length;
         for(i = uint(0); i < nlen; )
         {
            if(this._anti.rwneedAry[i].curhas > 0)
            {
               return true;
            }
            i++;
         }
         return false;
      }
      
      public function getBossChinaName() : String
      {
         var i:* = 0;
         var str:String = "";
         var nlen:uint = this._anti.rwneedAry.length;
         for(i = uint(0); i < nlen; )
         {
            str += this._anti.rwneedAry[i].name;
            if(i != nlen - 1)
            {
               str += "、";
            }
            i++;
         }
         return str;
      }
      
      public function judgeComplete() : Boolean
      {
         for(var nlen:uint = this._anti.rwneedAry.length; nlen-- > 0; )
         {
            if(this._anti.rwneedAry[nlen].curhas < this._anti.rwneedAry[nlen].neednum)
            {
               return false;
            }
         }
         this.isComplete = true;
         return true;
      }
      
      public function getSave() : String
      {
         var i:* = 0;
         var nlen:uint = this._anti.rwneedAry.length;
         var saveString:String = this.rwid + "";
         for(i = uint(0); i < nlen; )
         {
            saveString += "|" + this._anti.rwneedAry[i].curhas;
            i++;
         }
         saveString += "|" + this.isComplete + "|" + this.hasGetAward;
         if(this.rwid >= 500)
         {
            saveString += "|" + this.isaccept;
            if(this.isaccept && !this.hasGetAward)
            {
               saveString += "|" + this._anti.randomAry[0] + "|" + this._anti.randomAry[1] + "|" + this._anti.randomAry[2];
               saveString += "|" + this.rwaward[0].type + "|" + this.rwaward[0].value;
            }
         }
         return saveString;
      }
      
      public function setSave(data:String) : Boolean
      {
         var nlen:* = 0;
         var i:* = 0;
         var arr:* = null;
         var stage:* = 0;
         var level:* = 0;
         var time:* = 0;
         var obj:* = null;
         var getArray:Array = data.split("|");
         if(getArray[0] == this.rwid)
         {
            nlen = uint(this._anti.rwneedAry.length);
            for(i = uint(0); i < nlen; )
            {
               arr = this._anti.rwneedAry;
               arr[i].curhas = getArray[i + 1];
               this._anti.rwneedAry = arr;
               i++;
            }
            if(getArray[nlen + 1] == true || getArray[nlen + 1] == "true")
            {
               this.isComplete = true;
            }
            else
            {
               this.isComplete = false;
            }
            if(getArray[nlen + 2] == true || getArray[nlen + 2] == "true")
            {
               this.hasGetAward = true;
            }
            else
            {
               this.hasGetAward = false;
            }
            if(this.rwid >= 500)
            {
               if(getArray[nlen + 3] != undefined)
               {
                  if(getArray[nlen + 3] == true || getArray[nlen + 3] == "true")
                  {
                     this.isaccept = true;
                  }
                  else
                  {
                     this.isaccept = false;
                  }
               }
               if(this.isaccept && !this.hasGetAward)
               {
                  if(getArray[nlen + 4] != undefined)
                  {
                     stage = uint(getArray[nlen + 4]);
                  }
                  if(getArray[nlen + 5] != undefined)
                  {
                     level = uint(getArray[nlen + 5]);
                  }
                  if(getArray[nlen + 6] != undefined)
                  {
                     time = uint(getArray[nlen + 6]);
                  }
                  this._anti.randomAry = [stage,level,time];
                  obj = {};
                  obj.cname = "";
                  if(getArray[nlen + 7] != undefined)
                  {
                     obj.type = getArray[nlen + 7];
                  }
                  if(getArray[nlen + 8] != undefined)
                  {
                     obj.value = getArray[nlen + 8];
                  }
                  this.rwaward.push(obj);
               }
            }
            return true;
         }
         return false;
      }
   }
}
