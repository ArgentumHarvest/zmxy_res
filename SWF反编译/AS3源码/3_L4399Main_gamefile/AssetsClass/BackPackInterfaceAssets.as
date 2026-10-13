package AssetsClass
{
   import export.pack.BackPack;
   
   public class BackPackInterfaceAssets extends BaseAssets
   {
       
      
      private var num:uint;
      
      public function BackPackInterfaceAssets(_num:*)
      {
         this.num = _num;
         super(BackPack);
         this.loadAssets(["BackPackInterfacev1000.swf"]);
      }
      
      override protected function addContent() : void
      {
         this.content = new this.assetsClass();
         BackPack(this.content).setpack(this.num);
         this.addChild(this.content);
         this.content.addEventListener("removedFromStage",__contentRemoved);
      }
   }
}
