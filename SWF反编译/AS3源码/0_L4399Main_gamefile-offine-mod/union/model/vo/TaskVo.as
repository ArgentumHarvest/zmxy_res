package union.model.vo
{
   import union.model.Unify;
   import union.model.vo.utils.VoBasic;
   import union.utils.UnionConfig;
   
   public class TaskVo extends VoBasic
   {
       
      
      public var tasks:Array;
      
      public var exchange:String = "";
      
      public var total:int = 0;
      
      public function TaskVo()
      {
         super();
      }
      
      override public function updateFromObject(o:Object) : void
      {
         var i:int = 0;
         super.updateFromObject(o);
         tasks = [];
         if(o.tasklist)
         {
            for(i = 0; i < o.tasklist.length; )
            {
               tasks.push(o.tasklist[i]);
               i++;
            }
         }
      }
      
      public function get conNumSprite() : int
      {
         var i:int = 0;
         var da:* = null;
         var value:int = 1;
         Unify.log("task",tasks,total);
         if(tasks)
         {
            for(i = 0; i < tasks.length; )
            {
               da = tasks[i];
               if(da.taskName == UnionConfig.contriSpriteTaskId)
               {
                  value -= Number(da.value);
               }
               i++;
            }
         }
         return value > 0 ? value : 0;
      }
      
      public function get conNumTicket() : int
      {
         var i:int = 0;
         var da:* = null;
         var value:int = 1;
         Unify.log("task",tasks,total);
         if(tasks)
         {
            for(i = 0; i < tasks.length; )
            {
               da = tasks[i];
               if(da.taskName == UnionConfig.contriTicketTaskId)
               {
                  value -= Number(da.value);
               }
               i++;
            }
         }
         return value > 0 ? value : 0;
      }
   }
}
