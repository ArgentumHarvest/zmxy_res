package union.view
{
   import union.model.Unify;
   import union.model.UnionManager;
   import union.utils.UnionConfig;
   
   public class UnionTeam extends UnionMember
   {
       
      
      public function UnionTeam(name:String)
      {
         super(name);
      }
      
      override protected function render() : void
      {
         var i:int = 0;
         var name:* = null;
         mainPanel = this.addMovieClip("teamPanel");
         this.addBtnEvent("btnJr1","btnJr2","btnJr3","btnJr4");
         this.setTitle();
         if(!UnionManager.getIns().unionInfo.isLeader)
         {
            for(i = 1; i <= 4; )
            {
               name = "btnJr" + i;
               this.hide(name);
               i++;
            }
         }
      }
      
      private function setTitle() : void
      {
         var title:String = Unify.message("联盟等级达到num级后，可选择不同的联盟阵营加入。加入对应阵营后，更换阵营需消耗num点券",2,100);
         text("txtTitle").text = title;
      }
      
      override protected function onBtnName(name:String) : void
      {
         name = name;
         if(UnionManager.getIns().unionLevel >= 2)
         {
            var index:Number = name.split("btnJr")[1] - 1;
            if(UnionManager.getIns().unionInfo.team == Unify.getTeamByIndex(index))
            {
               Unify.alert("你已经是该阵营的了");
               return;
            }
            var teamName:String = Unify.getTeamByIndex(index);
            var ticket:int = 100;
            Unify.again(Unify.message("确定消耗num点券，选择num阵营吗？",ticket,teamName),function():void
            {
               Unify.removeTicket(ticket);
               UnionManager.getIns().unionInfo.changeTeam(index);
               UnionConfig.isSave = true;
            });
         }
         else
         {
            Unify.alert("联盟等级不足");
         }
      }
   }
}
