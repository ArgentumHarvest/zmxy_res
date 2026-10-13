package event
{
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class AEventDispatcher extends EventDispatcher
   {
       
      
      public function AEventDispatcher(target:IEventDispatcher = null)
      {
         super(target);
      }
      
      override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         super.removeEventListener(type,listener,useCapture);
         super.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
   }
}
