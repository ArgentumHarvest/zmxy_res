package com.superkaka.game.Const
{
   import com.superkaka.Tools.Singleton;
   import flash.utils.Dictionary;
   
   public class ProtocolDict extends Singleton
   {
       
      
      public var protocolToServerFile:Dictionary;
      
      public var protocolToserverFunc:Dictionary;
      
      public var protocolToClientFile:Dictionary;
      
      public var protocolToClientFunc:Dictionary;
      
      private var type:int = 0;
      
      private var dicts:Object;
      
      public function ProtocolDict()
      {
         protocolToServerFile = new Dictionary();
         protocolToserverFunc = new Dictionary();
         protocolToClientFile = new Dictionary();
         protocolToClientFunc = new Dictionary();
         dicts = {};
         super();
      }
      
      public static function getIns() : ProtocolDict
      {
         return Singleton.getIns(ProtocolDict);
      }
      
      public function initToServerFileDict(data:Object) : void
      {
         for(protocolToServerFile[data[key]] in data)
         {
         }
      }
      
      public function initToServerFuncDict(data:Object) : void
      {
         var funcObj:* = null;
         for(var key in data)
         {
            funcObj = {};
            for(funcObj[data[key][key2]] in data[key])
            {
            }
            protocolToserverFunc[key] = funcObj;
         }
      }
      
      public function initToClientFileDict(data:Object) : void
      {
         for(protocolToClientFile[data[key]] in data)
         {
         }
      }
      
      public function initToClientFuncDict(data:Object) : void
      {
         var funcObj:* = null;
         for(var key in data)
         {
            funcObj = {};
            for(funcObj[data[key][key2]] in data[key])
            {
            }
            protocolToClientFunc[key] = funcObj;
         }
      }
      
      public function registerDict(name:String, decodeKeyArray:Array, encodeKeyArray:Array) : void
      {
         if(!dicts[name])
         {
            dicts[name] = {};
         }
         this.type = 0;
         dicts[name]["decode"] = decodeKeyArray;
         dicts[name]["decodeIndex"] = 0;
         dicts[name]["encode"] = encodeKeyArray;
         dicts[name]["encodeIndex"] = 0;
      }
      
      public function registerAutoIncreaseDict(name:String) : void
      {
         if(!dicts[name])
         {
            dicts[name] = {};
         }
         this.type = 1;
         dicts[name]["decodeKey"] = 0;
         dicts[name]["encodeKey"] = 0;
      }
      
      public function getEncodeKey(name:String) : int
      {
         var key:int = 0;
         var returnKey:* = 0;
         if(this.type == 0)
         {
            dicts[name]["encodeIndex"]++;
            if(dicts[name]["encodeIndex"] == (dicts[name]["encode"] as Array).length)
            {
               dicts[name]["encodeIndex"] = 0;
            }
            return dicts[name]["encode"][dicts[name]["encodeIndex"]];
         }
         if(this.type == 1)
         {
            key = dicts[name]["encodeKey"];
            returnKey = key;
            key++;
            if(key > 255)
            {
               key = 0;
            }
            dicts[name]["encodeKey"] = key;
            return returnKey;
         }
         throw new Error("getEncodeKey error!type:" + type);
      }
      
      public function getDecodeKey(name:String) : int
      {
         var key:int = 0;
         var returnKey:* = 0;
         if(this.type == 0)
         {
            dicts[name]["decodeIndex"]++;
            if(dicts[name]["decodeIndex"] == (dicts[name]["decode"] as Array).length)
            {
               dicts[name]["decodeIndex"] = 0;
            }
            return dicts[name]["decode"][dicts[name]["decodeIndex"]];
         }
         if(this.type == 1)
         {
            key = dicts[name]["decodeKey"];
            returnKey = key;
            key++;
            if(key > 255)
            {
               key = 0;
            }
            dicts[name]["decodeKey"] = key;
            return returnKey;
         }
         throw new Error("getDecodeKey error!type:" + type);
      }
      
      public function reset(name:String) : void
      {
         dicts[name]["decodeIndex"] = 0;
         dicts[name]["encodeIndex"] = 0;
         dicts[name]["decodeKey"] = 0;
         dicts[name]["encodeKey"] = 0;
      }
   }
}
