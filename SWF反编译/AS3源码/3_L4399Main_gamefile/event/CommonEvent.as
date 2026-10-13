package event
{
   import flash.events.Event;
   
   public class CommonEvent extends Event
   {
       
      
      public var data:Object;
      
      public function CommonEvent(type:String, data:Object = null, bubbles:Boolean = false, cancelable:Boolean = false)
      {
         this.data = data;
         super(type,bubbles,cancelable);
      }
      
      override public function clone() : Event
      {
         return new CommonEvent(type,data,bubbles,cancelable);
      }
   }
}
