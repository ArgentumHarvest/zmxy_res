package export.cure
{
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.*;
   import config.*;
   import my.*;
   
   public class SmallHP extends BaseObject
   {
       
      
      protected var allcount:uint = 600;
      
      protected var count:uint = 0;
      
      protected var isfilled:Boolean = true;
      
      public var cname:String;
      
      public var isUsed:Boolean = false;
      
      public var isRemoved:Boolean = false;
      
      protected var curWho:BaseHero;
      
      protected var curNum:uint;
      
      protected var tcount:uint = 0;
      
      var isfirst:Boolean = true;
      
      public function SmallHP(param1:Boolean = false)
      {
         super();
         this.isUsed = param1;
         this.cname = "SHp";
         this.curNum = 100;
         gc = Config.getInstance();
      }
      
      override public function step() : void
      {
         var _loc2_:BaseHero = null;
         super.step();
         var _loc1_:uint = gc.getPlayerArray().length;
         while(_loc1_-- > 0)
         {
            _loc2_ = gc.getPlayerArray()[_loc1_];
            if(!(Math.abs(this.x - _loc2_.x) > 700 || _loc2_.isDead()))
            {
               if(Math.abs(this.y - _loc2_.y) < 200)
               {
                  this.colwho(_loc2_);
               }
            }
         }
         if(this.tcount++ >= 240)
         {
            this.tcount = 0;
            this.remove();
         }
      }
      
      protected function colwho(param1:BaseHero) : void
      {
         if(this.isfirst)
         {
            if(param1.body)
            {
               if(!this.hitTestObject(param1.colipse))
               {
                  return;
               }
               if(HitTest.complexHitTestObject(this,param1.colipse))
               {
                  this.curWho = param1;
                  this.cure();
                  this.isfirst = false;
                  TweenMax.to(this,0.8,{
                     "y":this.y - 100,
                     "alpha":0,
                     "onComplete":this.remove
                  });
               }
            }
         }
      }
      
      protected function cure() : *
      {
         this.curWho.roleProperies.setHHP(this.curWho.roleProperies.getHHP() + this.curNum);
         this.addCureMc(this.curNum);
      }
      
      private function remove() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         var _loc1_:int = gc.otherList.indexOf(this);
         if(_loc1_ != -1)
         {
            gc.otherList.splice(_loc1_,1);
            delete global[this];
         }
      }
      
      override protected function checkOver() : void
      {
         if(this.y >= 1500)
         {
            this.remove();
         }
      }
   }
}
