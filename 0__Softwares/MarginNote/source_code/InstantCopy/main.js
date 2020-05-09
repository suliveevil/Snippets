JSB.newAddon = function (mainPath) {
    return JSB.defineClass('InstantCopy : JSExtension', /*Instance members*/{
        //Window initialize
        sceneWillConnect: function () {
            self.webController = WebViewController.new();
        },
        //Window disconnect
        sceneDidDisconnect: function () {
        },
        //Window resign active
        sceneWillResignActive: function () {
        },
        //Window become active
        sceneDidBecomeActive: function () {
        },
        notebookWillOpen: function (notebookid) {
            // New Excerpt
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onProcessExcerptText:', 'ProcessNewExcerpt');
            // Change Excerpt
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onProcessExcerptText:', 'ChangeExcerptRange');
            // Selecting text on pdf or epub
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onPopupMenuOnSelection:', 'PopupMenuOnSelection');
            // Clicking note
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onPopupMenuOnNote:', 'PopupMenuOnNote');
            self.instantCopy = NSUserDefaults.standardUserDefaults().objectForKey('marginnote_instantcopy');
        },
        notebookWillClose: function (notebookid) {
            NSNotificationCenter.defaultCenter().removeObserverName(self, 'ProcessNewExcerpt');
            NSNotificationCenter.defaultCenter().removeObserverName(self, 'ChangeExcerptRange');
            NSNotificationCenter.defaultCenter().removeObserverName(self, 'PopupMenuOnSelection');
            NSNotificationCenter.defaultCenter().removeObserverName(self, 'PopupMenuOnNote');
        },
        documentDidOpen: function (docmd5) {
        },
        documentWillClose: function (docmd5) {
        },
        controllerWillLayoutSubviews: function (controller) {
        },
        queryAddonCommandStatus: function () {
            if (Application.sharedInstance().studyController(self.window).studyMode < 3)
                return {
                    image: 'instantCopy.png',
                    object: self,
                    selector: 'toggleInstantCopy:',
                    checked: self.instantCopy
                };
            return null;
        },
        onPopupMenuOnSelection: function (sender) {
            if (!Application.sharedInstance().checkNotifySenderInWindow(sender, self.window)) return;//Don't process message from other window
            if (!self.instantCopy) return;
            let text = sender.userInfo.documentController.selectionText;
            if (text && text.length) {
                // Copy to Clipboard
                let pasteBoard = UIPasteboard.generalPasteboard();
                pasteBoard.string = text;
            }
        },
        onPopupMenuOnNote: function (sender) {
            if (!Application.sharedInstance().checkNotifySenderInWindow(sender, self.window)) return;//Don't process message from other window
            if (!self.instantCopy) return;
            let note = sender.userInfo.note;
            let titleText = note.noteTitle;
            let excerptText = note.excerptText.split("**")[0];
            let text = titleText || excerptText;
            if (text && text.length) {
                // Copy to Clipboard
                let pasteBoard = UIPasteboard.generalPasteboard();
                pasteBoard.string = text;
            }
        },
        onProcessExcerptText: function (sender) {
            if (!Application.sharedInstance().checkNotifySenderInWindow(sender, self.window)) return;//Don't process message from other window
            if (!self.instantCopy) return;
            let noteid = sender.userInfo.noteid;
            let note = noteid ? Database.sharedInstance().getNoteById(noteid) : {excerptText: '', noteTitle: ''};
            let text = note.excerptText || note.noteTitle;
            if (text && text.length) {
                // Copy to Clipboard
                let pasteBoard = UIPasteboard.generalPasteboard();
                pasteBoard.string = text;
            }
        },
        toggleInstantCopy: function (sender) {
            var lan = NSLocale.preferredLanguages().length ? NSLocale.preferredLanguages()[0].substring(0, 2) : 'en';
            let tips = lan === 'zh' ? '自动复制已关闭' : 'InstantCopy is turned off';
            if (self.instantCopy) {
                self.instantCopy = false;
            } else {
                self.instantCopy = true;
                tips = lan === 'zh' ? '选中的文字会被自动复制到系统剪贴板' : 'The selected text will be copied to the clipboard simultaneously';
            }
            Application.sharedInstance().showHUD(tips, self.window, 2);
            NSUserDefaults.standardUserDefaults().setObjectForKey(self.instantCopy, 'marginnote_instantcopy');
            Application.sharedInstance().studyController(self.window).refreshAddonCommands();
        },
    }, /*Class members*/{
        addonDidConnect: function () {
        },
        addonWillDisconnect: function () {
        },
        applicationWillEnterForeground: function () {
        },
        applicationDidEnterBackground: function () {
        },
        applicationDidReceiveLocalNotification: function (notify) {
        },
    });
};

