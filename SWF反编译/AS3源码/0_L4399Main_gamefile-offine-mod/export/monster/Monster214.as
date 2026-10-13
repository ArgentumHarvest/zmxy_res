package export.monster
{
   import base.BaseAddEffect;
   
   public class Monster214 extends Monster206
   {
       
      
      private var ti:int;
      
      public function Monster214()
      {
         super();
         this.setHp(100);
         this.setSHp(100);
         this.attackBackInfoDict["hit1"] = {
            "hitMaxCount":99,
            "attackBackSpeed":[6,-5],
            "attackInterval":99,
            "power":800,
            "attackKind":"magic",
            "addEffect":[{
               "name":BaseAddEffect.MONSTER66HURT,
               "time":1
            }]
         };
      }
   }
}
