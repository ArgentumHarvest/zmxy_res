package export.monster.Monster191Children
{
   import base.BaseMonster;
   import base.BaseObject;
   import base.BaseSummon;
   import config.Config;
   import event.CommonEvent;
   import flash.events.Event;
   
   public class LineSkillControl
   {
       
      
      private var lineArr:Array;
      
      private var source:BaseObject;
      
      private var gc:Config;
      
      public function LineSkillControl(source:BaseObject)
      {
         lineArr = [];
         super();
         gc = Config.getInstance();
         this.source = source;
      }
      
      public function addLine(bo:BaseObject) : void
      {
         var line:LineEffect = new LineEffect();
         line.targetObject1 = this.source;
         line.targetObject2 = bo;
         line.addEventListener("destroy",__lineDestroy);
         line.addEventListener("cure",__lineCure);
         gc.gameSence.addChild(line);
         lineArr.push(line);
      }
      
      protected function __lineCure(evt:CommonEvent) : void
      {
         var cure:int = int(evt.data);
         if(this.source)
         {
            if(this.source is BaseMonster)
            {
               BaseMonster(this.source).cureHp(cure);
            }
            else if(this.source is BaseSummon)
            {
               BaseSummon(this.source).cureHp(cure);
            }
         }
      }
      
      protected function __lineDestroy(evt:Event) : void
      {
         var line:LineEffect = evt.currentTarget as LineEffect;
         line.removeEventListener("destroy",__lineDestroy);
         line.removeEventListener("cure",__lineCure);
         lineArr.splice(lineArr.indexOf(line),1);
      }
      
      public function step() : void
      {
         for each(var line in lineArr.concat())
         {
            line.step();
         }
      }
      
      public function destroy() : void
      {
         for each(var line in lineArr)
         {
            line.destroy();
         }
         lineArr = null;
      }
   }
}
