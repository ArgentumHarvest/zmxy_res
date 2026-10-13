package com.multi4399
{
   import flash.events.Event;
   
   public class ResponseEvent extends Event
   {
      
      public static const PACKET:String = "packet";
       
      
      public var mark:uint = 0;
      
      public var values:Array;
      
      public var errors:Vector.<int>;
      
      public function ResponseEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         values = [];
         errors = new Vector.<int>();
         super(type,bubbles,cancelable);
      }
   }
}
