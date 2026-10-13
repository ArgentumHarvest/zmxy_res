package union.view
{
   import flash.display.DisplayObject;
   import flash.text.TextField;
   import union.model.EventManager;
   import union.model.TextManager;
   import union.model.Unify;
   import union.model.UnionManager;
   import union.model.vo.UnionInfoVo;
   
   public class UnionMy extends BasicView
   {
       
      
      private var viewers:Array;
      
      public function UnionMy(name:String)
      {
         viewers = [];
         this.assetName = name;
         this.isCloseMain = true;
         super();
      }
      
      override protected function render() : void
      {
         mainPanel = this.addMovieClip("mainPanel");
         this.initViewer();
         this.addBtnEvent("btnClose","btnExit","btnXggg","btn1","btn2","btn3","btn4");
         EventManager.on("UNION_CHECK",onUnionUpdate);
         EventManager.on("UNION_UPDATE_INFO",onUnionUpdate);
         UnionManager.getIns().getOwnUnion();
         var txt:TextField = TextManager.createTextField(10,560,100,20,"left",18,16777215);
         txt.text = "v.1.4";
         this.addChild(txt);
      }
      
      protected function onUnionUpdate(data:Object = null) : void
      {
         var unionInfo:UnionInfoVo = UnionManager.getIns().unionInfo;
         if(unionInfo.hasUnion)
         {
            mainPanel["btnExit"].visible = !unionInfo.isLeader;
            mainPanel["btnXggg"].visible = unionInfo.isLeader;
            text("txtUnionName").text = unionInfo.title;
            text("txtLevel").text = unionInfo.level + "";
            text("txtTeam").text = unionInfo.team;
            text("txtMember").text = Unify.showUnionNum(unionInfo.count,unionInfo.level);
            text("txtUnionMoney").text = unionInfo.experience + "";
            text("txtMyMoney").text = unionInfo.personMoney + "";
            text("txtFightPower").text = unionInfo.memberVo.fightPower + "";
            text("txtNotice").text = unionInfo.note;
         }
         if(data && unionInfo.hasUnion)
         {
            this.openView(0);
         }
      }
      
      protected function initViewer() : void
      {
         var i:int = 0;
         var cs:Array = [UnionMember,UnionContribute,UnionApply,UnionTeam];
         for(i = 0; i < cs.length; )
         {
            viewers.push(new cs[i](assetName));
            i++;
         }
      }
      
      override protected function onBtnName(name:String) : void
      {
         name = name;
         super.onBtnName(name);
         switch(name)
         {
            case "btnExit":
               Unify.again("你确定要退出联盟吗？",function():void
               {
                  UnionManager.getIns().quitUion();
                  EventManager.emit("CLOSE_MAIN");
               });
               break;
            case "btnXggg":
               var message:String = text("txtNotice").text;
               UnionManager.getIns().match2(message,function(message:String):void
               {
                  UnionManager.getIns().unionInfo.changeNote(message);
               });
               break;
            default:
               var btn:DisplayObject = mainPanel[name];
               mainPanel["bottomLine"].x = btn.x;
               var index:int = name.split("btn")[1] - 1;
               this.openView(index);
         }
      }
      
      protected function openView(index:int) : void
      {
         var i:int = 0;
         for(i = 0; i < viewers.length; )
         {
            viewers[i].removeFromParent();
            i++;
         }
         var basicView:BasicView = viewers[index];
         basicView.updateView();
         this.addChild(basicView);
      }
      
      override public function dispose() : void
      {
         var i:int = 0;
         EventManager.off("UNION_CHECK",onUnionUpdate);
         EventManager.off("UNION_UPDATE_INFO",onUnionUpdate);
         UnionManager.getIns().unionInfo.memberVo.changeFightPower();
         for(i = 0; i < viewers.length; )
         {
            viewers[i].removeFromParent(true);
            i++;
         }
         super.dispose();
      }
   }
}
