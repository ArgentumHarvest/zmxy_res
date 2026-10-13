package export.pack
{
   import flash.display.GradientType;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.GlowFilter;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import my.MyEquipObj;
   
   public class AttributeCon extends Sprite
   {
       
      
      private var attributeObj:MyEquipObj;
      
      private var bg:Sprite;
      
      private var info:Sprite;
      
      private var i:uint = 0;
      
      private var bigw:uint = 0;
      
      public function AttributeCon(param1:MyEquipObj)
      {
         this.bg = new Sprite();
         this.info = new Sprite();
         super();
         this.attributeObj = param1;
         this.addEventListener(Event.ADDED_TO_STAGE,this.added,false,0,true);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removed,false,0,true);
      }
      
      private function added(param1:Event) : void
      {
         this.drawInfo();
         this.drawbg();
         if(this.getChildIndex(this.bg) > this.getChildIndex(this.info))
         {
            this.swapChildren(this.bg,this.info);
         }
      }
      
      private function removed(param1:Event) : void
      {
      }
      
      private function drawInfo() : void
      {
         this.addChild(this.info);
         this.info.x = 20;
         this.info.y = 10;
         var _loc1_:TextFormat = new TextFormat();
         var _loc2_:TextField = new TextField();
         _loc2_.embedFonts = true;
         _loc1_.font = "FZCuYuan-M03S";
         _loc1_.color = this.attributeObj.color;
         _loc1_.size = 16;
         _loc2_.text = this.attributeObj.ename;
         _loc2_.setTextFormat(_loc1_);
         _loc2_.height = 25;
         _loc2_.width = _loc2_.textWidth + 10;
         ++this.i;
         this.drawpz("品质",this.attributeObj.color,this.attributeObj.quality);
         if(this.attributeObj.user != "")
         {
            this.drawpz("类型",16777215,this.attributeObj.etype + "·" + this.attributeObj.user);
         }
         else
         {
            this.drawpz("类型",16777215,this.attributeObj.etype);
         }
         this.drawAttribute();
         this.drawInstruction();
         this.drawValue();
         this.info.addChild(_loc2_);
      }
      
      private function drawpz(param1:String, param2:*, param3:String) : void
      {
         var _loc4_:TextFormat = new TextFormat();
         var _loc5_:TextField;
         (_loc5_ = new TextField()).embedFonts = true;
         _loc4_.font = "FZCuYuan-M03S";
         _loc4_.color = 0;
         _loc4_.size = 16;
         _loc4_.bold = true;
         _loc5_.filters = [this.GlowEffect()];
         _loc5_.text = param1;
         _loc5_.setTextFormat(_loc4_);
         _loc5_.y = this.i * 25;
         _loc5_.height = 25;
         _loc5_.width = _loc5_.textWidth + 10;
         if(this.bigw < _loc5_.width)
         {
            this.bigw = _loc5_.width;
         }
         this.info.addChild(_loc5_);
         var _loc6_:Sprite;
         (_loc6_ = new Sprite()).x = _loc5_.x + _loc5_.width - 4;
         _loc6_.y = _loc5_.y + _loc5_.height - 6;
         _loc6_.graphics.lineStyle(2,16777215);
         _loc6_.graphics.lineGradientStyle(GradientType.LINEAR,[16777215,16777215],[1,0],[120,255]);
         _loc6_.graphics.moveTo(0,0);
         _loc6_.graphics.lineTo(80,0);
         this.info.addChild(_loc6_);
         var _loc7_:TextFormat = new TextFormat();
         var _loc8_:TextField;
         (_loc8_ = new TextField()).embedFonts = true;
         _loc7_.font = "FZCuYuan-M03S";
         _loc7_.color = param2;
         _loc7_.size = 16;
         _loc8_.text = "  " + param3;
         _loc8_.setTextFormat(_loc7_);
         _loc8_.x = _loc5_.x + _loc5_.width;
         _loc8_.y = _loc5_.y - 1;
         _loc8_.height = 25;
         _loc8_.width = _loc8_.textWidth + 10;
         if(this.bigw < _loc8_.width)
         {
            this.bigw = _loc8_.width;
         }
         this.info.addChild(_loc8_);
         ++this.i;
      }
      
      private function drawAttribute() : void
      {
         if(this.attributeObj.ehp != 0)
         {
            this.drawSimpleAttribute("生命:",this.attributeObj.ehp);
         }
         if(this.attributeObj.emp != 0)
         {
            this.drawSimpleAttribute("魔法:",this.attributeObj.emp);
         }
         if(this.attributeObj.eatt != 0)
         {
            this.drawSimpleAttribute("攻击力:",this.attributeObj.eatt);
         }
         if(this.attributeObj.edef != 0)
         {
            this.drawSimpleAttribute("防御力:",this.attributeObj.edef);
         }
         if(this.attributeObj.ecrit != 0)
         {
            this.drawSimpleAttribute("暴击率:",this.attributeObj.ecrit * 100 + "%");
         }
         if(this.attributeObj.emiss != 0)
         {
            this.drawSimpleAttribute("闪避率:",this.attributeObj.emiss * 100 + "%");
         }
         if(this.attributeObj.eahp != 0)
         {
            this.drawSimpleAttribute("回血:",this.attributeObj.eahp);
         }
         if(this.attributeObj.eamp != 0)
         {
            this.drawSimpleAttribute("回魔:",this.attributeObj.eamp);
         }
      }
      
      private function drawSimpleAttribute(param1:String, param2:*, param3:uint = 0, param4:uint = 0) : void
      {
         var _loc5_:TextFormat;
         (_loc5_ = new TextFormat()).font = "FZCuYuan-M03S";
         _loc5_.color = 16750899;
         _loc5_.size = 16;
         _loc5_.bold = true;
         var _loc6_:TextField;
         (_loc6_ = new TextField()).embedFonts = true;
         _loc6_.text = param1 + "： " + param2;
         _loc6_.setTextFormat(_loc5_);
         _loc6_.y = this.i * 25;
         _loc6_.height = 25;
         _loc6_.width = _loc6_.textWidth + 10;
         this.info.addChild(_loc6_);
         ++this.i;
      }
      
      private function drawInstruction() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "FZCuYuan-M03S";
         _loc1_.color = 16777215;
         _loc1_.size = 14;
         var _loc2_:TextField = new TextField();
         _loc2_.wordWrap = true;
         _loc2_.embedFonts = true;
         _loc2_.text = this.attributeObj.instruction;
         _loc2_.setTextFormat(_loc1_);
         _loc2_.y = this.i * 25;
         _loc2_.height = _loc2_.textHeight + 10;
         _loc2_.width = 135;
         this.info.addChild(_loc2_);
         var _loc3_:uint = Math.round(_loc2_.height / 25);
         this.i += _loc3_;
      }
      
      private function drawValue() : void
      {
         var _loc1_:TextFormat = new TextFormat();
         _loc1_.font = "FZCuYuan-M03S";
         _loc1_.color = 16750899;
         _loc1_.size = 14;
         var _loc2_:TextField = new TextField();
         _loc2_.embedFonts = true;
         _loc2_.text = "价值 : " + this.attributeObj.value + " 灵魂";
         _loc2_.setTextFormat(_loc1_);
         _loc2_.y = this.i * 25;
         _loc2_.height = _loc2_.textHeight + 10;
         _loc2_.width = 135;
         this.info.addChild(_loc2_);
      }
      
      private function drawbg() : void
      {
         this.addChild(this.bg);
         this.bg.graphics.lineStyle(1,16777215);
         this.bg.graphics.beginFill(0,0.7);
         this.bg.graphics.drawRoundRect(0,0,this.info.width + 35,this.info.height + 10,5,5);
         this.bg.graphics.endFill();
      }
      
      private function GlowEffect() : GlowFilter
      {
         return new GlowFilter(16777215,1,2,2,5.3,BitmapFilterQuality.HIGH,false,false);
      }
   }
}
