//
//  CardModel.swift
//  Tori's Forest
//
//  Created by 김다빈 on 2023/06/16.
//
import SwiftUI
import Foundation

struct SelectModel: Identifiable{
    let id = UUID()
    let chapter: Int64
    let header: String
    let PlantName: String
    let imageName : String
    let discription: String
    
}

let Selects: [SelectModel] = [
    .init(chapter: 0, header: "매일 창문 30분 열어 환기하기", PlantName: "민들레씨", imageName: "STR_Img_PlantSelect_Spring_1", discription: "겁이 많은 민들레씨들이 하늘로 날아가지 못하고 있어요. 용기를 낼 수 있게 매일 창문을 열어 민들레씨들을 도와줄래요?"),
    .init(chapter: 0, header: "양치하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Spring_2", discription: "???"),
    .init(chapter: 0, header: "일어나자마자 이불 정리하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Spring_3", discription: "???"),
    .init(chapter: 0, header: "하루에 한번 샤워하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Spring_4", discription: "???"),
    .init(chapter: 0, header: "방청소 하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Spring_5", discription: "???"),
    .init(chapter: 1, header: "내가 좋아하는 것 기록하기", PlantName: "작은 선인장", imageName: "STR_Img_PlantSelect_Summer_1", discription: "꿈을 찾으려 먼 사막에서 온 작은 선인장 친구는\n자신이 무엇을 좋아하는지 몰라 난처해 하고 있어요.\n함께 찾아볼까요?"),
    .init(chapter: 1, header: "하루 5분씩 명상하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Summer_2", discription: "???"),
    .init(chapter: 1, header: "스스로 칭찬 노트 작성하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Summer_3", discription: "???"),
    .init(chapter: 1, header: "하루에 한 번 책읽기", PlantName: "???", imageName: "STR_Img_PlantSelect_Summer_4", discription: "???"),
    .init(chapter: 1, header: "버킷리스트 작성하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Summer_5", discription: "???"),
    .init(chapter: 2, header: "여행계획 세워보기", PlantName: "단풍나무", imageName: "STR_Img_PlantSelect_Autumn_1", discription: "부끄럼이 많아 집에만 머무르는 단풍나무가\n 새로운 곳으로 여행을 떠나보려 해요.\n단풍나무와 함께 여행을 준비해 볼까요?"),
    .init(chapter: 2, header: "간단한 요리 도전하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Autumn_2", discription: "???"),
    .init(chapter: 2, header: "동네 소식,이벤트 찾아보기", PlantName: "???", imageName: "STR_Img_PlantSelect_Autumn_3", discription: "???"),
    .init(chapter: 2, header: "정리하고 싶은 앱, 오래된 옷 정리하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Autumn_4", discription: "???"),
    .init(chapter: 2, header: "햔관문 열어보기", PlantName: "???", imageName: "STR_Img_PlantSelect_Autumn_5", discription: "???"),
    .init(chapter: 3, header: "봉사활동 하기", PlantName: "목화나무", imageName: "STR_Img_PlantSelect_Winter_1", discription: "이웃들의 도움 덕에 가을 불꽃으로부터 소중한 솜을 지킨 목화나무는,\n자신도 도움이 필요한 사람들에게 힘이 되고자 해요. 함께 해볼까요?"),
    .init(chapter: 3, header: "카페에서 좋아하는 음료 사오기", PlantName: "???", imageName: "STR_Img_PlantSelect_Winter_2", discription: "???"),
    .init(chapter: 3, header: "당일치기 여행 다녀오기", PlantName: "???", imageName: "STR_Img_PlantSelect_Winter_3", discription: "???"),
    .init(chapter: 3, header: "혼자서 영화보기", PlantName: "???", imageName: "STR_Img_PlantSelect_Winter_4", discription: "???"),
    .init(chapter: 3, header: "하루 20분 산책하기", PlantName: "???", imageName: "STR_Img_PlantSelect_Winter_5", discription: "???"),
]
