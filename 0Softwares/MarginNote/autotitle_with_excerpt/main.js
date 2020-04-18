JSB.newAddon = function (mainPath) {
    return JSB.defineClass('AutoTitleWithExcerpt : JSExtension', /*Instance members*/{
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
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onProcessExcerptText:', 'ProcessNewExcerpt');
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onProcessExcerptText:', 'ChangeExcerptRange');
            self.autotitle = NSUserDefaults.standardUserDefaults().objectForKey('marginnote.extension.autotitle');
            self.autotitle_with_excerpt = NSUserDefaults.standardUserDefaults().objectForKey('marginnote.extension.autotitle_with_excerpt');
        },
        notebookWillClose: function (notebookid) {
            NSNotificationCenter.defaultCenter().removeObserverName(self, 'ProcessNewExcerpt');
            NSNotificationCenter.defaultCenter().removeObserverName(self, 'ChangeExcerptRange');
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
                    image: 'title.png',
                    object: self,
                    selector: 'toggleAutoTitleWithExcerpt:',
                    checked: (self.autotitle_with_excerpt),
                };
            return null;
        },
        //Clicking note
        onProcessExcerptText: function (sender) {
            if (!Application.sharedInstance().checkNotifySenderInWindow(sender, self.window)) return;//Don't process message from other window
            if (!self.autotitle_with_excerpt) return;
            var noteid = sender.userInfo.noteid;
            var note = Database.sharedInstance().getNoteById(noteid);
            if (note && note.excerptText && note.excerptText.length > 0 && note.excerptText.length <= 250) {
                var timerCount = 0;
                NSTimer.scheduledTimerWithTimeInterval(1, true, function (timer) {
                    var text = note.excerptText.split("**").join("");
                    if (text && text.length) {
                        UndoManager.sharedInstance().undoGrouping('AutoTitleWithExcerpt', note.notebookId, function () {
                            note.noteTitle = text;
                            note.excerptText = text;
                            // todo:
                            //  创建后保存有延迟？
                            //  导致如果不点空白处继续修改标题，显示异常。如果点击空白处将焦点移出该卡片，在修改标题，正常
                            Database.sharedInstance().setNotebookSyncDirty(note.notebookId);
                        });
                        NSNotificationCenter.defaultCenter().postNotificationNameObjectUserInfo('RefreshAfterDBChange', self, {topicid: note.notebookId});
                    }
                    timerCount++;
                    if (timerCount >= 4) {
                        timer.invalidate();
                    }
                });
            }
        },
        toggleAutoTitleWithExcerpt: function (sender) {
            let lan = NSLocale.preferredLanguages().length ? NSLocale.preferredLanguages()[0].substring(0, 2) : 'en';
            if (self.autotitle_with_excerpt) {
                self.autotitle_with_excerpt = false;
                let cnTips = '自动设置标题和摘录已关闭';
                let enTips = 'Auto title with excerpt is turned off';
                Application.sharedInstance().showHUD(lan === 'zh' ? cnTips : enTips, self.window, 2);
            } else {
                self.autotitle_with_excerpt = true;
                let cnTips = '创建摘录后，摘录内容将自动被添加标题';
                let enTips = 'After creating an excerpt, the excerpt will be automatically add the note title';
                if (self.autotitle) {
                    // todo: invalid
                    self.autotitle = false;
                    cnTips = '请确保官版自动标题插件已关闭';
                    enTips = 'Make sure that Autotitle plugin has been closed';
                }
                Application.sharedInstance().showHUD(lan === 'zh' ? cnTips : enTips, self.window, 2);
            }
            NSUserDefaults.standardUserDefaults().setObjectForKey(self.autotitle_with_excerpt, 'marginnote_autotitle_with_excerpt');
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

