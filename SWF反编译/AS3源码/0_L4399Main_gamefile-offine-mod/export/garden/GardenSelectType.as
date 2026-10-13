package export.garden
{
   import com.edgarcai.encrypt.binaryEncrypt;
   import com.edgarcai.gamelogic.Antiwear;
   import config.Config;
   import flash.display.SimpleButton;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class GardenSelectType extends Sprite
   {
       
      
      public var p1_btn:SimpleButton;
      
      public var p2_btn:SimpleButton;
      
      public var p3_btn:SimpleButton;
      
      public var btn_close:SimpleButton;
      
      private var gc:Config;
      
      private var _anti:Antiwear;
      
      public function GardenSelectType(_landId:uint)
      {
         _anti = new Antiwear(new binaryEncrypt());
         super();
         gc = Config.getInstance();
         this._anti.landId = _landId;
         this.addEventListener("addedToStage",added,false,0,true);
         this.addEventListener("removedFromStage",removed,false,0,true);
      }
      
      private function added(e:Event) : void
      {
         this.p1_btn.addEventListener("click",plant1Click);
         this.p2_btn.addEventListener("click",plant2Click);
         this.p3_btn.addEventListener("click",plant3Click);
         this.btn_close.addEventListener("click",xClick);
      }
      
      private function removed(e:Event) : void
      {
         this.p1_btn.removeEventListener("click",plant1Click);
         this.p2_btn.removeEventListener("click",plant2Click);
         this.p3_btn.removeEventListener("click",plant3Click);
         this.btn_close.removeEventListener("click",xClick);
      }
      
      private function plant1Click(e:MouseEvent) : void
      {
         var spf:SelectPlantInterface = new SelectPlantInterface(gc.dataObject.one,this._anti.landId);
         if(this.parent)
         {
            this.parent.addChild(spf);
            this.parent.removeChild(this);
         }
      }
      
      private function plant2Click(e:MouseEvent) : void
      {
         var spf:SelectPlantInterface = new SelectPlantInterface(gc.dataObject.three,this._anti.landId);
         if(this.parent)
         {
            this.parent.addChild(spf);
            this.parent.removeChild(this);
         }
      }
      
      private function plant3Click(e:MouseEvent) : void
      {
         var spf:SelectPlantInterface = new SelectPlantInterface(gc.dataObject.five,this._anti.landId);
         if(this.parent)
         {
            this.parent.addChild(spf);
            this.parent.removeChild(this);
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
