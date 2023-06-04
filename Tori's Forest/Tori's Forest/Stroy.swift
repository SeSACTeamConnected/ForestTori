//
//  Stroy.swift
//  Tori's Forest
//
//  Created by Nayeon Kim on 2023/06/05.
//

import SwiftUI

struct Message: Identifiable {
    let id: Int
    var message: Array<String>
}

struct Plant: Identifiable {
    let id: Int
    var name: String
    var detail: String
    var images: Array<String>
    var missions: Array<String>
    var messages: [Message]
}

struct Chapter: Identifiable {
    let id: Int
    var days: Int
    var plants: [Plant]
}

class ChapterStore: ObservableObject {
    static let shared = ChapterStore()
    
    var chapters: [Chapter] = []
    
    private init() {
        let chapter1 = Chapter(id: 0, days: 3, plants: [
            Plant(id: 0, name: "데이지", detail: "하루에 한 번 샤워하기", images: ["test1", "test2", "test3"], missions: Array(repeating: "샤워하기", count: 3), messages: [
            Message(id: 0, message: ["안녕?", "메시지1"]),
            Message(id: 1, message: ["안녕?", "메시지2"]),
            Message(id: 2, message: ["안녕?", "메시지3"])
            ]),
            Plant(id: 1, name: "민들레", detail: "창문 열고 환기하기", images: ["test1", "test2", "test3"], missions: Array(repeating: "환기하기", count: 3), messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 2, name: "유채꽃", detail: "일어나자마자 이불 정리하기", images: ["test1", "test2", "test3"], missions: Array(repeating: "이부정리하기", count: 3), messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 3, name: "은방울꽃", detail: "방청소하기", images: ["test1", "test2", "test3"], missions: Array(repeating: "방청소하기", count: 3), messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 4, name: "하늘매발톱", detail: "매일 아침 개운하게 양치하기", images: ["test1", "test2", "test3"], missions: Array(repeating: "양치하기", count: 3), messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ])
        ])
        
        let chapter2 = Chapter(id: 1, days: 3, plants: [
            Plant(id: 0, name: "기쁠때춤추는선인장", detail: "Details of Plant1", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 1, name: "???", detail: "Details of Plant2", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 2, name: "???", detail: "Details of Plant3", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 3, name: "???", detail: "Details of Plant4", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 4, name: "???", detail: "Details of Plant5", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ])
        ])

        let chapter3 = Chapter(id: 2, days: 3, plants: [
            Plant(id: 0, name: "호박나무", detail: "Details of Plant1", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 1, name: "단풍나무", detail: "Details of Plant2", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 2, name: "책 나무", detail: "Details of Plant3", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 3, name: "???", detail: "Details of Plant4", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 4, name: "은행나무", detail: "Details of Plant5", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                  Message(id: 0, message: ["안녕?", "메시지1"]),
                  Message(id: 1, message: ["안녕?", "메시지2"]),
                  Message(id: 2, message: ["안녕?", "메시지3"])
                  ])
        ])

        let chapter4 = Chapter(id: 3, days: 3, plants: [
            Plant(id: 0, name: "???", detail: "Details of Plant1", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 1, name: "마시멜로핫초코나무", detail: "Details of Plant2", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 2, name: "포인세티아", detail: "Details of Plant3", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 3, name: "???", detail: "Details of Plant4", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 4, name: "흰동백나무", detail: "Details of Plant5", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 5, name: "???", detail: "Details of Plant6", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 6, name: "???", detail: "Details of Plant7", images: ["test1", "test2", "test3"], missions: ["양치하기", "환기하기", "운동하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ]),
            Plant(id: 7, name: "목화나무", detail: "봉사 활동 해보기", images: ["test1", "test2", "test3"], missions: ["1365포털 가입하고 봉사 활동 신청하기", "봉사 활동 하기", "봉사 시간과 수료증 확인하기"], messages: [
                Message(id: 0, message: ["안녕?", "메시지1"]),
                Message(id: 1, message: ["안녕?", "메시지2"]),
                Message(id: 2, message: ["안녕?", "메시지3"])
                ])
        ])
        
        chapters.append(chapter1)
        chapters.append(chapter2)
        chapters.append(chapter3)
        chapters.append(chapter4)
    }
}
