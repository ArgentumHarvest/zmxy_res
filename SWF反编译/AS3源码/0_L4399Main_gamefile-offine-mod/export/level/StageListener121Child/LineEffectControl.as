package export.level.StageListener121Child
{
   import base.BaseAddEffect;
   import base.BaseHero;
   import base.BaseMonster;
   import config.Config;
   import mvc.controllor.RandomControllor;
   
   public class LineEffectControl
   {
       
      
      private var line_red:LineEffect;
      
      private var line_blue:LineEffect;
      
      private var gc:Config;
      
      private var targetHero:BaseHero;
      
      private var targetMonster:BaseMonster;
      
      private var boomCount:uint = 144;
      
      public var isDestroyed:Boolean = false;
      
      public var isBoomReady:Boolean = false;
      
      public function LineEffectControl()
      {
         super();
         gc = Config.getInstance();
      }
      
      public function addFirstLine(bo1:BaseMonster, bo2:BaseHero, kind:uint = 0) : void
      {
         if(!this.targetHero)
         {
            this.targetHero = bo2;
            this.targetMonster = bo1;
            if(kind == 0)
            {
               if(RandomControllor.getIns().getRandom() <= 0.5)
               {
                  this.newBlueLine(bo1,bo2);
               }
               else
               {
                  this.newRedLine(bo1,bo2);
               }
            }
            else if(kind == 1)
            {
               this.newBlueLine(bo1,bo2);
            }
            else if(kind == 2)
            {
               this.newRedLine(bo1,bo2);
            }
         }
      }
      
      public function addSecondLine() : void
      {
         if(this.targetHero)
         {
            if(!line_red)
            {
               this.newRedLine(this.targetMonster,this.targetHero);
               line_red.offsetYVal = -line_blue.offsetYVal;
               line_red.direct = -line_blue.offsetYVal;
            }
            else if(!line_blue)
            {
               this.newBlueLine(this.targetMonster,this.targetHero);
               line_blue.offsetYVal = -line_red.offsetYVal;
               line_blue.direct = -line_red.offsetYVal;
            }
         }
      }
      
      private function newBlueLine(bo1:BaseMonster, bo2:BaseHero) : void
      {
         var bo1Idx:int = 0;
         var bo2Idx:int = 0;
         if(bo1.parent && bo2.parent)
         {
            line_blue = new LineEffect(LineEffect.LINE_BLUE);
            line_blue.targetObject1 = bo1;
            line_blue.targetObject2 = bo2;
            bo1Idx = bo1.parent.getChildIndex(bo1);
            bo2Idx = bo2.parent.getChildIndex(bo2);
            gc.gameSence.addChildAt(line_blue,Math.min(bo1Idx,bo2Idx));
         }
      }
      
      private function newRedLine(bo1:BaseMonster, bo2:BaseHero) : void
      {
         var bo1Idx:int = 0;
         var bo2Idx:int = 0;
         if(bo1.parent && bo2.parent)
         {
            line_red = new LineEffect(LineEffect.LINE_RED);
            line_red.targetObject1 = bo1;
            line_red.targetObject2 = bo2;
            bo1Idx = bo1.parent.getChildIndex(bo1);
            bo2Idx = bo2.parent.getChildIndex(bo2);
            gc.gameSence.addChildAt(line_red,Math.min(bo1Idx,bo2Idx));
         }
      }
      
      public function boom() : void
      {
         if(this.targetHero)
         {
            this.targetHero.addCurAddEffect([{
               "name":BaseAddEffect.MONSTER53_TIE,
               "time":gc.frameClips * 5
            }]);
            if(this.line_blue)
            {
               this.line_blue.destroy();
               this.line_blue = null;
            }
            if(this.line_red)
            {
               this.line_red.destroy();
               this.line_red = null;
            }
            this.targetHero = null;
            this.targetMonster = null;
         }
         this.destroy();
      }
      
      public function step() : void
      {
         if(this.line_red)
         {
            this.line_red.step();
            if(this.line_red.isDestroy)
            {
               this.line_red = null;
            }
         }
         if(this.line_blue)
         {
            this.line_blue.step();
            if(this.line_blue.isDestroy)
            {
               this.line_blue = null;
            }
         }
         if(!this.line_red && !this.line_blue)
         {
            this.destroy();
            return;
         }
         if(this.getLineEffectNum() == 2)
         {
            if(this.boomCount > 0)
            {
               this.boomCount--;
               if(this.boomCount == 0)
               {
                  this.isBoomReady = true;
               }
            }
         }
      }
      
      public function getLineEffectNum() : int
      {
         var returnNum:int = 0;
         if(this.line_blue)
         {
            returnNum++;
         }
         if(this.line_red)
         {
            returnNum++;
         }
         return returnNum;
      }
      
      public function destroy() : void
      {
         if(this.line_red)
         {
            this.line_red.destroy();
            this.line_red = null;
         }
         if(this.line_blue)
         {
            this.line_blue.destroy();
            this.line_blue = null;
         }
         this.isDestroyed = true;
      }
   }
}
