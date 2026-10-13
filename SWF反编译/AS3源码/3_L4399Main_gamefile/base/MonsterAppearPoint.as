package base
{
   import PhysicsWorld.PhysicsWorld;
   import com.superkaka.Tools.CommonEvent;
   import config.Config;
   import flash.display.MovieClip;
   import flash.events.Event;
   import my.MainGame;
   
   public class MonsterAppearPoint extends MovieClip
   {
       
      
      [Inspectable(defaultValue="0")]
      public var delay:int;
      
      [Inspectable(defaultValue="0")]
      public var interval:Number;
      
      [Inspectable(defaultValue="5")]
      public var totalNum:int;
      
      [Inspectable(defaultValue="1")]
      public var enemyType:int;
      
      [Inspectable(defaultValue="false")]
      public var isRandom:Boolean;
      
      [Inspectable(defaultValue="0")]
      public var stopPointIdx:int;
      
      public var monsterDisapperaPoint:MovieClip;
      
      private var pWorld:PhysicsWorld;
      
      private var count:int = 0;
      
      private var isStart:Boolean = false;
      
      private var gc:Config;
      
      private var currentCount:int = 0;
      
      public var isOver:Boolean = false;
      
      private var isReady:Boolean = false;
      
      private var randomArray:Array;
      
      private var isStartStep:Boolean = false;
      
      public function MonsterAppearPoint()
      {
         randomArray = [1,2,4,5,7,8,11,12,13];
         super();
         gc = Config.getInstance();
         this.addEventListener("removedFromStage",__removed,false,0,true);
      }
      
      private function __removed(evt:Event) : void
      {
      }
      
      public function start() : void
      {
         this.isStartStep = true;
      }
      
      public function step() : void
      {
         var bm:* = null;
         var idx:int = 0;
         if(!this.isStartStep)
         {
            return;
         }
         if(gc.isStopGame)
         {
            return;
         }
         if(!isStart)
         {
            if(count / gc.frameClips >= delay)
            {
               isStart = true;
               count = 0;
            }
         }
         if(isStart)
         {
            if(currentCount < totalNum)
            {
               if(count / gc.frameClips >= interval)
               {
                  isReady = true;
               }
            }
            if(count / gc.frameClips >= interval)
            {
               count = 0;
            }
         }
         if(isReady)
         {
            if(gc.pWorld.monsterArray.length < gc.maxMonsterPerScreen)
            {
               bm = MainGame.getInstance().createMonster(this.enemyType,this.x,this.y);
               this.dispatchEvent(new CommonEvent("MonsterCreated",bm));
               currentCount++;
               isReady = false;
            }
         }
         if(currentCount >= totalNum)
         {
            isOver = true;
            if(this.parent)
            {
               this.parent.removeChild(this);
               idx = gc.pWorld.getMonsterAppearArray().indexOf(this);
               if(idx != -1)
               {
                  gc.pWorld.getMonsterAppearArray().splice(idx,1);
               }
            }
         }
         if(!isReady)
         {
            count++;
         }
      }
   }
}
