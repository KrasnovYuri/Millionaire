import Foundation

public protocol QuestionStorageProtocol {
    func fetchAllQuestions(completion: @escaping ([Question]) -> Void)
    func fetchQuestion(for level: QuestionLevel, completion: @escaping ([Question]) -> Void)
}

public final class QuestionStorage {
    public init () {}
    
    private func dataHandle(_ url: URL) -> [Question] {
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
}

extension QuestionStorage: QuestionStorageProtocol {
    public func fetchAllQuestions(completion: @escaping ([Question]) -> Void) {
        let paths: [String] = QuestionLevel.allCases
            .map({ $0.jsonName })
            .compactMap({ Bundle.module.path(forResource: $0, ofType: "json") })
        
        var allQuestions = [Question]()
        
        paths.forEach({ json in
            let url = URL(fileURLWithPath: json)
            let questions = dataHandle(url)
            allQuestions += questions
        })
        completion(allQuestions.shuffled())
    }
    
    public func fetchQuestion(for level: QuestionLevel, completion: @escaping ([Question]) -> Void) {
        guard let json = Bundle.module
            .path(forResource: level.jsonName, ofType: "json") else { return}
        let url = URL(fileURLWithPath: json)
        completion(dataHandle(url).shuffled())
    }
}
