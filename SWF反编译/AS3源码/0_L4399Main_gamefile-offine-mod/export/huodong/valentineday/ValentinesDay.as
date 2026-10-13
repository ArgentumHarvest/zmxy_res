package export.huodong.valentineday
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import my.MyEquipObj;
   import user.User;
   
   public class ValentinesDay extends Sprite
   {
       
      
      public var btn_play1:SimpleButton;
      
      public var btn_play2:SimpleButton;
      
      public var exchange:SimpleButton;
      
      public var updata:SimpleButton;
      
      public var bclose:SimpleButton;
      
      public var txtjl:TextField;
      
      public var txtss:TextField;
      
      public var ggbtn:SimpleButton;
      
      private var gc:Config;
      
      private var player:User;
      
      private var whichzzs:String = "";
      
      private var hasbuy:Boolean = false;
      
      var playerbtnState;
      
      public function ValentinesDay()
      {
         super();
         gc = Config.getInstance();
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.player = gc.player1;
         btn_play1.addEventListener("click",play1Click);
         btn_play2.addEventListener("click",play2Click);
         btn_play1.dispatchEvent(new MouseEvent("click"));
         exchange.addEventListener("click",exchangeClick);
         updata.addEventListener("click",updataClick);
         bclose.addEventListener("click",closeClick);
         ggbtn.addEventListener("click",ggClick);
         if(gc.player2.roleid > 0)
         {
            this.btn_play2.visible = true;
         }
         else
         {
            this.btn_play2.visible = false;
         }
      }
      
      private function removed(e:Event) : void
      {
         this.player = null;
         btn_play1.removeEventListener("click",play1Click);
         btn_play2.removeEventListener("click",play2Click);
         exchange.removeEventListener("click",exchangeClick);
         updata.removeEventListener("click",updataClick);
         bclose.removeEventListener("click",closeClick);
         ggbtn.addEventListener("click",ggClick);
         if(this.hasbuy)
         {
            if(gc.isHideDebug)
            {
               gc.memory.setStorage(gc.luanqibazaojiami.saveId);
            }
         }
      }
      
      private function setTxt() : void
      {
         if(this.player)
         {
            this.txtjl.text = "";
            this.txtss.text = "";
            this.txtjl.text = "已有玫瑰(" + this.player.getSomeOneEquipNumberByName("wpmgh") + "/11)";
            this.txtss.text = "已有玫瑰(" + this.player.getSomeOneEquipNumberByName("wpmgh") + "/99)\r";
            this.txtss.text += "已有精良制作书(" + this.player.getSomeOneEquipNumberByName("jl" + this.whichzzs) + "/1)\r";
            this.txtss.text += "已有孟婆药剂(" + this.player.getSomeOneEquipNumberByName("mpyj") + "/1)";
         }
      }
      
      private function play1Click(e:MouseEvent) : void
      {
         player = gc.player1;
         if(btn_play1.upState != btn_play1.overState)
         {
            if(playerbtnState)
            {
               btn_play2.upState = playerbtnState;
            }
            playerbtnState = e.target.upState;
            e.target.upState = e.target.overState;
         }
         this.setJLZzs();
         this.setTxt();
      }
      
      private function play2Click(e:MouseEvent) : void
      {
         player = gc.player2;
         if(btn_play2.upState != btn_play2.overState)
         {
            if(playerbtnState)
            {
               btn_play1.upState = playerbtnState;
            }
            playerbtnState = e.target.upState;
            e.target.upState = e.target.overState;
         }
         this.setJLZzs();
         this.setTxt();
      }
      
      private function exchangeClick(e:MouseEvent) : void
      {
         var bool:Boolean = false;
         var str:* = null;
         if(this.player.getSomeOneEquipNumberByName("wpmgh") >= 11)
         {
            bool = false;
            str = "背包";
            if(this.player.getSomeOneEquipNumberByName("jl" + this.whichzzs) <= 0 && this.player.djlist.length >= this.player.getMax())
            {
               str += "道具栏已满 ";
               bool = true;
            }
            if(bool)
            {
               gc.ts.setTxt(str);
               gc.stage.addChild(gc.ts);
               return;
            }
            this.hasbuy = true;
            this.removeSomeEquip("wpmgh",11);
            gc.putQhsInBackPack(this.player,"jl" + this.whichzzs);
            this.setTxt();
            gc.ts.setTxt("兑换成功");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            gc.ts.setTxt("玫瑰花数量不足");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function closeClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function ggClick(e:MouseEvent) : void
      {
         gc.eventManger.dispatchEvent(new CommonEvent("showGradenInterface"));
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
      
      private function updataClick(e:MouseEvent) : void
      {
         if(this.player.getSomeOneEquipNumberByName("jl" + this.whichzzs) >= 1 && this.player.getSomeOneEquipNumberByName("wpmgh") >= 99 && this.player.getSomeOneEquipNumberByName("mpyj") >= 1)
         {
            this.hasbuy = true;
            this.removeSomeEquip("jl" + this.whichzzs,1);
            this.removeSomeEquip("wpmgh",99);
            this.removeSomeEquip("mpyj",1);
            gc.putQhsInBackPack(this.player,"ss" + this.whichzzs);
            this.setTxt();
            gc.ts.setTxt("兑换成功");
            gc.stage.addChild(gc.ts);
         }
         else
         {
            gc.ts.setTxt("材料数量不足");
            gc.stage.addChild(gc.ts);
         }
      }
      
      private function removeSomeEquip(fname:String, num:int) : void
      {
         var sit:int = 0;
         var temp:MyEquipObj = this.player.getSomeEquipInPackBackByName(fname);
         if(temp.getENum() > num)
         {
            temp.setNum(-num);
         }
         else
         {
            sit = this.player.djlist.indexOf(temp);
            if(sit != -1)
            {
               this.player.djlist.splice(sit,1);
            }
         }
      }
      
      private function setJLZzs() : void
      {
         if(this.player.roleid == 1)
         {
            this.whichzzs = "qrcszzs";
         }
         else if(this.player.roleid == 2)
         {
            this.whichzzs = "qrzrzzs";
         }
         else if(this.player.roleid == 3)
         {
            this.whichzzs = "qrhdzzs";
         }
         else if(this.player.roleid == 4)
         {
            this.whichzzs = "qrmjzzs";
         }
      }
   }
}
