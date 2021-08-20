# My School
### 학교 스케줄 관리 어플리케이션
> 수업에서 제공된 서버 문제로 로그인되지 않음
---
### 1.  개발 목표
+ 모바일앱프로그래밍 수업을 수강하며 과제로 제출하고자 한다.
+ 코로나-19로 사이버 강의로 대체되면서 과제와 출석(수업 시청)을 놓치게 되는 경우가 많아 강의/과제/시험으로 나누어 편하게 관리하도록 한다.
+ 전반적인 개발 기초 지식을 쌓는다.
+ APM(Apache, PHP, MySql)을 사용한다.
+ core data를 활용한다.
+ 테이블을 생성하여 데이터를 관리한다.

### 2.  개발 언어
+ Swift 


### 3.  개발 툴
+ Xcode 

### 4.  최적화 디바이스
+ iPhone XR/XS Max/11/11 Pro Max  


### 5.  주요 기능
+ 로그인 - 서버에 아이디 비밀번호 저장 및 확인
+ 과목 입력 - 입력한 값 coredata에 저장
+ 스케줄 - 색상과 과목이 대입되어 과목을 추가하면 해당 색상으로 스케줄 추가
+ 메모 - 텍스트를 coredata에 저장하여 추가하거나 확인 및 삭제


### 6.  스크린샷
<img src="https://user-images.githubusercontent.com/63438947/129935690-4cf26d02-b20c-418f-a48e-552fb7d0d0ce.png" width="30%">  <img src="https://user-images.githubusercontent.com/63438947/129935703-61363168-b4de-469c-bf63-9ea362ccba82.png" width="30%">  <img src="https://user-images.githubusercontent.com/63438947/129935707-c5ab38bc-29d2-4732-9871-f325a69993f5.png" width="30%">  <img src="https://user-images.githubusercontent.com/63438947/129935710-323990ca-8e23-41ba-ae29-801193230b14.png" width="30%">  <img src="https://user-images.githubusercontent.com/63438947/129935712-50962ff9-d333-4276-91a1-34bfee57b72a.png" width="30%">  



### 7.  주요 개발 사항
+ core data를 활용하여 과목에 따른 cell색상 지정 


  1. 사용자가 저장한 강의명을 각 변수로 저장
  2. picker에 강의명 업데이트
  3. picker입력시 1에서 저장한 변수와 비교해서 cell컬러 설정
```Swift
  @IBAction func buttonColorSave(_ sender: UIBarButtonItem) {
        
        textColor1.isUserInteractionEnabled = false
        textColor2.isUserInteractionEnabled = false
        textColor3.isUserInteractionEnabled = false
        textColor4.isUserInteractionEnabled = false
        textColor5.isUserInteractionEnabled = false
        textColor6.isUserInteractionEnabled = false
        textColor7.isUserInteractionEnabled = false
        textColor8.isUserInteractionEnabled = false
        textColor9.isUserInteractionEnabled = false
        
        let context = self.getContext()
        let entity = NSEntityDescription.entity(forEntityName: "Color", in: context)
        let object = NSManagedObject(entity: entity!, insertInto: context)
        
        if textColor1.text != ""{
            object.setValue(textColor1.text, forKey: "color1")
            existColorForPicker += 1
        }
        if textColor2.text != ""{
            object.setValue(textColor2.text, forKey: "color2")
            existColorForPicker += 1
        }
        if textColor3.text != ""{
            object.setValue(textColor3.text, forKey: "color3")
            existColorForPicker += 1
        }
        if textColor4.text != ""{
            object.setValue(textColor4.text, forKey: "color4")
            existColorForPicker += 1
        }
        if textColor5.text != ""{
            object.setValue(textColor5.text, forKey: "color5")
            existColorForPicker += 1
        }
        if textColor6.text != ""{
            object.setValue(textColor6.text, forKey: "color6")
            existColorForPicker += 1
        }
        if textColor7.text != ""{
            object.setValue(textColor7.text, forKey: "color7")
            existColorForPicker += 1
        }
        if textColor8.text != ""{
            object.setValue(textColor8.text, forKey: "color8")
            existColorForPicker += 1
        }
        if textColor9.text != ""{
            object.setValue(textColor9.text, forKey: "color9")
            existColorForPicker += 1
        }
        
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError{
            print("Could not save \(error), \(error.userInfo)")
        }
        let alert = UIAlertController(title: "완료!", message: "색상이 적용되었습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.existColorNumber = self.existColorForPicker
        
    }
```


