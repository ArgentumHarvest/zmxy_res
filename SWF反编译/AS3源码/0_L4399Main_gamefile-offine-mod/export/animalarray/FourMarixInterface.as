package export.animalarray
{
   import config.Config;
   import event.CommonEvent;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class FourMarixInterface extends Sprite
   {
       
      
      private var gc:Config;
      
      public var xbtn:SimpleButton;
      
      private var mName:String;
      
      public function FourMarixInterface(_mName:String)
      {
         trace("--FourMarixInterface--");
         super();
         gc = Config.getInstance();
         this.mName = _mName;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         trace("this.mName：" + this.mName);
         xbtn.addEventListener("click",xClick);
         if(this.mName == "south")
         {
            this.addSuzakuMar();
         }
         else if(this.mName == "north")
         {
            this.addBasalticMar();
         }
         gc.eventManger.addEventListener("ChangeMarix",changeMarix);
      }
      
      private function removed(e:Event) : void
      {
         xbtn.removeEventListener("click",xClick);
         gc.eventManger.removeEventListener("ChangeMarix",changeMarix);
      }
      
      private function addSuzakuMar() : void
      {
         var sk:SuzakuMar = new SuzakuMar();
         sk.x = 154.85;
         sk.y = 87.4;
         this.addChild(sk);
         if(this.getChildIndex(sk) > this.getChildIndex(this.xbtn))
         {
            this.swapChildren(sk,this.xbtn);
         }
      }
      
      private function addBasalticMar() : void
      {
         var bl:Basaltic = new Basaltic();
         bl.x = 154.85;
         bl.y = 87.4;
         this.addChild(bl);
         if(this.getChildIndex(bl) > this.getChildIndex(this.xbtn))
         {
            this.swapChildren(bl,this.xbtn);
         }
      }
      
      protected function changeMarix(e:CommonEvent) : void
      {
         var data:String = e.data as String;
         trace("data ---->>" + data);
         var ary:Array = data.split("_") as Array;
         if(ary[0] == "suzaku")
         {
            if(ary[1] == "right")
            {
               this.addBasalticMar();
            }
         }
         else if(ary[0] == "basaltic")
         {
            if(ary[1] == "left")
            {
               this.addSuzakuMar();
            }
         }
         else if(ary[0] != "")
         {
            if(ary[0] == "")
            {
            }
         }
      }
      
      private function xClick(e:MouseEvent) : void
      {
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
      }
   }
}
