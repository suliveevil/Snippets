var HtmlEditController = JSB.defineClass('HtmlEditController : UIViewController', {
  viewDidLoad: function() {
    var webFrame = self.view.bounds;

    self.webView = new UIWebView(webFrame);
    
    self.webView.scalesPageToFit = true;
    self.webView.autoresizingMask = (1 << 1 | 1 << 4);
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    self.view.addSubview(self.webView);
    
  },
  viewWillAppear: function(animated) {
    self.loaded = false;
    self.webView.delegate = self;
    self.view.backgroundColor = Application.sharedInstance().defaultNotebookColor;
    self.webView.backgroundColor = Application.sharedInstance().defaultNotebookColor;
    self.webView.loadRequest(NSURLRequest.requestWithURL(NSURL.fileURLWithPath(self.mainPath + '/CKEditor/editor.html')));
  },
  viewWillDisappear: function(animated) {
    if(!self.loaded){
      self.retfunc({html:self.html,dirty:false});        
      return;
    }
    self.webView.evaluateJavaScript('CKEDITOR.instances.editor1.checkDirty();',function(ret){
      if(ret == true){
        self.webView.evaluateJavaScript('CKEDITOR.instances.editor1.getData();',function(ret){
          if(ret && typeof ret === 'string'){
            self.html = ret;
          }
          //calculate size
          self.webView.evaluateJavaScript('CKEDITOR.instances.editor1.resize(400,1600);\
            var size = {width:CKEDITOR.instances.editor1.editable().$.offsetWidth,height:CKEDITOR.instances.editor1.editable().$.offsetHeight};\
            size;',function(ret){
              var size = JSON.parse(ret);
              self.retfunc({html:self.html,dirty:true,size:size});
            });
        });
      }
      else{
        self.retfunc({html:self.html,dirty:false});        
      }
    });
    self.webView.delegate = null;
  },
  viewWillLayoutSubviews: function() {
    if(self.loaded){
      var h = self.webView.bounds.height - 40;
      self.webView.evaluateJavaScript("CKEDITOR.instances.editor1.resize( '100%'," + h + " );");
    }
  },
  scrollViewDidScroll: function() {
  },
  webViewDidStartLoad: function(webView) {
  },
  webViewDidFinishLoad: function(webView) {
    self.loaded = true;
    self.webView.evaluateJavaScript("document.getElementById('editor1').innerHTML='"+self.html.replace(/'/g,"\\'")+"';");
    NSTimer.scheduledTimerWithTimeInterval(0.2,false,function(timer){
      var h = self.webView.bounds.height - 40;
      self.webView.evaluateJavaScript("CKEDITOR.instances.editor1.resize( '100%'," + h + " );CKEDITOR.instances.editor1.resetDirty();");
      self.webView.evaluateJavaScript("document.getElementById('editor1').focus();",function(ret){});
    });
    var backColor = '#' + Application.sharedInstance().defaultNotebookColor.hexStringValue;
    var textColor = '#' + Application.sharedInstance().defaultTextColor.hexStringValue;
    self.webView.evaluateJavaScript(
        "CKEDITOR.instances.editor1.on('instanceReady', function(e) {\
            e.editor.document.getBody().setStyle('background-color', '"+backColor+"');\
            e.editor.document.getBody().setStyle('color', '"+textColor+"');\
            e.editor.on('contentDom', function() {\
                e.editor.document.getBody().setStyle('background-color', '"+backColor+"');\
                e.editor.document.getBody().setStyle('color', '"+textColor+"');\
            });\
        });");
  },
  webViewDidFailLoadWithError: function(webView, error) {
  },
});


