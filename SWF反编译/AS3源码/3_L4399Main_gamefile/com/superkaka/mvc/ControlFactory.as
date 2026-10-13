package com.superkaka.mvc
{
   import com.superkaka.Tools.Singleton;
   import com.superkaka.mvc.Base.BaseControl;
   import com.superkaka.mvc.Control.RMessageControl;
   import flash.utils.Dictionary;
   import flash.utils.getQualifiedClassName;
   
   public class ControlFactory extends Singleton
   {
       
      
      private var dict:Dictionary;
      
      public function ControlFactory()
      {
         dict = new Dictionary();
         super();
      }
      
      public static function getIns() : ControlFactory
      {
         return Singleton.getIns(ControlFactory);
      }
      
      public function init() : void
      {
         ControlFactory.getIns().initControl(RMessageControl);
      }
      
      public function initControl(cl:Class) : BaseControl
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
      
      public function getControl(cl:Class) : BaseControl
      {
         var name:String = getQualifiedClassName(cl);
         return dict[name];
      }
      
      public function destroyControl(cl:Class) : void
      {
         var name:String = getQualifiedClassName(cl);
         if(dict[name])
         {
            dict[name].destroy();
            dict[name] = null;
         }
      }
   }
}
