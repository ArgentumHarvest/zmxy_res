package com.superkaka.mvc.Base
{
   public class BaseProxy
   {
       
      
      private var _name:String = "";
      
      public function BaseProxy()
      {
         super();
      }
      
      public function destroy() : void
      {
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(value:String) : void
      {
         _name = value;
      }
   }
}
