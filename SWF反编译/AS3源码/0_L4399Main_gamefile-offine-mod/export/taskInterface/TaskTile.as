package export.taskInterface
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import task.Task;
   
   public class TaskTile extends MovieClip
   {
       
      
      public var rwnametxt:TextField;
      
      private var myTask:Task;
      
      public function TaskTile()
      {
         super();
         this.gotoAndStop(1);
         this.buttonMode = true;
         rwnametxt.selectable = false;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
      }
      
      private function removed(e:Event) : void
      {
      }
      
      public function setTask(task:Task) : void
      {
         this.myTask = task;
         this.rwnametxt.text = myTask.getrwname();
         this.setReceive();
      }
      
      public function selected() : void
      {
         this.gotoAndStop(2);
      }
      
      public function unselected() : void
      {
         this.gotoAndStop(1);
      }
      
      public function getTask() : Task
      {
         return this.myTask;
      }
      
      public function setReceive() : void
      {
         var icon:* = undefined;
         if(this.myTask)
         {
            if(this.myTask.getHasGetAward())
            {
               icon = AUtils.getImageObj("hasReceive");
               icon.name = "hasReceiveIcon";
               icon.x = 150.5;
               this.addChild(icon);
            }
            else if(this.getChildByName("hasReceiveIcon"))
            {
               this.removeChild(this.getChildByName("hasReceiveIcon"));
            }
         }
      }
      
      public function removeIcon() : void
      {
         if(this.getChildByName("hasReceiveIcon"))
         {
            this.removeChild(this.getChildByName("hasReceiveIcon"));
         }
      }
   }
}
