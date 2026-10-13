package export.cure
{
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import config.Config;
   import event.CommonEvent;
   import my.HitTest;
   
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
      
      public function SmallHP(used:Boolean = false)
      {
         super();
         this.isUsed = used;
         this.cname = "SHp";
         this.curNum = 100;
         gc = Config.getInstance();
      }
      
      override public function step() : void
      {
         var who:* = null;
         super.step();
         var plen:uint = gc.getPlayerArray().length;
         while(plen-- > 0)
         {
            who = gc.getPlayerArray()[plen];
            if(!(Math.abs(this.x - who.x) > 700 || who.isDead()))
            {
               if(Math.abs(this.y - who.y) < 200)
               {
                  this.colwho(who);
               }
            }
         }
         if(this.tcount++ >= gc.frameClips * 10)
         {
            tcount = 0;
            this.remove();
         }
      }
      
      protected function colwho(who:BaseHero) : void
      {
         if(this.isfirst)
         {
            if(who.body)
            {
               if(!this.hitTestObject(who.colipse))
               {
                  return;
               }
               if(HitTest.complexHitTestObject(this,who.colipse))
               {
                  this.curWho = who;
                  this.cure();
                  isfirst = false;
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
         curWho.roleProperies.dispatchEvent(new CommonEvent("SetHHp",[curWho.roleProperies.getHHP() + this.curNum]));
         this.addCureMc(this.curNum);
      }
      
      private function remove() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         var idx:int = gc.otherList.indexOf(this);
         if(idx != -1)
         {
            gc.otherList.splice(idx,1);
         }
         this.curWho = null;
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
