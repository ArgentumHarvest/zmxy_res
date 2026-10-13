package
{
   import base.BaseMonster;
   import config.Config;
   import flash.display.MovieClip;
   
   public dynamic class BossDead extends MovieClip
   {
       
      
      public var i:int;
      
      public var b:BaseMonster;
      
      public function BossDead()
      {
         super();
         addFrameScript(11,this.frame12);
      }
      
      function frame12() : *
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         this.i = 0;
         while(this.i < Config.getInstance().pWorld.monsterArray.length)
         {
            this.b = Config.getInstance().pWorld.monsterArray[this.i] as BaseMonster;
            if(this.b.isBoss)
            {
               this.b.dropAura();
               this.b.destroy();
            }
            ++this.i;
         }
         stop();
      }
   }
}
