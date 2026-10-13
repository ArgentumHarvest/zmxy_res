package export.monster.Monster145Children
{
   import base.BaseHero;
   import base.BaseObject;
   import com.greensock.TweenMax;
   import config.Config;
   import flash.display.MovieClip;
   import mvc.controllor.RandomControllor;
   import my.HitTest;
   import my.MyEquipObj;
   
   public class ShengdanPresent extends BaseObject
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
      
      public function ShengdanPresent(used:Boolean = false)
      {
         super();
         this.isUsed = used;
         this.cname = "Exp";
         this.curNum = 100;
         gc = Config.getInstance();
         var co:MovieClip = AUtils.getNewObj("ShengDanPresent") as MovieClip;
         this.colipse = co;
         this.addChild(co);
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
         if(this.tcount++ >= gc.frameClips * 9999)
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
         var itemName:* = null;
         var arr:Array = ["wpsh_1","wpst_1","tlzsp","llzsp","hlzsp","flzsp","slzsp"];
         var rand:MyEquipObj = gc.allEquip.findByName(arr[int(RandomControllor.getIns().getRandom() * arr.length)]);
         if(rand)
         {
            itemName = rand.getFillName();
            gc.ts.setTxt("获得 " + rand.ename);
            gc.stage.addChild(gc.ts);
            gc.putQhsInBackPack(this.curWho.getPlayer(),itemName);
         }
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
