import UIKit

// NOTE: CouchbaseLite framework disabled for arm64 simulator compatibility.
// To re-enable, uncomment CouchbaseLite-Swift in Podfile and run pod install.

class CouchBaseExerciseVC: UIViewController {

    @IBOutlet weak var nameTextfield: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var diseaseTextField: UITextField!

    let CBKeyPatientName = "CouchKeyPatientName"
    let CBKeyPatientAge = "CouchKeyPatientAge"
    let CBKeyPatientGender = "CouchKeyPatientGender"
    let CBKeyPatientDisease = "CouchKeyPatientDisease"

    let CBValuePatientName = "Jane Roe"
    let CBValuePatientAge = "52"
    let CBValuePatientGender = "Female"
    let CBValuePatientDisease = "Cancer"

    override func viewDidLoad() {
        super.viewDidLoad()
        saveData()
    }

    func saveData() {
        // Store in UserDefaults as a fallback (CouchbaseLite disabled)
        if UserDefaults.standard.object(forKey: "couchbase_patient") == nil {
            let properties: [String: String] = [
                CBKeyPatientName: CBValuePatientName,
                CBKeyPatientAge: CBValuePatientAge,
                CBKeyPatientGender: CBValuePatientGender,
                CBKeyPatientDisease: CBValuePatientDisease
            ]
            UserDefaults.standard.set(properties, forKey: "couchbase_patient")
        }
    }

    @IBAction func verifyItemPressed() {
        let info: [String: String] = [
            CBKeyPatientName: nameTextfield.text ?? "",
            CBKeyPatientAge: ageTextField.text ?? "",
            CBKeyPatientGender: genderTextField.text ?? "",
            CBKeyPatientDisease: diseaseTextField.text ?? ""
        ]

        let isVerified = verifyPatientInfo(info)
        UIAlertController.showAlertWith(title: "iGoat", message: isVerified ? "Success!!" : "Failed")
    }

    func verifyPatientInfo(_ info: [String: String]) -> Bool {
        guard let stored = UserDefaults.standard.dictionary(forKey: "couchbase_patient") as? [String: String] else {
            return false
        }

        return stored[CBKeyPatientName] == info[CBKeyPatientName] &&
               stored[CBKeyPatientAge] == info[CBKeyPatientAge] &&
               stored[CBKeyPatientGender] == info[CBKeyPatientGender] &&
               stored[CBKeyPatientDisease] == info[CBKeyPatientDisease]
    }
}
