package com.superkaka.mvc
{
   import com.superkaka.Tools.Singleton;
   import com.superkaka.mvc.Base.BaseProxy;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ProxyFactory extends Singleton
   {
       
      
      private var dict:Dictionary;
      
      public function ProxyFactory()
      {
         dict = new Dictionary();
         super();
      }
      
      public static function getIns() : ProxyFactory
      {
         return Singleton.getIns(ProxyFactory);
      }
      
      public function init() : void
      {
      }
      
      public function initProxy(cl:Class) : BaseProxy
      {
         var bv:* = null;
         var name:String = getQualifiedClassName(cl);
         if(!dict[name])
         {
            bv = new cl();
            dict[name] = bv;
         }
         return dict[name];
      }
      
      public function getProxy(cl:Class) : BaseProxy
      {
         var name:String = getQualifiedClassName(cl);
         return dict[name];
      }
      
      public function destroyProxy(cl:Class) : void
      {
         var name:String = getQualifiedClassName(cl);
         if(dict[name])
         {
            (dict[name] as BaseProxy).destroy();
            dict[name] = null;
         }
      }
   }
}
