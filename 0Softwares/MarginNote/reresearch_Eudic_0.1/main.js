JSB.newAddon = function(mainPath) {
    // baseUrl can be modified as needed.
    // Google: http://www.google.com/search?q={keyword}
    // Baidu: http://www.baidu.com/s?wd={keyword}
    // the baseUrl can also be URL Scheme such as eudic://dict/{keyword}
    // eudic-de://dict/{keyword}
    var baseUrl = "eudic-de://dict/";
    //MARK: - Customized functions
    // URL generation
    function generateUrl(keyWords) {
        // return baseUrl + keyWords.replace(/ +/g, "+");
        return baseUrl + keyWords;
    }
    // Open External Browser
    function openUrlWithExternalBrowser(url) {
        // endoce URL to utf-8. NSURL cannot handle Chinese url
        let encodedUrl = encodeURI(url);
        UIApplication.sharedApplication().openURL(NSURL.URLWithString(encodedUrl));
    }
    //MARK - Addon Class definition
    var newAddonClass= JSB.defineClass('ReResearchAddon : JSExtension', {
        //Mark: - Instance Method Definitions
        // Window initialize
        sceneWillConnect: function() {
        },
        // Window disconnect
        sceneDidDisconnect: function() {
        },
        // Window resign active
        sceneWillResignActive: function() {
        },
        // Window become active
        sceneDidBecomeActive: function() {
        },
        //MARK: MN behaviors
        notebookWillOpen: function(notebookid) {
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onPopupMenuOnSelection:', 'PopupMenuOnSelection');
            self.reResearchIsOn = NSUserDefaults.standardUserDefaults().objectForKey('marginnote_reresearch');
        },
        notebookWillClose: function(notebookid) {
            NSNotificationCenter.defaultCenter().removeObserverName(self,'PopupMenuOnSelection');
        },
        documentDidOpen: function(docmd5) {
        },
        docmentWillClose: function(docmd5) {
        },
        controllerWillLayoutSubviews: function(controller) {
        },
        queryAddonCommandStatus: function() {
            if(Application.sharedInstance().studyController(self.window).studyMode < 3) {
                return {
                    image: 'reresearch.png',
                    object: self,
                    selector: "toggleReResearch:",
                    checked: self.reResearchIsOn
                };
            }
            return null;
        },

        // Select text and open the external Browser to process the selected Text
        onPopupMenuOnSelection: function(sender) {
            if(!Application.sharedInstance().checkNotifySenderInWindow(sender,self.window)) {
                return; // Don't process message from other window
            }
            if(!self.reResearchIsOn) {
                return;
            }
            var text = sender.userInfo.documentController.selectionText;
            if(text && text.length) {
                let url = generateUrl(text);
                openUrlWithExternalBrowser(url);
            }
        },
        // Add-On Switch
        toggleReResearch: function(sender) {
            var lan = NSLocale.preferredLanguages().length ? NSLocale.preferredLanguages()[0].substring(0, 2) : 'en';
            let tips = lan === 'zh' ? 'ReResearch插件已关闭' : 'ReResearch is off';
            if(self.reResearchIsOn) {
                self.reResearchIsOn = false;
            } else {
                self.reResearchIsOn = true;
                tips = lan === 'zh' ? 'ReResearch插件已开启，所选文字将被外部浏览器处理' : 'ReResearch is on. Process selected Text in the external Browser';
            }
            Application.sharedInstance().showHUD(tips, self.window, 2);
            NSUserDefaults.standardUserDefaults().setObjectForKey(self.reResearchIsOn, 'marginnote_reresearch');
            Application.sharedInstance().studyController(self.window).refreshAddonCommands();
        },
    }, {
        //MARK: - Class Method Definitions
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
