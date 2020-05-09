JSB.newAddon = function(mainPath){
  JSB.require('HtmlEditController');
  var newAddonClass = JSB.defineClass('MNCKEditor : JSExtension', /*Instance members*/{
    //Window initialize
    sceneWillConnect: function() {
      self.htmlController = HtmlEditController.new();
      Application.sharedInstance().studyController(self.window).addChildViewController(self.htmlController); //To fix 3.6.8 bug.
      self.htmlController.mainPath = mainPath;
      var editorFunc = function(html,text,respath,retfunc){
        self.htmlController.html = html;
        self.htmlController.text = text;
        self.htmlController.respath = respath;
        self.htmlController.retfunc = retfunc;
        return {'viewController':self.htmlController};
      };
      var image = UIImage.imageWithDataScale(NSData.dataWithContentsOfFile(mainPath + '/formula.png'),2);
      var lan = NSLocale.preferredLanguages().length?NSLocale.preferredLanguages()[0].substring(0,2):'en';
      var title = (lan == 'zh')?'公式和表格':'Formulas and tables';
      Application.sharedInstance().regsiterHtmlCommentEditor({title:title,image:image},editorFunc,null,'MNCKEditor');
    },
    //Window disconnect
    sceneDidDisconnect: function() {
      self.htmlController.removeFromParentViewController();
      Application.sharedInstance().unregsiterHtmlCommentEditor('MNCKEditor');
    },
    //Window resign active
    sceneWillResignActive: function() {
    },
    //Window become active
    sceneDidBecomeActive: function() {
    },
    notebookWillOpen: function(notebookid) {
    },
    notebookWillClose: function(notebookid) {
    },
    documentDidOpen: function(docmd5) {
    },
    documentWillClose: function(docmd5) {
    },
    controllerWillLayoutSubviews: function(controller) {
    },
  }, /*Class members*/{
    addonDidConnect: function() {
    },
    addonWillDisconnect: function() {
    },
    applicationWillEnterForeground: function() {
    },
    applicationDidEnterBackground: function() {
    },
    applicationDidReceiveLocalNotification: function(notify) {
    },
  });
  return newAddonClass;
};

