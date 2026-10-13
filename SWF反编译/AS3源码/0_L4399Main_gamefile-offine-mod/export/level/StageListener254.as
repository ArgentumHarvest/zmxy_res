package export.level
{
   import base.BaseLevelListenering;
   import base.BaseMonster;
   import my.MainGame;
   
   public class StageListener254 extends BaseLevelListenering
   {
       
      
      private var boss1:BaseMonster;
      
      private var boss2:BaseMonster;
      
      public function StageListener254()
      {
         super();
         this.waitForRegisterDataArray = [];
      }
      
      override public function start() : void
      {
         super.start();
         if(gc.player1.roleid == 1)
         {
            boss1 = MainGame.getInstance().createMonster(34,600,200);
         }
         else if(gc.player1.roleid == 2)
         {
            boss1 = MainGame.getInstance().createMonster(31,600,200);
         }
         else if(gc.player1.roleid == 3)
         {
            boss1 = MainGame.getInstance().createMonster(33,600,200);
         }
         else if(gc.player1.roleid == 4)
         {
            boss1 = MainGame.getInstance().createMonster(32,600,200);
         }
         if(gc.player2.roleid == 1)
         {
            boss2 = MainGame.getInstance().createMonster(34,600,200);
         }
         else if(gc.player2.roleid == 2)
         {
            boss2 = MainGame.getInstance().createMonster(31,600,200);
         }
         else if(gc.player2.roleid == 3)
         {
            boss2 = MainGame.getInstance().createMonster(33,600,200);
         }
         else if(gc.player2.roleid == 4)
         {
            boss2 = MainGame.getInstance().createMonster(32,600,200);
         }
         if(boss1)
         {
            boss1.setProbability(0.1);
            boss1.setFallList([{
               "name":"lxfs_1",
               "bigtype":"dj"
            },{
               "name":"lxfs_2",
               "bigtype":"dj"
            },{
               "name":"lxfs_3",
               "bigtype":"dj"
            }]);
            boss1.curAddEffect.add([{
               "name":"father",
               "time":gc.frameClips * 3,
               "interval":800,
               "isForever":1
            }]);
         }
         if(boss2)
         {
            boss2.setProbability(0.1);
            boss2.setFallList([{
               "name":"lxfs_1",
               "bigtype":"dj"
            },{
               "name":"lxfs_2",
               "bigtype":"dj"
            },{
               "name":"lxfs_3",
               "bigtype":"dj"
            }]);
            boss2.curAddEffect.add([{
               "name":"father",
               "time":gc.frameClips * 3,
               "interval":800,
               "isForever":1
            }]);
         }
      }
      
      override public function step() : void
      {
         super.step();
      }
      
      override public function destroy() : void
      {
         super.destroy();
      }
   }
}
