package export.invite
{
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFormat;
   
   public class InvitationInterface extends Sprite
   {
       
      
      public var closeBtn:SimpleButton;
      
      public var changeBtn:SimpleButton;
      
      public var exitBtn:SimpleButton;
      
      private var nameTf:TextField;
      
      private var roleTf:TextField;
      
      private var tip1:TextField;
      
      private var gc:Config;
      
      public function InvitationInterface()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",__added,false,0,true);
         this.addEventListener("removedFromStage",__removed,false,0,true);
      }
      
      protected function __removed(event:Event) : void
      {
         closeBtn.removeEventListener("click",__close);
         changeBtn.removeEventListener("click",__change);
         exitBtn.removeEventListener("click",__exit);
      }
      
      protected function __added(event:Event) : void
      {
         closeBtn.addEventListener("click",__close);
         changeBtn.addEventListener("click",__change);
         exitBtn.addEventListener("click",__exit);
         var ttf:TextFormat = new TextFormat();
         ttf.size = 22;
         ttf.color = 16777215;
         var ttf2:TextFormat = new TextFormat();
         ttf2.size = 22;
         ttf2.color = 16777215;
         nameTf = new TextField();
         nameTf.selectable = false;
         nameTf.defaultTextFormat = ttf;
         nameTf.height = 40;
         nameTf.width = 100;
         nameTf.x = changeBtn.x;
         nameTf.y = changeBtn.y - 100;
         this.addChild(nameTf);
         roleTf = new TextField();
         roleTf.selectable = false;
         roleTf.height = 40;
         roleTf.width = 100;
         roleTf.defaultTextFormat = ttf2;
         roleTf.x = changeBtn.x;
         roleTf.y = changeBtn.y - 50;
         this.addChild(roleTf);
         var ttf3:TextFormat = new TextFormat();
         ttf3.size = 20;
         ttf3.color = 16777215;
         this.tip1 = new TextField();
         this.tip1.defaultTextFormat = ttf3;
         this.tip1.selectable = false;
         this.tip1.text = "邀请其他玩家之后，点击任意关卡进行双人作战";
         this.tip1.width = this.tip1.textWidth + 10;
         this.tip1.height = this.tip1.textHeight + 5;
         this.tip1.x = 256;
         this.tip1.y = 184;
         this.addChild(this.tip1);
         this.refreshInfo();
      }
      
      private function refreshInfo() : void
      {
         var roleName:* = null;
         if(gc.player3)
         {
            roleName = "";
            if(gc.player3.roleid > 0)
            {
               if(gc.player3.roleid == 1)
               {
                  roleName = "悟空";
               }
               else if(gc.player3.roleid == 2)
               {
                  roleName = "唐僧";
               }
               else if(gc.player3.roleid == 3)
               {
                  roleName = "八戒";
               }
               else if(gc.player3.roleid == 4)
               {
                  roleName = "沙僧";
               }
               roleTf.text = roleName + "     LV." + gc.player3.getCurLevel() + "";
               roleTf.width = roleTf.textWidth + 10;
               roleTf.height = roleTf.textHeight + 5;
            }
            else
            {
               roleTf.text = "未选择存档";
               roleTf.width = roleTf.textWidth + 10;
               roleTf.height = roleTf.textHeight + 5;
            }
         }
         if(GMain.serviceHold)
         {
            if(GMain.serviceHold.isSecondaryLog)
            {
               nameTf.text = "邀请帐号：" + GMain.serviceHold.isSecondaryLog.name;
               nameTf.width = nameTf.textWidth + 10;
               nameTf;
               nameTf.height = nameTf.textHeight + 5;
            }
         }
      }
      
      protected function __exit(event:MouseEvent) : void
      {
         if(GMain.serviceHold)
         {
            GMain.serviceHold.secondaryLogOut();
         }
         this.destroy();
      }
      
      protected function __change(event:MouseEvent) : void
      {
         gc.currentRead = 1;
         gc.showReadSaveInter();
         this.destroy();
      }
      
      protected function __close(event:MouseEvent) : void
      {
         this.destroy();
      }
      
      private function destroy() : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
