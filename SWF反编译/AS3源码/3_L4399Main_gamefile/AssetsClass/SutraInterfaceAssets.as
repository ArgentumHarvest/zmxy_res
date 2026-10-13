package AssetsClass
{
   import base.BaseHero;
   import export.strength.SutraInterface;
   
   public class SutraInterfaceAssets extends BaseAssets
   {
       
      
      private var hero:BaseHero;
      
      public function SutraInterfaceAssets(_hero:BaseHero)
      {
         this.hero = _hero;
         super(SutraInterface);
         this.loadAssets(["SutraInterfacev1320.swf"]);
      }
      
      override protected function addContent() : void
      {
         super.addContent();
         SutraInterface(this.content).setRole(this.hero);
      }
      
      override public function destroy() : void
      {
         super.destroy();
         this.hero = null;
      }
   }
}
