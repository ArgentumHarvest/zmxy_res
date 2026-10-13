package com.edgarcai.gamelogic
{
   import com.edgarcai.encrypt.IEncrypt;
   import com.edgarcai.util.Utils;
   import flash.utils.ByteArray;
   import flash.utils.Proxy;
   import flash.utils.flash_proxy;
   
   public dynamic class Antiwear extends Proxy
   {
       
      
      public var encrypt:IEncrypt;
      
      public var errorHandler:Function;
      
      public var data:Object;
      
      private var _data:Object;
      
      public function Antiwear(encrypt:IEncrypt)
      {
         super();
         this.encrypt = encrypt;
         data = {};
         _data = {};
         this.errorHandler = defaultErrorHandler;
      }
      
      protected function defaultErrorHandler() : void
      {
      }
      
      override flash_proxy function callProperty(methodName:*, ... args) : *
      {
         var metrod:* = data[methodName];
         return (metrod as Function).apply(null,args);
      }
      
      override flash_proxy function getProperty(property:*) : *
      {
         if(property == null)
         {
            return null;
         }
         var v:* = encrypt.decode(_data[property]);
         if(v is Number || v is String)
         {
            if(v != data[property])
            {
               errorHandler();
            }
         }
         else if(!Utils.equal(v,data[property]))
         {
            errorHandler();
         }
         return v;
      }
      
      override flash_proxy function setProperty(property:*, value:*) : void
      {
         var bytes:* = null;
         if(value is Number || value is String)
         {
            data[property] = value;
         }
         else
         {
            bytes = new ByteArray();
            bytes.writeObject(value);
            bytes.position = 0;
            data[property] = bytes.readObject();
         }
         _data[property] = encrypt.encode(value);
      }
   }
}
