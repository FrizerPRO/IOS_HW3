//
//  THemePickerControllerViewController.swift
//  palebedev_1PW2
//
//  Created by Lebedev Petr on 01.11.2022.
//

import UIKit

class ThemePickerViewController: UIViewController,UIPickerViewDataSource,UIPickerViewDelegate {
    var pickerView: UIPickerView = UIPickerView()
    var pickerData = ["default"]
    var colorTheme: ColorTheme = ColorTheme()
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.backgroundColor = .orange
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        // Do any additional setup after loading the view.
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        
        do {
            (try fm.contentsOfDirectory(atPath: path)).forEach({
                [self] in
                if($0.hasSuffix(".json")){
                    self.pickerData.append(String($0.prefix($0.count - 5)))
                }
            })
        } catch {
        }
        print(pickerData)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    public func setupThemePicker(colorTheme: ColorTheme){
        self.colorTheme = colorTheme
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard pickerData[row] != "default"
        else{
            colorTheme.Copy(from: ColorTheme())
            return
        }
        if let directory = Bundle.main.path(forResource: pickerData[row], ofType: "json"){
            do{
                let text2 = try Data(contentsOf: URL(fileURLWithPath: directory))
                colorTheme.Copy(from: (try JSONDecoder().decode(ColorTheme.self, from: text2)))
            }
            catch{
                print("Has no json files")
            }
        }

    }

}
