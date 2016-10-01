// ======================================================================
// Project Name    : unity plugin
//
// Copyright © 2016 U-CREATES. All rights reserved.
//
// This source code is the property of U-CREATES.
// If such findings are accepted at any time.
// We hope the tips and helpful in developing.
//======================================================================
import Foundation
import UIKit
public class PreferenceViewControllerPlugin: UIViewController, UITableViewDataSource, UITableViewDelegate {
    public static let VIEWCONTROLLER_ID: Int = 2
    private static let CELL_NAME: String = "PREFERENCE_CELL"
    private static let CELL_NUM: Int = 5
    private static let PREFERENCE_COLOR: UIColor = UIColor(red: 0.937, green: 0.937, blue: 0.956, alpha: 1.0)
    private static let SECTION_TITLE: [String] = ["設定カテゴリ1", "設定カテゴリ2"]
    private static let SECTION_HEIGHT: CGFloat = UIScreen.mainScreen().bounds.height * 0.1
    private static let VIEW_CONTROLLER_NAME: String = "設定画面"
    private var tableView: UITableView!
    override public func viewDidLoad() {
        super.viewDidLoad()
        let backButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(PreferenceViewControllerPlugin.onClickReturnButton))
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        let height: CGFloat = controller.view.frame.height
        let width: CGFloat = controller.view.frame.width
        let tableFrame: CGRect = CGRect(x: 0, y: 0, width: width, height: height)
        self.navigationItem.leftBarButtonItem = backButton
        self.title = PreferenceViewControllerPlugin.VIEW_CONTROLLER_NAME
        self.tableView = UITableView(frame: tableFrame)
        self.tableView.backgroundColor = PreferenceViewControllerPlugin.PREFERENCE_COLOR
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.separatorColor = UIColor.grayColor()
        self.tableView.tableFooterView = UIView()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: PreferenceViewControllerPlugin.CELL_NAME)
        self.view.addSubview(self.tableView)
        return
    }
    override public func viewWillAppear(animated: Bool) {
        self.navigationController?.view.backgroundColor = PreferenceViewControllerPlugin.PREFERENCE_COLOR
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.tableView.reloadData()
        super.viewWillAppear(animated)
        return
    }
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return PreferenceViewControllerPlugin.SECTION_TITLE.count
    }
    public func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return PreferenceViewControllerPlugin.SECTION_TITLE[section]
    }
    public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PreferenceViewControllerPlugin.CELL_NUM
    }
    public func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PreferenceViewControllerPlugin.SECTION_HEIGHT
    }
    public func tableView(tableView: UITableView, cellForRowAtIndexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = PreferenceViewControllerPlugin.CELL_NAME + String(cellForRowAtIndexPath.section)
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier(identifier)
        if (nil == cell) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        }
        let tag: Int = cellForRowAtIndexPath.row + 1
        if (0 == cellForRowAtIndexPath.section) {
            cell?.textLabel?.text = String(format: "項目%02d", tag)
            cell?.textLabel?.backgroundColor = UIColor.whiteColor()
            cell?.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        } else if (1 == cellForRowAtIndexPath.section) {
            let id: String = "switch" + String(tag)
            let status: Bool = PreferencePlugin.getSwitchPreference(id)
            let switchView: UISwitch = UISwitch()
            switchView.addTarget(self, action: #selector(PreferenceViewControllerPlugin.onChangeSwitchStatus(_:)), forControlEvents: UIControlEvents.ValueChanged)
            switchView.on = status
            switchView.tag = tag
            cell?.selectionStyle = UITableViewCellSelectionStyle.Default
            cell?.textLabel?.text = String(format: "項目%02d", tag)
            cell?.textLabel?.backgroundColor = UIColor.whiteColor()
            cell?.accessoryView = switchView
        }
        return cell!
    }
    public func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (0 != indexPath.section) {
            return
        }
        let url: NSURL = NSURL(string: UIApplicationOpenSettingsURLString)!
        let app: UIApplication = UIApplication.sharedApplication()
        app.openURL(url)
        return
    }
    public func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath(rect: cell.bounds)
        layer.path = path.CGPath
        layer.fillColor = UIColor.whiteColor().CGColor
        let bgView: UIView = UIView(frame: cell.bounds)
        bgView.layer.insertSublayer(layer, atIndex: 0)
        bgView.backgroundColor = UIColor.clearColor()
        cell.backgroundColor = PreferenceViewControllerPlugin.PREFERENCE_COLOR
        cell.backgroundView = bgView
        return
    }
    internal func onClickReturnButton() {
        func callback() -> Void {
            if (nil == self.tableView) {
                return
            }
            self.tableView.removeFromSuperview()
            return
        }
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.dismissViewControllerAnimated(true, completion: callback)
        return
    }
    internal func onChangeSwitchStatus(sender: UISwitch) {
        let id: String = "switch" + String(sender.tag)
        PreferencePlugin.setSwitchPreference(id, value: sender.on)
        return
    }
}
