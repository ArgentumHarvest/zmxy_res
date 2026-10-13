package my
{
   import config.Config;
   import manager.ANumberManager;
   
   public class CureHpQueue
   {
       
      
      private var queue:Array;
      
      private var showInterval:uint = 0;
      
      private var showIntervalCount:uint = 6;
      
      private var gc:Config;
      
      public function CureHpQueue()
      {
         queue = [];
         super();
         gc = Config.getInstance();
      }
      
      public function addCure(cure:int, posX:Number, posY:Number) : void
      {
         var obj:Object = {};
         obj.value = cure;
         obj.posX = posX;
         obj.posY = posY;
         obj.resName = "bunum";
         this.queue.push(obj);
      }
      
      public function addMpCure(cure:int, posX:Number, posY:Number) : void
      {
         var obj:Object = {};
         obj.value = cure;
         obj.posX = posX;
         obj.posY = posY;
         obj.resName = "bulnum";
         this.queue.push(obj);
      }
      
      public function addMpLose(lose:int, posX:Number, posY:Number) : void
      {
         var obj:Object = {};
         obj.value = lose;
         obj.posX = posX;
         obj.posY = posY;
         obj.resName = "mp_";
         this.queue.push(obj);
      }
      
      public function addHpLose(lose:int, posX:Number, posY:Number) : void
      {
         var obj:Object = {};
         obj.value = lose;
         obj.posX = posX;
         obj.posY = posY;
         obj.resName = "pnum";
         this.queue.push(obj);
      }
      
      public function addMonsterHurt(lose:int, posX:Number, posY:Number) : void
      {
         var obj:Object = {};
         obj.value = lose;
         obj.posX = posX;
         obj.posY = posY;
         obj.resName = "hurtnum";
         this.queue.push(obj);
      }
      
      public function addMonsterCritHurt(lose:int, posX:Number, posY:Number) : void
      {
         var obj:Object = {};
         obj.value = lose;
         obj.posX = posX;
         obj.posY = posY;
         obj.resName = "bnum";
         this.queue.push(obj);
      }
      
      private function showCure() : void
      {
         if(this.queue.length > 5)
         {
            this.showSingleCure(-20,-20);
            this.showSingleCure(-10,-10);
            this.showSingleCure(0,0);
            this.showSingleCure(10,-10);
            this.showSingleCure(20,-20);
         }
         else
         {
            this.showSingleCure();
         }
      }
      
      private function showSingleCure(offsetX:Number = 0, offsetY:Number = 0) : void
      {
         var obj:Object = this.queue.shift();
         var monHurtNumMc:ANumber = ANumberManager.getInstance().createANumber();
         gc.gameSence.addChild(monHurtNumMc);
         monHurtNumMc.aNumImage(obj.resName,obj.value,obj.posX + offsetX,obj.posY + offsetY,20);
      }
      
      public function step() : void
      {
         if(this.showInterval == 0)
         {
            if(this.queue.length > 0)
            {
               this.showCure();
               this.showInterval = this.showIntervalCount;
            }
         }
         if(this.showInterval > 0)
         {
            this.showInterval--;
         }
      }
      
      public function destroy() : void
      {
      }
   }
}
