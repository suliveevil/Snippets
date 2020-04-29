JSB.newAddon = function (mainPath) {
    return JSB.defineClass('SwitchTitle : JSExtension', /*Instance members*/{
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
            NSNotificationCenter.defaultCenter().addObserverSelectorName(self, 'onPopupMenuOnNote:', 'PopupMenuOnNote');
            self.switchtitle = NSUserDefaults.standardUserDefaults().objectForKey('marginnote.extension.switchtitle');
            self.autotitle = NSUserDefaults.standardUserDefaults().objectForKey('marginnote.extension.autotitle');
            self.autotitle_with_excerpt = NSUserDefaults.standardUserDefaults().objectForKey('marginnote.extension.autotitle_with_excerpt');
        },
        notebookWillClose: function (notebookid) {
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
                    image: 'switch.png',
                    object: self,
                    selector: 'toggleSwitchTitle:',
                    checked: (self.switchtitle),
                };
            return null;
        },
        //Clicking note
        onPopupMenuOnNote: function (sender) {
            if (!Application.sharedInstance().checkNotifySenderInWindow(sender, self.window)) return;//Don't process message from other window
            if (!self.switchtitle) return;
            let note = sender.userInfo.note;

            if (note) {
                let timerCount = 0;
                NSTimer.scheduledTimerWithTimeInterval(1, true, function (timer) {
                    let text = note.excerptText.split("**")[0];
                    UndoManager.sharedInstance().undoGrouping('SwitchTitle', note.notebookId, function () {
                        // let ok = text === note.noteTitle;
                        // Application.sharedInstance().showHUD(text+' 1 '+note.noteTitle+' '+ok, self.window, 2);
                        if (text && text.length) {
                            // Application.sharedInstance().showHUD(text+' 2 '+note.noteTitle+' '+ok, self.window, 2);
                            if (note.noteTitle) {
                                // Application.sharedInstance().showHUD(text+' 3 '+note.noteTitle+' '+ok, self.window, 2);
                                // 两者都有，且一样 -> 仅有摘录，无标题
                                if (text.trim() === note.noteTitle.trim()) {
                                    note.noteTitle = '';
                                }
                            } else {
                                // 仅有摘录，无标题 -> 只有标题，无摘录
                                note.noteTitle = text;
                                note.excerptText = note.excerptText.split('**').slice(1).join('**');
                            }
                        } else {
                            if (note.noteTitle) {
                                // 仅有标题，无摘录 -> 两者均有，且一样
                                note.excerptText = note.noteTitle;
                            }
                        }
                        Database.sharedInstance().setNotebookSyncDirty(note.notebookId);
                    });
                    NSNotificationCenter.defaultCenter().postNotificationNameObjectUserInfo('RefreshAfterDBChange', self, {topicid: note.notebookId});

                    timerCount++;
                    if (timerCount >= 1) {
                        timer.invalidate();
                    }
                });
            }
        },
        toggleSwitchTitle: function (sender) {
            let lan = NSLocale.preferredLanguages().length ? NSLocale.preferredLanguages()[0].substring(0, 2) : 'en';
            if (self.switchtitle) {
                self.switchtitle = false;
                let cnTips = '转化标题已关闭';
                let enTips = 'Switch title is turned off';
                Application.sharedInstance().showHUD(lan === 'zh' ? cnTips : enTips, self.window, 2);
            } else {
                self.switchtitle = true;
                let cnTips = '点击卡片后，摘录和标题将转化';
                let enTips = 'After clicking a card, the excerpt and title will be toggled';
                if (self.autotitle || self.autotitle_with_excerpt) {
                    // todo: invalid
                    self.autotitle = false;
                    self.autotitle_with_excerpt = false;
                    cnTips = '请确保其他标题插件已关闭';
                    enTips = 'Make sure that Other Title Plugin has been closed';
                }
                Application.sharedInstance().showHUD(lan === 'zh' ? cnTips : enTips, self.window, 2);
            }
            NSUserDefaults.standardUserDefaults().setObjectForKey(self.switchtitle, 'marginnote_switchtitle');
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

