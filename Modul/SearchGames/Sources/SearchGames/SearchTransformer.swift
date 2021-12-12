import Foundation
import Core

public struct SearchTransformer: CoreMapper {
    public typealias Request = [SearchGameResult]
    public typealias Domain = [SearchModel]
    public init() {}
    public func transformResponseToDomain(request: [SearchGameResult]) -> [SearchModel] {
        return request.map { search in
            return SearchModel(
                id: search.id ?? 0,
                name: search.name ?? "",
                backgroundImage: search.backgroundImage ?? "",
                shortScreenshots: search.shortScreenshots.map({ screenshots in
                    screenshots.map { ss in
                        return SearchShortScreenshotModel(id: ss.id, image: ss.image)
                    }
                }) ?? [])
        }
    }
}
