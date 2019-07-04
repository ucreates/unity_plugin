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
open class PreferenceViewControllerPlugin: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @objc
    public static let VIEWCONTROLLER_ID: Int = 2
    fileprivate static let CELL_NAME: String = "PREFERENCE_CELL"
    fileprivate static let CELL_NUM: Int = 5
    fileprivate static let PREFERENCE_COLOR: UIColor = UIColor(red: 0.937, green: 0.937, blue: 0.956, alpha: 1.0)
    fileprivate static let SECTION_TITLE: [String] = ["設定カテゴリ1", "設定カテゴリ2"]
    fileprivate static let SECTION_HEIGHT: CGFloat = UIScreen.main.bounds.height * 0.1
    fileprivate static let VIEW_CONTROLLER_NAME: String = "設定画面"
    fileprivate var tableView: UITableView!
    open override func viewDidLoad() -> Void {
        super.viewDidLoad()
        let backButton: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(PreferenceViewControllerPlugin.onClickReturnButton))
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
        self.tableView.separatorColor = UIColor.gray
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: PreferenceViewControllerPlugin.CELL_NAME)
        self.view.addSubview(self.tableView)
        return
    }
    open override func viewWillAppear(_ animated: Bool) -> Void {
        self.navigationController?.view.backgroundColor = PreferenceViewControllerPlugin.PREFERENCE_COLOR
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.setToolbarHidden(false, animated: false)
        self.tableView.reloadData()
        super.viewWillAppear(animated)
        return
    }
    open func numberOfSections(in tableView: UITableView) -> Int {
        return PreferenceViewControllerPlugin.SECTION_TITLE.count
    }
    open func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return PreferenceViewControllerPlugin.SECTION_TITLE[section]
    }
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PreferenceViewControllerPlugin.CELL_NUM
    }
    open func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return PreferenceViewControllerPlugin.SECTION_HEIGHT
    }
    open func tableView(_ tableView: UITableView, cellForRowAt cellForRowAtIndexPath: IndexPath) -> UITableViewCell {
        let identifier: String = PreferenceViewControllerPlugin.CELL_NAME + String(cellForRowAtIndexPath.section)
        var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: identifier)
        if (nil == cell) {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: identifier)
        }
        let tag: Int = cellForRowAtIndexPath.row + 1
        if (0 == cellForRowAtIndexPath.section) {
            cell?.textLabel?.text = String(format: "項目%02d", tag)
            cell?.textLabel?.backgroundColor = UIColor.white
            cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        } else if (1 == cellForRowAtIndexPath.section) {
            let id: String = "switch" + String(tag)
            let status: Bool = PreferencePlugin.getSwitchPreference(id)
            let switchView: UISwitch = UISwitch()
            switchView.addTarget(self, action: #selector(PreferenceViewControllerPlugin.onChangeSwitchStatus(_:)), for: UIControlEvents.valueChanged)
            switchView.isOn = status
            switchView.tag = tag
            cell?.selectionStyle = UITableViewCellSelectionStyle.default
            cell?.textLabel?.text = String(format: "項目%02d", tag)
            cell?.textLabel?.backgroundColor = UIColor.white
            cell?.accessoryView = switchView
        }
        return cell!
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) -> Void {
        if (0 != indexPath.section) {
            return
        }
        let url: URL = URL(string: UIApplicationOpenSettingsURLString)!
        let app: UIApplication = UIApplication.shared
        app.openURL(url)
        return
    }
    open func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) -> Void {
        let layer: CAShapeLayer = CAShapeLayer()
        let path: UIBezierPath = UIBezierPath(rect: cell.bounds)
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        let bgView: UIView = UIView(frame: cell.bounds)
        bgView.layer.insertSublayer(layer, at: 0)
        bgView.backgroundColor = UIColor.clear
        cell.backgroundColor = PreferenceViewControllerPlugin.PREFERENCE_COLOR
        cell.backgroundView = bgView
        return
    }
    @objc internal func onClickReturnButton() -> Void {
        func callback() -> Void {
            if (nil == self.tableView) {
                return
            }
            self.tableView.removeFromSuperview()
            return
        }
        let controller: UIViewController = ViewControllerPlugin.getInstance()
        controller.dismiss(animated: true, completion: callback)
        return
    }
    @objc internal func onChangeSwitchStatus(_ sender: UISwitch) -> Void {
        let id: String = "switch" + String(sender.tag)
        PreferencePlugin.setSwitchPreference(id, value: sender.isOn)
        return
    }
}
